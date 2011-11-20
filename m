Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Nov 2011 03:56:39 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:61260 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903563Ab1KTC4b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 20 Nov 2011 03:56:31 +0100
Received: by iapp10 with SMTP id p10so7309075iap.36
        for <linux-mips@linux-mips.org>; Sat, 19 Nov 2011 18:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=date:from:x-x-sender:to:cc:subject:message-id:user-agent
         :mime-version:content-type;
        bh=tw7vXZJo7r8Tuw6EBHcj8wEN9jBscEw4gf40JC5deDU=;
        b=VANFMGbcp0Jm6UdL2DqmODL7healkZfDB9uUKNcC9MBKoHrtbS5jf1zWMBrR7Kii4l
         Cph52s8viu8uJfBc4OxQ==
Received: by 10.43.131.196 with SMTP id hr4mr8196844icc.55.1321757785120;
        Sat, 19 Nov 2011 18:56:25 -0800 (PST)
Received: by 10.43.131.196 with SMTP id hr4mr8196829icc.55.1321757784898;
        Sat, 19 Nov 2011 18:56:24 -0800 (PST)
Received: from [2620:0:1008:1201:be30:5bff:fed8:5e64] ([2620:0:1008:1201:be30:5bff:fed8:5e64])
        by mx.google.com with ESMTPS id mb4sm14351921igc.1.2011.11.19.18.56.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Nov 2011 18:56:24 -0800 (PST)
Date:   Sat, 19 Nov 2011 18:56:22 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Hillf Danton <dhillf@gmail.com>, linux-mips@linux-mips.org
Subject: [patch] mips, mm: avoid using HPAGE constants without
 CONFIG_HUGETLB_PAGE
Message-ID: <alpine.DEB.2.00.1111191855410.5457@chino.kir.corp.google.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 31817
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rientjes@google.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16586

HPAGE_{MASK,SHIFT,SIZE} are only defined with CONFIG_HUGETLB_PAGE, so
make sure to never use them unless that option is enabled.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 arch/mips/mm/tlb-r4k.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -124,9 +124,11 @@ void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 
 		ENTER_CRITICAL(flags);
 		if (huge) {
+#ifdef CONFIG_HUGETLB_PAGE
 			start = round_down(start, HPAGE_SIZE);
 			end = round_up(end, HPAGE_SIZE);
 			size = (end - start) >> HPAGE_SHIFT;
+#endif
 		} else {
 			start = round_down(start, PAGE_SIZE << 1);
 			end = round_up(end, PAGE_SIZE << 1);
@@ -135,15 +137,16 @@ void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		if (size <= current_cpu_data.tlbsize/2) {
 			int oldpid = read_c0_entryhi();
 			int newpid = cpu_asid(cpu, mm);
+			unsigned long incr = PAGE_SIZE << 1;
 
-			while (start < end) {
+#ifdef CONFIG_HUGETLB_PAGE
+			if (huge)
+				incr = HPAGE_SIZE;
+#endif
+			for (; start < end; start += incr) {
 				int idx;
 
 				write_c0_entryhi(start | newpid);
-				if (huge)
-					start += HPAGE_SIZE;
-				else
-					start += (PAGE_SIZE << 1);
 				mtc0_tlbw_hazard();
 				tlb_probe();
 				tlb_probe_hazard();
