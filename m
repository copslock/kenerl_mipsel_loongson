Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jul 2006 22:26:52 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:52713 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S3489828AbWGFV0n (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 6 Jul 2006 22:26:43 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 604B63EC9; Thu,  6 Jul 2006 14:26:21 -0700 (PDT)
Message-ID: <44AD7FBA.8000203@ru.mvista.com>
Date:	Fri, 07 Jul 2006 01:25:14 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	ralf@linux-mips.org, Linux-MIPS <linux-mips@linux-mips.org>
Cc:	a.voropay@equant.ru
Subject: [PATCH] Fix process crash in 2.4 on attempt to use FPU on MIPS32
Content-Type: multipart/mixed;
 boundary="------------080003060807040507050809"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11927
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------080003060807040507050809
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

If there's built-in FPU in a MIPS32 CPU the first time the process tries
to use it, the kernel should crash with "reserved instruction" -- CPU will try
to execute 'dmtc1' which is a MIPS64 only insn. _init_fpu() was apprently 
blindly copied form arch/mips64/... :-)

Since this occured with GXemul recently resending this 1.5 year old patch.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>



--------------080003060807040507050809
Content-Type: text/plain;
 name="MIPS32-FPU-init-2.4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="MIPS32-FPU-init-2.4.patch"

diff --git a/arch/mips/kernel/r4k_switch.S b/arch/mips/kernel/r4k_switch.S
index 1999483..30b67c8 100644
--- a/arch/mips/kernel/r4k_switch.S
+++ b/arch/mips/kernel/r4k_switch.S
@@ -134,7 +134,6 @@ LEAF(_restore_fp)
 #define FPU_DEFAULT  0x00000000
 
 LEAF(_init_fpu)
-	.set	mips3
 	mfc0	t0, CP0_STATUS
 	li	t1, ST0_CU1
 	or	t0, t1
@@ -146,24 +145,40 @@ LEAF(_init_fpu)
 
 	li	t0, -1
 
-	dmtc1	t0, $f0
-	dmtc1	t0, $f2
-	dmtc1	t0, $f4
-	dmtc1	t0, $f6
-	dmtc1	t0, $f8
-	dmtc1	t0, $f10
-	dmtc1	t0, $f12
-	dmtc1	t0, $f14
-	dmtc1	t0, $f16
-	dmtc1	t0, $f18
-	dmtc1	t0, $f20
-	dmtc1	t0, $f22
-	dmtc1	t0, $f24
-	dmtc1	t0, $f26
-	dmtc1	t0, $f28
+	mtc1	t0, $f0
+	mtc1	t0, $f1
+	mtc1	t0, $f2
+	mtc1	t0, $f3
+	mtc1	t0, $f4
+	mtc1	t0, $f5
+	mtc1	t0, $f6
+	mtc1	t0, $f7
+	mtc1	t0, $f8
+	mtc1	t0, $f9
+	mtc1	t0, $f10
+	mtc1	t0, $f11
+	mtc1	t0, $f12
+	mtc1	t0, $f13
+	mtc1	t0, $f14
+	mtc1	t0, $f15
+	mtc1	t0, $f16
+	mtc1	t0, $f17
+	mtc1	t0, $f18
+	mtc1	t0, $f19
+	mtc1	t0, $f20
+	mtc1	t0, $f21
+	mtc1	t0, $f22
+	mtc1	t0, $f23
+	mtc1	t0, $f24
+	mtc1	t0, $f25
+	mtc1	t0, $f26
+	mtc1	t0, $f27
+	mtc1	t0, $f28
+	mtc1	t0, $f29
+	mtc1	t0, $f30
 	.set	noreorder
 	jr	ra
-	 dmtc1	t0, $f30
 	.set	reorder
+	 mtc1	t0, $f31
 	END(_init_fpu)
 



--------------080003060807040507050809--
