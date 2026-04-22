import logging
import os
from homeassistant.core import HomeAssistant
from homeassistant.config_entries import ConfigEntry
from homeassistant.components import frontend
from .const import DOMAIN, NAME, VERSION
from .services import async_setup_services, async_unload_services
from .web_server import ESPHomeWebServer

_LOGGER = logging.getLogger(__name__)

async def async_setup_entry(hass: HomeAssistant, entry: ConfigEntry):
    """通过配置条目设置集成"""
    _LOGGER.info(f"Setting up {NAME} v{VERSION}")
    
    # 设置初始状态
    hass.states.async_set(f"{DOMAIN}.status", "ready")
    
    # 设置服务
    await async_setup_services(hass)
    
    # 尝试启动Web服务器（处理端口占用）
    web_server = ESPHomeWebServer(hass, port=8099)
    try:
        await web_server.start()
        web_server_started = True
    except OSError as e:
        if "address in use" in str(e):
            _LOGGER.warning(f"Port 8099 is in use, trying port 8090")
            web_server = ESPHomeWebServer(hass, port=8090)
            await web_server.start()
            web_server_started = True
        else:
            _LOGGER.error(f"Failed to start web server: {e}")
            web_server_started = False
    
    # 存储条目和Web服务器以供卸载时使用
    hass.data.setdefault(DOMAIN, {})
    hass.data[DOMAIN][entry.entry_id] = {
        'entry': entry,
        'web_server': web_server if web_server_started else None
    }
    
    return True

async def async_unload_entry(hass: HomeAssistant, entry: ConfigEntry):
    """卸载集成"""
    _LOGGER.info(f"Unloading {NAME}")
    
    # 获取Web服务器实例
    data = hass.data[DOMAIN].get(entry.entry_id, {})
    web_server = data.get('web_server') if data else None
    
    # 停止Web服务器
    if web_server:
        await web_server.stop()
    
    # 卸载服务
    await async_unload_services(hass)
    
    # 清理数据
    hass.data[DOMAIN].pop(entry.entry_id, None)
    
    return True

async def async_setup(hass: HomeAssistant, config: dict):
    """通过YAML配置设置集成（向后兼容）"""
    return True
