Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 May 2013 00:27:38 +0200 (CEST)
Received: from mail-pb0-f51.google.com ([209.85.160.51]:53929 "EHLO
        mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6820514Ab3EVW1eT7DNA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 May 2013 00:27:34 +0200
Received: by mail-pb0-f51.google.com with SMTP id jt11so2195050pbb.10
        for <multiple recipients>; Wed, 22 May 2013 15:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=oAK9NaQUM2uZpMfHZegBrUkFdqfal5KRaCNJHcDvoZo=;
        b=WzZoYhlWJ3p0Nc6CoDjRX5Z54F5AMcz0FPF2hQWLAKxLL5gQP5fOg9AOG1vHzEhFAl
         6zGcy5ihs7C7sK8mr1apSlyHKDQSPOIDj3lz6Eya3MRKaxINMOr1DgxCDCs9s1yAQfsC
         CSvDKetjCK2bijc76VSBcsnBZ8f/vnwKrGXsIP8KfhBomDvnd2Mn4Lndy8s05XdLGaQ7
         MJbJA56bW3ySx1kAN37PF7A6ISD/MA6OLlg5fCTwhEIUWcMT4Rfn/V09JuVnR31Nmlsm
         YyUYm6p1HTepZ6si9kmMABjx69vn7kbkS9Ls4QnMaQln//j09ejl1y+3r64pzVTSKQ1A
         9ZDA==
X-Received: by 10.68.114.100 with SMTP id jf4mr9788165pbb.144.1369261647602;
        Wed, 22 May 2013 15:27:27 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id kr16sm9728276pab.23.2013.05.22.15.27.26
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 22 May 2013 15:27:26 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r4MMROVi000971;
        Wed, 22 May 2013 15:27:24 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r4MMROWF000970;
        Wed, 22 May 2013 15:27:24 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: Remove duplicate definition of check_for_high_segbits.
Date:   Wed, 22 May 2013 15:27:22 -0700
Message-Id: <1369261642-937-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36543
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

From: David Daney <david.daney@cavium.com>

In C, one definition is sufficient.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/mm/tlbex.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 3028674..5d82513 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -303,10 +303,6 @@ static u32 tlb_handler[128] __cpuinitdata;
 static struct uasm_label labels[128] __cpuinitdata;
 static struct uasm_reloc relocs[128] __cpuinitdata;
 
-#ifdef CONFIG_64BIT
-static int check_for_high_segbits __cpuinitdata;
-#endif
-
 static int check_for_high_segbits __cpuinitdata;
 
 static unsigned int kscratch_used_mask __cpuinitdata;
-- 
1.7.11.7
