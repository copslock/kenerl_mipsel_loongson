Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2011 20:38:40 +0100 (CET)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:35504 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904143Ab1KRTiL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Nov 2011 20:38:11 +0100
Received: by ywp31 with SMTP id 31so3437715ywp.36
        for <multiple recipients>; Fri, 18 Nov 2011 11:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=JAZFN0rrR5RwoS38mMQQ6FuAa7XM8IRQfDR5QS02QSQ=;
        b=iYUpo6+72huDT5qtAwpzEjy6py0yce4ARKIV5qiSGt10jFuAjvTXtspt0CRn+QxphX
         UBSyHO7vqBpU8+8MRJ+ZbybwGtbmJM27YxEV0BF5zMMVnKGgaWH7MkPQclSMCbF+FkxI
         OHGIt5RStDWF/UHWv1QMMVvsUqN4wt6uAqRXQ=
Received: by 10.236.195.36 with SMTP id o24mr7454163yhn.57.1321645085022;
        Fri, 18 Nov 2011 11:38:05 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id m29sm2117179yhi.20.2011.11.18.11.38.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Nov 2011 11:38:04 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pAIJc24b020521;
        Fri, 18 Nov 2011 11:38:02 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pAIJc2gG020520;
        Fri, 18 Nov 2011 11:38:02 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-embedded@vger.kernel.org, x86@kernel.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH RFC 2/5] extable: Skip sorting if sorted at build time.
Date:   Fri, 18 Nov 2011 11:37:45 -0800
Message-Id: <1321645068-20475-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1321645068-20475-1-git-send-email-ddaney.cavm@gmail.com>
References: <1321645068-20475-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 31809
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15864

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
