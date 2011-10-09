Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Oct 2011 14:54:09 +0200 (CEST)
Received: from mail-ww0-f41.google.com ([74.125.82.41]:38957 "EHLO
        mail-ww0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491014Ab1JIMyC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 9 Oct 2011 14:54:02 +0200
Received: by wwf10 with SMTP id 10so2676922wwf.0
        for <multiple recipients>; Sun, 09 Oct 2011 05:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=GmbfinFG3O5ZGHcYzjyE1iEYGbOVdh2Vrs5sqV/KF6k=;
        b=DcLnqZ2iuypdhaMVhMsX93cjeXBTI+rNT9Rkb0/RioT0cDFXrednbGP9mpn1Z/YfJ+
         r6U+wO4w7QAMNy9e1EUM/PSPrZTLLAUdiYiJtRGyvn+knmjhnouH9k3i5pu/wEPcVBLK
         lZbgTvO8uqbOFRn88JoKNh2BCrAin9RT+JrLU=
MIME-Version: 1.0
Received: by 10.216.185.5 with SMTP id t5mr3189629wem.28.1318164837197; Sun,
 09 Oct 2011 05:53:57 -0700 (PDT)
Received: by 10.216.73.193 with HTTP; Sun, 9 Oct 2011 05:53:57 -0700 (PDT)
Date:   Sun, 9 Oct 2011 20:53:57 +0800
Message-ID: <CAJd=RBBPd6frOA5zCg5juHuWdZ6wHzmOhhufgGhUCOc=rkNEzA@mail.gmail.com>
Subject: [RFC] Flush huge TLB
From:   Hillf Danton <dhillf@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Jayachandran C." <jayachandranc@netlogicmicro.com>
Content-Type: text/plain; charset=UTF-8
X-archive-position: 31214
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhillf@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 5645

When flushing TLB, if @vma is backed by huge page, huge TLB should be flushed,
due to the fact that huge page is defined to be far from normal page, and the
flushing is shorten a bit.

Any comment is welcome.

Thanks

Signed-off-by: Hillf Danton <dhillf@gmail.com>
---

--- a/arch/mips/mm/tlb-r4k.c	Mon May 30 21:17:04 2011
+++ b/arch/mips/mm/tlb-r4k.c	Sun Oct  9 20:50:06 2011
@@ -120,22 +120,35 @@ void local_flush_tlb_range(struct vm_are

 	if (cpu_context(cpu, mm) != 0) {
 		unsigned long size, flags;
+		int huge = is_vm_hugetlb_page(vma);

 		ENTER_CRITICAL(flags);
-		size = (end - start + (PAGE_SIZE - 1)) >> PAGE_SHIFT;
-		size = (size + 1) >> 1;
+		if (huge) {
+			size = (end - start) / HPAGE_SIZE;
+		} else {
+			size = (end - start + (PAGE_SIZE - 1)) >> PAGE_SHIFT;
+			size = (size + 1) >> 1;
+		}
 		if (size <= current_cpu_data.tlbsize/2) {
 			int oldpid = read_c0_entryhi();
 			int newpid = cpu_asid(cpu, mm);

-			start &= (PAGE_MASK << 1);
-			end += ((PAGE_SIZE << 1) - 1);
-			end &= (PAGE_MASK << 1);
+			if (huge) {
+				start &= HPAGE_MASK;
+				end &= HPAGE_MASK;
+			} else {
+				start &= (PAGE_MASK << 1);
+				end += ((PAGE_SIZE << 1) - 1);
+				end &= (PAGE_MASK << 1);
+			}
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
