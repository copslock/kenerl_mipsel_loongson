Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Jul 2003 09:35:57 +0100 (BST)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:18141 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225072AbTGYIfz>;
	Fri, 25 Jul 2003 09:35:55 +0100
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id RAA22264;
	Fri, 25 Jul 2003 17:35:51 +0900 (JST)
Received: 4UMDO00 id h6P8ZpR15544; Fri, 25 Jul 2003 17:35:51 +0900 (JST)
Received: 4UMRO01 id h6P8Zo427868; Fri, 25 Jul 2003 17:35:50 +0900 (JST)
	from pudding.montavista.co.jp (sonicwall.montavista.co.jp [202.232.97.131]) (authenticated)
Date: Fri, 25 Jul 2003 17:35:51 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: ralf@linux-mips.org
Cc: yuasa@hh.iij4u.or.jp, linux-mips@linux-mips.org
Subject: [patch] wrong value definition about IBM WorkPad
Message-Id: <20030725173551.628f5bcb.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Fri__25_Jul_2003_17:35:51_+0900_08517000"
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2910
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

--Multipart_Fri__25_Jul_2003_17:35:51_+0900_08517000
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello Ralf,

I made a patch for wrong value definition about IBM WorkPad.

Please apply these patches to v2.4 and v2.6 CVS tree.

Yoichi

--Multipart_Fri__25_Jul_2003_17:35:51_+0900_08517000
Content-Type: text/plain;
 name="workpad-v24.diff"
Content-Disposition: attachment;
 filename="workpad-v24.diff"
Content-Transfer-Encoding: 7bit

diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/include/asm-mips/vr41xx/workpad.h linux/include/asm-mips/vr41xx/workpad.h
--- linux.orig/include/asm-mips/vr41xx/workpad.h	Fri Oct  4 01:58:02 2002
+++ linux/include/asm-mips/vr41xx/workpad.h	Fri Jul 25 15:10:10 2003
@@ -22,7 +22,7 @@
 /*
  * Board specific address mapping
  */
-#define VR41XX_ISA_MEM_BASE		0x100000000
+#define VR41XX_ISA_MEM_BASE		0x10000000
 #define VR41XX_ISA_MEM_SIZE		0x04000000
 
 /* VR41XX_ISA_IO_BASE includes offset from real base. */

--Multipart_Fri__25_Jul_2003_17:35:51_+0900_08517000
Content-Type: text/plain;
 name="workpad-v26.diff"
Content-Disposition: attachment;
 filename="workpad-v26.diff"
Content-Transfer-Encoding: 7bit

diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/include/asm-mips/vr41xx/workpad.h linux/include/asm-mips/vr41xx/workpad.h
--- linux.orig/include/asm-mips/vr41xx/workpad.h	Fri Oct  4 01:57:50 2002
+++ linux/include/asm-mips/vr41xx/workpad.h	Fri Jul 25 17:26:10 2003
@@ -22,7 +22,7 @@
 /*
  * Board specific address mapping
  */
-#define VR41XX_ISA_MEM_BASE		0x100000000
+#define VR41XX_ISA_MEM_BASE		0x10000000
 #define VR41XX_ISA_MEM_SIZE		0x04000000
 
 /* VR41XX_ISA_IO_BASE includes offset from real base. */

--Multipart_Fri__25_Jul_2003_17:35:51_+0900_08517000--
