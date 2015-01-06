Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jan 2015 19:42:37 +0100 (CET)
Received: from mail-ie0-f181.google.com ([209.85.223.181]:56511 "EHLO
        mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026740AbbAFSmfFR3TI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Jan 2015 19:42:35 +0100
Received: by mail-ie0-f181.google.com with SMTP id rl12so4289303iec.12;
        Tue, 06 Jan 2015 10:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=o4kc4tiBQR0odSpPMHKi+cZb9JtPcYgvg7Cb8rbg88I=;
        b=Nd4CnpgFMT1DnRMJ0L5RjWjJ5TvImnyZndkkYb8aVj4WfqpXTUdnIn79tkZOghKSqr
         /aeUSW1no9Tc7sS/3HcQnOI6bn6+iwqy2EvHHGygMeD17PRppBhMzlwbmwpqE2iThi1A
         kdOAN53GV9Oew/2oLXtg9sZ4mAHAkNHmpDgJx6Hn2IeTN7+dFCEYrxptFKTm3uAiOZRU
         K1BLDRCxnHJqyfPO3uCJi5vzvteqc7dLkfdqWojhiYBMA6Adif6KjZLU1AxHm29ST74Q
         AigVWDoHmZGigYeCi5dUYCi63sc+JLLkHxt673dpJ4phoydMsifILDDKnw81L1ZL5eY0
         8zAw==
X-Received: by 10.50.67.18 with SMTP id j18mr17659615igt.26.1420569749000;
        Tue, 06 Jan 2015 10:42:29 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id i8sm5335879igt.2.2015.01.06.10.42.28
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 06 Jan 2015 10:42:28 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id t06IgRr8013138;
        Tue, 6 Jan 2015 10:42:27 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id t06IgP3F013137;
        Tue, 6 Jan 2015 10:42:25 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>, <stable@vger.kernel.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: [PATCH] MIPS: Fix C0_Pagegrain[IEC] support.
Date:   Tue,  6 Jan 2015 10:42:23 -0800
Message-Id: <1420569743-13104-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44979
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

The following commits:

  5890f70f15c52d (MIPS: Use dedicated exception handler if CPU supports RI/XI exceptions)
  6575b1d4173eae (MIPS: kernel: cpu-probe: Detect unique RI/XI exceptions)

break the kernel for *all* existing MIPS CPUs that implement the
CP0_PageGrain[IEC] bit.  They cause the TLB exception handlers to be
generated without the legacy execute-inhibit handling, but never set
the CP0_PageGrain[IEC] bit to activate the use of dedicated exception
vectors for execute-inhibit exceptions.  The result is that upon
detection of an execute-inhibit violation, we loop forever in the TLB
exception handlers instead of sending SIGSEGV to the task.

If we are generating TLB exception handlers expecting separate
vectors, we must also enable the CP0_PageGrain[IEC] feature.

The bug was introduced in kernel version 3.17.

Cc: <stable@vger.kernel.org>
Cc: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: David Daney <david.daney@cavium.com>
---

This is the same patch sent 19/12/2014 with an improved changlog and Cc list.

 arch/mips/mm/tlb-r4k.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index e90b2e8..30639a6 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -489,6 +489,8 @@ static void r4k_tlb_configure(void)
 #ifdef CONFIG_64BIT
 		pg |= PG_ELPA;
 #endif
+		if (cpu_has_rixiex)
+			pg |= PG_IEC;
 		write_c0_pagegrain(pg);
 	}
 
-- 
1.7.11.7
