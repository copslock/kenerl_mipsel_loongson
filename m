Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Feb 2010 19:22:27 +0100 (CET)
Received: from mail-bw0-f215.google.com ([209.85.218.215]:51691 "EHLO
        mail-bw0-f215.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492408Ab0BWSVj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Feb 2010 19:21:39 +0100
Received: by bwz7 with SMTP id 7so2764020bwz.24
        for <linux-mips@linux-mips.org>; Tue, 23 Feb 2010 10:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=AXEIaJKpG6G4MJhf8jQlEGSHN3MGLWD4imR3TlXSjjQ=;
        b=Qo8Rxa4DAPYMdjjDsZTD/0Im9waoz8XMNlMqGvMxSEjHx3ABzHcEsD0Z6khEeMyTpb
         j0YvM64PBnaBXDyy+A1Cp97s5ZGB89gW1dCqt1klrsK2kHuZI3/xNA9GXEHU3yCUnCNd
         6Kob2O0wmgbmpAHLK1qNHalE70TN/WIO1iwwE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XvqivZbeCgSYoCuv+QqKtykvromwhJdk/8N0+CucdetfEqS5mW8ZVAdER5FfVaFUD+
         +4BYuzyjJiqSgHRDGn+27m3UWc0fWU6WTwlR5Hqfz8+8EAUPNQE9N2Gxd02s1hoZulmY
         dMpAgF7iE/URbBkvCgzaTb0NvjftiDXw2CSAM=
Received: by 10.204.25.194 with SMTP id a2mr2266602bkc.191.1266949292508;
        Tue, 23 Feb 2010 10:21:32 -0800 (PST)
Received: from localhost.localdomain (p5496C184.dip.t-dialin.net [84.150.193.132])
        by mx.google.com with ESMTPS id 15sm2041976bwz.12.2010.02.23.10.21.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Feb 2010 10:21:31 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux Serial <linux-serial@vger.kernel.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: [RFC PATCH 2/2] Alchemy: UART PM through serial framework.
Date:   Tue, 23 Feb 2010 19:22:27 +0100
Message-Id: <1266949347-12024-3-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.7.0
In-Reply-To: <1266949347-12024-2-git-send-email-manuel.lauss@gmail.com>
References: <1266949347-12024-1-git-send-email-manuel.lauss@gmail.com>
 <1266949347-12024-2-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25999
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Hook up the Alchemy on-chip uarts with the platform 8250 PM callback
and enable/disable clocks to the uart blocks as needed.

This allows to get rid of the devboard-specific uart pm hack in the
Alchemy common code.

Tested on Au1200/DB1200.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
This patch applies against Ralf Baechle's mips-queue tree.

 arch/mips/alchemy/common/platform.c |   17 +++++++++++++++++
 arch/mips/alchemy/common/power.c    |   35 -----------------------------------
 2 files changed, 17 insertions(+), 35 deletions(-)

diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index 3fbe30c..a85d515 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -21,6 +21,22 @@
 #include <asm/mach-au1x00/au1100_mmc.h>
 #include <asm/mach-au1x00/au1xxx_eth.h>
 
+static void alchemy_8250_pm(struct uart_port *port, unsigned int state,
+			    unsigned int old_state)
+{
+	if (state == 0) {		/* power on */
+		__raw_writel(0, port->membase + UART_MOD_CNTRL);
+		wmb();
+		__raw_writel(1, port->membase + UART_MOD_CNTRL);
+		wmb();
+		__raw_writel(3, port->membase + UART_MOD_CNTRL);
+		wmb();
+	} else if (state == 3) {	/* power off */
+		__raw_writel(0, port->membase + UART_MOD_CNTRL);
+		wmb();
+	}
+}
+
 #define PORT(_base, _irq)					\
 	{							\
 		.mapbase	= _base,			\
@@ -30,6 +46,7 @@
 		.flags		= UPF_SKIP_TEST | UPF_IOREMAP |	\
 				  UPF_FIXED_TYPE,		\
 		.type		= PORT_16550A,			\
+		.pm		= alchemy_8250_pm,		\
 	}
 
 static struct plat_serial8250_port au1x00_uart_data[] = {
diff --git a/arch/mips/alchemy/common/power.c b/arch/mips/alchemy/common/power.c
index 6ab7b42..cf37e27 100644
--- a/arch/mips/alchemy/common/power.c
+++ b/arch/mips/alchemy/common/power.c
@@ -52,11 +52,6 @@
  * We only have to save/restore registers that aren't otherwise
  * done as part of a driver pm_* function.
  */
-static unsigned int sleep_uart0_inten;
-static unsigned int sleep_uart0_fifoctl;
-static unsigned int sleep_uart0_linectl;
-static unsigned int sleep_uart0_clkdiv;
-static unsigned int sleep_uart0_enable;
 static unsigned int sleep_usb[2];
 static unsigned int sleep_sys_clocks[5];
 static unsigned int sleep_sys_pinfunc;
@@ -65,22 +60,6 @@ static unsigned int sleep_static_memctlr[4][3];
 
 static void save_core_regs(void)
 {
-	extern void save_au1xxx_intctl(void);
-	extern void pm_eth0_shutdown(void);
-
-	/*
-	 * Do the serial ports.....these really should be a pm_*
-	 * registered function by the driver......but of course the
-	 * standard serial driver doesn't understand our Au1xxx
-	 * unique registers.
-	 */
-	sleep_uart0_inten = au_readl(UART0_ADDR + UART_IER);
-	sleep_uart0_fifoctl = au_readl(UART0_ADDR + UART_FCR);
-	sleep_uart0_linectl = au_readl(UART0_ADDR + UART_LCR);
-	sleep_uart0_clkdiv = au_readl(UART0_ADDR + UART_CLK);
-	sleep_uart0_enable = au_readl(UART0_ADDR + UART_MOD_CNTRL);
-	au_sync();
-
 #ifndef CONFIG_SOC_AU1200
 	/* Shutdown USB host/device. */
 	sleep_usb[0] = au_readl(USB_HOST_CONFIG);
@@ -186,20 +165,6 @@ static void restore_core_regs(void)
 	au_writel(sleep_static_memctlr[3][1], MEM_STTIME3);
 	au_writel(sleep_static_memctlr[3][2], MEM_STADDR3);
 
-	/*
-	 * Enable the UART if it was enabled before sleep.
-	 * I guess I should define module control bits........
-	 */
-	if (sleep_uart0_enable & 0x02) {
-		au_writel(0, UART0_ADDR + UART_MOD_CNTRL); au_sync();
-		au_writel(1, UART0_ADDR + UART_MOD_CNTRL); au_sync();
-		au_writel(3, UART0_ADDR + UART_MOD_CNTRL); au_sync();
-		au_writel(sleep_uart0_inten, UART0_ADDR + UART_IER); au_sync();
-		au_writel(sleep_uart0_fifoctl, UART0_ADDR + UART_FCR); au_sync();
-		au_writel(sleep_uart0_linectl, UART0_ADDR + UART_LCR); au_sync();
-		au_writel(sleep_uart0_clkdiv, UART0_ADDR + UART_CLK); au_sync();
-	}
-
 	restore_au1xxx_intctl();
 
 #if defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200)
-- 
1.7.0
