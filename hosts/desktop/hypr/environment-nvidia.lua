-- -----------------------------------------------------
-- Environment Variables
-- name: "Nvidia"
-- -----------------------------------------------------
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("WLR_DRM_NO_ATOMIC", 1)
--hl.env("__GL_VRR_ALLOWED", 0)
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("__NV_PRIME_RENDER_OFFLOAD", 1)
hl.env("__VK_LAYER_NV_optimus", "NVIDIA_only")
--hl.env("NVD_BACKEND", "direct")
hl.env("__NV_DISABLE_EXPLICIT_SYNC", 1)

-- For VM and POSSIBLY NVIDIA
hl.env("WLR_NO_HARDWARE_CURSORS", 1)
hl.env("WLR_RENDERER_ALLOW_SOFTWARE", 1)

-- nvidia firefox
-- check this post https://github.com/elFarto/nvidia-vaapi-driver#configuration
hl.env("MOZ_DISABLE_RDD_SANDBOX", 1)
hl.env("EGL_PLATFORM", "wayland")

-- Electron on Wayland support
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

hl.config({
	cursor = {
		no_hardware_cursors = true,
	},
})
