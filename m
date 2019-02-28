Return-Path: <SRS0=OKHG=RD=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA37EC4360F
	for <linux-mips@archiver.kernel.org>; Thu, 28 Feb 2019 22:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB7A2064A
	for <linux-mips@archiver.kernel.org>; Thu, 28 Feb 2019 22:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="TqoUAoDM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733235AbfB1WIZ (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:08:25 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:57438 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbfB1WIY (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 28 Feb 2019 17:08:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1551391702; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ugvGMwzpZ3H+oMvm6aXU0Jmr2XZ35vs/5fg6dcSDEn8=;
        b=TqoUAoDMLW0zLtd8xdysiDrfQEjpiVo5ubxq/vXeOepaUTi7Cr6zRrwhgASkkLBeRSybMl
        +PGqdL8JZYGQLUcijtN3A1p4EfpDGIxiLhRQfJEE7oxMSLf6PpCsMybEdQqQItuIFIO0wr
        wrKYaByvaS6FfW/LX3ad1oSWz1TPnTg=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/3] DRM: Add KMS driver for the Ingenic JZ47xx SoCs
Date:   Thu, 28 Feb 2019 19:07:56 -0300
Message-Id: <20190228220756.20262-4-paul@crapouillou.net>
In-Reply-To: <20190228220756.20262-1-paul@crapouillou.net>
References: <20190228220756.20262-1-paul@crapouillou.net>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Add a KMS driver for the Ingenic JZ47xx family of SoCs.
This driver is meant to replace the aging jz4740-fb driver.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---
 drivers/gpu/drm/Kconfig               |   2 +
 drivers/gpu/drm/Makefile              |   1 +
 drivers/gpu/drm/ingenic/Kconfig       |  16 +
 drivers/gpu/drm/ingenic/Makefile      |   1 +
 drivers/gpu/drm/ingenic/ingenic-drm.c | 896 ++++++++++++++++++++++++++++++++++
 5 files changed, 916 insertions(+)
 create mode 100644 drivers/gpu/drm/ingenic/Kconfig
 create mode 100644 drivers/gpu/drm/ingenic/Makefile
 create mode 100644 drivers/gpu/drm/ingenic/ingenic-drm.c

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index bd943a71756c..f1929112e559 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -303,6 +303,8 @@ source "drivers/gpu/drm/sti/Kconfig"
 
 source "drivers/gpu/drm/imx/Kconfig"
 
+source "drivers/gpu/drm/ingenic/Kconfig"
+
 source "drivers/gpu/drm/v3d/Kconfig"
 
 source "drivers/gpu/drm/vc4/Kconfig"
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 1ac55c65eac0..9666c0767f44 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -94,6 +94,7 @@ obj-$(CONFIG_DRM_TEGRA) += tegra/
 obj-$(CONFIG_DRM_STM) += stm/
 obj-$(CONFIG_DRM_STI) += sti/
 obj-$(CONFIG_DRM_IMX) += imx/
+obj-y			+= ingenic/
 obj-$(CONFIG_DRM_MEDIATEK) += mediatek/
 obj-$(CONFIG_DRM_MESON)	+= meson/
 obj-y			+= i2c/
diff --git a/drivers/gpu/drm/ingenic/Kconfig b/drivers/gpu/drm/ingenic/Kconfig
new file mode 100644
index 000000000000..d82c3d37ec9c
--- /dev/null
+++ b/drivers/gpu/drm/ingenic/Kconfig
@@ -0,0 +1,16 @@
+config DRM_INGENIC
+	tristate "DRM Support for Ingenic SoCs"
+	depends on MIPS || COMPILE_TEST
+	depends on DRM
+	depends on CMA
+	depends on OF
+	select DRM_BRIDGE
+	select DRM_PANEL_BRIDGE
+	select DRM_KMS_HELPER
+	select DRM_KMS_CMA_HELPER
+	select DRM_GEM_CMA_HELPER
+	select VT_HW_CONSOLE_BINDING if FRAMEBUFFER_CONSOLE
+	help
+	  Choose this option for DRM support for the Ingenic SoCs.
+
+	  If M is selected the module will be called ingenic-drm.
diff --git a/drivers/gpu/drm/ingenic/Makefile b/drivers/gpu/drm/ingenic/Makefile
new file mode 100644
index 000000000000..11cac42ce0bb
--- /dev/null
+++ b/drivers/gpu/drm/ingenic/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_DRM_INGENIC) += ingenic-drm.o
diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c b/drivers/gpu/drm/ingenic/ingenic-drm.c
new file mode 100644
index 000000000000..18120deea96f
--- /dev/null
+++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
@@ -0,0 +1,896 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Ingenic JZ47xx KMS driver
+//
+// Copyright (C) 2019, Paul Cercueil <paul@crapouillou.net>
+
+#include <linux/clk.h>
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_gem_cma_helper.h>
+#include <drm/drm_fb_cma_helper.h>
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_fourcc.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_irq.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_plane.h>
+#include <drm/drm_plane_helper.h>
+#include <drm/drm_probe_helper.h>
+#include <drm/drm_vblank.h>
+
+#include <dt-bindings/display/ingenic,drm.h>
+
+#include "../drm_internal.h"
+
+#define JZ_REG_LCD_CFG		0x00
+#define JZ_REG_LCD_VSYNC	0x04
+#define JZ_REG_LCD_HSYNC	0x08
+#define JZ_REG_LCD_VAT		0x0C
+#define JZ_REG_LCD_DAH		0x10
+#define JZ_REG_LCD_DAV		0x14
+#define JZ_REG_LCD_PS		0x18
+#define JZ_REG_LCD_CLS		0x1C
+#define JZ_REG_LCD_SPL		0x20
+#define JZ_REG_LCD_REV		0x24
+#define JZ_REG_LCD_CTRL		0x30
+#define JZ_REG_LCD_STATE	0x34
+#define JZ_REG_LCD_IID		0x38
+#define JZ_REG_LCD_DA0		0x40
+#define JZ_REG_LCD_SA0		0x44
+#define JZ_REG_LCD_FID0		0x48
+#define JZ_REG_LCD_CMD0		0x4C
+#define JZ_REG_LCD_DA1		0x50
+#define JZ_REG_LCD_SA1		0x54
+#define JZ_REG_LCD_FID1		0x58
+#define JZ_REG_LCD_CMD1		0x5C
+
+#define JZ_LCD_CFG_SLCD			BIT(31)
+#define JZ_LCD_CFG_PS_DISABLE		BIT(23)
+#define JZ_LCD_CFG_CLS_DISABLE		BIT(22)
+#define JZ_LCD_CFG_SPL_DISABLE		BIT(21)
+#define JZ_LCD_CFG_REV_DISABLE		BIT(20)
+#define JZ_LCD_CFG_HSYNCM		BIT(19)
+#define JZ_LCD_CFG_PCLKM		BIT(18)
+#define JZ_LCD_CFG_INV			BIT(17)
+#define JZ_LCD_CFG_SYNC_DIR		BIT(16)
+#define JZ_LCD_CFG_PS_POLARITY		BIT(15)
+#define JZ_LCD_CFG_CLS_POLARITY		BIT(14)
+#define JZ_LCD_CFG_SPL_POLARITY		BIT(13)
+#define JZ_LCD_CFG_REV_POLARITY		BIT(12)
+#define JZ_LCD_CFG_HSYNC_ACTIVE_LOW	BIT(11)
+#define JZ_LCD_CFG_PCLK_FALLING_EDGE	BIT(10)
+#define JZ_LCD_CFG_DE_ACTIVE_LOW	BIT(9)
+#define JZ_LCD_CFG_VSYNC_ACTIVE_LOW	BIT(8)
+#define JZ_LCD_CFG_18_BIT		BIT(7)
+#define JZ_LCD_CFG_PDW			(BIT(5) | BIT(4))
+#define JZ_LCD_CFG_MODE_MASK		0xf
+
+#define JZ_LCD_VSYNC_VPS_OFFSET		16
+#define JZ_LCD_VSYNC_VPE_OFFSET		0
+
+#define JZ_LCD_HSYNC_HPS_OFFSET		16
+#define JZ_LCD_HSYNC_HPE_OFFSET		0
+
+#define JZ_LCD_VAT_HT_OFFSET		16
+#define JZ_LCD_VAT_VT_OFFSET		0
+
+#define JZ_LCD_DAH_HDS_OFFSET		16
+#define JZ_LCD_DAH_HDE_OFFSET		0
+
+#define JZ_LCD_DAV_VDS_OFFSET		16
+#define JZ_LCD_DAV_VDE_OFFSET		0
+
+#define JZ_LCD_CTRL_BURST_4		(0x0 << 28)
+#define JZ_LCD_CTRL_BURST_8		(0x1 << 28)
+#define JZ_LCD_CTRL_BURST_16		(0x2 << 28)
+#define JZ_LCD_CTRL_RGB555		BIT(27)
+#define JZ_LCD_CTRL_OFUP		BIT(26)
+#define JZ_LCD_CTRL_FRC_GRAYSCALE_16	(0x0 << 24)
+#define JZ_LCD_CTRL_FRC_GRAYSCALE_4	(0x1 << 24)
+#define JZ_LCD_CTRL_FRC_GRAYSCALE_2	(0x2 << 24)
+#define JZ_LCD_CTRL_PDD_MASK		(0xff << 16)
+#define JZ_LCD_CTRL_EOF_IRQ		BIT(13)
+#define JZ_LCD_CTRL_SOF_IRQ		BIT(12)
+#define JZ_LCD_CTRL_OFU_IRQ		BIT(11)
+#define JZ_LCD_CTRL_IFU0_IRQ		BIT(10)
+#define JZ_LCD_CTRL_IFU1_IRQ		BIT(9)
+#define JZ_LCD_CTRL_DD_IRQ		BIT(8)
+#define JZ_LCD_CTRL_QDD_IRQ		BIT(7)
+#define JZ_LCD_CTRL_REVERSE_ENDIAN	BIT(6)
+#define JZ_LCD_CTRL_LSB_FISRT		BIT(5)
+#define JZ_LCD_CTRL_DISABLE		BIT(4)
+#define JZ_LCD_CTRL_ENABLE		BIT(3)
+#define JZ_LCD_CTRL_BPP_1		0x0
+#define JZ_LCD_CTRL_BPP_2		0x1
+#define JZ_LCD_CTRL_BPP_4		0x2
+#define JZ_LCD_CTRL_BPP_8		0x3
+#define JZ_LCD_CTRL_BPP_15_16		0x4
+#define JZ_LCD_CTRL_BPP_18_24		0x5
+#define JZ_LCD_CTRL_BPP_MASK		(JZ_LCD_CTRL_RGB555 | (0x7 << 0))
+
+#define JZ_LCD_CMD_SOF_IRQ		BIT(31)
+#define JZ_LCD_CMD_EOF_IRQ		BIT(30)
+#define JZ_LCD_CMD_ENABLE_PAL		BIT(28)
+
+#define JZ_LCD_SYNC_MASK		0x3ff
+
+#define JZ_LCD_STATE_EOF_IRQ		BIT(5)
+#define JZ_LCD_STATE_SOF_IRQ		BIT(4)
+#define JZ_LCD_STATE_DISABLED		BIT(0)
+
+struct ingenic_framedesc {
+	uint32_t next;
+	uint32_t addr;
+	uint32_t id;
+	uint32_t cmd;
+} __packed;
+
+struct jz_soc_info {
+	bool needs_dev_clk;
+};
+
+struct ingenic_drm {
+	struct device *dev;
+	void __iomem *base;
+	struct regmap *map;
+	struct clk *lcd_clk, *pix_clk;
+
+	u32 lcd_mode;
+
+	struct ingenic_framedesc *framedesc;
+	dma_addr_t framedesc_phys;
+
+	struct drm_device *drm;
+	struct drm_plane primary;
+	struct drm_crtc crtc;
+	struct drm_connector connector;
+	struct drm_encoder encoder;
+	struct drm_panel *panel;
+
+	struct device_node *panel_node;
+
+	unsigned short ps_start, ps_end, cls_start,
+		       cls_end, spl_start, spl_end, rev_start;
+};
+
+static const uint32_t ingenic_drm_primary_formats[] = {
+	DRM_FORMAT_XRGB1555,
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_XRGB8888,
+};
+
+static bool ingenic_drm_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case JZ_REG_LCD_IID:
+	case JZ_REG_LCD_SA0:
+	case JZ_REG_LCD_FID0:
+	case JZ_REG_LCD_CMD0:
+	case JZ_REG_LCD_SA1:
+	case JZ_REG_LCD_FID1:
+	case JZ_REG_LCD_CMD1:
+		return false;
+	default:
+		return true;
+	}
+}
+
+static const struct regmap_config ingenic_drm_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+
+	.max_register = JZ_REG_LCD_CMD1,
+	.writeable_reg = ingenic_drm_writeable_reg,
+};
+
+static inline struct ingenic_drm *drm_crtc_get_priv(struct drm_crtc *crtc)
+{
+	return container_of(crtc, struct ingenic_drm, crtc);
+}
+
+static inline struct ingenic_drm *drm_plane_get_priv(struct drm_plane *plane)
+{
+	return container_of(plane, struct ingenic_drm, primary);
+}
+
+static inline struct ingenic_drm *drm_conn_get_priv(struct drm_connector *conn)
+{
+	return container_of(conn, struct ingenic_drm, connector);
+}
+
+static void ingenic_drm_crtc_atomic_enable(struct drm_crtc *crtc,
+					  struct drm_crtc_state *state)
+{
+	struct ingenic_drm *priv = drm_crtc_get_priv(crtc);
+
+	regmap_write(priv->map, JZ_REG_LCD_STATE, 0);
+
+	regmap_update_bits(priv->map, JZ_REG_LCD_CTRL,
+			   JZ_LCD_CTRL_ENABLE | JZ_LCD_CTRL_DISABLE,
+			   JZ_LCD_CTRL_ENABLE);
+
+	drm_panel_enable(priv->panel);
+
+	drm_crtc_vblank_on(crtc);
+}
+
+static void ingenic_drm_crtc_atomic_disable(struct drm_crtc *crtc,
+					   struct drm_crtc_state *state)
+{
+	struct ingenic_drm *priv = drm_crtc_get_priv(crtc);
+	unsigned int var;
+
+	drm_crtc_vblank_off(crtc);
+
+	drm_panel_disable(priv->panel);
+
+	regmap_update_bits(priv->map, JZ_REG_LCD_CTRL,
+			   JZ_LCD_CTRL_DISABLE, JZ_LCD_CTRL_DISABLE);
+
+	regmap_read_poll_timeout(priv->map, JZ_REG_LCD_STATE, var,
+				 var & JZ_LCD_STATE_DISABLED,
+				 1000, 0);
+}
+
+static inline bool ingenic_drm_lcd_is_special_mode(u32 mode)
+{
+	switch (mode) {
+	case JZ_DRM_LCD_SPECIAL_TFT_1:
+	case JZ_DRM_LCD_SPECIAL_TFT_2:
+	case JZ_DRM_LCD_SPECIAL_TFT_3:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static inline bool ingenic_drm_lcd_is_stn_mode(u32 mode)
+{
+	switch (mode) {
+	case JZ_DRM_LCD_SINGLE_COLOR_STN:
+	case JZ_DRM_LCD_SINGLE_MONOCHROME_STN:
+	case JZ_DRM_LCD_DUAL_COLOR_STN:
+	case JZ_DRM_LCD_DUAL_MONOCHROME_STN:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static void ingenic_drm_crtc_update_timings(struct ingenic_drm *priv,
+					    struct drm_display_mode *mode)
+{
+	unsigned int vpe, vds, vde, vt, hpe, hds, hde, ht;
+
+	vpe = mode->vsync_end - mode->vsync_start;
+	vds = mode->vtotal - mode->vsync_start;
+	vde = vds + mode->vdisplay;
+	vt = vde + mode->vsync_start - mode->vdisplay;
+
+	hpe = mode->hsync_end - mode->hsync_start;
+	hds = mode->htotal - mode->hsync_start;
+	hde = hds + mode->hdisplay;
+	ht = hde + mode->hsync_start - mode->hdisplay;
+
+	regmap_write(priv->map, JZ_REG_LCD_VSYNC,
+		     0 << JZ_LCD_VSYNC_VPS_OFFSET |
+		     vpe << JZ_LCD_VSYNC_VPE_OFFSET);
+
+	regmap_write(priv->map, JZ_REG_LCD_HSYNC,
+		     0 << JZ_LCD_HSYNC_HPS_OFFSET |
+		     hpe << JZ_LCD_HSYNC_HPE_OFFSET);
+
+	regmap_write(priv->map, JZ_REG_LCD_VAT,
+		     ht << JZ_LCD_VAT_HT_OFFSET |
+		     vt << JZ_LCD_VAT_VT_OFFSET);
+
+	regmap_write(priv->map, JZ_REG_LCD_DAH,
+		     hds << JZ_LCD_DAH_HDS_OFFSET |
+		     hde << JZ_LCD_DAH_HDE_OFFSET);
+	regmap_write(priv->map, JZ_REG_LCD_DAV,
+		     vds << JZ_LCD_DAV_VDS_OFFSET |
+		     vde << JZ_LCD_DAV_VDE_OFFSET);
+
+	if (ingenic_drm_lcd_is_special_mode(priv->lcd_mode)) {
+		regmap_write(priv->map, JZ_REG_LCD_PS, hde << 16 | (hde + 1));
+		regmap_write(priv->map, JZ_REG_LCD_CLS, hde << 16 | (hde + 1));
+		regmap_write(priv->map, JZ_REG_LCD_SPL, hpe << 16 | (hpe + 1));
+		regmap_write(priv->map, JZ_REG_LCD_REV, mode->htotal << 16);
+	}
+}
+
+static void ingenic_drm_crtc_update_cfg(struct ingenic_drm *priv,
+					struct drm_display_mode *mode)
+
+{
+	unsigned int cfg = priv->lcd_mode;
+	u32 bus_flags = priv->connector.display_info.bus_flags;
+
+	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
+		cfg |= JZ_LCD_CFG_HSYNC_ACTIVE_LOW;
+	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
+		cfg |= JZ_LCD_CFG_VSYNC_ACTIVE_LOW;
+	if (bus_flags & DRM_BUS_FLAG_DE_LOW)
+		cfg |= JZ_LCD_CFG_DE_ACTIVE_LOW;
+	if (bus_flags & DRM_BUS_FLAG_PIXDATA_NEGEDGE)
+		cfg |= JZ_LCD_CFG_PCLK_FALLING_EDGE;
+
+	if (ingenic_drm_lcd_is_special_mode(priv->lcd_mode)) {
+		// TODO: Is that valid for all special modes?
+		cfg |= JZ_LCD_CFG_REV_POLARITY;
+	} else {
+		cfg |= JZ_LCD_CFG_PS_DISABLE
+		    | JZ_LCD_CFG_CLS_DISABLE
+		    | JZ_LCD_CFG_SPL_DISABLE
+		    | JZ_LCD_CFG_REV_DISABLE;
+	}
+
+	regmap_write(priv->map, JZ_REG_LCD_CFG, cfg);
+}
+
+static void ingenic_drm_crtc_update_ctrl(struct ingenic_drm *priv,
+					 unsigned int bpp)
+{
+	unsigned int ctrl = JZ_LCD_CTRL_OFUP | JZ_LCD_CTRL_BURST_16;
+
+	switch (bpp) {
+	case 1:
+		ctrl |= JZ_LCD_CTRL_BPP_1;
+		break;
+	case 2:
+		ctrl |= JZ_LCD_CTRL_BPP_2;
+		break;
+	case 4:
+		ctrl |= JZ_LCD_CTRL_BPP_4;
+		break;
+	case 8:
+		ctrl |= JZ_LCD_CTRL_BPP_8;
+	break;
+	case 15:
+		ctrl |= JZ_LCD_CTRL_RGB555; /* Falltrough */
+	case 16:
+		ctrl |= JZ_LCD_CTRL_BPP_15_16;
+		break;
+	case 18:
+	case 24:
+	case 32:
+		ctrl |= JZ_LCD_CTRL_BPP_18_24;
+		break;
+	default:
+		break;
+	}
+
+	regmap_update_bits(priv->map, JZ_REG_LCD_CTRL,
+			   JZ_LCD_CTRL_OFUP | JZ_LCD_CTRL_BURST_16 |
+			   JZ_LCD_CTRL_BPP_MASK, ctrl);
+}
+
+static int ingenic_drm_crtc_atomic_check(struct drm_crtc *crtc,
+					 struct drm_crtc_state *state)
+{
+	struct ingenic_drm *priv = drm_crtc_get_priv(crtc);
+	long rate;
+
+	if (!drm_atomic_crtc_needs_modeset(state))
+		return 0;
+
+	rate = clk_round_rate(priv->pix_clk,
+			      state->adjusted_mode.clock * 1000);
+	if (rate < 0)
+		return rate;
+
+	return 0;
+}
+
+static void ingenic_drm_crtc_atomic_flush(struct drm_crtc *crtc,
+					  struct drm_crtc_state *oldstate)
+{
+	struct ingenic_drm *priv = drm_crtc_get_priv(crtc);
+	struct drm_crtc_state *state = crtc->state;
+	struct drm_pending_vblank_event *event = state->event;
+	struct drm_framebuffer *drm_fb = crtc->primary->state->fb;
+	const struct drm_format_info *finfo;
+	unsigned int width, height;
+
+	if (drm_atomic_crtc_needs_modeset(state)) {
+		finfo = drm_format_info(drm_fb->format->format);
+		width = state->adjusted_mode.hdisplay;
+		height = state->adjusted_mode.vdisplay;
+
+		ingenic_drm_crtc_update_timings(priv, &state->mode);
+
+		ingenic_drm_crtc_update_ctrl(priv, finfo->depth);
+		ingenic_drm_crtc_update_cfg(priv, &state->adjusted_mode);
+
+		clk_set_rate(priv->pix_clk, state->adjusted_mode.clock * 1000);
+
+		regmap_write(priv->map, JZ_REG_LCD_DA0, priv->framedesc->next);
+	}
+
+	if (event) {
+		state->event = NULL;
+
+		spin_lock_irq(&crtc->dev->event_lock);
+		if (drm_crtc_vblank_get(crtc) == 0)
+			drm_crtc_arm_vblank_event(crtc, event);
+		else
+			drm_crtc_send_vblank_event(crtc, event);
+		spin_unlock_irq(&crtc->dev->event_lock);
+	}
+}
+
+static void ingenic_drm_plane_atomic_update(struct drm_plane *plane,
+					    struct drm_plane_state *oldstate)
+{
+	struct ingenic_drm *priv = drm_plane_get_priv(plane);
+	struct drm_plane_state *state = plane->state;
+	const struct drm_format_info *finfo;
+	unsigned int width, height;
+
+	finfo = drm_format_info(state->fb->format->format);
+	width = state->crtc->state->adjusted_mode.hdisplay;
+	height = state->crtc->state->adjusted_mode.vdisplay;
+
+	priv->framedesc->addr = drm_fb_cma_get_gem_addr(state->fb, state, 0);
+
+	priv->framedesc->cmd = width * height * ((finfo->depth + 7) / 8) / 4;
+	priv->framedesc->cmd |= JZ_LCD_CMD_EOF_IRQ;
+}
+
+static enum drm_connector_status
+ingenic_drm_conn_detect(struct drm_connector *conn, bool force)
+{
+	struct ingenic_drm *priv = drm_conn_get_priv(conn);
+
+	if (priv->panel) {
+		drm_panel_attach(priv->panel, conn);
+
+		return connector_status_connected;
+	}
+
+	return connector_status_disconnected;
+}
+
+static void ingenic_drm_conn_destroy(struct drm_connector *conn)
+{
+	struct ingenic_drm *priv = drm_conn_get_priv(conn);
+
+	if (priv->panel)
+		drm_panel_detach(priv->panel);
+
+	drm_connector_cleanup(conn);
+}
+
+static int ingenic_drm_conn_get_modes(struct drm_connector *conn)
+{
+	struct ingenic_drm *priv = drm_conn_get_priv(conn);
+
+	if (priv->panel)
+		return priv->panel->funcs->get_modes(priv->panel);
+
+	return 0;
+}
+
+static irqreturn_t ingenic_drm_irq_handler(int irq, void *arg)
+{
+	struct drm_device *drm = arg;
+	struct ingenic_drm *priv = drm->dev_private;
+	unsigned int state;
+
+	regmap_read(priv->map, JZ_REG_LCD_STATE, &state);
+
+	regmap_update_bits(priv->map, JZ_REG_LCD_STATE,
+			   JZ_LCD_STATE_EOF_IRQ, 0);
+
+	if (state & JZ_LCD_STATE_EOF_IRQ)
+		drm_crtc_handle_vblank(&priv->crtc);
+
+	return IRQ_HANDLED;
+}
+
+static int ingenic_drm_enable_vblank(struct drm_crtc *crtc)
+{
+	struct ingenic_drm *priv = drm_crtc_get_priv(crtc);
+
+	regmap_update_bits(priv->map, JZ_REG_LCD_CTRL,
+			   JZ_LCD_CTRL_EOF_IRQ, JZ_LCD_CTRL_EOF_IRQ);
+
+	return 0;
+}
+
+static void ingenic_drm_disable_vblank(struct drm_crtc *crtc)
+{
+	struct ingenic_drm *priv = drm_crtc_get_priv(crtc);
+
+	regmap_update_bits(priv->map, JZ_REG_LCD_CTRL, JZ_LCD_CTRL_EOF_IRQ, 0);
+}
+
+DEFINE_DRM_GEM_CMA_FOPS(ingenic_drm_fops);
+
+static struct drm_driver ingenic_drm_driver_data = {
+	.driver_features	= DRIVER_MODESET | DRIVER_GEM | DRIVER_PRIME
+				| DRIVER_ATOMIC | DRIVER_HAVE_IRQ,
+	.name			= "ingenic-drm",
+	.desc			= "DRM module for Ingenic SoCs",
+	.date			= "20190228",
+	.major			= 1,
+	.minor			= 0,
+	.patchlevel		= 0,
+
+	.fops			= &ingenic_drm_fops,
+
+	.dumb_create		= drm_gem_cma_dumb_create,
+	.gem_free_object_unlocked = drm_gem_cma_free_object,
+	.gem_vm_ops		= &drm_gem_cma_vm_ops,
+
+	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
+	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
+	.gem_prime_import	= drm_gem_prime_import,
+	.gem_prime_export	= drm_gem_prime_export,
+	.gem_prime_get_sg_table	= drm_gem_cma_prime_get_sg_table,
+	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
+	.gem_prime_vmap		= drm_gem_cma_prime_vmap,
+	.gem_prime_vunmap	= drm_gem_cma_prime_vunmap,
+	.gem_prime_mmap		= drm_gem_cma_prime_mmap,
+
+	.irq_handler		= ingenic_drm_irq_handler,
+};
+
+static const struct drm_plane_funcs ingenic_drm_primary_plane_funcs = {
+	.update_plane		= drm_atomic_helper_update_plane,
+	.disable_plane		= drm_atomic_helper_disable_plane,
+	.reset			= drm_atomic_helper_plane_reset,
+
+	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
+};
+
+static const struct drm_crtc_funcs ingenic_drm_crtc_funcs = {
+	.reset			= drm_atomic_helper_crtc_reset,
+	.set_config		= drm_atomic_helper_set_config,
+	.page_flip		= drm_atomic_helper_page_flip,
+
+	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
+
+	.enable_vblank		= ingenic_drm_enable_vblank,
+	.disable_vblank		= ingenic_drm_disable_vblank,
+
+	.gamma_set		= drm_atomic_helper_legacy_gamma_set,
+};
+
+static const struct drm_connector_funcs ingenic_drm_conn_funcs = {
+	.fill_modes		= drm_helper_probe_single_connector_modes,
+	.detect			= ingenic_drm_conn_detect,
+	.destroy		= ingenic_drm_conn_destroy,
+	.reset			= drm_atomic_helper_connector_reset,
+	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
+};
+
+static const struct drm_plane_helper_funcs ingenic_drm_plane_helper_funcs = {
+	.atomic_update		= ingenic_drm_plane_atomic_update,
+	.prepare_fb		= drm_gem_fb_prepare_fb,
+};
+
+static const struct drm_crtc_helper_funcs ingenic_drm_crtc_helper_funcs = {
+	.atomic_enable		= ingenic_drm_crtc_atomic_enable,
+	.atomic_disable		= ingenic_drm_crtc_atomic_disable,
+	.atomic_flush		= ingenic_drm_crtc_atomic_flush,
+	.atomic_check		= ingenic_drm_crtc_atomic_check,
+};
+
+static const struct drm_connector_helper_funcs ingenic_drm_conn_helper_funcs = {
+	.get_modes		= ingenic_drm_conn_get_modes,
+};
+
+static const struct drm_mode_config_funcs ingenic_drm_mode_config_funcs = {
+	.fb_create		= drm_gem_fb_create,
+	.output_poll_changed	= drm_fb_helper_output_poll_changed,
+	.atomic_check		= drm_atomic_helper_check,
+	.atomic_commit		= drm_atomic_helper_commit,
+};
+
+static const struct drm_encoder_funcs ingenic_drm_encoder_funcs = {
+	.destroy		= drm_encoder_cleanup,
+};
+
+static int ingenic_drm_probe(struct platform_device *pdev)
+{
+	const struct jz_soc_info *soc_info;
+	struct device *dev = &pdev->dev;
+	struct ingenic_drm *priv;
+	struct clk *parent_clk;
+	struct drm_device *drm;
+	struct resource *mem;
+	void __iomem *base;
+	long parent_rate;
+	int ret, irq;
+
+	soc_info = device_get_match_data(dev);
+	if (!soc_info)
+		return -EINVAL;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->base = base = devm_ioremap_resource(dev, mem);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(dev, "Failed to get platform irq\n");
+		return -ENOENT;
+	}
+
+	priv->map = devm_regmap_init_mmio(dev, base,
+					  &ingenic_drm_regmap_config);
+	if (IS_ERR(priv->map)) {
+		dev_err(dev, "Failed to create regmap\n");
+		return PTR_ERR(priv->map);
+	}
+
+	if (soc_info->needs_dev_clk) {
+		priv->lcd_clk = devm_clk_get(dev, "lcd");
+		if (IS_ERR(priv->lcd_clk)) {
+			dev_err(dev, "Failed to get lcd clock\n");
+			return PTR_ERR(priv->lcd_clk);
+		}
+	}
+
+	priv->pix_clk = devm_clk_get(dev, "lcd_pclk");
+	if (IS_ERR(priv->pix_clk)) {
+		dev_err(dev, "Failed to get pixel clock\n");
+		return PTR_ERR(priv->pix_clk);
+	}
+
+	priv->panel_node = of_parse_phandle(dev->of_node, "ingenic,panel", 0);
+	if (!priv->panel_node) {
+		DRM_INFO("No panel found");
+	} else {
+		priv->panel = of_drm_find_panel(priv->panel_node);
+		of_node_put(priv->panel_node);
+
+		if (IS_ERR(priv->panel)) {
+			if (PTR_ERR(priv->panel) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
+
+			priv->panel = NULL;
+		} else {
+			ret = drm_panel_prepare(priv->panel);
+			if (ret && ret != -ENOSYS)
+				return ret;
+		}
+	}
+
+	if (priv->panel) {
+		ret = device_property_read_u32(dev, "ingenic,lcd-mode",
+					       &priv->lcd_mode);
+		if (ret) {
+			dev_err(dev, "Unable to read ingenic,lcd-mode property\n");
+			return ret;
+		}
+	}
+
+	priv->framedesc = dma_alloc_coherent(dev, sizeof(*priv->framedesc),
+					     &priv->framedesc_phys, GFP_KERNEL);
+	if (!priv->framedesc)
+		return -ENOMEM;
+
+	priv->framedesc->next = priv->framedesc_phys;
+	priv->framedesc->id = 0xdeafbead;
+
+	drm = drm_dev_alloc(&ingenic_drm_driver_data, dev);
+	if (IS_ERR(drm)) {
+		ret = PTR_ERR(drm);
+		goto err_free_dma;
+	}
+
+	priv->drm = drm;
+
+	drm_mode_config_init(drm);
+	drm->mode_config.min_width = 0;
+	drm->mode_config.min_height = 0;
+	drm->mode_config.max_width = 800;
+	drm->mode_config.max_height = 600;
+	drm->mode_config.funcs = &ingenic_drm_mode_config_funcs;
+
+	drm_plane_helper_add(&priv->primary, &ingenic_drm_plane_helper_funcs);
+
+	ret = drm_universal_plane_init(drm, &priv->primary,
+				       0, &ingenic_drm_primary_plane_funcs,
+				       ingenic_drm_primary_formats,
+				       ARRAY_SIZE(ingenic_drm_primary_formats),
+				       NULL, DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (ret) {
+		dev_err(dev, "Failed to register primary plane: %i\n", ret);
+		goto err_unref_drm;
+	}
+
+	drm_crtc_helper_add(&priv->crtc, &ingenic_drm_crtc_helper_funcs);
+
+	ret = drm_crtc_init_with_planes(drm, &priv->crtc, &priv->primary,
+					NULL, &ingenic_drm_crtc_funcs, NULL);
+	if (ret) {
+		dev_err(dev, "Failed to init CRTC: %i\n", ret);
+		goto err_cleanup_plane;
+	}
+
+	drm_connector_helper_add(&priv->connector,
+				 &ingenic_drm_conn_helper_funcs);
+	ret = drm_connector_init(drm, &priv->connector,
+				 &ingenic_drm_conn_funcs,
+				 DRM_MODE_CONNECTOR_Unknown);
+	if (ret) {
+		dev_err(dev, "Failed to init connector: %i\n", ret);
+		goto err_cleanup_crtc;
+	}
+
+	priv->encoder.possible_crtcs = 1;
+
+	ret = drm_encoder_init(drm, &priv->encoder, &ingenic_drm_encoder_funcs,
+			       DRM_MODE_ENCODER_NONE, NULL);
+	if (ret) {
+		dev_err(dev, "Failed to init encoder: %i\n", ret);
+		goto err_cleanup_connector;
+	}
+
+	drm_connector_attach_encoder(&priv->connector, &priv->encoder);
+
+	platform_set_drvdata(pdev, drm);
+	priv->drm = drm;
+	drm->dev_private = priv;
+
+	ret = drm_irq_install(drm, irq);
+	if (ret) {
+		dev_err(dev, "Unable to install IRQ handler\n");
+		goto err_cleanup_encoder;
+	}
+
+	ret = drm_vblank_init(drm, 1);
+	if (ret) {
+		dev_err(dev, "Failed calling drm_vblank_init()\n");
+		goto err_uninstall_irq;
+	}
+
+	drm_mode_config_reset(drm);
+
+	ret = clk_prepare_enable(priv->pix_clk);
+	if (ret) {
+		dev_err(dev, "Unable to start pixel clock\n");
+		goto err_cleanup_vblank;
+	}
+
+	if (priv->lcd_clk) {
+		parent_clk = clk_get_parent(priv->lcd_clk);
+		parent_rate = clk_get_rate(parent_clk);
+
+		/* LCD Device clock must be 3x the pixel clock for STN panels,
+		 * or 1.5x the pixel clock for TFT panels. To avoid having to
+		 * check for the LCD device clock everytime we do a mode change,
+		 * we set the LCD device clock to the highest rate possible.
+		 */
+		ret = clk_set_rate(priv->lcd_clk, parent_rate);
+		if (ret) {
+			dev_err(dev, "Unable to set LCD clock rate\n");
+			goto err_pixclk_disable;
+		}
+
+		ret = clk_prepare_enable(priv->lcd_clk);
+		if (ret) {
+			dev_err(dev, "Unable to start lcd clock\n");
+			goto err_pixclk_disable;
+		}
+	}
+
+	ret = drm_fbdev_generic_setup(drm, 16);
+	if (ret) {
+		dev_err(dev, "Failed to init fbdev\n");
+		goto err_devclk_disable;
+	}
+
+	ret = drm_dev_register(drm, 0);
+	if (ret) {
+		dev_err(dev, "Failed to register DRM driver\n");
+		goto err_cleanup_fbdev;
+	}
+
+	return 0;
+
+err_cleanup_fbdev:
+	drm_mode_config_cleanup(drm);
+err_devclk_disable:
+	if (priv->lcd_clk)
+		clk_disable_unprepare(priv->lcd_clk);
+err_pixclk_disable:
+	clk_disable_unprepare(priv->pix_clk);
+err_cleanup_vblank:
+	drm_vblank_cleanup(drm);
+err_uninstall_irq:
+	drm_irq_uninstall(drm);
+err_cleanup_encoder:
+	drm_encoder_cleanup(&priv->encoder);
+err_cleanup_connector:
+	drm_connector_cleanup(&priv->connector);
+err_cleanup_crtc:
+	drm_crtc_cleanup(&priv->crtc);
+err_cleanup_plane:
+	drm_plane_cleanup(&priv->primary);
+err_unref_drm:
+	drm_dev_put(drm);
+err_free_dma:
+	dma_free_coherent(dev, sizeof(*priv->framedesc),
+			  priv->framedesc, priv->framedesc_phys);
+	return ret;
+}
+
+static int ingenic_drm_remove(struct platform_device *pdev)
+{
+	struct drm_device *drm = platform_get_drvdata(pdev);
+	struct ingenic_drm *priv = drm->dev_private;
+
+	drm_dev_unregister(drm);
+	drm_mode_config_cleanup(drm);
+
+	if (priv->lcd_clk)
+		clk_disable_unprepare(priv->lcd_clk);
+	clk_disable_unprepare(priv->pix_clk);
+
+	drm_vblank_cleanup(drm);
+	drm_irq_uninstall(drm);
+
+	drm_encoder_cleanup(&priv->encoder);
+	drm_connector_cleanup(&priv->connector);
+	drm_crtc_cleanup(&priv->crtc);
+	drm_plane_cleanup(&priv->primary);
+
+	drm_dev_put(drm);
+
+	dma_free_coherent(&pdev->dev, sizeof(*priv->framedesc),
+			  priv->framedesc, priv->framedesc_phys);
+
+	return 0;
+}
+
+static const struct jz_soc_info jz4740_soc_info = {
+	.needs_dev_clk = true,
+};
+
+static const struct jz_soc_info jz4725b_soc_info = {
+	.needs_dev_clk = false,
+};
+
+static const struct of_device_id ingenic_drm_of_match[] = {
+	{ .compatible = "ingenic,jz4740-drm", .data = &jz4740_soc_info },
+	{ .compatible = "ingenic,jz4725b-drm", .data = &jz4725b_soc_info },
+	{},
+};
+
+static struct platform_driver ingenic_drm_driver = {
+	.driver = {
+		.name = "ingenic-drm",
+		.of_match_table = of_match_ptr(ingenic_drm_of_match),
+	},
+	.probe = ingenic_drm_probe,
+	.remove = ingenic_drm_remove,
+};
+module_platform_driver(ingenic_drm_driver);
+
+MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
+MODULE_DESCRIPTION("DRM driver for the Ingenic SoCs\n");
+MODULE_LICENSE("GPL v2");
-- 
2.11.0

