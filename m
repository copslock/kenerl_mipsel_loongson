Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2011 20:40:16 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:41558 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904147Ab1KRTiO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Nov 2011 20:38:14 +0100
Received: by ggnb1 with SMTP id b1so3418392ggn.36
        for <multiple recipients>; Fri, 18 Nov 2011 11:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5nwa3lYYDjtq67+5lileIlaaaLGqDuLODTZJqzHVNbs=;
        b=AlD7eVd5x6ojZWu+CD6GMNQf5G/wwZ+kj/kGRY8jmEJV5Lj2r7Vk3O4swA4HXr88wj
         dzKX7U+As1/qeTaz5UHH2FnByHg+afIoWaRzOgPcHEcZzPMLxH777xtm8NdrryoeAU0N
         NxnXfApZEuPTzaZYgI2J0MSq3kD+ZJSqEWlqI=
Received: by 10.236.77.233 with SMTP id d69mr7390948yhe.84.1321645087999;
        Fri, 18 Nov 2011 11:38:07 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id d5sm2117910yhl.19.2011.11.18.11.38.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Nov 2011 11:38:04 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pAIJc3ul020533;
        Fri, 18 Nov 2011 11:38:03 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pAIJc3CP020532;
        Fri, 18 Nov 2011 11:38:03 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-embedded@vger.kernel.org, x86@kernel.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH RFC 5/5] x86: Select BUILDTIME_EXTABLE_SORT
Date:   Fri, 18 Nov 2011 11:37:48 -0800
Message-Id: <1321645068-20475-6-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1321645068-20475-1-git-send-email-ddaney.cavm@gmail.com>
References: <1321645068-20475-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 31813
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15876

From: David Daney <david.daney@cavium.com>

We can sort the exeception table at build time for x86, so let's do
it.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/x86/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index cb9a104..c6b52a6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -75,6 +75,7 @@ config X86
 	select HAVE_BPF_JIT if (X86_64 && NET)
 	select CLKEVT_I8253
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
+	select BUILDTIME_EXTABLE_SORT
 
 config INSTRUCTION_DECODER
 	def_bool (KPROBES || PERF_EVENTS)
-- 
1.7.2.3
