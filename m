Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2012 18:20:26 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:57801 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904028Ab2AaRTa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jan 2012 18:19:30 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 532C14486D5;
        Tue, 31 Jan 2012 18:19:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uDyN5xSghHYw; Tue, 31 Jan 2012 18:19:30 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id E317B44775B;
        Tue, 31 Jan 2012 18:19:29 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 1/6] MIPS: Alchemy: use IS_ENABLED() macro
Date:   Tue, 31 Jan 2012 18:19:03 +0100
Message-Id: <1328030348-21967-2-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1328030348-21967-1-git-send-email-florian@openwrt.org>
References: <1328030348-21967-1-git-send-email-florian@openwrt.org>
X-archive-position: 32368
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/alchemy/board-mtx1.c       |    4 ++--
 arch/mips/alchemy/devboards/pb1100.c |    4 ++--
 arch/mips/alchemy/devboards/pb1500.c |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/alchemy/board-mtx1.c b/arch/mips/alchemy/board-mtx1.c
index 295f1a9..9996948 100644
--- a/arch/mips/alchemy/board-mtx1.c
+++ b/arch/mips/alchemy/board-mtx1.c
@@ -81,10 +81,10 @@ static void mtx1_power_off(void)
 
 void __init board_setup(void)
 {
-#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
+#if IS_ENABLED(CONFIG_USB_OHCI_HCD)
 	/* Enable USB power switch */
 	alchemy_gpio_direction_output(204, 0);
-#endif /* defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE) */
+#endif /* IS_ENABLED(CONFIG_USB_OHCI_HCD) */
 
 	/* Initialize sys_pinfunc */
 	au_writel(SYS_PF_NI2, SYS_PINFUNC);
diff --git a/arch/mips/alchemy/devboards/pb1100.c b/arch/mips/alchemy/devboards/pb1100.c
index cff50d0..78c77a4 100644
--- a/arch/mips/alchemy/devboards/pb1100.c
+++ b/arch/mips/alchemy/devboards/pb1100.c
@@ -46,7 +46,7 @@ void __init board_setup(void)
 	alchemy_gpio1_input_enable();
 	udelay(100);
 
-#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
+#if IS_ENABLED(CONFIG_USB_OHCI_HCD)
 	{
 		u32 pin_func, sys_freqctrl, sys_clksrc;
 
@@ -93,7 +93,7 @@ void __init board_setup(void)
 		pin_func |= SYS_PF_USB;
 		au_writel(pin_func, SYS_PINFUNC);
 	}
-#endif /* defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE) */
+#endif /* IS_ENABLED(CONFIG_USB_OHCI_HCD) */
 
 	/* Enable sys bus clock divider when IDLE state or no bus activity. */
 	au_writel(au_readl(SYS_POWERCTRL) | (0x3 << 5), SYS_POWERCTRL);
diff --git a/arch/mips/alchemy/devboards/pb1500.c b/arch/mips/alchemy/devboards/pb1500.c
index e7b807b..232fee9 100644
--- a/arch/mips/alchemy/devboards/pb1500.c
+++ b/arch/mips/alchemy/devboards/pb1500.c
@@ -53,7 +53,7 @@ void __init board_setup(void)
 	alchemy_gpio_direction_input(201);
 	alchemy_gpio_direction_input(203);
 
-#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
+#if IS_ENABLED(CONFIG_USB_OHCI_HCD)
 
 	/* Zero and disable FREQ2 */
 	sys_freqctrl = au_readl(SYS_FREQCTRL0);
@@ -87,7 +87,7 @@ void __init board_setup(void)
 	/* 2nd USB port is USB host */
 	pin_func |= SYS_PF_USB;
 	au_writel(pin_func, SYS_PINFUNC);
-#endif /* defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE) */
+#endif /* IS_ENABLED(CONFIG_USB_OHCI_HCD) */
 
 #ifdef CONFIG_PCI
 	{
-- 
1.7.5.4
