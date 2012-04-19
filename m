Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Apr 2012 00:00:31 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:36375 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903731Ab2DSWAQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Apr 2012 00:00:16 +0200
Received: by obcni5 with SMTP id ni5so5398640obc.36
        for <multiple recipients>; Thu, 19 Apr 2012 15:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=JAZFN0rrR5RwoS38mMQQ6FuAa7XM8IRQfDR5QS02QSQ=;
        b=xdxrnq97LC4QtQCBEkuFs0hGnj/8VEjhd7Juj7RwY0gxPXzxIGSWDFPfdADYoaqgiG
         OLY2S4gJr52DgZmQiXxJ0cE0G0a25mpG3XgIHEgO7ErLMLVEq561f6Uj4LLAh8ziTmul
         79cd0tNcYujaBrah41FfxHDXJmammF9ZRQEGj9ttjrM6jmXVIeNnaUs+Ah/cGlvbavx9
         b5p5PJh+7BORacNzPdSvqqwZnwoOJUJ0RIwOUzeOm3GwTEv6j8rI6PQzU1qxECOBs99I
         DgB7wUHrMx2hTBLMyH1LR75hXYpRhrLJW/DZMfOoqZ9FRv9BNUoYTfvaO1NrhhSY+ivf
         2Omw==
Received: by 10.182.202.104 with SMTP id kh8mr5658552obc.1.1334872810274;
        Thu, 19 Apr 2012 15:00:10 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id m2sm4226692obk.9.2012.04.19.15.00.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Apr 2012 15:00:09 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q3JM07YW014636;
        Thu, 19 Apr 2012 15:00:07 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q3JM07aw014635;
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
Subject: [PATCH v2 2/5] extable: Skip sorting if sorted at build time.
Date:   Thu, 19 Apr 2012 14:59:56 -0700
Message-Id: <1334872799-14589-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1334872799-14589-1-git-send-email-ddaney.cavm@gmail.com>
References: <1334872799-14589-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 32980
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

If the build program sortextable has already sorted the exception
table, don't sort it again.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 kernel/extable.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/kernel/extable.c b/kernel/extable.c
index 5339705..fe35a63 100644
--- a/kernel/extable.c
+++ b/kernel/extable.c
@@ -35,10 +35,16 @@ DEFINE_MUTEX(text_mutex);
 extern struct exception_table_entry __start___ex_table[];
 extern struct exception_table_entry __stop___ex_table[];
 
+/* Cleared by build time tools if the table is already sorted. */
+u32 __initdata main_extable_sort_needed = 1;
+
 /* Sort the kernel's built-in exception table */
 void __init sort_main_extable(void)
 {
-	sort_extable(__start___ex_table, __stop___ex_table);
+	if (main_extable_sort_needed)
+		sort_extable(__start___ex_table, __stop___ex_table);
+	else
+		pr_notice("__ex_table already sorted, skipping sort\n");
 }
 
 /* Given an address, look for it in the exception tables. */
-- 
1.7.2.3
