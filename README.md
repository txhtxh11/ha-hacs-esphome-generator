# ESPHome YAML Generator (HACS Integration)

一个用于生成 ESPHome YAML 配置的 Home Assistant 集成。

## 功能
- 通过 Home Assistant 服务生成 ESPHome YAML 配置
- 支持常见 ESPHome 组件
- 集成到 Home Assistant 自动化系统

## 安装（通过 HACS）

### 1. 添加自定义仓库
1. 打开 HACS → Integrations
2. 点击右上角 ⋮ → Custom repositories
3. 添加仓库 URL：`https://github.com/txhtxh11/ha-hacs-esphome-generator`
4. 类型选择：**Integration**

### 2. 安装集成
1. 在 HACS 中搜索 "ESPHome YAML Generator"
2. 点击安装
3. 重启 Home Assistant

### 3. 配置
1. 进入 Home Assistant **设置 → 设备与服务 → 添加集成**
2. 搜索 "ESPHome YAML Generator"
3. 点击添加

## 使用方法

安装后，可以通过 Home Assistant 服务调用 YAML 生成功能。

## 开发
这是一个最小版本，后续将添加完整的 Web 界面和服务功能。
# 测试推送
