# HACS集成推送指南

## 📍 项目位置
`/home/t/github项目/ha-hacs-esphome-generator`

## 🚀 首次推送（一次性）

### 1. 在GitHub创建仓库
1. 登录 https://github.com
2. 点击 "+" → "New repository"
3. 填写：
   - Repository name: `ha-hacs-esphome-generator`
   - **不要**勾选 "Initialize this repository with a README"
4. 点击 "Create repository"

### 2. 设置Git身份（如果还没设置）
```bash
git config --global user.name "你的名字"
git config --global user.email "你的邮箱"
```

### 3. 首次推送命令
```bash
cd /home/t/github项目/ha-hacs-esphome-generator
git init
git add .
git commit -m "首次提交：ESPHome YAML Generator HACS集成"
git branch -M main
git remote add origin https://令牌@github.com/你的用户名/ha-hacs-esphome-generator.git
git push -u origin main
```

## 🔄 后续更新推送

### 使用推送脚本（推荐）
```bash
cd /home/t/github项目/ha-hacs-esphome-generator
./push.sh "更新描述"
```

### 或手动三行命令
```bash
cd /home/t/github项目/ha-hacs-esphome-generator
git add .
git commit -m "更新描述"
git push
```

## ⚡ 极简命令总结

### 首次推送：
```bash
cd /home/t/github项目/ha-hacs-esphome-generator
git init
git add .
git commit -m "first"
git remote add origin https://令牌@github.com/用户名/ha-hacs-esphome-generator.git
git push -u origin main
```

### 后续更新：
```bash
cd /home/t/github项目/ha-hacs-esphome-generator
./push.sh "update"
```

## 📁 项目结构说明
```
ha-hacs-esphome-generator/
├── README.md              # 项目说明
├── hacs.json             # HACS配置文件
├── info.md               # HACS显示信息
└── custom_components/    # 集成代码
    └── esphome_generator/
        ├── __init__.py   # 主文件
        ├── manifest.json # 集成清单
        ├── config_flow.py # 配置流程
        ├── const.py      # 常量定义
        ├── services.yaml # 服务定义
        ├── services.py   # 服务实现
        └── web_server.py # Web服务器
```

## ✅ 验证成功
1. 访问：https://github.com/你的用户名/ha-hacs-esphome-generator
2. 看到文件列表 = 成功！
3. 可以在HACS中添加这个仓库

## ❗ 注意事项
1. **个人令牌URL格式**：`https://令牌@github.com/用户名/仓库.git`
2. **HACS要求**：必须包含 `hacs.json` 和 `info.md` 文件
3. **版本更新**：修改 `manifest.json` 中的版本号

---

**记住**：所有操作都在 `/home/t/github项目/ha-hacs-esphome-generator` 目录下。

**更新永远三步骤**：
1. `git add .`
2. `git commit -m "描述"`
3. `git push`

完成！ 🎉