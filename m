Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Apr 2004 20:20:54 +0100 (BST)
Received: from ispmxmta09-srv.alltel.net ([IPv6:::ffff:166.102.165.170]:62975
	"EHLO ispmxmta09-srv.alltel.net") by linux-mips.org with ESMTP
	id <S8225801AbUDMTUx>; Tue, 13 Apr 2004 20:20:53 +0100
Received: from lahoo.priv ([162.39.1.206]) by ispmxmta09-srv.alltel.net
          with ESMTP
          id <20040413192043.VXPA2984.ispmxmta09-srv.alltel.net@lahoo.priv>
          for <linux-mips@linux-mips.org>; Tue, 13 Apr 2004 14:20:43 -0500
Received: from prefect.priv ([10.1.1.141] helo=prefect)
	by lahoo.priv with smtp (Exim 3.36 #1 (Debian))
	id 1BDTET-0006Ax-00
	for <linux-mips@linux-mips.org>; Tue, 13 Apr 2004 15:06:05 -0400
Message-ID: <028001c4218c$6d792350$8d01010a@prefect>
From: "Bradley D. LaRonde" <brad@laronde.org>
To: <linux-mips@linux-mips.org>
Subject: [PATCH] catch "new" gcc 3.4.0 sections
Date: Tue, 13 Apr 2004 15:20:48 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Return-Path: <brad@laronde.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4770
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brad@laronde.org
Precedence: bulk
X-list: linux-mips

Building with gcc 3.4.0 emits a couple new sections, .rodata.cst4 and
.rodata.str1.4, which the current ld.script doesn't contemplate.  Here is a
patch to catch them (and maybe some other latent ones).

Anyone know why or when these sections are emitted?

Regards,
Brad


diff -u -r1.1.1.1 ld.script.in
--- arch/mips/ld.script.in      10 Nov 2003 21:06:52 -0000      1.1.1.1
+++ arch/mips/ld.script.in      13 Apr 2004 19:18:25 -0000
@@ -11,6 +11,11 @@
     *(.text)
     *(.rodata)
     *(.rodata1)
+    *(.rodata.str1.1);
+    *(.rodata.str1.4);
+    *(.rodata.str1.32);
+    *(.rodata.cst4);
+    *(.rodata.cst8);
     /* .gnu.warning sections are handled specially by elf32.em.  */
     *(.gnu.warning)
   } =0
