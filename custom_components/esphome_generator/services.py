import logging
from .const import DOMAIN

_LOGGER = logging.getLogger(__name__)

async def async_setup_services(hass):
    """设置服务"""
    
    async def handle_generate_yaml(call):
        """处理生成YAML的服务调用"""
        device_name = call.data.get("device_name", "esp_device")
        board = call.data.get("board", "esp32")
        
        # 简单的YAML模板
        yaml_config = f"""
esphome:
  name: {device_name}
  platform: {board}
  board: {board}

wifi:
  ssid: !secret wifi_ssid
  password: !secret wifi_password

api:
  encryption:
    key: !secret api_key

ota:
  password: !secret ota_password

logger:
"""
        # 将结果存储为Home Assistant状态
        hass.states.set(f"{DOMAIN}.last_generated", yaml_config)
        
        # 返回结果
        return {"yaml": yaml_config}
    
    # 注册服务
    hass.services.async_register(DOMAIN, "generate_yaml", handle_generate_yaml)
    return True

async def async_unload_services(hass):
    """卸载服务"""
    hass.services.async_remove(DOMAIN, "generate_yaml")
    return True
