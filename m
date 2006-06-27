Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jun 2006 16:56:10 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:38086 "EHLO
	goldrake.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8126483AbWF0P4B (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Jun 2006 16:56:01 +0100
Received: from zaigor.enneenne.com ([192.168.32.1])
	by goldrake.enneenne.com with esmtp (Exim 4.50)
	id 1FvFqI-0000O0-5r
	for linux-mips@linux-mips.org; Tue, 27 Jun 2006 17:51:10 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1FvFv0-0002nR-D4
	for linux-mips@linux-mips.org; Tue, 27 Jun 2006 17:56:02 +0200
Date:	Tue, 27 Jun 2006 17:56:02 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Message-ID: <20060627155602.GB10595@enneenne.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.11+cvs20060403
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: au1x00 GPIO2 power management
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on goldrake.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11873
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

attached patch adds support for power management for the secondary
general purpose I/O.

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-gpio2-pm-support

diff --git a/arch/mips/au1000/common/power.c b/arch/mips/au1000/common/power.c
index 9b47082..482de93 100644
--- a/arch/mips/au1000/common/power.c
+++ b/arch/mips/au1000/common/power.c
@@ -88,7 +88,10 @@ static DEFINE_SPINLOCK(pm_lock);
 static uint	sleep_aux_pll_cntrl;
 static uint	sleep_cpu_pll_cntrl;
 static uint	sleep_pin_function;
+static uint	sleep_gpio2_dir;
+static uint	sleep_gpio2_output;
 static uint	sleep_gpio2_enable;
+static uint	sleep_gpio2_inten;
 static uint	sleep_uart0_inten;
 static uint	sleep_uart0_fifoctl;
 static uint	sleep_uart0_linectl;
@@ -182,6 +185,10 @@ save_core_regs(void)
 	sleep_cpu_pll_cntrl = au_readl(SYS_CPUPLL);
 
 	sleep_pin_function = au_readl(SYS_PINFUNC);
+
+	sleep_gpio2_dir = au_readl(GPIO2_DIR);
+	sleep_gpio2_output = au_readl(GPIO2_OUTPUT);
+	sleep_gpio2_inten = au_readl(GPIO2_INTENABLE);
 	sleep_gpio2_enable = au_readl(GPIO2_ENABLE);
 
 	/* Save the static memory controller configuration.
@@ -209,7 +216,11 @@ restore_core_regs(void)
 	au_writel(sleep_aux_pll_cntrl, SYS_AUXPLL); au_sync();
 	au_writel(sleep_cpu_pll_cntrl, SYS_CPUPLL); au_sync();
 	au_writel(sleep_pin_function, SYS_PINFUNC); au_sync();
+
 	au_writel(sleep_gpio2_enable, GPIO2_ENABLE); au_sync();
+	au_writel(sleep_gpio2_dir, GPIO2_DIR); au_sync();
+	au_writel((sleep_gpio2_output<<16)|sleep_gpio2_output, GPIO2_OUTPUT); au_sync();
+	au_writel(sleep_gpio2_inten, GPIO2_INTENABLE); au_sync();
 
 	/* Restore the static memory controller configuration.
 	*/

--sm4nu43k4a2Rpi4c--
