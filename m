Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jul 2011 18:34:55 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:48430 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491144Ab1GUQeW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Jul 2011 18:34:22 +0200
Received: by fxd20 with SMTP id 20so2711768fxd.36
        for <multiple recipients>; Thu, 21 Jul 2011 09:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=0H+GzBgACGzw0DEicWYRrhg/bNvsLLUvqUHkG43fAgc=;
        b=ErjL/NZ7eodm5ewbnycf86R5dML+d7PGn74rOrPq5Y67yw+zbF4nE0U3+vA3qFO1Hd
         C/X/b/rd+O0tVvwyWi2DK4OSy0PHLzY7sFHv9gIGJG6dLMM2VmsdUj/mw68+1kJuq17k
         OwUMg8PEJGo/g4w9GLamghxVWZTxBM8a7AgrM=
Received: by 10.223.52.155 with SMTP id i27mr501350fag.139.1311266057542;
        Thu, 21 Jul 2011 09:34:17 -0700 (PDT)
Received: from localhost.localdomain (188-22-154-193.adsl.highway.telekom.at [188.22.154.193])
        by mx.google.com with ESMTPS id j19sm1490495faa.41.2011.07.21.09.34.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Jul 2011 09:34:16 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     alsa-devel@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH V2 1/2] ALSA: Alchemy AC97C/I2SC audio support
Date:   Thu, 21 Jul 2011 18:34:09 +0200
Message-Id: <1311266050-22199-2-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1311266050-22199-1-git-send-email-manuel.lauss@googlemail.com>
References: <1311266050-22199-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 30653
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15239

This patch adds ASoC support for the AC97 and I2S controllers
on the old Au1000/Au1500/Au1100 chips and a universal machine
driver for the Db1000/Db1500/Db1100 boards.

AC97 Tested on a Db1500.  I2S untested since none of the boards
actually have and I2S codec wired up.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
V2: added untested I2S controller driver for completeness, removed the audio
    defines from the au1000 header as well.

 arch/mips/alchemy/devboards/db1x00/platform.c |   37 ++
 arch/mips/include/asm/mach-au1x00/au1000.h    |   61 ----
 sound/soc/au1x/Kconfig                        |   28 ++
 sound/soc/au1x/Makefile                       |   10 +
 sound/soc/au1x/ac97c.c                        |  398 +++++++++++++++++++++
 sound/soc/au1x/db1000.c                       |   75 ++++
 sound/soc/au1x/dma.c                          |  470 +++++++++++++++++++++++++
 sound/soc/au1x/i2sc.c                         |  353 +++++++++++++++++++
 sound/soc/au1x/psc.h                          |   31 ++-
 9 files changed, 1393 insertions(+), 70 deletions(-)
 create mode 100644 sound/soc/au1x/ac97c.c
 create mode 100644 sound/soc/au1x/db1000.c
 create mode 100644 sound/soc/au1x/dma.c
 create mode 100644 sound/soc/au1x/i2sc.c

diff --git a/arch/mips/alchemy/devboards/db1x00/platform.c b/arch/mips/alchemy/devboards/db1x00/platform.c
index 978d5ab..e2025ac 100644
--- a/arch/mips/alchemy/devboards/db1x00/platform.c
+++ b/arch/mips/alchemy/devboards/db1x00/platform.c
@@ -19,8 +19,11 @@
  */
 
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/platform_device.h>
 
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/au1000_dma.h>
 #include <asm/mach-au1x00/au1xxx.h>
 #include <asm/mach-db1x00/bcsr.h>
 #include "../platform.h"
@@ -85,6 +88,36 @@
 #endif
 #endif
 
+static struct resource alchemy_ac97c_res[] = {
+	[0] = {
+		.start	= AU1000_AC97_PHYS_ADDR,
+		.end	= AU1000_AC97_PHYS_ADDR + 0xfff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= DMA_ID_AC97C_TX,
+		.end	= DMA_ID_AC97C_TX,
+		.flags	= IORESOURCE_DMA,
+	},
+	[2] = {
+		.start	= DMA_ID_AC97C_RX,
+		.end	= DMA_ID_AC97C_RX,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct platform_device alchemy_ac97c_dev = {
+	.name		= "alchemy-ac97c",
+	.id		= -1,
+	.resource	= alchemy_ac97c_res,
+	.num_resources	= ARRAY_SIZE(alchemy_ac97c_res),
+};
+
+static struct platform_device db1x00_codec_dev = {
+	.name		= "ac97-codec",
+	.id		= -1,
+};
+
 static int __init db1xxx_dev_init(void)
 {
 #ifdef DB1XXX_HAS_PCMCIA
@@ -113,6 +146,10 @@ static int __init db1xxx_dev_init(void)
 				    1);
 #endif
 	db1x_register_norflash(BOARD_FLASH_SIZE, BOARD_FLASH_WIDTH, F_SWAPPED);
+
+	platform_device_register(&db1x00_codec_dev);
+	platform_device_register(&alchemy_ac97c_dev);
+
 	return 0;
 }
 device_initcall(db1xxx_dev_init);
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index f260ebe..6de3c43 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -927,36 +927,6 @@ enum soc_au1200_ints {
 #define SYS_RTCMATCH2		(SYS_BASE + 0x54)
 #define SYS_RTCREAD		(SYS_BASE + 0x58)
 
-/* I2S Controller */
-#define I2S_DATA		0xB1000000
-#  define I2S_DATA_MASK 	0xffffff
-#define I2S_CONFIG		0xB1000004
-#  define I2S_CONFIG_XU 	(1 << 25)
-#  define I2S_CONFIG_XO 	(1 << 24)
-#  define I2S_CONFIG_RU 	(1 << 23)
-#  define I2S_CONFIG_RO 	(1 << 22)
-#  define I2S_CONFIG_TR 	(1 << 21)
-#  define I2S_CONFIG_TE 	(1 << 20)
-#  define I2S_CONFIG_TF 	(1 << 19)
-#  define I2S_CONFIG_RR 	(1 << 18)
-#  define I2S_CONFIG_RE 	(1 << 17)
-#  define I2S_CONFIG_RF 	(1 << 16)
-#  define I2S_CONFIG_PD 	(1 << 11)
-#  define I2S_CONFIG_LB 	(1 << 10)
-#  define I2S_CONFIG_IC 	(1 << 9)
-#  define I2S_CONFIG_FM_BIT	7
-#  define I2S_CONFIG_FM_MASK	(0x3 << I2S_CONFIG_FM_BIT)
-#    define I2S_CONFIG_FM_I2S	(0x0 << I2S_CONFIG_FM_BIT)
-#    define I2S_CONFIG_FM_LJ	(0x1 << I2S_CONFIG_FM_BIT)
-#    define I2S_CONFIG_FM_RJ	(0x2 << I2S_CONFIG_FM_BIT)
-#  define I2S_CONFIG_TN 	(1 << 6)
-#  define I2S_CONFIG_RN 	(1 << 5)
-#  define I2S_CONFIG_SZ_BIT	0
-#  define I2S_CONFIG_SZ_MASK	(0x1F << I2S_CONFIG_SZ_BIT)
-
-#define I2S_CONTROL		0xB1000008
-#  define I2S_CONTROL_D 	(1 << 1)
-#  define I2S_CONTROL_CE	(1 << 0)
 
 /* USB Host Controller */
 #ifndef USB_OHCI_LEN
@@ -1436,37 +1406,6 @@ enum soc_au1200_ints {
 #define SYS_CPUPLL		0xB1900060
 #define SYS_AUXPLL		0xB1900064
 
-/* AC97 Controller */
-#define AC97C_CONFIG		0xB0000000
-#  define AC97C_RECV_SLOTS_BIT	13
-#  define AC97C_RECV_SLOTS_MASK (0x3ff << AC97C_RECV_SLOTS_BIT)
-#  define AC97C_XMIT_SLOTS_BIT	3
-#  define AC97C_XMIT_SLOTS_MASK (0x3ff << AC97C_XMIT_SLOTS_BIT)
-#  define AC97C_SG		(1 << 2)
-#  define AC97C_SYNC		(1 << 1)
-#  define AC97C_RESET		(1 << 0)
-#define AC97C_STATUS		0xB0000004
-#  define AC97C_XU		(1 << 11)
-#  define AC97C_XO		(1 << 10)
-#  define AC97C_RU		(1 << 9)
-#  define AC97C_RO		(1 << 8)
-#  define AC97C_READY		(1 << 7)
-#  define AC97C_CP		(1 << 6)
-#  define AC97C_TR		(1 << 5)
-#  define AC97C_TE		(1 << 4)
-#  define AC97C_TF		(1 << 3)
-#  define AC97C_RR		(1 << 2)
-#  define AC97C_RE		(1 << 1)
-#  define AC97C_RF		(1 << 0)
-#define AC97C_DATA		0xB0000008
-#define AC97C_CMD		0xB000000C
-#  define AC97C_WD_BIT		16
-#  define AC97C_READ		(1 << 7)
-#  define AC97C_INDEX_MASK	0x7f
-#define AC97C_CNTRL		0xB0000010
-#  define AC97C_RS		(1 << 1)
-#  define AC97C_CE		(1 << 0)
-
 #if defined(CONFIG_SOC_AU1500) || defined(CONFIG_SOC_AU1550)
 /* Au1500 PCI Controller */
 #define Au1500_CFG_BASE 	0xB4005000	/* virtual, KSEG1 addr */
diff --git a/sound/soc/au1x/Kconfig b/sound/soc/au1x/Kconfig
index 4b67140..6d59254 100644
--- a/sound/soc/au1x/Kconfig
+++ b/sound/soc/au1x/Kconfig
@@ -18,10 +18,38 @@ config SND_SOC_AU1XPSC_AC97
 	select SND_AC97_CODEC
 	select SND_SOC_AC97_BUS
 
+##
+## Au1000/1500/1100 DMA + AC97C/I2SC
+##
+config SND_SOC_AU1XAUDIO
+	tristate "SoC Audio for Au1000/Au1500/Au1100"
+	depends on MIPS_ALCHEMY
+	help
+	  This is a driver set for the AC97 unit and the
+	  old DMA controller as found on the Au1000/Au1500/Au1100 chips.
+
+config SND_SOC_AU1XAC97C
+	tristate
+	select AC97_BUS
+	select SND_AC97_CODEC
+	select SND_SOC_AC97_BUS
+
+config SND_SOC_AU1XI2SC
+	tristate
+
 
 ##
 ## Boards
 ##
+config SND_SOC_DB1000
+	tristate "DB1000 Audio support"
+	depends on SND_SOC_AU1XAUDIO
+	select SND_SOC_AU1XAC97C
+	select SND_SOC_AC97_CODEC
+	help
+	  Select this option to enable AC97 audio on the early DB1x00 series
+	  of boards (DB1000/DB1500/DB1100).
+
 config SND_SOC_DB1200
 	tristate "DB1200 AC97+I2S audio support"
 	depends on SND_SOC_AU1XPSC
diff --git a/sound/soc/au1x/Makefile b/sound/soc/au1x/Makefile
index 1687307..9207105 100644
--- a/sound/soc/au1x/Makefile
+++ b/sound/soc/au1x/Makefile
@@ -3,11 +3,21 @@ snd-soc-au1xpsc-dbdma-objs := dbdma2.o
 snd-soc-au1xpsc-i2s-objs := psc-i2s.o
 snd-soc-au1xpsc-ac97-objs := psc-ac97.o
 
+# Au1000/1500/1100 Audio units
+snd-soc-au1x-dma-objs := dma.o
+snd-soc-au1x-ac97c-objs := ac97c.o
+snd-soc-au1x-i2sc-objs := i2sc.o
+
 obj-$(CONFIG_SND_SOC_AU1XPSC) += snd-soc-au1xpsc-dbdma.o
 obj-$(CONFIG_SND_SOC_AU1XPSC_I2S) += snd-soc-au1xpsc-i2s.o
 obj-$(CONFIG_SND_SOC_AU1XPSC_AC97) += snd-soc-au1xpsc-ac97.o
+obj-$(CONFIG_SND_SOC_AU1XAUDIO) += snd-soc-au1x-dma.o
+obj-$(CONFIG_SND_SOC_AU1XAC97C) += snd-soc-au1x-ac97c.o
+obj-$(CONFIG_SND_SOC_AU1XI2SC) += snd-soc-au1x-i2sc.o
 
 # Boards
+snd-soc-db1000-objs := db1000.o
 snd-soc-db1200-objs := db1200.o
 
+obj-$(CONFIG_SND_SOC_DB1000) += snd-soc-db1000.o
 obj-$(CONFIG_SND_SOC_DB1200) += snd-soc-db1200.o
diff --git a/sound/soc/au1x/ac97c.c b/sound/soc/au1x/ac97c.c
new file mode 100644
index 0000000..8fc25d0
--- /dev/null
+++ b/sound/soc/au1x/ac97c.c
@@ -0,0 +1,398 @@
+/*
+ * Au1000/Au1500/Au1100 AC97C controller driver for ASoC
+ *
+ * (c) 2011 Manuel Lauss <manuel.lauss@googlemail.com>
+ *
+ * based on the old ALSA driver by Charles Eidsness.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/suspend.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/au1xxx_psc.h>
+
+#include "psc.h"
+
+/*#define AC_DEBUG*/
+
+#define MSG(x...)	printk(KERN_ERR "ac97c: " x)
+#ifdef AC_DEBUG
+#define DBG(x...)	MSG(x)
+#else
+#define DBG(x...)	do {} while (0)
+#endif
+
+/* register offsets and bits */
+#define AC97_CONFIG	0x00
+#define AC97_STATUS	0x04
+#define AC97_DATA	0x08
+#define AC97_CMDRESP	0x0c
+#define AC97_ENABLE	0x10
+
+#define CFG_RC(x)	(((x) & 0x3ff) << 13)
+#define CFG_XS(x)	(((x) & 0x3ff) << 3)
+#define CFG_SG		(1 << 2)	/* sync gate */
+#define CFG_SN		(1 << 1)	/* sync control */
+#define CFG_RS		(1 << 0)	/* acrst# control */
+#define STAT_XU		(1 << 11)	/* tx underflow */
+#define STAT_XO		(1 << 10)	/* tx overflow */
+#define STAT_RU		(1 << 9)	/* rx underflow */
+#define STAT_RO		(1 << 8)	/* rx overflow */
+#define STAT_RD		(1 << 7)	/* codec ready */
+#define STAT_CP		(1 << 6)	/* command pending */
+#define STAT_TE		(1 << 4)	/* tx fifo empty */
+#define STAT_TF		(1 << 3)	/* tx fifo full */
+#define STAT_RE		(1 << 1)	/* rx fifo empty */
+#define STAT_RF		(1 << 0)	/* rx fifo full */
+#define CMD_SET_DATA(x)	(((x) & 0xffff) << 16)
+#define CMD_GET_DATA(x)	((x) & 0xffff)
+#define CMD_READ	(1 << 7)
+#define CMD_WRITE	(0 << 7)
+#define CMD_IDX(x)	((x) & 0x7f)
+#define EN_D		(1 << 1)	/* DISable bit */
+#define EN_CE		(1 << 0)	/* clock enable bit */
+
+/* how often to retry failed codec register reads/writes */
+#define AC97_RW_RETRIES	5
+
+#define AC97_DIR	\
+	(SND_SOC_DAIDIR_PLAYBACK | SND_SOC_DAIDIR_CAPTURE)
+
+#define AC97_RATES	\
+	SNDRV_PCM_RATE_8000_44100
+
+#define AC97_FMTS	\
+	SNDRV_PCM_FMTBIT_S16_LE
+
+struct ac97c_ctx {
+	void __iomem *mmio;
+
+	unsigned long cfg;
+
+	struct mutex lock;	/* codec access lock */
+
+	struct platform_device *dmapd;
+};
+
+/* instance data. There can be only one, MacLeod!!!!, fortunately there IS only
+ * once AC97C on early Alchemy chips.
+ */
+static struct ac97c_ctx *ac97c_workdata;
+
+
+#define ac97_to_ctx(x)		ac97c_workdata
+
+static inline unsigned long RD(struct ac97c_ctx *ctx, int reg)
+{
+	return __raw_readl(ctx->mmio + reg);
+}
+
+static inline void WR(struct ac97c_ctx *ctx, int reg, unsigned long v)
+{
+	__raw_writel(v, ctx->mmio + reg);
+	wmb();
+}
+
+static unsigned short au1xac97c_ac97_read(struct snd_ac97 *ac97,
+					  unsigned short r)
+{
+	struct ac97c_ctx *ctx = ac97_to_ctx(ac97);
+	unsigned int tmo, retry;
+	unsigned long data;
+
+	data = ~0;
+	retry = AC97_RW_RETRIES;
+	do {
+		mutex_lock(&ctx->lock);
+
+		tmo = 5;
+		while ((RD(ctx, AC97_STATUS) & STAT_CP) && tmo--)
+			udelay(21);	/* wait an ac97 frame time */
+		if (!tmo) {
+			DBG("ac97rd timeout #1\n");
+			goto next;
+		}
+
+		WR(ctx, AC97_CMDRESP, CMD_IDX(r) | CMD_READ);
+
+		/* stupid errata: data is only valid for 21us, so
+		 * poll, forrest, poll...
+		 */
+		tmo = 0x10000;
+		while ((RD(ctx, AC97_STATUS) & STAT_CP) && tmo--)
+			asm volatile ("nop");
+		data = RD(ctx, AC97_CMDRESP);
+
+		if (!tmo)
+			DBG("ac97rd timeout #2\n");
+
+next:
+		mutex_unlock(&ctx->lock);
+	} while (--retry && !tmo);
+
+	DBG("AC97RD %04x %04lx %d\n", r, data, retry);
+
+	return retry ? data & 0xffff : 0xffff;
+}
+
+static void au1xac97c_ac97_write(struct snd_ac97 *ac97, unsigned short r,
+				 unsigned short v)
+{
+	struct ac97c_ctx *ctx = ac97_to_ctx(ac97);
+	unsigned int tmo, retry;
+
+	retry = AC97_RW_RETRIES;
+	do {
+		mutex_lock(&ctx->lock);
+
+		for (tmo = 5; (RD(ctx, AC97_STATUS) & STAT_CP) && tmo; tmo--)
+			udelay(21);	/* wait an ac97 frame time */
+		if (!tmo) {
+			DBG("ac97wr timeout #1\n");
+			goto next;
+		}
+
+		WR(ctx, AC97_CMDRESP, CMD_WRITE | CMD_IDX(r) | CMD_SET_DATA(v));
+
+		for (tmo = 10; (RD(ctx, AC97_STATUS) & STAT_CP) && tmo; tmo--)
+			udelay(21);	/* wait an ac97 frame time */
+		if (!tmo)
+			DBG("ac97wr timeout #2\n");
+next:
+		mutex_unlock(&ctx->lock);
+	} while (--retry && !tmo);
+
+	DBG("AC97WR %04x %04x %d\n", r, v, retry);
+}
+
+static void au1xac97c_ac97_warm_reset(struct snd_ac97 *ac97)
+{
+	struct ac97c_ctx *ctx = ac97_to_ctx(ac97);
+
+	DBG("entering WARM_RESET\n");
+
+	WR(ctx, AC97_CONFIG, ctx->cfg | CFG_SG | CFG_SN);
+	msleep(20);
+	WR(ctx, AC97_CONFIG, ctx->cfg | CFG_SG);
+	WR(ctx, AC97_CONFIG, ctx->cfg);
+
+	DBG("leaving WARM_RESET\n");
+}
+
+static void au1xac97c_ac97_cold_reset(struct snd_ac97 *ac97)
+{
+	struct ac97c_ctx *ctx = ac97_to_ctx(ac97);
+	int i;
+
+	DBG("entering COLD_RESET\n");
+
+	WR(ctx, AC97_CONFIG, ctx->cfg | CFG_RS);
+	msleep(500);
+	WR(ctx, AC97_CONFIG, ctx->cfg);
+
+	/* wait for codec ready */
+	i = 1000;
+	while (((RD(ctx, AC97_STATUS) & STAT_RD) == 0) && --i)
+		msleep(20);
+	if (!i)
+		printk(KERN_ERR "ac97c: codec not ready\n");
+
+	DBG("leaving COLD_RESET\n");
+}
+
+/* AC97 controller operations */
+struct snd_ac97_bus_ops soc_ac97_ops = {
+	.read		= au1xac97c_ac97_read,
+	.write		= au1xac97c_ac97_write,
+	.reset		= au1xac97c_ac97_cold_reset,
+	.warm_reset	= au1xac97c_ac97_warm_reset,
+};
+EXPORT_SYMBOL_GPL(soc_ac97_ops);
+
+static int au1xac97c_hw_params(struct snd_pcm_substream *substream,
+			       struct snd_pcm_hw_params *params,
+			       struct snd_soc_dai *dai)
+{
+	return 0;
+}
+
+static int au1xac97c_trigger(struct snd_pcm_substream *substream,
+			     int cmd, struct snd_soc_dai *dai)
+{
+	return 0;
+}
+
+static int au1xac97c_dai_probe(struct snd_soc_dai *dai)
+{
+	return ac97c_workdata ? 0 : -ENODEV;
+}
+
+static struct snd_soc_dai_ops au1xac97c_dai_ops = {
+	.trigger	= au1xac97c_trigger,
+	.hw_params	= au1xac97c_hw_params,
+};
+
+static struct snd_soc_dai_driver au1xac97c_dai_driver = {
+	.name			= AC97C_DAINAME,
+	.ac97_control		= 1,
+	.probe			= au1xac97c_dai_probe,
+	.playback = {
+		.rates		= AC97_RATES,
+		.formats	= AC97_FMTS,
+		.channels_min	= 2,
+		.channels_max	= 2,
+	},
+	.capture = {
+		.rates		= AC97_RATES,
+		.formats	= AC97_FMTS,
+		.channels_min	= 2,
+		.channels_max	= 2,
+	},
+	.ops = &au1xac97c_dai_ops,
+};
+
+static int __devinit au1xac97c_drvprobe(struct platform_device *pdev)
+{
+	int ret;
+	struct resource *r;
+	struct ac97c_ctx *ctx;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	mutex_init(&ctx->lock);
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r) {
+		ret = -ENODEV;
+		goto out0;
+	}
+
+	ret = -EBUSY;
+	if (!request_mem_region(r->start, resource_size(r), pdev->name))
+		goto out0;
+
+	ctx->mmio = ioremap_nocache(r->start, resource_size(r));
+	if (!ctx->mmio)
+		goto out1;
+
+	/* switch it on */
+	WR(ctx, AC97_ENABLE, EN_D | EN_CE);
+	WR(ctx, AC97_ENABLE, EN_CE);
+
+	ctx->cfg = CFG_RC(3) | CFG_XS(3);
+	WR(ctx, AC97_CONFIG, ctx->cfg);
+
+	platform_set_drvdata(pdev, ctx);
+
+	ret = snd_soc_register_dai(&pdev->dev, &au1xac97c_dai_driver);
+	if (ret)
+		goto out1;
+
+	ctx->dmapd = alchemy_pcm_add(pdev, 0);	/* 0 == AC97 */
+	if (ctx->dmapd) {
+		ac97c_workdata = ctx;
+		return 0;
+	}
+
+	snd_soc_unregister_dai(&pdev->dev);
+out1:
+	release_mem_region(r->start, resource_size(r));
+out0:
+	kfree(ctx);
+	return ret;
+}
+
+static int __devexit au1xac97c_drvremove(struct platform_device *pdev)
+{
+	struct ac97c_ctx *ctx = platform_get_drvdata(pdev);
+	struct resource *r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	if (ctx->dmapd)
+		alchemy_pcm_destroy(ctx->dmapd);
+
+	snd_soc_unregister_dai(&pdev->dev);
+
+	WR(ctx, AC97_ENABLE, EN_D);	/* clock off, disable */
+
+	iounmap(ctx->mmio);
+	release_mem_region(r->start, resource_size(r));
+	kfree(ctx);
+
+	ac97c_workdata = NULL;	/* MDEV */
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int au1xac97c_drvsuspend(struct device *dev)
+{
+	struct ac97c_ctx *ctx = dev_get_drvdata(dev);
+
+	WR(ctx, AC97_ENABLE, EN_D);	/* clock off, disable */
+
+	return 0;
+}
+
+static int au1xac97c_drvresume(struct device *dev)
+{
+	struct ac97c_ctx *ctx = dev_get_drvdata(dev);
+
+	WR(ctx, AC97_ENABLE, EN_D | EN_CE);
+	WR(ctx, AC97_ENABLE, EN_CE);
+	WR(ctx, AC97_CONFIG, ctx->cfg);
+
+	return 0;
+}
+
+static const struct dev_pm_ops au1xpscac97_pmops = {
+	.suspend	= au1xac97c_drvsuspend,
+	.resume		= au1xac97c_drvresume,
+};
+
+#define AU1XPSCAC97_PMOPS (&au1xpscac97_pmops)
+
+#else
+
+#define AU1XPSCAC97_PMOPS NULL
+
+#endif
+
+static struct platform_driver au1xac97c_driver = {
+	.driver	= {
+		.name	= "alchemy-ac97c",
+		.owner	= THIS_MODULE,
+		.pm	= AU1XPSCAC97_PMOPS,
+	},
+	.probe		= au1xac97c_drvprobe,
+	.remove		= __devexit_p(au1xac97c_drvremove),
+};
+
+static int __init au1xac97c_load(void)
+{
+	ac97c_workdata = NULL;
+	return platform_driver_register(&au1xac97c_driver);
+}
+
+static void __exit au1xac97c_unload(void)
+{
+	platform_driver_unregister(&au1xac97c_driver);
+}
+
+module_init(au1xac97c_load);
+module_exit(au1xac97c_unload);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Au1000/1500/1100 AC97C ALSA ASoC audio driver");
+MODULE_AUTHOR("Manuel Lauss");
diff --git a/sound/soc/au1x/db1000.c b/sound/soc/au1x/db1000.c
new file mode 100644
index 0000000..9368b5d
--- /dev/null
+++ b/sound/soc/au1x/db1000.c
@@ -0,0 +1,75 @@
+/*
+ * DB1000/DB1500/DB1100 ASoC audio fabric support code.
+ *
+ * (c) 2011 Manuel Lauss <manuel.lauss@googlemail.com>
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/timer.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-db1x00/bcsr.h>
+
+#include "psc.h"
+
+/*-------------------------  AC97 PART  ---------------------------*/
+
+static struct snd_soc_dai_link db1000_ac97_dai = {
+	.name		= "AC97",
+	.stream_name	= "AC97 HiFi",
+	.codec_dai_name	= "ac97-hifi",
+	.cpu_dai_name	= AC97C_DAINAME,
+	.platform_name	= AC97C_DMANAME,
+	.codec_name	= "ac97-codec",
+};
+
+static struct snd_soc_card db1000_ac97_machine = {
+	.name		= "DB1000_AC97",
+	.dai_link	= &db1000_ac97_dai,
+	.num_links	= 1,
+};
+
+/*-------------------------  COMMON PART  ---------------------------*/
+
+static struct platform_device *db1000_asoc97_dev;
+
+static int __init db1000_audio_load(void)
+{
+	int ret, id;
+
+	/* impostor check */
+	id = BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI));
+
+	ret = -ENOMEM;
+	db1000_asoc97_dev = platform_device_alloc("soc-audio", 0);
+	if (!db1000_asoc97_dev)
+		goto out;
+
+	platform_set_drvdata(db1000_asoc97_dev, &db1000_ac97_machine);
+	ret = platform_device_add(db1000_asoc97_dev);
+
+	if (ret) {
+		platform_device_put(db1000_asoc97_dev);
+		db1000_asoc97_dev = NULL;
+	}
+out:
+	return ret;
+}
+
+static void __exit db1000_audio_unload(void)
+{
+	platform_device_unregister(db1000_asoc97_dev);
+}
+
+module_init(db1000_audio_load);
+module_exit(db1000_audio_unload);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("DB1000/DB1500/DB1100 ASoC audio support");
+MODULE_AUTHOR("Manuel Lauss");
diff --git a/sound/soc/au1x/dma.c b/sound/soc/au1x/dma.c
new file mode 100644
index 0000000..0f7d90a
--- /dev/null
+++ b/sound/soc/au1x/dma.c
@@ -0,0 +1,470 @@
+/*
+ * Au1000/Au1500/Au1100 Audio DMA support.
+ *
+ * (c) 2011 Manuel Lauss <manuel.lauss@googlemail.com>
+ *
+ * copied almost verbatim from the old ALSA driver, written by
+ *			Charles Eidsness <charles@cooper-street.com>
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/dma-mapping.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/au1000_dma.h>
+
+#include "psc.h"
+
+/*#define PCM_DEBUG*/
+
+#define MSG(x...)	printk(KERN_INFO "alchemy-pcm: " x)
+#ifdef PCM_DEBUG
+#define DBG(x...)		MSG(x)
+#else
+#define DBG(x...)	do {} while (0)
+#endif
+
+#define ALCHEMY_PCM_FMTS					\
+	(SNDRV_PCM_FMTBIT_S8     | SNDRV_PCM_FMTBIT_U8 |	\
+	 SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S16_BE |	\
+	 SNDRV_PCM_FMTBIT_U16_LE | SNDRV_PCM_FMTBIT_U16_BE |	\
+	 SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S32_BE |	\
+	 SNDRV_PCM_FMTBIT_U32_LE | SNDRV_PCM_FMTBIT_U32_BE |	\
+	 0)
+
+
+struct pcm_period {
+	u32 start;
+	u32 relative_end;	/* relative to start of buffer */
+	struct pcm_period *next;
+};
+
+struct audio_stream {
+	struct snd_pcm_substream *substream;
+	int dma;
+	struct pcm_period *buffer;
+	unsigned int period_size;
+	unsigned int periods;
+};
+
+struct alchemy_pcm_ctx {
+	struct audio_stream stream[2];	/* playback & capture */
+};
+
+static void au1000_release_dma_link(struct audio_stream *stream)
+{
+	struct pcm_period *pointer;
+	struct pcm_period *pointer_next;
+
+	stream->period_size = 0;
+	stream->periods = 0;
+	pointer = stream->buffer;
+	if (!pointer)
+		return;
+	do {
+		pointer_next = pointer->next;
+		kfree(pointer);
+		pointer = pointer_next;
+	} while (pointer != stream->buffer);
+	stream->buffer = NULL;
+}
+
+static int au1000_setup_dma_link(struct audio_stream *stream,
+				 unsigned int period_bytes,
+				 unsigned int periods)
+{
+	struct snd_pcm_substream *substream = stream->substream;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct pcm_period *pointer;
+	unsigned long dma_start;
+	int i;
+
+	dma_start = virt_to_phys(runtime->dma_area);
+
+	if (stream->period_size == period_bytes &&
+	    stream->periods == periods)
+		return 0; /* not changed */
+
+	au1000_release_dma_link(stream);
+
+	stream->period_size = period_bytes;
+	stream->periods = periods;
+
+	stream->buffer = kmalloc(sizeof(struct pcm_period), GFP_KERNEL);
+	if (!stream->buffer)
+		return -ENOMEM;
+	pointer = stream->buffer;
+	for (i = 0; i < periods; i++) {
+		pointer->start = (u32)(dma_start + (i * period_bytes));
+		pointer->relative_end = (u32) (((i+1) * period_bytes) - 0x1);
+		if (i < periods - 1) {
+			pointer->next = kmalloc(sizeof(struct pcm_period),
+						GFP_KERNEL);
+			if (!pointer->next) {
+				au1000_release_dma_link(stream);
+				return -ENOMEM;
+			}
+			pointer = pointer->next;
+		}
+	}
+	pointer->next = stream->buffer;
+	return 0;
+}
+
+static void au1000_dma_stop(struct audio_stream *stream)
+{
+	if (stream->buffer)
+		disable_dma(stream->dma);
+}
+
+static void au1000_dma_start(struct audio_stream *stream)
+{
+	if (!stream->buffer)
+		return;
+
+	init_dma(stream->dma);
+	if (get_dma_active_buffer(stream->dma) == 0) {
+		clear_dma_done0(stream->dma);
+		set_dma_addr0(stream->dma, stream->buffer->start);
+		set_dma_count0(stream->dma, stream->period_size >> 1);
+		set_dma_addr1(stream->dma, stream->buffer->next->start);
+		set_dma_count1(stream->dma, stream->period_size >> 1);
+	} else {
+		clear_dma_done1(stream->dma);
+		set_dma_addr1(stream->dma, stream->buffer->start);
+		set_dma_count1(stream->dma, stream->period_size >> 1);
+		set_dma_addr0(stream->dma, stream->buffer->next->start);
+		set_dma_count0(stream->dma, stream->period_size >> 1);
+	}
+	enable_dma_buffers(stream->dma);
+	start_dma(stream->dma);
+}
+
+static irqreturn_t au1000_dma_interrupt(int irq, void *ptr)
+{
+	struct audio_stream *stream = (struct audio_stream *)ptr;
+	struct snd_pcm_substream *substream = stream->substream;
+
+	switch (get_dma_buffer_done(stream->dma)) {
+	case DMA_D0:
+		stream->buffer = stream->buffer->next;
+		clear_dma_done0(stream->dma);
+		set_dma_addr0(stream->dma, stream->buffer->next->start);
+		set_dma_count0(stream->dma, stream->period_size >> 1);
+		enable_dma_buffer0(stream->dma);
+		break;
+	case DMA_D1:
+		stream->buffer = stream->buffer->next;
+		clear_dma_done1(stream->dma);
+		set_dma_addr1(stream->dma, stream->buffer->next->start);
+		set_dma_count1(stream->dma, stream->period_size >> 1);
+		enable_dma_buffer1(stream->dma);
+		break;
+	case (DMA_D0 | DMA_D1):
+		DBG("DMA %d missed interrupt.\n", stream->dma);
+		au1000_dma_stop(stream);
+		au1000_dma_start(stream);
+		break;
+	case (~DMA_D0 & ~DMA_D1):
+		DBG("DMA %d empty irq.\n", stream->dma);
+	}
+	snd_pcm_period_elapsed(substream);
+	return IRQ_HANDLED;
+}
+
+static const struct snd_pcm_hardware alchemy_pcm_hardware = {
+	.info		  = SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
+			    SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BATCH,
+	.formats	  = ALCHEMY_PCM_FMTS,
+	.rates		  = SNDRV_PCM_RATE_8000_192000,
+	.rate_min	  = SNDRV_PCM_RATE_8000,
+	.rate_max	  = SNDRV_PCM_RATE_192000,
+	.channels_min	  = 2,
+	.channels_max	  = 2,
+	.period_bytes_min = 1024,
+	.period_bytes_max = 16 * 1024 - 1,
+	.periods_min	  = 4,
+	.periods_max	  = 255,
+	.buffer_bytes_max = 128 * 1024,
+	.fifo_size	  = 16,
+};
+
+static inline struct alchemy_pcm_ctx *ss_to_ctx(struct snd_pcm_substream *ss)
+{
+	struct snd_soc_pcm_runtime *rtd = ss->private_data;
+	return snd_soc_platform_get_drvdata(rtd->platform);
+}
+
+static inline struct audio_stream *ss_to_as(struct snd_pcm_substream *ss)
+{
+	struct alchemy_pcm_ctx *ctx = ss_to_ctx(ss);
+	return &(ctx->stream[SUBSTREAM_TYPE(ss)]);
+}
+
+static int alchemy_pcm_open(struct snd_pcm_substream *substream)
+{
+	struct alchemy_pcm_ctx *ctx = ss_to_ctx(substream);
+	int stype = SUBSTREAM_TYPE(substream);
+
+	ctx->stream[stype].substream = substream;
+	ctx->stream[stype].buffer = NULL;
+	snd_soc_set_runtime_hwparams(substream, &alchemy_pcm_hardware);
+
+	return 0;
+}
+
+static int alchemy_pcm_close(struct snd_pcm_substream *substream)
+{
+	struct alchemy_pcm_ctx *ctx = ss_to_ctx(substream);
+
+	ctx->stream[SUBSTREAM_TYPE(substream)].substream = NULL;
+
+	return 0;
+}
+
+static int alchemy_pcm_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *hw_params)
+{
+	struct audio_stream *stream = ss_to_as(substream);
+	int err;
+
+	err = snd_pcm_lib_malloc_pages(substream,
+				       params_buffer_bytes(hw_params));
+	if (err < 0)
+		return err;
+	return au1000_setup_dma_link(stream,
+				     params_period_bytes(hw_params),
+				     params_periods(hw_params));
+}
+
+static int alchemy_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	struct audio_stream *stream = ss_to_as(substream);
+	au1000_release_dma_link(stream);
+	return snd_pcm_lib_free_pages(substream);
+}
+
+static int alchemy_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct audio_stream *stream = ss_to_as(substream);
+	int err = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		au1000_dma_start(stream);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		au1000_dma_stop(stream);
+		break;
+	default:
+		err = -EINVAL;
+		break;
+	}
+	return err;
+}
+
+static snd_pcm_uframes_t alchemy_pcm_pointer(struct snd_pcm_substream *ss)
+{
+	struct audio_stream *stream = ss_to_as(ss);
+	long location;
+
+	location = get_dma_residue(stream->dma);
+	location = stream->buffer->relative_end - location;
+	if (location == -1)
+		location = 0;
+	return bytes_to_frames(ss->runtime, location);
+}
+
+static struct snd_pcm_ops alchemy_pcm_ops = {
+	.open			= alchemy_pcm_open,
+	.close			= alchemy_pcm_close,
+	.ioctl			= snd_pcm_lib_ioctl,
+	.hw_params	        = alchemy_pcm_hw_params,
+	.hw_free	        = alchemy_pcm_hw_free,
+	.trigger		= alchemy_pcm_trigger,
+	.pointer		= alchemy_pcm_pointer,
+};
+
+static void alchemy_pcm_free_dma_buffers(struct snd_pcm *pcm)
+{
+	snd_pcm_lib_preallocate_free_for_all(pcm);
+}
+
+static int alchemy_pcm_new(struct snd_card *card,
+			   struct snd_soc_dai *dai,
+			   struct snd_pcm *pcm)
+{
+	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
+		snd_dma_continuous_data(GFP_KERNEL), 65536, (4096 * 1024) - 1);
+
+	return 0;
+}
+
+struct snd_soc_platform_driver alchemy_pcm_soc_platform = {
+	.ops		= &alchemy_pcm_ops,
+	.pcm_new	= alchemy_pcm_new,
+	.pcm_free	= alchemy_pcm_free_dma_buffers,
+};
+
+
+static int __devinit alchemy_pcm_drvprobe(struct platform_device *pdev)
+{
+	struct alchemy_pcm_ctx *ctx;
+	struct resource *r;
+	int ret;
+
+	DBG("probing %s\n", pdev->name);
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+	if (!r) {
+		ret = -ENODEV;
+		goto out1;
+	}
+	ctx->stream[PCM_TX].dma = request_au1000_dma(r->start, "audio-tx",
+					au1000_dma_interrupt, IRQF_DISABLED,
+					&ctx->stream[PCM_TX]);
+	set_dma_mode(ctx->stream[PCM_TX].dma,
+		     get_dma_mode(ctx->stream[PCM_TX].dma) & ~DMA_NC);
+
+	/* RX DMA */
+	r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
+	if (!r) {
+		ret = -ENODEV;
+		goto out2;
+	}
+	ctx->stream[PCM_RX].dma = request_au1000_dma(r->start, "audio-rx",
+					au1000_dma_interrupt, IRQF_DISABLED,
+					&ctx->stream[PCM_RX]);
+	set_dma_mode(ctx->stream[PCM_RX].dma,
+		     get_dma_mode(ctx->stream[PCM_RX].dma) & ~DMA_NC);
+
+	DBG("DMA: %d %d\n", ctx->stream[PCM_TX].dma, ctx->stream[PCM_RX].dma);
+
+	platform_set_drvdata(pdev, ctx);
+
+	ret = snd_soc_register_platform(&pdev->dev, &alchemy_pcm_soc_platform);
+	if (!ret)
+		return ret;
+
+	free_au1000_dma(ctx->stream[PCM_RX].dma);
+out2:
+	free_au1000_dma(ctx->stream[PCM_TX].dma);
+out1:
+	kfree(ctx);
+	DBG("bailing out\n");
+	return ret;
+}
+
+static int __devexit alchemy_pcm_drvremove(struct platform_device *pdev)
+{
+	struct alchemy_pcm_ctx *ctx = platform_get_drvdata(pdev);
+
+	free_au1000_dma(ctx->stream[PCM_RX].dma);
+	free_au1000_dma(ctx->stream[PCM_TX].dma);
+
+	kfree(ctx);
+	snd_soc_unregister_platform(&pdev->dev);
+
+	return 0;
+}
+
+static struct platform_driver alchemy_ac97pcm_driver = {
+	.driver	= {
+		.name	= AC97C_DMANAME,
+		.owner	= THIS_MODULE,
+	},
+	.probe		= alchemy_pcm_drvprobe,
+	.remove		= __devexit_p(alchemy_pcm_drvremove),
+};
+
+static struct platform_driver alchemy_i2spcm_driver = {
+	.driver	= {
+		.name	= I2SC_DMANAME,
+		.owner	= THIS_MODULE,
+	},
+	.probe		= alchemy_pcm_drvprobe,
+	.remove		= __devexit_p(alchemy_pcm_drvremove),
+};
+
+static int __init alchemy_audio_dma_load(void)
+{
+	(void)platform_driver_register(&alchemy_i2spcm_driver);
+	return platform_driver_register(&alchemy_ac97pcm_driver);
+}
+
+static void __exit alchemy_audio_dma_unload(void)
+{
+	platform_driver_unregister(&alchemy_i2spcm_driver);
+	platform_driver_unregister(&alchemy_ac97pcm_driver);
+}
+
+module_init(alchemy_audio_dma_load);
+module_exit(alchemy_audio_dma_unload);
+
+
+struct platform_device *alchemy_pcm_add(struct platform_device *pdev, int type)
+{
+	struct resource *res, *r;
+	struct platform_device *pd;
+	char *pdevname;
+	int id[2];
+	int ret;
+
+	r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+	if (!r)
+		return NULL;
+	id[0] = r->start;
+
+	r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
+	if (!r)
+		return NULL;
+	id[1] = r->start;
+
+	res = kzalloc(sizeof(struct resource) * 2, GFP_KERNEL);
+	if (!res)
+		return NULL;
+
+	res[0].start = res[0].end = id[0];
+	res[1].start = res[1].end = id[1];
+	res[0].flags = res[1].flags = IORESOURCE_DMA;
+
+	/* "alchemy-pcm-ac97" or "alchemy-pcm-i2s" */
+	pdevname = (type == 0) ? AC97C_DMANAME : I2SC_DMANAME;
+	pd = platform_device_alloc(pdevname, -1);
+	if (!pd)
+		goto out;
+
+	pd->resource = res;
+	pd->num_resources = 2;
+
+	ret = platform_device_add(pd);
+	if (!ret)
+		return pd;
+
+	platform_device_put(pd);
+out:
+	kfree(res);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(alchemy_pcm_add);
+
+void alchemy_pcm_destroy(struct platform_device *dmapd)
+{
+	if (dmapd)
+		platform_device_unregister(dmapd);
+}
+EXPORT_SYMBOL_GPL(alchemy_pcm_destroy);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Au1000/Au1500/Au1100 Audio DMA driver");
+MODULE_AUTHOR("Manuel Lauss");
diff --git a/sound/soc/au1x/i2sc.c b/sound/soc/au1x/i2sc.c
new file mode 100644
index 0000000..1a31d51
--- /dev/null
+++ b/sound/soc/au1x/i2sc.c
@@ -0,0 +1,353 @@
+/*
+ * Au1000/Au1500/Au1100 I2S controller driver for ASoC
+ *
+ * (c) 2011 Manuel Lauss <manuel.lauss@googlemail.com>
+ *
+ * Note: clock supplied to the I2S controller must be 256x samplerate.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/suspend.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+#include <asm/mach-au1x00/au1000.h>
+
+#include "psc.h"
+
+#define I2S_DATA	0x00
+#define I2S_CONFIG	0x04
+#define I2S_ENABLE	0x08
+
+#define CFG_XU		(1 << 25)	/* tx underflow */
+#define CFG_XO		(1 << 24)
+#define CFG_RU		(1 << 23)
+#define CFG_RO		(1 << 22)
+#define CFG_TR		(1 << 21)
+#define CFG_TE		(1 << 20)
+#define CFG_TF		(1 << 19)
+#define CFG_RR		(1 << 18)
+#define CFG_RF		(1 << 17)
+#define CFG_ICK		(1 << 12)	/* clock invert */
+#define CFG_PD		(1 << 11)	/* set to make I2SDIO INPUT */
+#define CFG_LB		(1 << 10)	/* loopback */
+#define CFG_IC		(1 << 9)	/* word select invert */
+#define CFG_FM_I2S	(0 << 7)	/* I2S format */
+#define CFG_FM_LJ	(1 << 7)	/* left-justified */
+#define CFG_FM_RJ	(2 << 7)	/* right-justified */
+#define CFG_FM_MASK	(3 << 7)
+#define CFG_TN		(1 << 6)	/* tx fifo en */
+#define CFG_RN		(1 << 5)	/* rx fifo en */
+#define CFG_SZ_8	(0x08)
+#define CFG_SZ_16	(0x10)
+#define CFG_SZ_18	(0x12)
+#define CFG_SZ_20	(0x14)
+#define CFG_SZ_24	(0x18)
+#define CFG_SZ_MASK	(0x1f)
+#define EN_D		(1 << 1)	/* DISable */
+#define EN_CE		(1 << 0)	/* clock enable */
+
+/* supported I2S DAI hardware formats */
+#define AU1XI2SC_DAIFMT \
+	(SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_LEFT_J |	\
+	 SND_SOC_DAIFMT_NB_NF)
+
+/* supported I2S direction */
+#define AU1XI2SC_DIR \
+	(SND_SOC_DAIDIR_PLAYBACK | SND_SOC_DAIDIR_CAPTURE)
+
+#define AU1XI2SC_RATES \
+	SNDRV_PCM_RATE_8000_192000
+
+#define AU1XI2SC_FMTS \
+	SNDRV_PCM_FMTBIT_S16_LE
+
+struct i2sc_ctx {
+	void __iomem *mmio;
+	unsigned long cfg, rate;
+	struct platform_device *dmapd;
+};
+
+static inline unsigned long RD(struct i2sc_ctx *ctx, int reg)
+{
+	return __raw_readl(ctx->mmio + reg);
+}
+
+static inline void WR(struct i2sc_ctx *ctx, int reg, unsigned long v)
+{
+	__raw_writel(v, ctx->mmio + reg);
+	wmb();
+}
+
+static int au1xi2s_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
+{
+	struct i2sc_ctx *ctx = snd_soc_dai_get_drvdata(cpu_dai);
+	unsigned long c;
+	int ret;
+
+	ret = -EINVAL;
+	c = ctx->cfg;
+
+	c &= ~CFG_FM_MASK;
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		c |= CFG_FM_I2S;	/* enable I2S mode */
+		break;
+	case SND_SOC_DAIFMT_MSB:
+		c |= CFG_FM_RJ;
+		break;
+	case SND_SOC_DAIFMT_LSB:
+		c |= CFG_FM_LJ;
+		break;
+	default:
+		goto out;
+	}
+
+	c &= ~(CFG_IC | CFG_ICK);		/* IB-IF */
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		c |= CFG_IC | CFG_ICK;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		c |= CFG_IC;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		c |= CFG_ICK;
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		break;
+	default:
+		goto out;
+	}
+
+	/* I2S controller only supports master */
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:	/* CODEC slave */
+		break;
+	default:
+		goto out;
+	}
+
+	ret = 0;
+	ctx->cfg = c;
+out:
+	return ret;
+}
+
+static int au1xi2s_trigger(struct snd_pcm_substream *substream,
+			   int cmd, struct snd_soc_dai *dai)
+{
+	struct i2sc_ctx *ctx = snd_soc_dai_get_drvdata(dai);
+	int stype = SUBSTREAM_TYPE(substream);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+		ctx->cfg |= (stype == PCM_TX) ? CFG_TN : CFG_RN;
+		WR(ctx, I2S_CONFIG, ctx->cfg);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		ctx->cfg &= ~((stype == PCM_TX) ? CFG_TN : CFG_RN);
+		WR(ctx, I2S_CONFIG, ctx->cfg);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static unsigned long msbits_to_reg(int msbits)
+{
+	switch (msbits) {
+	case 8:  return CFG_SZ_8;
+	case 16: return CFG_SZ_16;
+	case 18: return CFG_SZ_18;
+	case 20: return CFG_SZ_20;
+	case 24: return CFG_SZ_24;
+	}
+	return 0;
+}
+
+static int au1xi2s_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params,
+			     struct snd_soc_dai *dai)
+{
+	struct i2sc_ctx *ctx = snd_soc_dai_get_drvdata(dai);
+	unsigned long stat, v;
+
+	v = msbits_to_reg(params->msbits);
+	/* check if the PSC is already streaming data */
+	stat = RD(ctx, I2S_CONFIG);
+	if (stat & (CFG_TN | CFG_RN)) {
+		/* reject parameters not currently set up in hardware */
+		if ((ctx->rate != params_rate(params)) ||
+		    ((stat & CFG_SZ_MASK) != v))
+			return -EINVAL;
+	} else {
+		/* set sample bitdepth */
+		ctx->cfg &= ~CFG_SZ_MASK;
+		if (v)
+			ctx->cfg |= v;
+		else
+			return -EINVAL;
+		/* remember current rate for other stream */
+		ctx->rate = params_rate(params);
+	}
+	return 0;
+}
+
+static struct snd_soc_dai_ops au1xi2s_dai_ops = {
+	.trigger	= au1xi2s_trigger,
+	.hw_params	= au1xi2s_hw_params,
+	.set_fmt	= au1xi2s_set_fmt,
+};
+
+static struct snd_soc_dai_driver au1xi2s_dai_driver = {
+	.playback = {
+		.rates		= AU1XI2SC_RATES,
+		.formats	= AU1XI2SC_FMTS,
+		.channels_min	= 2,
+		.channels_max	= 2,
+	},
+	.capture = {
+		.rates		= AU1XI2SC_RATES,
+		.formats	= AU1XI2SC_FMTS,
+		.channels_min	= 2,
+		.channels_max	= 2,
+	},
+	.ops = &au1xi2s_dai_ops,
+};
+
+static int __devinit au1xi2s_drvprobe(struct platform_device *pdev)
+{
+	int ret;
+	struct resource *r;
+	struct i2sc_ctx *ctx;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r) {
+		ret = -ENODEV;
+		goto out0;
+	}
+
+	ret = -EBUSY;
+	if (!request_mem_region(r->start, resource_size(r), pdev->name))
+		goto out0;
+
+	ctx->mmio = ioremap_nocache(r->start, resource_size(r));
+	if (!ctx->mmio)
+		goto out1;
+
+	/* switch it on */
+	WR(ctx, I2S_ENABLE, EN_D | EN_CE);
+	WR(ctx, I2S_ENABLE, EN_CE);
+
+	ctx->cfg = CFG_FM_I2S | CFG_SZ_16;
+	WR(ctx, I2S_CONFIG, ctx->cfg);
+
+	platform_set_drvdata(pdev, ctx);
+
+	ret = snd_soc_register_dai(&pdev->dev, &au1xi2s_dai_driver);
+	if (ret)
+		goto out1;
+
+	ctx->dmapd = alchemy_pcm_add(pdev, 1);	/* 1 == I2S */
+	if (ctx->dmapd)
+		return 0;
+
+	snd_soc_unregister_dai(&pdev->dev);
+out1:
+	release_mem_region(r->start, resource_size(r));
+out0:
+	kfree(ctx);
+	return ret;
+}
+
+static int __devexit au1xi2s_drvremove(struct platform_device *pdev)
+{
+	struct i2sc_ctx *ctx = platform_get_drvdata(pdev);
+	struct resource *r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	if (ctx->dmapd)
+		alchemy_pcm_destroy(ctx->dmapd);
+
+	snd_soc_unregister_dai(&pdev->dev);
+
+	WR(ctx, I2S_ENABLE, EN_D);	/* clock off, disable */
+
+	iounmap(ctx->mmio);
+	release_mem_region(r->start, resource_size(r));
+	kfree(ctx);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int au1xi2s_drvsuspend(struct device *dev)
+{
+	struct i2sc_ctx *ctx = dev_get_drvdata(dev);
+
+	WR(ctx, I2S_ENABLE, EN_D);	/* clock off, disable */
+
+	return 0;
+}
+
+static int au1xi2s_drvresume(struct device *dev)
+{
+	struct i2sc_ctx *ctx = dev_get_drvdata(dev);
+
+	WR(ctx, I2S_ENABLE, EN_D | EN_CE);
+	WR(ctx, I2S_ENABLE, EN_CE);
+	WR(ctx, I2S_CONFIG, ctx->cfg);
+
+	return 0;
+}
+
+static const struct dev_pm_ops au1xpscac97_pmops = {
+	.suspend	= au1xi2s_drvsuspend,
+	.resume		= au1xi2s_drvresume,
+};
+
+#define AU1XPSCAC97_PMOPS (&au1xpscac97_pmops)
+
+#else
+
+#define AU1XPSCAC97_PMOPS NULL
+
+#endif
+
+static struct platform_driver au1xi2s_driver = {
+	.driver	= {
+		.name	= "alchemy-ac97c",
+		.owner	= THIS_MODULE,
+		.pm	= AU1XPSCAC97_PMOPS,
+	},
+	.probe		= au1xi2s_drvprobe,
+	.remove		= __devexit_p(au1xi2s_drvremove),
+};
+
+static int __init au1xi2s_load(void)
+{
+	return platform_driver_register(&au1xi2s_driver);
+}
+
+static void __exit au1xi2s_unload(void)
+{
+	platform_driver_unregister(&au1xi2s_driver);
+}
+
+module_init(au1xi2s_load);
+module_exit(au1xi2s_unload);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Au1000/1500/1100 AC97C ALSA ASoC audio driver");
+MODULE_AUTHOR("Manuel Lauss");
diff --git a/sound/soc/au1x/psc.h b/sound/soc/au1x/psc.h
index b30eadd..21b944a 100644
--- a/sound/soc/au1x/psc.h
+++ b/sound/soc/au1x/psc.h
@@ -1,7 +1,7 @@
 /*
- * Au12x0/Au1550 PSC ALSA ASoC audio support.
+ * Alchemy ALSA ASoC audio support.
  *
- * (c) 2007-2008 MSC Vertriebsges.m.b.H.,
+ * (c) 2007-2011 MSC Vertriebsges.m.b.H.,
  *	Manuel Lauss <manuel.lauss@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
@@ -13,7 +13,26 @@
 #ifndef _AU1X_PCM_H
 #define _AU1X_PCM_H
 
-/* DBDMA helpers */
+#define PCM_TX	0
+#define PCM_RX	1
+
+#define SUBSTREAM_TYPE(substream) \
+	((substream)->stream == SNDRV_PCM_STREAM_PLAYBACK ? PCM_TX : PCM_RX)
+
+
+/* AC97C/I2SC DMA helpers */
+extern  struct platform_device *alchemy_pcm_add(struct platform_device *pdev,
+						int type);
+extern void alchemy_pcm_destroy(struct platform_device *dmapd);
+
+/* Au1000 AC97C/I2SC DAI names. Required to get at correct DMA instance */
+#define AC97C_DAINAME	"alchemy-ac97c"
+#define I2SC_DAINAME	"alchemy-i2sc"
+#define AC97C_DMANAME	"alchemy-pcm-ac97"
+#define I2SC_DMANAME	"alchemy-pcm-i2s"
+
+
+/* PSC/DBDMA helpers */
 extern struct platform_device *au1xpsc_pcm_add(struct platform_device *pdev);
 extern void au1xpsc_pcm_destroy(struct platform_device *dmapd);
 
@@ -30,12 +49,6 @@ struct au1xpsc_audio_data {
 	struct platform_device *dmapd;
 };
 
-#define PCM_TX	0
-#define PCM_RX	1
-
-#define SUBSTREAM_TYPE(substream) \
-	((substream)->stream == SNDRV_PCM_STREAM_PLAYBACK ? PCM_TX : PCM_RX)
-
 /* easy access macros */
 #define PSC_CTRL(x)	((unsigned long)((x)->mmio) + PSC_CTRL_OFFSET)
 #define PSC_SEL(x)	((unsigned long)((x)->mmio) + PSC_SEL_OFFSET)
-- 
1.7.6
