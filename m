Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Aug 2011 19:57:16 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:33355 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491763Ab1HBRvk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Aug 2011 19:51:40 +0200
Received: by mail-fx0-f49.google.com with SMTP id 20so73189fxd.36
        for <multiple recipients>; Tue, 02 Aug 2011 10:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=DWKOjKoXcf9KMJQZKrK3XLoUrhELA0ijU6/uzQk01zo=;
        b=TeriulgoFq4wHmp0tzqDbjYES4y0PZURGmVLen7eYtKBCCrQuNZCheWMC1wx6sZNBy
         ZPeBWMFzNIy5CxlDrySXkbIESAOwnTBlPNVY2+I8i3EL8XSjeRujwfW5np7FOWsRvZQm
         5LlLy+WiL5Z6at88rm+7AqqiIdi3deGc2AVpM=
Received: by 10.223.20.143 with SMTP id f15mr8610697fab.49.1312307500282;
        Tue, 02 Aug 2011 10:51:40 -0700 (PDT)
Received: from localhost.localdomain (188-22-5-211.adsl.highway.telekom.at [188.22.5.211])
        by mx.google.com with ESMTPS id r12sm3608450fam.24.2011.08.02.10.51.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Aug 2011 10:51:39 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 13/15] MIPS: remove __init from add_wired_entry()
Date:   Tue,  2 Aug 2011 19:51:08 +0200
Message-Id: <1312307470-6841-14-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1312307470-6841-1-git-send-email-manuel.lauss@googlemail.com>
References: <1312307470-6841-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 30809
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1624

For Alchemy-PCI I need to add a wired entry after resuming from RAM;
remove the __init from add_wired_entry() so that this actually works.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/mm/tlb-r3k.c |    4 ++--
 arch/mips/mm/tlb-r4k.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/mm/tlb-r3k.c b/arch/mips/mm/tlb-r3k.c
index 40424af..87bb85d 100644
--- a/arch/mips/mm/tlb-r3k.c
+++ b/arch/mips/mm/tlb-r3k.c
@@ -223,8 +223,8 @@ void __update_tlb(struct vm_area_struct *vma, unsigned long address, pte_t pte)
 	local_irq_restore(flags);
 }
 
-void __init add_wired_entry(unsigned long entrylo0, unsigned long entrylo1,
-			    unsigned long entryhi, unsigned long pagemask)
+void add_wired_entry(unsigned long entrylo0, unsigned long entrylo1,
+		     unsigned long entryhi, unsigned long pagemask)
 {
 	unsigned long flags;
 	unsigned long old_ctx;
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index ba40325..0d394e0 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -337,8 +337,8 @@ void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
 	EXIT_CRITICAL(flags);
 }
 
-void __init add_wired_entry(unsigned long entrylo0, unsigned long entrylo1,
-	unsigned long entryhi, unsigned long pagemask)
+void add_wired_entry(unsigned long entrylo0, unsigned long entrylo1,
+		     unsigned long entryhi, unsigned long pagemask)
 {
 	unsigned long flags;
 	unsigned long wired;
-- 
1.7.6
