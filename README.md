# ESPHome YAML Generator（HACS 集成）

> Home Assistant 自定义集成：在 HA 内生成 ESPHome YAML 配置，支持配置流（config flow）与服务调用，并内置 Web 面板。

## 安装（HACS）

1. HACS → **集成** → 右上角 `⋮` → **自定义存储库**
2. 填入 `https://github.com/txhtxh11/ha-hacs-esphome-generator`，类别选 **Integration**
3. 搜索 **ESPHome YAML Generator** → 下载 → 重启 Home Assistant
4. **设置 → 设备与服务 → 添加集成 → ESPHome YAML Generator**

## 功能

- 配置流引导添加集成
- 通过 HA 服务生成 ESPHome 配置
- 内置 Web 面板（`custom_components/esphome_generator/www/index.html`）
- 常见 ESPHome 组件模板，可接入自动化

## 要求

- Home Assistant `2024.1.0` 及以上（见 `hacs.json`）
- 依赖 `aiohttp >= 3.8.0`（HA 自带）

## 相关仓库

- [ha-addon-repo](https://github.com/txhtxh11/ha-addon-repo) —— 同功能的 Home Assistant add-on 版
- [homekit](https://github.com/txhtxh11/homekit) —— ESPHome 的 HomeKit 外部组件

## 许可证

本项目采用 MIT 许可证，详见 [LICENSE](LICENSE)。