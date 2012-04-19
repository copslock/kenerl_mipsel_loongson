Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Apr 2012 00:01:03 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:45496 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903732Ab2DSWAR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Apr 2012 00:00:17 +0200
Received: by obcni5 with SMTP id ni5so5398667obc.36
        for <multiple recipients>; Thu, 19 Apr 2012 15:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=c+UH2O4SxdjMCZIzoml/mo6jUQnaPypxbB2dneUJ2qs=;
        b=h5DKWLJ035HExi5uNLnNy3nPpmUBK/PdEGQB3PpPh9pMyIuMT0bIScl2qJ8W4s70G/
         1nWYXVXsBJKpo2lrRNcH3KmZd2jjYvJmF2wdjkGcisjJM9xlsNLnGDj97HPW+95RqrdT
         Il+9Wduu2zqfrymtK5gOJonYt+tGyV9NpNMxyQevpi5CyUrzYY0xTy7hepQKKMlCQXv9
         N2xLAhzy2bfS4LZUjCYFTuUdiVbtA5Mdmg7lRQ2nN45FpkeNmj19C+D0zVBG1YIiN5aY
         hD5oLmRU6kyWQJDI34kH/U32CK4ikTGf05NwbaTlS0fL/6baZji4gAjOc01+TrohdUh4
         5mmw==
Received: by 10.182.179.73 with SMTP id de9mr5397630obc.44.1334872811368;
        Thu, 19 Apr 2012 15:00:11 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id vp14sm3536639oeb.5.2012.04.19.15.00.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Apr 2012 15:00:09 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q3JM07Kb014648;
        Thu, 19 Apr 2012 15:00:07 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q3JM073u014647;
        Thu, 19 Apr 2012 15:00:07 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Marek <mmarek@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 5/5] x86: Select BUILDTIME_EXTABLE_SORT
Date:   Thu, 19 Apr 2012 14:59:59 -0700
Message-Id: <1334872799-14589-6-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1334872799-14589-1-git-send-email-ddaney.cavm@gmail.com>
References: <1334872799-14589-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 32981
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

We can sort the exeception table at build time for x86, so let's do
it.

Signed-off-by: David Daney <david.daney@cavium.com>
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
1.7.2.3
