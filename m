Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 May 2010 13:10:43 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:58672 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491849Ab0ENLJN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 May 2010 13:09:13 +0200
Received: by mail-pw0-f49.google.com with SMTP id 3so114515pwi.36
        for <multiple recipients>; Fri, 14 May 2010 04:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=68LFZGu6NUH8C8AQiePJHdFodJK1B/VLdKBFLHRR4RQ=;
        b=M+DCyTJI8z9EIHAySqc5zP9Q9PhveqVC0hfbT8QpVC2ypcCJ7Qpe2iHqFneE/hLstp
         6QD7OQ++d8ctW28bwEgun97chHnZ38iMKs8GiPgk+NHb5dJUzA68h2CzbdLmae969XQv
         /+RqHpynRgr/qyRczmw0x0m1SiDvxCaVee4qU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tH9Gpt3f19Y2hPxghIMJNkqDjgqtpNvYNhcNEBxsg7ySBqLOQ5YnFvqdytboKxnUJn
         WmUIuTkBg5P7VYWlrVpOFRnvcrfxF7BXmM1D2zWYeLiSacXTv9BkulfnjChtTsad5bIb
         sIEVBeTaf8N0O3/xAYSlsj1LDvcc2f05KyeIo=
Received: by 10.114.19.9 with SMTP id 9mr1046014was.52.1273835352090;
        Fri, 14 May 2010 04:09:12 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id c14sm19145160waa.13.2010.05.14.04.09.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 May 2010 04:09:11 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        David Daney <david.s.daney@gmail.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 4/9] tracing: MIPS: mcount.S: Fix the argument passing of the 32bit support with gcc 4.5
Date:   Fri, 14 May 2010 19:08:29 +0800
Message-Id: <e67789486c5aac4bb5fd5b4ef34a4ca797facac1.1273834562.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1273834561.git.wuzhangjin@gmail.com>
References: <cover.1273834561.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1273834561.git.wuzhangjin@gmail.com>
References: <cover.1273834561.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26713
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

As the doc[1] of gcc-4.5 shows, the -mmcount-ra-address uses register
$12 to transfer the stack offset of the return address to the _mcount
function. in 64bit kernel, $12 is t0, but in 32bit kernel, it is t4, so,
we need to use $12 instead of t0 here to cover the 64bit and 32bit
support.

[1] Gcc doc: MIPS Options
http://gcc.gnu.org/onlinedocs/gcc/MIPS-Options.html

Changes from old revision:
  o Apply the feedback from David Daney:
  define a macro MCOUNT_RA_ADDRESS_REG instead of the magic number $12


Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/mcount.S |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
index 9a029d4..6bfcb7a 100644
--- a/arch/mips/kernel/mcount.S
+++ b/arch/mips/kernel/mcount.S
@@ -57,6 +57,12 @@
 	 move ra, AT
 	.endm
 
+/*
+ * The -mmcount-ra-address option of gcc 4.5 uses register $12 to pass
+ * the location of the parent's return address.
+ */
+#define MCOUNT_RA_ADDRESS_REG	$12
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 NESTED(ftrace_caller, PT_SIZE, ra)
@@ -70,7 +76,7 @@ _mcount:
 
 	MCOUNT_SAVE_REGS
 #ifdef KBUILD_MCOUNT_RA_ADDRESS
-	PTR_S	t0, PT_R12(sp)	/* save location of parent's return address */
+	PTR_S	MCOUNT_RA_ADDRESS_REG, PT_R12(sp)
 #endif
 
 	move	a0, ra		/* arg1: self return address */
@@ -142,9 +148,9 @@ NESTED(ftrace_graph_caller, PT_SIZE, ra)
 #ifdef CONFIG_DYNAMIC_FTRACE
 	PTR_L	a0, PT_R12(sp)
 #else
-	move	a0, t0
+	move	a0, MCOUNT_RA_ADDRESS_REG
 #endif
-	bnez	a0, 1f		/* non-leaf func: stored in t0 */
+	bnez	a0, 1f	/* non-leaf func: stored in MCOUNT_RA_ADDRESS_REG */
 	 nop
 #endif
 	PTR_LA	a0, PT_R1(sp)	/* leaf func: the location in current stack */
-- 
1.7.0.4
