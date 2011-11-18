Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2011 14:15:48 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:35576 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904109Ab1KRNPo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Nov 2011 14:15:44 +0100
Received: by faar25 with SMTP id r25so5349220faa.36
        for <multiple recipients>; Fri, 18 Nov 2011 05:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=cZSG+II3Z6BdgX+D2BXaNMeow5ENSxC+AuqphyxSOvw=;
        b=ITDbub+/b13hN12DjcTJCZ/PAC1VTB4xpsgvTfKGAVKn/Yu5IsScrPvPcHyR3XRQzH
         I27vilViivr6RNcEXxS2I5BhIE/rEU5q8LIE5lriaJzzETIiUe29D4TCMKOYEicMzTi/
         5cdekuI84JzccsU2Zn3/AlUXXlo+uyZD5YYpQ=
MIME-Version: 1.0
Received: by 10.181.13.5 with SMTP id eu5mr3045089wid.55.1321622139293; Fri,
 18 Nov 2011 05:15:39 -0800 (PST)
Received: by 10.216.45.11 with HTTP; Fri, 18 Nov 2011 05:15:39 -0800 (PST)
Date:   Fri, 18 Nov 2011 21:15:39 +0800
Message-ID: <CAJd=RBBTx8zWrFfVQGMK=aj=iPO_+i6nvqkhGDfYp_9=d1hyEw@mail.gmail.com>
Subject: [PATCH] MIPS: Flush huge TLB
From:   Hillf Danton <dhillf@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <david.daney@cavium.com>,
        "Jayachandran C." <jayachandranc@netlogicmicro.com>,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 31786
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhillf@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15413

When flushing TLB, if @vma is backed by huge page, we could flush huge TLB,
due to that huge page is defined to be far from normal page.

Signed-off-by: Hillf Danton <dhillf@gmail.com>
---

--- a/arch/mips/mm/tlb-r4k.c	Mon May 30 21:17:04 2011
+++ b/arch/mips/mm/tlb-r4k.c	Fri Nov 18 21:13:13 2011
@@ -120,22 +120,30 @@ void local_flush_tlb_range(struct vm_are

 	if (cpu_context(cpu, mm) != 0) {
 		unsigned long size, flags;
+		int huge = is_vm_hugetlb_page(vma);

 		ENTER_CRITICAL(flags);
-		size = (end - start + (PAGE_SIZE - 1)) >> PAGE_SHIFT;
-		size = (size + 1) >> 1;
+		if (huge) {
+			start = round_down(start, HPAGE_SIZE);
+			end = round_up(end, HPAGE_SIZE);
+			size = (end - start) >> HPAGE_SHIFT;
+		} else {
+			start = round_down(start, PAGE_SIZE << 1);
+			end = round_up(end, PAGE_SIZE << 1);
+			size = (end - start) >> (PAGE_SHIFT + 1);
+		}
 		if (size <= current_cpu_data.tlbsize/2) {
 			int oldpid = read_c0_entryhi();
 			int newpid = cpu_asid(cpu, mm);

-			start &= (PAGE_MASK << 1);
-			end += ((PAGE_SIZE << 1) - 1);
-			end &= (PAGE_MASK << 1);
 			while (start < end) {
 				int idx;

 				write_c0_entryhi(start | newpid);
-				start += (PAGE_SIZE << 1);
+				if (huge)
+					start += HPAGE_SIZE;
+				else
+					start += (PAGE_SIZE << 1);
 				mtc0_tlbw_hazard();
 				tlb_probe();
 				tlb_probe_hazard();
