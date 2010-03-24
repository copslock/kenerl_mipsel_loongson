Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Mar 2010 18:15:46 +0100 (CET)
Received: from fg-out-1718.google.com ([72.14.220.154]:54681 "EHLO
        fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492796Ab0CXRPS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Mar 2010 18:15:18 +0100
Received: by fg-out-1718.google.com with SMTP id e12so1853570fga.6
        for <linux-mips@linux-mips.org>; Wed, 24 Mar 2010 10:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=C8vvWSSm9LII//gqm03sr/Qn/8TU5uuTELYqVuIvt9Q=;
        b=bmagfoQqwk0LKFyPpE8X1id6kvVSzSUnZe32cZFYfTIoiRRVEu3UEBY76EbuOx2qDv
         cnaqTb/L8B/9S2g4G4ik8ZYjip0FWXAwZKy/DRVYfQ3T7PLWOwf1b/7szEGisRlHj8mi
         sOO3G0eQ7pTuSitSrveueQZP+/jAoIBFmuSuw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JQn0n9+KhwGJh7nrjDvIgk5Znaex4qTPmT24+xYgJwJW4i3MFVlMe/9dvybN6WFe35
         +qisL64aclxAsFmbwYtahZeZn9ZHgA3yHz3aZXr4/FHU4ob0drm9EAEoi3pRalfmdTuP
         /OBIxt9CbHzJRan+JI7EdnpTqjNAerKTlAgOU=
Received: by 10.86.239.33 with SMTP id m33mr204576fgh.31.1269450918087;
        Wed, 24 Mar 2010 10:15:18 -0700 (PDT)
Received: from localhost.localdomain (p5496E06D.dip.t-dialin.net [84.150.224.109])
        by mx.google.com with ESMTPS id 3sm1874576fge.20.2010.03.24.10.15.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Mar 2010 10:15:17 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Manuel Lauss <manuel.lauss@gmail.com>
Subject: [RFC PATCH 2/2] Alchemy: UART PM through serial framework.
Date:   Wed, 24 Mar 2010 18:16:26 +0100
Message-Id: <1269450986-3714-3-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.7.0.2
In-Reply-To: <1269450986-3714-1-git-send-email-manuel.lauss@gmail.com>
References: <1269450986-3714-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26305
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Hook up the Alchemy on-chip uarts with the platform 8250 PM callback
and enable/disable the uart blocks as needed.

Tested on Au1200.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/common/platform.c |   17 +++++++++++++++++
 arch/mips/alchemy/common/power.c    |   32 --------------------------------
 2 files changed, 17 insertions(+), 32 deletions(-)

diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index 2580e77..70f4abd 100644
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
index 6ab7b42..8fbf6d0 100644
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
@@ -68,19 +63,6 @@ static void save_core_regs(void)
 	extern void save_au1xxx_intctl(void);
 	extern void pm_eth0_shutdown(void);
 
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
@@ -186,20 +168,6 @@ static void restore_core_regs(void)
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
1.7.0.2
