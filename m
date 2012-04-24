Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Apr 2012 20:23:47 +0200 (CEST)
Received: from mail-pz0-f48.google.com ([209.85.210.48]:49091 "EHLO
        mail-pz0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903766Ab2DXSXb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Apr 2012 20:23:31 +0200
Received: by dakb39 with SMTP id b39so1052376dak.35
        for <multiple recipients>; Tue, 24 Apr 2012 11:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=eqWWh6rwtjaa9VtNAQr5Pg+YpYYoYMi1IBnN4B8tUmQ=;
        b=D0GEQ0usaNVIkKNLHaKXemqSIRFXXWBSE0zQc4MVsQa/ignl7e7TkYbwkuogfqnB26
         jpRSiHauz/LxE/wVxdgiJlaLGsEJL5C3RFsWTp56fzWStez6hzt4LODrEsV4D/YaY2z5
         X2fMv8A7Tr8eyeOxJRHyUox59ngYYbOxK9RbOHP0AJD/HGEacjkXVlkarUon4eBzAmAC
         PrUgFpFnlfLS4nXkhMSNHA7gHOVyBpbNqtEGUb8rcDFvIRx+65C+JDMKl9DgoVOvwwXg
         amHdKIUfIH1w3XZrvjvxTG8GdKg+ZfvNmCKUPtzsywltgBRkYQ2V7szKwTnTxjMHgJ1n
         byZg==
Received: by 10.68.129.129 with SMTP id nw1mr25253pbb.29.1335291805208;
        Tue, 24 Apr 2012 11:23:25 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id r10sm18056978pbf.22.2012.04.24.11.23.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Apr 2012 11:23:23 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q3OINLrg026737;
        Tue, 24 Apr 2012 11:23:21 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q3OINLGL026736;
        Tue, 24 Apr 2012 11:23:21 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Marek <mmarek@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/2] Revert "x86, extable: Disable presorted exception table for now"
Date:   Tue, 24 Apr 2012 11:23:15 -0700
Message-Id: <1335291795-26693-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1335291795-26693-1-git-send-email-ddaney.cavm@gmail.com>
References: <1335291795-26693-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 33004
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <ddaney@caviumnetworks.com>

sortextable now works with relative entries, re-enable it.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/x86/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1d14cc6..2f925cc 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -82,6 +82,7 @@ config X86
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select GENERIC_IOMAP
 	select DCACHE_WORD_ACCESS if !DEBUG_PAGEALLOC
+	select BUILDTIME_EXTABLE_SORT
 
 config INSTRUCTION_DECODER
 	def_bool (KPROBES || PERF_EVENTS)
-- 
1.7.7.6
