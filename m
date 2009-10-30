Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Oct 2009 02:35:47 +0100 (CET)
Received: from mail-yw0-f173.google.com ([209.85.211.173]:40483 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493621AbZJ3Bfl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 30 Oct 2009 02:35:41 +0100
Received: by ywh3 with SMTP id 3so2522571ywh.22
        for <multiple recipients>; Thu, 29 Oct 2009 18:35:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=gnjHt5nvoeU5iEoXA9u7ZnhwBO5mCvQ141LB9lLZo6c=;
        b=nUpWkhfztMeTjm02ugQ901UAbeSaZMB8EtSWim9WI0BhrgSgVaVGdcVnPKFSXu055c
         WNxxbKUW/7RjlKn1l0a6ljJFZz+dnlyNPnhDIKhuSvNvyGBx+aWUd5uM62/iU/R7Quuj
         By5vJQXMlnZcfRVu6tH6lDzwt72b/68WvAw0o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=XOkJh2RKlGPLLbScZlgJCY2hJvONvufgrJQWC9KADVrRe/wINK8FnVZubQC5IJOuth
         1X/QNqjjbbkffKXfuGuQJ3Z5ivrf5rHnezvZQacyb2NmJ94cyx8SjC1m3WYIixD04mlt
         jgoqzsnH/9VZXxt4JCjwaXsrqdZPxBU7BQyXI=
Received: by 10.150.87.28 with SMTP id k28mr1676235ybb.275.1256866534139;
        Thu, 29 Oct 2009 18:35:34 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 4sm934793ywd.29.2009.10.29.18.35.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Oct 2009 18:35:33 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v3] MIPS: fixes and cleanups for the compressed kernel support
Date:	Fri, 30 Oct 2009 09:35:24 +0800
Message-Id: <1256866524-26863-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24584
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

This -v3 revision incorporates the feedback from "Maciej W. Rozycki"
<macro@linux-mips.org> and David Daney <ddaney@caviumnetworks.com>

Hi, Ralf, could you please merge it into you mips-for-linux-next
branch?)

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/boot/compressed/head.S |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/mips/boot/compressed/head.S b/arch/mips/boot/compressed/head.S
index e23f25e..4e65a84 100644
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
-	b 3b
+	b	3b
+	 nop
 	END(start)
 
 	.comm .heap,BOOT_HEAP_SIZE,4
-- 
1.6.2.1
