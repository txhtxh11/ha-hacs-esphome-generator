"""Config flow for ESPHome YAML Generator."""
from homeassistant import config_entries
from homeassistant.data_entry_flow import FlowResult

class ESPHomeGeneratorConfigFlow(config_entries.ConfigFlow, domain="esphome_generator"):
    """Handle a config flow for ESPHome YAML Generator."""

    VERSION = 1

    async def async_step_user(self, user_input=None) -> FlowResult:
        """Handle the initial step."""
        if user_input is not None:
            return self.async_create_entry(title="ESPHome YAML Generator", data={})
            
        return self.async_show_form(step_id="user")