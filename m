Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Feb 2005 23:09:18 +0000 (GMT)
Received: from e3.ny.us.ibm.com ([IPv6:::ffff:32.97.182.143]:42699 "EHLO
	e3.ny.us.ibm.com") by linux-mips.org with ESMTP id <S8225439AbVBBXJB>;
	Wed, 2 Feb 2005 23:09:01 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.12.10/8.12.10) with ESMTP id j12N8sZW005620;
	Wed, 2 Feb 2005 18:08:54 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j12N8sGL127266;
	Wed, 2 Feb 2005 18:08:54 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j12N8snf004102;
	Wed, 2 Feb 2005 18:08:54 -0500
Received: from joust (joust.beaverton.ibm.com [9.47.17.68])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j12N8sFv004065;
	Wed, 2 Feb 2005 18:08:54 -0500
Received: by joust (Postfix, from userid 1000)
	id 355F24F9C9; Wed,  2 Feb 2005 15:08:53 -0800 (PST)
Date:	Wed, 2 Feb 2005 15:08:53 -0800
From:	Nishanth Aravamudan <nacc@us.ibm.com>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, kernel-janitors@lists.osdl.org
Subject: [PATCH 20/20] mips/bcm1250_tbprof: remove interruptible_sleep_on() usage
Message-ID: <20050202230853.GA2546@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Return-Path: <nacc@us.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7122
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nacc@us.ibm.com
Precedence: bulk
X-list: linux-mips

Hello,

Please consider applying.

Description: Remove deprecated interruptible_sleep_on() function call
and replace with direct wait-queue usage.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.11-rc2-kj-v/arch/mips/sibyte/sb1250/bcm1250_tbprof.c	2005-01-24 09:28:12.000000000 -0800
+++ 2.6.11-rc2-kj/arch/mips/sibyte/sb1250/bcm1250_tbprof.c	2005-02-02 15:07:08.000000000 -0800
@@ -28,6 +28,7 @@
 #include <linux/fs.h>
 #include <linux/errno.h>
 #include <linux/reboot.h>
+#include <linux/wait.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/sibyte/sb1250.h>
@@ -227,6 +228,7 @@ int sbprof_zbprof_start(struct file *fil
 
 int sbprof_zbprof_stop(void)
 {
+	DEFINE_WAIT(wait);
 	DBG(printk(DEVNAME ": stopping\n"));
 
 	if (sbp.tb_enable) {
@@ -236,7 +238,9 @@ int sbprof_zbprof_stop(void)
 		   this sleep happens. */
 		if (sbp.tb_armed) {
 			DBG(printk(DEVNAME ": wait for disarm\n"));
-			interruptible_sleep_on(&sbp.tb_sync);
+			prepare_to_wait(&sbp.tb_sync, &wait, TASK_INTERRUPTIBLE);
+			schedule();
+			finish_wait(&sbp.tb_sync, &wait);
 			DBG(printk(DEVNAME ": disarm complete\n"));
 		}
 		free_irq(K_INT_TRACE_FREEZE, &sbp);
@@ -344,7 +348,10 @@ static int sbprof_tb_ioctl(struct inode 
 		error = sbprof_zbprof_stop();
 		break;
 	case SBPROF_ZBWAITFULL:
-		interruptible_sleep_on(&sbp.tb_read);
+		DEFINE_WAIT(wait);
+		prepare_to_wait(&sbp.tb_read, &wait, TASK_INTERRUPTIBLE);
+		schedule();
+		finish_wait(&sbp.tb_read, &wait);
 		/* XXXKW check if interrupted? */
 		return put_user(TB_FULL, (int *) arg);
 	default:
