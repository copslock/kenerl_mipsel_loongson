Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Mar 2005 10:49:54 +0000 (GMT)
Received: from coderock.org ([IPv6:::ffff:193.77.147.115]:19371 "EHLO
	trashy.coderock.org") by linux-mips.org with ESMTP
	id <S8225467AbVCFKqW>; Sun, 6 Mar 2005 10:46:22 +0000
Received: by trashy.coderock.org (Postfix, from userid 780)
	id BAD6B1F23F; Sun,  6 Mar 2005 11:46:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by trashy.coderock.org (Postfix) with ESMTP id E03AE1F203;
	Sun,  6 Mar 2005 11:46:19 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by trashy.coderock.org (Postfix) with ESMTP id 1D8C11F23D;
	Sun,  6 Mar 2005 11:46:07 +0100 (CET)
Subject: [patch 7/8] mips/bcm1250_tbprof: remove interruptible_sleep_on() usage
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, domen@coderock.org, nacc@us.ibm.com
From:	domen@coderock.org
Date:	Sun, 06 Mar 2005 11:46:06 +0100
Message-Id: <20050306104607.1D8C11F23D@trashy.coderock.org>
Return-Path: <domen@coderock.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7380
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen@coderock.org
Precedence: bulk
X-list: linux-mips



Remove deprecated interruptible_sleep_on() function call
and replace with direct wait-queue usage.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/arch/mips/sibyte/sb1250/bcm1250_tbprof.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff -puN arch/mips/sibyte/sb1250/bcm1250_tbprof.c~int_sleep_on-arch_mips_sibyte_sb1250_bcm1250_tbprof arch/mips/sibyte/sb1250/bcm1250_tbprof.c
--- kj/arch/mips/sibyte/sb1250/bcm1250_tbprof.c~int_sleep_on-arch_mips_sibyte_sb1250_bcm1250_tbprof	2005-03-05 16:12:04.000000000 +0100
+++ kj-domen/arch/mips/sibyte/sb1250/bcm1250_tbprof.c	2005-03-05 16:12:04.000000000 +0100
@@ -28,6 +28,7 @@
 #include <linux/fs.h>
 #include <linux/errno.h>
 #include <linux/reboot.h>
+#include <linux/wait.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/sibyte/sb1250.h>
@@ -231,6 +232,7 @@ int sbprof_zbprof_start(struct file *fil
 
 int sbprof_zbprof_stop(void)
 {
+	DEFINE_WAIT(wait);
 	DBG(printk(DEVNAME ": stopping\n"));
 
 	if (sbp.tb_enable) {
@@ -240,7 +242,9 @@ int sbprof_zbprof_stop(void)
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
@@ -348,7 +352,10 @@ static int sbprof_tb_ioctl(struct inode 
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
_
