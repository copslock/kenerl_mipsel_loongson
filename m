Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Oct 2011 07:20:07 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:62884 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491092Ab1JAFT7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 1 Oct 2011 07:19:59 +0200
Received: by wyi11 with SMTP id 11so2218072wyi.36
        for <multiple recipients>; Fri, 30 Sep 2011 22:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=AmsZ2EystNIMyZwzo+LyfxyMI267J/UFIUOO7vctxNc=;
        b=TMlhiSJR2e2+F1ypyBthUqPgtX/ari1Md17DFO99I2oI8Hw3NAlj7Nv7jtMsxXu3kD
         EiaWeQIqodFD2u/oudufsoF6WGEj7mBu/Ux8Mk+wkCMDPZ7ZRlDpxrEuwazl/c2nO0GO
         MlptfS+TNs9rYWOZ+ouHpoChUPQ2jwB3oRNkI=
MIME-Version: 1.0
Received: by 10.216.138.138 with SMTP id a10mr14962418wej.58.1317446393853;
 Fri, 30 Sep 2011 22:19:53 -0700 (PDT)
Received: by 10.216.73.193 with HTTP; Fri, 30 Sep 2011 22:19:53 -0700 (PDT)
Date:   Sat, 1 Oct 2011 13:19:53 +0800
Message-ID: <CAJd=RBDQ9eyfgWkgsdUrojteqbnribZyk0QATr3CgPXLbBDkPQ@mail.gmail.com>
Subject: [RFC] count TLB refill for Netlogic XLR chip
From:   Hillf Danton <dhillf@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     "Jayachandran C." <jayachandranc@netlogicmicro.com>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
X-archive-position: 31192
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhillf@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 111

TLB miss is one of the concerned factors when tuning the performance of user
applications, and there are on netlogic XLR chip eight 64-bit registers,
c0 register 22 select 0-7, which could be used as temporary storage.

One of them is used for counting TLB refill, and any comment is appreciated.

Thanks

Signed-off-by: Hillf Danton <dhillf@gmail.com>
---

--- a/arch/mips/mm/tlbex.c	Sat Aug 13 11:44:39 2011
+++ b/arch/mips/mm/tlbex.c	Sat Oct  1 12:41:07 2011
@@ -1239,6 +1239,11 @@ static void __cpuinit build_r4000_tlb_re
 	memset(relocs, 0, sizeof(relocs));
 	memset(final_handler, 0, sizeof(final_handler));

+	if (current_cpu_type() == CPU_XLR) {
+		UASM_i_MFC0(p, K0, 22, 0);
+		UASM_i_ADDIU(p, K0, K0, 1);
+		UASM_i_MTC0(p, K0, 22, 0);
+	}
 	if ((scratch_reg > 0 || scratchpad_available()) && use_bbit_insns()) {
 		htlb_info = build_fast_tlb_refill_handler(&p, &l, &r, K0, K1,
 							  scratch_reg);
--- a/arch/mips/lib/dump_tlb.c	Sat May 14 15:21:02 2011
+++ b/arch/mips/lib/dump_tlb.c	Sat Oct  1 12:46:19 2011
@@ -99,6 +99,10 @@ static void dump_tlb(int first, int last
 			       (entrylo1 & 1) ? 1 : 0);
 		}
 	}
+	if (current_cpu_type() == CPU_XLR) {
+		entrylo0 = __read_64bit_c0_register($22, 0);
+		printk("TLB refill count %llu\n", entrylo0);
+	}
 	printk("\n");

 	write_c0_entryhi(s_entryhi);
