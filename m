Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Oct 2009 03:11:16 +0100 (CET)
Received: from mail-yw0-f173.google.com ([209.85.211.173]:36081 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493209AbZJ2CLK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 29 Oct 2009 03:11:10 +0100
Received: by ywh3 with SMTP id 3so1441776ywh.22
        for <multiple recipients>; Wed, 28 Oct 2009 19:11:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=eQpdJ0vkDqD8qwjuZbonTcfSGoHDjsokr1OG5E6s+DY=;
        b=cZsMmh59sNQeBOKQgMhcO+0Rylnc8ylEyAuzl5hhYoaTnLGv2c/3dDl/NaRTMokzRm
         5GKxp2z1NPvJ/N3LDMUhkzrgXm3DvZSjl638wPX2VNsjasK4sUPyLAJz4J6EfuON1lXD
         xOjnRkqzxKo2+mNgPyYRhEBcKNHwqR8cpLB4w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=up9S2uSJGtGHM4BcoQPE25PvcWqXQFPTTjFtkjSjzHxuFqIk25OBsFjgPzxXt9k0kk
         g2n1MHMAeFaq+jUYj3WnyX2eAv8qpexXs2sUyv+NqXAxmp/WQq4LFkuGlck7xATqn3mt
         2lK4n4VTjjJERtfEyGcfT6eFMW3wbNY/t1VEw=
Received: by 10.90.121.17 with SMTP id t17mr2487763agc.57.1256782263697;
        Wed, 28 Oct 2009 19:11:03 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 8sm686255yxb.61.2009.10.28.19.11.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 19:11:03 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Robert Richter <robert.richter@amd.com>, chenj@lemote.com,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -sfr.git] MIPS: zboot: indent the nop instruction in delay slot
Date:	Thu, 29 Oct 2009 10:10:52 +0800
Message-Id: <1256782252-2240-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24569
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

This is for the commit c6adcc73663a71f2aa9e66796a9bd57fcb6a349a(MIPS:
add support for gzip/bzip2/lzma compressed kernel images)

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/boot/compressed/head.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/boot/compressed/head.S b/arch/mips/boot/compressed/head.S
index e23f25e..29080f4 100644
--- a/arch/mips/boot/compressed/head.S
+++ b/arch/mips/boot/compressed/head.S
@@ -38,7 +38,7 @@ start:
 	PTR_LA	ra, 2f
 	PTR_LA	k0, decompress_kernel
 	jr	k0
-	nop
+	 nop
 2:
 	move	a0, s0
 	move	a1, s1
@@ -46,7 +46,7 @@ start:
 	move	a3, s3
 	PTR_LI	k0, KERNEL_ENTRY
 	jr	k0
-	nop
+	 nop
 3:
 	b 3b
 	END(start)
-- 
1.6.2.1
