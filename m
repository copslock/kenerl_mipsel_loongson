Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 May 2011 10:43:50 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:41234 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491010Ab1EHImd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 8 May 2011 10:42:33 +0200
Received: by mail-wy0-f177.google.com with SMTP id 28so4138962wyb.36
        for <linux-mips@linux-mips.org>; Sun, 08 May 2011 01:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=o4SuCZWzOEyTaQAUzNl6H4ExwRTV/wQLgylKqds5SvA=;
        b=i9Ul0TL2h6fJwImVjHsIR3KEPHZF7xLHRFnJpo4G5S88a4igZaJra29n1I79k6YdVQ
         WY6aw9tpAnj88eHKf2+410DlWgIpqS4GjvduaLHlVqz5bDyi8p8xpubyt5cXip0zhhAw
         g4ZPJxdsu6exE3mBF/6XIFfp2pr5f0lht7zLE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lUMSqM4EAteKHUDdDt3OvU5UFVz/byHGQuKU9kTENHOsgC/BvGYLiItgaUyslBc+9q
         E/VSnJpqGu2epQbF9SvL1aUr1EaESI+dLf89p+BXbyKq/djyQ48I3v1myrayHiYrKPJN
         HV3dT8YSP9Jy6i/xwBTVBLg5obbygZQNcJ7zg=
Received: by 10.227.208.65 with SMTP id gb1mr5902370wbb.42.1304844153456;
        Sun, 08 May 2011 01:42:33 -0700 (PDT)
Received: from localhost.localdomain (178-191-5-255.adsl.highway.telekom.at [178.191.5.255])
        by mx.google.com with ESMTPS id z9sm3022884wbx.34.2011.05.08.01.42.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 08 May 2011 01:42:33 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Florian Fainelli <florian@openwrt.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 8/9] MIPS: Alchemy: cleanup DMA addresses
Date:   Sun,  8 May 2011 10:42:19 +0200
Message-Id: <1304844140-3259-9-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.5.rc3
In-Reply-To: <1304844140-3259-1-git-send-email-manuel.lauss@googlemail.com>
References: <1304844140-3259-1-git-send-email-manuel.lauss@googlemail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29869
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

According to the databooks, the Au1000 DMA engine must be programmed
with the physical FIFO addresses.  This patch does that; furthermore
this opened the possibility to get rid of a lot of now unnecessary
address defines.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/alchemy/common/dma.c                 |   46 ++++++++++--------
 arch/mips/alchemy/common/platform.c            |    8 ++--
 arch/mips/include/asm/mach-au1x00/au1000.h     |   62 ++---------------------
 arch/mips/include/asm/mach-au1x00/au1000_dma.h |    4 --
 4 files changed, 35 insertions(+), 85 deletions(-)

diff --git a/arch/mips/alchemy/common/dma.c b/arch/mips/alchemy/common/dma.c
index d527887..347980e 100644
--- a/arch/mips/alchemy/common/dma.c
+++ b/arch/mips/alchemy/common/dma.c
@@ -58,6 +58,9 @@
  * returned from request_dma.
  */
 
+/* DMA Channel register block spacing */
+#define DMA_CHANNEL_LEN		0x00000100
+
 DEFINE_SPINLOCK(au1000_dma_spin_lock);
 
 struct dma_chan au1000_dma_table[NUM_AU1000_DMA_CHANNELS] = {
@@ -77,22 +80,23 @@ static const struct dma_dev {
 	unsigned int fifo_addr;
 	unsigned int dma_mode;
 } dma_dev_table[DMA_NUM_DEV] = {
-	{UART0_ADDR + UART_TX, 0},
-	{UART0_ADDR + UART_RX, 0},
-	{0, 0},
-	{0, 0},
-	{AC97C_DATA, DMA_DW16 },          /* coherent */
-	{AC97C_DATA, DMA_DR | DMA_DW16 }, /* coherent */
-	{UART3_ADDR + UART_TX, DMA_DW8 | DMA_NC},
-	{UART3_ADDR + UART_RX, DMA_DR | DMA_DW8 | DMA_NC},
-	{USBD_EP0RD, DMA_DR | DMA_DW8 | DMA_NC},
-	{USBD_EP0WR, DMA_DW8 | DMA_NC},
-	{USBD_EP2WR, DMA_DW8 | DMA_NC},
-	{USBD_EP3WR, DMA_DW8 | DMA_NC},
-	{USBD_EP4RD, DMA_DR | DMA_DW8 | DMA_NC},
-	{USBD_EP5RD, DMA_DR | DMA_DW8 | DMA_NC},
-	{I2S_DATA, DMA_DW32 | DMA_NC},
-	{I2S_DATA, DMA_DR | DMA_DW32 | DMA_NC}
+	{ AU1000_UART0_PHYS_ADDR + 0x04, DMA_DW8 },		/* UART0_TX */
+	{ AU1000_UART0_PHYS_ADDR + 0x00, DMA_DW8 | DMA_DR },	/* UART0_RX */
+	{ 0, 0 },	/* DMA_REQ0 */
+	{ 0, 0 },	/* DMA_REQ1 */
+	{ AU1000_AC97_PHYS_ADDR + 0x08, DMA_DW16 },		/* AC97 TX c */
+	{ AU1000_AC97_PHYS_ADDR + 0x08, DMA_DW16 | DMA_DR },	/* AC97 RX c */
+	{ AU1000_UART3_PHYS_ADDR + 0x04, DMA_DW8 | DMA_NC },	/* UART3_TX */
+	{ AU1000_UART3_PHYS_ADDR + 0x00, DMA_DW8 | DMA_NC | DMA_DR }, /* UART3_RX */
+	{ AU1000_USBD_PHYS_ADDR + 0x00, DMA_DW8 | DMA_NC | DMA_DR }, /* EP0RD */
+	{ AU1000_USBD_PHYS_ADDR + 0x04, DMA_DW8 | DMA_NC }, /* EP0WR */
+	{ AU1000_USBD_PHYS_ADDR + 0x08, DMA_DW8 | DMA_NC }, /* EP2WR */
+	{ AU1000_USBD_PHYS_ADDR + 0x0c, DMA_DW8 | DMA_NC }, /* EP3WR */
+	{ AU1000_USBD_PHYS_ADDR + 0x10, DMA_DW8 | DMA_NC | DMA_DR }, /* EP4RD */
+	{ AU1000_USBD_PHYS_ADDR + 0x14, DMA_DW8 | DMA_NC | DMA_DR }, /* EP5RD */
+	/* on Au1500, these 2 are DMA_REQ2/3 (GPIO208/209) instead! */
+	{ AU1000_I2S_PHYS_ADDR + 0x00, DMA_DW32 | DMA_NC},	/* I2S TX */
+	{ AU1000_I2S_PHYS_ADDR + 0x00, DMA_DW32 | DMA_NC | DMA_DR}, /* I2S RX */
 };
 
 int au1000_dma_read_proc(char *buf, char **start, off_t fpos,
@@ -123,10 +127,10 @@ int au1000_dma_read_proc(char *buf, char **start, off_t fpos,
 
 /* Device FIFO addresses and default DMA modes - 2nd bank */
 static const struct dma_dev dma_dev_table_bank2[DMA_NUM_DEV_BANK2] = {
-	{ SD0_XMIT_FIFO, DMA_DS | DMA_DW8 },		/* coherent */
-	{ SD0_RECV_FIFO, DMA_DS | DMA_DR | DMA_DW8 },	/* coherent */
-	{ SD1_XMIT_FIFO, DMA_DS | DMA_DW8 },		/* coherent */
-	{ SD1_RECV_FIFO, DMA_DS | DMA_DR | DMA_DW8 }	/* coherent */
+	{ AU1100_SD0_PHYS_ADDR + 0x00, DMA_DS | DMA_DW8 },		/* coherent */
+	{ AU1100_SD0_PHYS_ADDR + 0x04, DMA_DS | DMA_DW8 | DMA_DR },	/* coherent */
+	{ AU1100_SD1_PHYS_ADDR + 0x00, DMA_DS | DMA_DW8 },		/* coherent */
+	{ AU1100_SD1_PHYS_ADDR + 0x04, DMA_DS | DMA_DW8 | DMA_DR }	/* coherent */
 };
 
 void dump_au1000_dma_channel(unsigned int dmanr)
@@ -202,7 +206,7 @@ int request_au1000_dma(int dev_id, const char *dev_str,
 	}
 
 	/* fill it in */
-	chan->io = DMA_CHANNEL_BASE + i * DMA_CHANNEL_LEN;
+	chan->io = KSEG1ADDR(AU1000_DMA_PHYS_ADDR) + i * DMA_CHANNEL_LEN;
 	chan->dev_id = dev_id;
 	chan->dev_str = dev_str;
 	chan->fifo_addr = dev->fifo_addr;
diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index 541fff2..3b2c18b 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -283,8 +283,8 @@ extern struct au1xmmc_platform_data au1xmmc_platdata[2];
 
 static struct resource au1200_mmc0_resources[] = {
 	[0] = {
-		.start          = SD0_PHYS_ADDR,
-		.end            = SD0_PHYS_ADDR + 0x7ffff,
+		.start          = AU1100_SD0_PHYS_ADDR,
+		.end            = AU1100_SD0_PHYS_ADDR + 0xfff,
 		.flags          = IORESOURCE_MEM,
 	},
 	[1] = {
@@ -319,8 +319,8 @@ static struct platform_device au1200_mmc0_device = {
 #ifndef CONFIG_MIPS_DB1200
 static struct resource au1200_mmc1_resources[] = {
 	[0] = {
-		.start          = SD1_PHYS_ADDR,
-		.end            = SD1_PHYS_ADDR + 0x7ffff,
+		.start          = AU1100_SD1_PHYS_ADDR,
+		.end            = AU1100_SD1_PHYS_ADDR + 0xfff,
 		.flags          = IORESOURCE_MEM,
 	},
 	[1] = {
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index 415d287..2dfff4f 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -686,10 +686,15 @@ enum soc_au1200_ints {
  * 0..au1000 1..au1500 2..au1100 3..au1550 4..au1200
  */
 
+#define AU1000_AC97_PHYS_ADDR		0x10000000 /* 012 */
+#define AU1000_USBD_PHYS_ADDR		0x10200000 /* 0123 */
 #define AU1000_IC0_PHYS_ADDR		0x10400000 /* 01234 */
 #define AU1000_MAC0_PHYS_ADDR		0x10500000 /* 023 */
 #define AU1000_MAC1_PHYS_ADDR		0x10510000 /* 023 */
 #define AU1000_MACEN_PHYS_ADDR		0x10520000 /* 023 */
+#define AU1100_SD0_PHYS_ADDR		0x10600000 /* 24 */
+#define AU1100_SD1_PHYS_ADDR		0x10680000 /* 24 */
+#define AU1000_I2S_PHYS_ADDR		0x11000000 /* 02 */
 #define AU1500_MAC0_PHYS_ADDR		0x11500000 /* 1 */
 #define AU1500_MAC1_PHYS_ADDR		0x11510000 /* 1 */
 #define AU1500_MACEN_PHYS_ADDR		0x11520000 /* 1 */
@@ -698,6 +703,7 @@ enum soc_au1200_ints {
 #define AU1000_UART2_PHYS_ADDR		0x11300000 /* 0 */
 #define AU1000_UART3_PHYS_ADDR		0x11400000 /* 0123 */
 #define AU1000_IC1_PHYS_ADDR		0x11800000 /* 01234 */
+#define AU1000_DMA_PHYS_ADDR		0x14002000 /* 012 */
 #define AU1550_DBDMA_PHYS_ADDR		0x14002000 /* 34 */
 #define AU1550_DBDMA_CONF_PHYS_ADDR	0x14003000 /* 34 */
 #define AU1000_MACDMA0_PHYS_ADDR	0x14004000 /* 0123 */
@@ -707,19 +713,8 @@ enum soc_au1200_ints {
 #ifdef CONFIG_SOC_AU1000
 #define	MEM_PHYS_ADDR		0x14000000
 #define	STATIC_MEM_PHYS_ADDR	0x14001000
-#define	DMA0_PHYS_ADDR		0x14002000
-#define	DMA1_PHYS_ADDR		0x14002100
-#define	DMA2_PHYS_ADDR		0x14002200
-#define	DMA3_PHYS_ADDR		0x14002300
-#define	DMA4_PHYS_ADDR		0x14002400
-#define	DMA5_PHYS_ADDR		0x14002500
-#define	DMA6_PHYS_ADDR		0x14002600
-#define	DMA7_PHYS_ADDR		0x14002700
-#define	AC97_PHYS_ADDR		0x10000000
 #define	USBH_PHYS_ADDR		0x10100000
-#define	USBD_PHYS_ADDR		0x10200000
 #define	IRDA_PHYS_ADDR		0x10300000
-#define	I2S_PHYS_ADDR		0x11000000
 #define	SSI0_PHYS_ADDR		0x11600000
 #define	SSI1_PHYS_ADDR		0x11680000
 #define	SYS_PHYS_ADDR		0x11900000
@@ -733,19 +728,8 @@ enum soc_au1200_ints {
 #ifdef CONFIG_SOC_AU1500
 #define	MEM_PHYS_ADDR		0x14000000
 #define	STATIC_MEM_PHYS_ADDR	0x14001000
-#define	DMA0_PHYS_ADDR		0x14002000
-#define	DMA1_PHYS_ADDR		0x14002100
-#define	DMA2_PHYS_ADDR		0x14002200
-#define	DMA3_PHYS_ADDR		0x14002300
-#define	DMA4_PHYS_ADDR		0x14002400
-#define	DMA5_PHYS_ADDR		0x14002500
-#define	DMA6_PHYS_ADDR		0x14002600
-#define	DMA7_PHYS_ADDR		0x14002700
-#define	AC97_PHYS_ADDR		0x10000000
 #define	USBH_PHYS_ADDR		0x10100000
-#define	USBD_PHYS_ADDR		0x10200000
 #define PCI_PHYS_ADDR		0x14005000
-#define	I2S_PHYS_ADDR		0x11000000
 #define GPIO2_PHYS_ADDR		0x11700000
 #define	SYS_PHYS_ADDR		0x11900000
 #define PCI_MEM_PHYS_ADDR	0x400000000ULL
@@ -762,21 +746,8 @@ enum soc_au1200_ints {
 #ifdef CONFIG_SOC_AU1100
 #define	MEM_PHYS_ADDR		0x14000000
 #define	STATIC_MEM_PHYS_ADDR	0x14001000
-#define	DMA0_PHYS_ADDR		0x14002000
-#define	DMA1_PHYS_ADDR		0x14002100
-#define	DMA2_PHYS_ADDR		0x14002200
-#define	DMA3_PHYS_ADDR		0x14002300
-#define	DMA4_PHYS_ADDR		0x14002400
-#define	DMA5_PHYS_ADDR		0x14002500
-#define	DMA6_PHYS_ADDR		0x14002600
-#define	DMA7_PHYS_ADDR		0x14002700
-#define SD0_PHYS_ADDR		0x10600000
-#define SD1_PHYS_ADDR		0x10680000
-#define	AC97_PHYS_ADDR		0x10000000
 #define	USBH_PHYS_ADDR		0x10100000
-#define	USBD_PHYS_ADDR		0x10200000
 #define	IRDA_PHYS_ADDR		0x10300000
-#define	I2S_PHYS_ADDR		0x11000000
 #define	SSI0_PHYS_ADDR		0x11600000
 #define	SSI1_PHYS_ADDR		0x11680000
 #define GPIO2_PHYS_ADDR		0x11700000
@@ -793,7 +764,6 @@ enum soc_au1200_ints {
 #define	MEM_PHYS_ADDR		0x14000000
 #define	STATIC_MEM_PHYS_ADDR	0x14001000
 #define	USBH_PHYS_ADDR		0x14020000
-#define	USBD_PHYS_ADDR		0x10200000
 #define PCI_PHYS_ADDR		0x14005000
 #define GPIO2_PHYS_ADDR		0x11700000
 #define	SYS_PHYS_ADDR		0x11900000
@@ -824,8 +794,6 @@ enum soc_au1200_ints {
 #define	SYS_PHYS_ADDR		0x11900000
 #define PSC0_PHYS_ADDR	 	0x11A00000
 #define PSC1_PHYS_ADDR	 	0x11B00000
-#define SD0_PHYS_ADDR		0x10600000
-#define SD1_PHYS_ADDR		0x10680000
 #define LCD_PHYS_ADDR		0x15000000
 #define SWCNT_PHYS_ADDR		0x1110010C
 #define MAEFE_PHYS_ADDR		0x14012000
@@ -867,9 +835,6 @@ enum soc_au1200_ints {
 /* Au1000 */
 #ifdef CONFIG_SOC_AU1000
 
-#define UART0_ADDR		0xB1100000
-#define UART3_ADDR		0xB1400000
-
 #define USB_OHCI_BASE		0x10100000	/* phys addr for ioremap */
 #define USB_HOST_CONFIG 	0xB017FFFC
 #define FOR_PLATFORM_C_USB_HOST_INT AU1000_USB_HOST_INT
@@ -878,9 +843,6 @@ enum soc_au1200_ints {
 /* Au1500 */
 #ifdef CONFIG_SOC_AU1500
 
-#define UART0_ADDR		0xB1100000
-#define UART3_ADDR		0xB1400000
-
 #define USB_OHCI_BASE		0x10100000	/* phys addr for ioremap */
 #define USB_HOST_CONFIG 	0xB017fffc
 #define FOR_PLATFORM_C_USB_HOST_INT AU1500_USB_HOST_INT
@@ -889,16 +851,12 @@ enum soc_au1200_ints {
 /* Au1100 */
 #ifdef CONFIG_SOC_AU1100
 
-#define UART0_ADDR		0xB1100000
-#define UART3_ADDR		0xB1400000
-
 #define USB_OHCI_BASE		0x10100000	/* phys addr for ioremap */
 #define USB_HOST_CONFIG 	0xB017FFFC
 #define FOR_PLATFORM_C_USB_HOST_INT AU1100_USB_HOST_INT
 #endif /* CONFIG_SOC_AU1100 */
 
 #ifdef CONFIG_SOC_AU1550
-#define UART0_ADDR		0xB1100000
 
 #define USB_OHCI_BASE		0x14020000	/* phys addr for ioremap */
 #define USB_OHCI_LEN		0x00060000
@@ -909,8 +867,6 @@ enum soc_au1200_ints {
 
 #ifdef CONFIG_SOC_AU1200
 
-#define UART0_ADDR		0xB1100000
-
 #define USB_UOC_BASE		0x14020020
 #define USB_UOC_LEN		0x20
 #define USB_OHCI_BASE		0x14020100
@@ -1534,12 +1490,6 @@ enum soc_au1200_ints {
 #  define AC97C_RS		(1 << 1)
 #  define AC97C_CE		(1 << 0)
 
-/* Secure Digital (SD) Controller */
-#define SD0_XMIT_FIFO	0xB0600000
-#define SD0_RECV_FIFO	0xB0600004
-#define SD1_XMIT_FIFO	0xB0680000
-#define SD1_RECV_FIFO	0xB0680004
-
 #if defined(CONFIG_SOC_AU1500) || defined(CONFIG_SOC_AU1550)
 /* Au1500 PCI Controller */
 #define Au1500_CFG_BASE 	0xB4005000	/* virtual, KSEG1 addr */
diff --git a/arch/mips/include/asm/mach-au1x00/au1000_dma.h b/arch/mips/include/asm/mach-au1x00/au1000_dma.h
index c333b4e..59f5b55 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000_dma.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000_dma.h
@@ -37,10 +37,6 @@
 
 #define NUM_AU1000_DMA_CHANNELS	8
 
-/* DMA Channel Base Addresses */
-#define DMA_CHANNEL_BASE	0xB4002000
-#define DMA_CHANNEL_LEN		0x00000100
-
 /* DMA Channel Register Offsets */
 #define DMA_MODE_SET		0x00000000
 #define DMA_MODE_READ		DMA_MODE_SET
-- 
1.7.5.rc3
