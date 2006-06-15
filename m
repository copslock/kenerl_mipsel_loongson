Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jun 2006 09:13:23 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:1153 "EHLO
	gundam.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133975AbWFOING (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Jun 2006 09:13:06 +0100
Received: from giometti by gundam.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1FqmyL-00066p-00
	for <linux-mips@linux-mips.org>; Thu, 15 Jun 2006 10:13:01 +0200
Date:	Thu, 15 Jun 2006 10:13:01 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Subject: [PATCH] Invalid setting for SYS_WAKEMSK
Message-ID: <20060615081301.GA22369@gundam.enneenne.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11735
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

the following patch fix setting of register SYS_WAKEMSK.

Without this patch when you reset the board via hardware reset, and
your bootloader supports wake up code, the board will execute wake up
code instead of reset one.

Ciao,

Rodolfo


-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-sys_wakesrc-on-reset-fix

diff --git a/arch/mips/au1000/common/power.c b/arch/mips/au1000/common/power.c
index 4175396..9b47082 100644
--- a/arch/mips/au1000/common/power.c
+++ b/arch/mips/au1000/common/power.c
@@ -281,8 +281,8 @@ int au_sleep(int reason, int force)
 	DPRINTK("reason %d force %d wakeup %lX ticks %d\n",
 	        reason, force, wakeup, ticks);
 
-	au_writel(wakeup, SYS_WAKEMSK);
 	au_writel(~0, SYS_WAKESRC);	/* clear cause */
+	au_writel(wakeup, SYS_WAKEMSK);
 	au_sync();
 
 	DPRINTK("Zzz...\n");
@@ -301,6 +301,10 @@ int au_sleep(int reason, int force)
 	if (reason&(1<<8))		/* Wake up thanks to TOY */
 		reason = -ticks*HZ;
 
+	au_writel(~0, SYS_WAKESRC);	/* clear cause */
+	au_writel(0, SYS_WAKEMSK);	/* clear mask */
+	au_sync();
+
 	/* Call specific board routine */
 	if (board_after_sleep)
 		board_after_sleep(reason);
diff --git a/arch/mips/au1000/common/time.c b/arch/mips/au1000/common/time.c
index 177606b..e807e1b 100644
--- a/arch/mips/au1000/common/time.c
+++ b/arch/mips/au1000/common/time.c
@@ -442,8 +442,8 @@ #ifdef CONFIG_PM
 		au_writel(0, SYS_TOYWRITE);
 		while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_C0S);
 
-		au_writel(au_readl(SYS_WAKEMSK) | (1<<8), SYS_WAKEMSK);
 		au_writel(~0, SYS_WAKESRC);
+		au_writel(0, SYS_WAKEMSK);
 		au_sync();
 		while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_M20);
 

--tKW2IUtsqtDRztdT--
