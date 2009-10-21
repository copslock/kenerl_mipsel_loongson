Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Oct 2009 16:36:44 +0200 (CEST)
Received: from mail-fx0-f225.google.com ([209.85.220.225]:52047 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493553AbZJUOfe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 21 Oct 2009 16:35:34 +0200
Received: by mail-fx0-f225.google.com with SMTP id 25so8067331fxm.0
        for <multiple recipients>; Wed, 21 Oct 2009 07:35:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=fuowreq3mv7Ra/i095UPkiUBWucGRWITP7Hq9/O00YM=;
        b=l4hXWnAlBBijXyPKhjchazQTK4h3/MpWHL1XR9ZMmPfhz9ka68aLeSlr/Xd7ms395r
         2msEwZlzhBBAJt5Pvhx75q/gRKblErO6tMn7U2pNQ9v3X3VgdrvPldhkfxwuemh9ZEDT
         zSvpk6YVUBshpUjvllFPdXv+b8aRwctX2DwNc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MWukmIfelNqR8gkEOkrmicKcJWkhPep7sow7KrZfqs/gPMbSbIRmm1A34ab1k1R9CF
         z715JEbMQLmP+5YxijmDRjpA37mkgRXM3KXUmLQ6FKTl39emKl0IaOdf1KB8bKWc23xb
         r0XkB/+m1hNfnXGRm72Gm5MFtBIFcY9vmIxUY=
Received: by 10.204.34.65 with SMTP id k1mr2919933bkd.111.1256135734373;
        Wed, 21 Oct 2009 07:35:34 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 1sm303459fkt.11.2009.10.21.07.35.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Oct 2009 07:35:33 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH -v4 5/9] tracing: enable HAVE_FUNCTION_TRACE_MCOUNT_TEST for MIPS
Date:	Wed, 21 Oct 2009 22:34:59 +0800
Message-Id: <96110ea5dd4d3d54eb97d0bb708a5bd81c7a50b5.1256135456.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <ea8aa927fbd184b54941e4c2ae0be8ea0b4f6b8a.1256135456.git.wuzhangjin@gmail.com>
References: <028867b99ec532b84963a35e7d552becc783cafc.1256135456.git.wuzhangjin@gmail.com>
 <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256135456.git.wuzhangjin@gmail.com>
 <3f0d3515f74a58f4cfd11e61b62a129fdc21e3a7.1256135456.git.wuzhangjin@gmail.com>
 <ea8aa927fbd184b54941e4c2ae0be8ea0b4f6b8a.1256135456.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1256135456.git.wuzhangjin@gmail.com>
References: <cover.1256135456.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24407
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Kconfig         |    1 +
 arch/mips/kernel/mcount.S |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 6b33e88..a9bd992 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -5,6 +5,7 @@ config MIPS
 	select HAVE_OPROFILE
 	select HAVE_ARCH_KGDB
 	select HAVE_FUNCTION_TRACER
+	select HAVE_FUNCTION_TRACE_MCOUNT_TEST
 	# Horrible source of confusion.  Die, die, die ...
 	select EMBEDDED
 	select RTC_LIB if !LEMOTE_FULOONG2E
diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
index 5bb8055..82e54ab 100644
--- a/arch/mips/kernel/mcount.S
+++ b/arch/mips/kernel/mcount.S
@@ -69,6 +69,10 @@
 
 NESTED(_mcount, PT_SIZE, ra)
 	RESTORE_SP_FOR_32BIT
+	lw	t0, function_trace_stop
+	bnez	t0, ftrace_stub
+	nop
+
 	PTR_LA	t0, ftrace_stub
 	PTR_L	t1, ftrace_trace_function /* please don't use t1 later, safe? */
 	bne	t0, t1, static_trace
-- 
1.6.2.1
