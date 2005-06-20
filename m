Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jun 2005 22:54:43 +0100 (BST)
Received: from coderock.org ([IPv6:::ffff:193.77.147.115]:11416 "EHLO
	trashy.coderock.org") by linux-mips.org with ESMTP
	id <S8225395AbVFTVvI>; Mon, 20 Jun 2005 22:51:08 +0100
Received: by trashy.coderock.org (Postfix, from userid 780)
	id EF5041EDD2; Mon, 20 Jun 2005 23:51:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by trashy.coderock.org (Postfix) with ESMTP id CB7F51EDCC;
	Mon, 20 Jun 2005 23:51:04 +0200 (CEST)
Received: from nd47.coderock.org (localhost [127.0.0.1])
	by trashy.coderock.org (Postfix) with ESMTP id 235FC1EDC5;
	Mon, 20 Jun 2005 23:49:59 +0200 (CEST)
Received: (from domen@localhost)
	by nd47.coderock.org (8.13.3/8.13.3/Submit) id j5KLnwrt021803;
	Mon, 20 Jun 2005 23:49:58 +0200
Message-Id: <20050620214958.810995000@nd47.coderock.org>
Date:	Mon, 20 Jun 2005 23:49:58 +0200
From:	domen@coderock.org
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, Nishanth Aravamudan <nacc@us.ibm.com>,
	domen@coderock.org
Subject: [patch 7/8] mips/bcm1250_tbprof: remove interruptible_sleep_on() usage
Content-Disposition: inline; filename=int_sleep_on-arch_mips_sibyte_sb1250_bcm1250_tbprof.patch
Return-Path: <domen@nd47.coderock.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8111
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen@coderock.org
Precedence: bulk
X-list: linux-mips

From: Nishanth Aravamudan <nacc@us.ibm.com>



Remove deprecated interruptible_sleep_on() function call
and replace with direct wait-queue usage.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 bcm1250_tbprof.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

Index: quilt/arch/mips/sibyte/sb1250/bcm1250_tbprof.c
===================================================================
--- quilt.orig/arch/mips/sibyte/sb1250/bcm1250_tbprof.c
+++ quilt/arch/mips/sibyte/sb1250/bcm1250_tbprof.c
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
@@ -339,6 +343,7 @@ static int sbprof_tb_ioctl(struct inode 
 			   unsigned long arg)
 {
 	int error = 0;
+	DEFINE_WAIT(wait);
 
 	switch (command) {
 	case SBPROF_ZBSTART:
@@ -348,7 +353,9 @@ static int sbprof_tb_ioctl(struct inode 
 		error = sbprof_zbprof_stop();
 		break;
 	case SBPROF_ZBWAITFULL:
-		interruptible_sleep_on(&sbp.tb_read);
+		prepare_to_wait(&sbp.tb_read, &wait, TASK_INTERRUPTIBLE);
+		schedule();
+		finish_wait(&sbp.tb_read, &wait);
 		/* XXXKW check if interrupted? */
 		return put_user(TB_FULL, (int *) arg);
 	default:

--
