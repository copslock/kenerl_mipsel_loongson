Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Nov 2009 16:37:27 +0100 (CET)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:46041 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493113AbZKIPdd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Nov 2009 16:33:33 +0100
Received: by mail-ew0-f216.google.com with SMTP id 12so3364851ewy.0
        for <multiple recipients>; Mon, 09 Nov 2009 07:33:32 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=gJbIT3YJD1oIEsFWj7fg0jtdQtyZo77vwZ5SgOJDET4=;
        b=IFliml1BTg69xm7BxSfyjUCnKLI1gE/JeN1T10Lhm2oF14PxUBVVnGwvmbxyWc0DzI
         9/HEfBje0MZCNCcZCm7Hmq012uCHkLN6I6kULIPGNOtkelxDnprt3UyHSYMF+e+kOaVa
         7Que+YQrDX051orzrBQMhwjTfXLbSBFz9pNxc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mgdl9mE8w1cCE3a1x5VxAFFatohEV7XmweHKHPhgXvdCKC2c+FsNVURPgl71MrhN45
         xb/FMnXvPHFEarG77tJkry5HoVLWlFBTfWwUmrZq1UUZuCKIrMjMm8q1QupqYXVEbsOt
         v8H29ZAaxtP2kjxUmfoXxs6g4lIkxAxSkhh18=
Received: by 10.216.87.71 with SMTP id x49mr94198wee.11.1257780811997;
        Mon, 09 Nov 2009 07:33:31 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id g9sm9033556gvc.25.2009.11.09.07.33.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 07:33:31 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:	zhangfx@lemote.com, zhouqg@gmail.com,
	Wu Zhangjin <wuzhangjin@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>, rostedt@goodmis.org,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	David Daney <ddaney@caviumnetworks.com>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	Patrik Kluba <kpajko79@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Simek <monstr@monstr.eu>
Subject: [PATCH v7 14/17] tracing: make ftrace for MIPS work without -fno-omit-frame-pointer
Date:	Mon,  9 Nov 2009 23:31:31 +0800
Message-Id: <695747bff7cddb97d6f43c05c4cf05eb269e402d.1257779502.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <0c463e2af521e613fd15751a9f610c74cf887292.1257779502.git.wuzhangjin@gmail.com>
References: <9dc81a7a9e5a292cccdf465c533a2b08d19d6021.1257779502.git.wuzhangjin@gmail.com>
 <b99c08397d9ff92ac5a72bda9131df41b702fc71.1257779502.git.wuzhangjin@gmail.com>
 <8f579e2cece16cd22358a4ec143ef6a8c462639b.1257779502.git.wuzhangjin@gmail.com>
 <cefe074f5eb3cfbc2e0bb41b0c1f61fcd0190d90.1257779502.git.wuzhangjin@gmail.com>
 <6199d7b3956b544fc65896af1062787a2e1283ce.1257779502.git.wuzhangjin@gmail.com>
 <58a7558730fbea6cd0417100c8fcd6f45668d1e3.1257779502.git.wuzhangjin@gmail.com>
 <3a9fc9ca02e8e6e9c3c28797a4c084c1f9d91f69.1257779502.git.wuzhangjin@gmail.com>
 <0cef783a71333ff96a78aaea8961e3b6b5392665.1257779502.git.wuzhangjin@gmail.com>
 <18e1d617ed824bb1c10f15216f2ed9ed3de78abd.1257779502.git.wuzhangjin@gmail.com>
 <3da916c1cb6e05445438826f98a91111f43ff6cd.1257779502.git.wuzhangjin@gmail.com>
 <d4aa4cdb9b4c25e7a683c923bdeabed847bd8010.1257779502.git.wuzhangjin@gmail.com>
 <451c55dead5d6afd871de6afd14dbbcf70a0f834.1257779502.git.wuzhangjin@gmail.com>
 <0c463e2af521e613fd15751a9f610c74cf887292.1257779502.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1257779502.git.wuzhangjin@gmail.com>
References: <cover.1257779502.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24786
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

When remove the -fno-omit-frame-pointer, gcc will not save the frame
pointer for us, we need to save one ourselves.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/mcount.S |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
index 98d4690..bdfef2c 100644
--- a/arch/mips/kernel/mcount.S
+++ b/arch/mips/kernel/mcount.S
@@ -139,7 +139,15 @@ NESTED(ftrace_graph_caller, PT_SIZE, ra)
 #endif
 	PTR_LA	a0, PT_R1(sp)	/* arg1: &AT -> a0 */
 	jal	prepare_ftrace_return
+#ifdef CONFIG_FRAME_POINTER
 	 move	a2, fp		/* arg3: frame pointer */
+#else
+#ifdef CONFIG_64BIT
+	 PTR_LA	a2, PT_SIZE(sp)
+#else
+	 PTR_LA	a2, (PT_SIZE+8)(sp)
+#endif
+#endif
 
 	MCOUNT_RESTORE_REGS
 	RETURN_BACK
-- 
1.6.2.1
