Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Oct 2009 07:20:41 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:53474 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492203AbZJ2GUf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 29 Oct 2009 07:20:35 +0100
Received: by pwi11 with SMTP id 11so1284846pwi.24
        for <multiple recipients>; Wed, 28 Oct 2009 23:20:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=i8JtyCVTXa9dY5scwObUCMdzP3ms0cLVSo3bL8o2J+E=;
        b=TJRHDnkhIk3Yqx1e2PfS185Q3I+2LoNV9ipX3XFuo6z1k4/TmdwrLyNNxSGl2w8dZ5
         HgmVpSv3mi37wn/APRPpR4KgkxoPA7tBjoVjoCl9Kwk/+Kb5GcEQBuANwxcHF5Fh8cS0
         jwFaWqO2lQhrd1UtFZOABSoVWs+WjFX9DWhuk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=WJeHgAQ4r9/kUa7wWUTxN2H4mpQ2IG/nddLmaM2F8uJDShF6yBlINMoXxOKZe6BMH/
         /GNAkYtBScIPN2g5JltjvpSNXQryKHxYWauK6dUWq5VKDAWk/dBQKdNEFpbZkMBIuBcp
         sm2D7wf7CxZz1DwH4GOorL1opXJl2T22i/SjY=
Received: by 10.115.116.37 with SMTP id t37mr8969762wam.79.1256797226615;
        Wed, 28 Oct 2009 23:20:26 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm1052654pxi.6.2009.10.28.23.20.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 23:20:25 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -v1] MIPS: a few of fixups and cleanups for the compressed kernel support
Date:	Thu, 29 Oct 2009 14:20:12 +0800
Message-Id: <1256797212-7794-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24574
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patch indents the instructions in the delay slot of the file which
has a ".set noreorder" added.

and also, the "addu a0, 4" instruction is replaced by "addiu a0, a0, 4".

(This is against the commit
c6adcc73663a71f2aa9e66796a9bd57fcb6a349a(MIPS: add support for
gzip/bzip2/lzma compressed kernel images) in the mips-for-linux-next
branch of Ralf's
http://www.linux-mips.org/git?p=upstream-sfr.git;a=summary

This -v1 revision incorporates the feedback from "Maciej W. Rozycki"
<macro@linux-mips.org>)

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/boot/compressed/head.S |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/mips/boot/compressed/head.S b/arch/mips/boot/compressed/head.S
index e23f25e..6d069cd 100644
--- a/arch/mips/boot/compressed/head.S
+++ b/arch/mips/boot/compressed/head.S
@@ -30,7 +30,7 @@ start:
 	PTR_LA	a2, _end
 1:	sw	zero, 0(a0)
 	bne	a2, a0, 1b
-	addu	a0, 4
+	 addiu	a0, a0, 4
 
 	PTR_LA	a0, (.heap)          /* heap address */
 	PTR_LA  sp, (.stack + 8192)  /* stack address */
@@ -38,7 +38,7 @@ start:
 	PTR_LA	ra, 2f
 	PTR_LA	k0, decompress_kernel
 	jr	k0
-	nop
+	 nop
 2:
 	move	a0, s0
 	move	a1, s1
@@ -46,10 +46,12 @@ start:
 	move	a3, s3
 	PTR_LI	k0, KERNEL_ENTRY
 	jr	k0
-	nop
+	 nop
 3:
 	b 3b
+	 nop
 	END(start)
 
 	.comm .heap,BOOT_HEAP_SIZE,4
 	.comm .stack,4096*2,4
+	.set reorder
-- 
1.6.2.1
