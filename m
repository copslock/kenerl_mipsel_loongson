Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Oct 2009 02:14:06 +0100 (CET)
Received: from mail-yw0-f173.google.com ([209.85.211.173]:37148 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492935AbZJ3BOA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 30 Oct 2009 02:14:00 +0100
Received: by ywh3 with SMTP id 3so2507144ywh.22
        for <multiple recipients>; Thu, 29 Oct 2009 18:13:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=9PiPCV6el15eFxtO4VsJzxODHioXX/3WPwjdG5BUu0U=;
        b=KN8RCQDuTObpzCJ16/NwP2vPvmJrRP2JQOGKMtrjc9whv0UqYohRcFY/Kwtrd1hD0O
         8uJOSepbBbFz9PGR0m90Ob4wwCxm0YwbdZWR3cJUIPhy/YOfqgs69OMyQQE71OUrvz+W
         9Cn6eGkSlrDfVp1W2mkScWQnrhyreRux5ca1k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=L63fNwCzDrhBOHFz4lKjfBaVBtw3iPookOVpcPlPttx/2xuTA6yhAMKxe0UQKByrD7
         nSCdfc5R324JXSuu17b1P6lIs6yCcBlW1uIcVAerVZ5hgWmGYOiNV0ds8ZXYMg0mhUVk
         s7Psy4sWAvcZ8Q6Vax20sm46ftimvI0i2g64Q=
Received: by 10.90.10.40 with SMTP id 40mr2408280agj.85.1256865231266;
        Thu, 29 Oct 2009 18:13:51 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 7sm1138370yxd.62.2009.10.29.18.13.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Oct 2009 18:13:50 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v2] MIPS: fixes and cleanups for the compressed kernel support
Date:	Fri, 30 Oct 2009 09:13:42 +0800
Message-Id: <1256865222-19817-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24582
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

This -v2 revision incorporates the feedback from "Maciej W. Rozycki"
<macro@linux-mips.org> and David Daney <ddaney@caviumnetworks.com>

Hi, Ralf, could you please merge it into you mips-for-linux-next
branch?)

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/boot/compressed/head.S |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/boot/compressed/head.S b/arch/mips/boot/compressed/head.S
index e23f25e..cd447e2 100644
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
@@ -46,9 +46,10 @@ start:
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
-- 
1.6.2.1
