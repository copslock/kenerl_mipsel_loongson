Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Feb 2006 15:45:39 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:41669 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133466AbWBIPpa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Feb 2006 15:45:30 +0000
Received: from localhost (p5155-ipad30funabasi.chiba.ocn.ne.jp [221.184.80.155])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 229968422; Fri, 10 Feb 2006 00:51:21 +0900 (JST)
Date:	Fri, 10 Feb 2006 00:51:04 +0900 (JST)
Message-Id: <20060210.005104.63742308.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] make qemu buildable without CONFIG_VT
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10382
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/qemu/Makefile b/arch/mips/qemu/Makefile
index 11189fa..5f34a85 100644
--- a/arch/mips/qemu/Makefile
+++ b/arch/mips/qemu/Makefile
@@ -2,4 +2,5 @@
 # Makefile for Qemu specific kernel interface routines under Linux.
 #
 
-obj-y		= q-firmware.o q-int.o q-irq.o q-mem.o q-setup.o q-vga.o
+obj-y		= q-firmware.o q-int.o q-irq.o q-mem.o q-setup.o
+obj-$(CONFIG_VT) = q-vga.o
diff --git a/arch/mips/qemu/q-setup.c b/arch/mips/qemu/q-setup.c
index 32c3d4c..acf0f5b 100644
--- a/arch/mips/qemu/q-setup.c
+++ b/arch/mips/qemu/q-setup.c
@@ -23,6 +23,8 @@ static void __init qemu_timer_setup(stru
 void __init plat_setup(void)
 {
 	set_io_port_base(QEMU_PORT_BASE);
+#ifdef CONFIG_VT
 	qvga_init();
+#endif
 	board_timer_setup = qemu_timer_setup;
 }
