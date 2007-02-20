Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Feb 2007 11:09:16 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:10703 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20038868AbXBTLJL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Feb 2007 11:09:11 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Tue, 20 Feb 2007 20:09:09 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 3B1E53EEB0;
	Tue, 20 Feb 2007 20:08:46 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 2EFDA203B8;
	Tue, 20 Feb 2007 20:08:46 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l1KB8jW0022825;
	Tue, 20 Feb 2007 20:08:46 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 20 Feb 2007 20:08:45 +0900 (JST)
Message-Id: <20070220.200845.98359099.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Drop __init from init_8259A()
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14167
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

init_8259A() is called from i8259A_resume() so should not be marked as
__init.  And add some tests for whether 8259A was already initialized
or not.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/kernel/i8259.c b/arch/mips/kernel/i8259.c
index b33ba6c..9c79703 100644
--- a/arch/mips/kernel/i8259.c
+++ b/arch/mips/kernel/i8259.c
@@ -28,7 +28,7 @@
  * moves to arch independent land
  */
 
-static int i8259A_auto_eoi;
+static int i8259A_auto_eoi = -1;
 DEFINE_SPINLOCK(i8259A_lock);
 /* some platforms call this... */
 void mask_and_ack_8259A(unsigned int);
@@ -216,7 +216,8 @@ spurious_8259A_irq:
 
 static int i8259A_resume(struct sys_device *dev)
 {
-	init_8259A(i8259A_auto_eoi);
+	if (i8259A_auto_eoi >= 0)
+		init_8259A(i8259A_auto_eoi);
 	return 0;
 }
 
@@ -226,8 +227,10 @@ static int i8259A_shutdown(struct sys_device *dev)
 	 * the kernel initialization code can get it
 	 * out of.
 	 */
-	outb(0xff, PIC_MASTER_IMR);	/* mask all of 8259A-1 */
-	outb(0xff, PIC_SLAVE_IMR);	/* mask all of 8259A-1 */
+	if (i8259A_auto_eoi >= 0) {
+		outb(0xff, PIC_MASTER_IMR);	/* mask all of 8259A-1 */
+		outb(0xff, PIC_SLAVE_IMR);	/* mask all of 8259A-1 */
+	}
 	return 0;
 }
 
@@ -252,7 +255,7 @@ static int __init i8259A_init_sysfs(void)
 
 device_initcall(i8259A_init_sysfs);
 
-void __init init_8259A(int auto_eoi)
+void init_8259A(int auto_eoi)
 {
 	unsigned long flags;
 
