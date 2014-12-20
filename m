Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Dec 2014 02:15:35 +0100 (CET)
Received: from mail-ig0-f170.google.com ([209.85.213.170]:55710 "EHLO
        mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009080AbaLTBPda921o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Dec 2014 02:15:33 +0100
Received: by mail-ig0-f170.google.com with SMTP id r2so2953050igi.3;
        Fri, 19 Dec 2014 17:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=M970wiYJuzb+iXswHiXjUzKMnfz58arRnXdo5pY8nEs=;
        b=EbD4/ApkX60hQV3wGWdVZFKtUp5z5dfvxibK7+IYhckH9+aIiFQWIev6+mdRmg/Dwz
         nu0EE3auE+SIyW/ks1t8td86fx81gncxxMYCj7HS7QOOMD6utef++opEkch/0hJ8gJSV
         Nn8UfgH7pgIa1MJ0R7UKmnV1ZSi+JwUmxMN7CYaPeGWhtxOoNHZpLddW7wHG3oE7N8K1
         DRhuPYieL0WWwcMKF3ihkKRgXW/si3HWNMiDqiqx32+CM5XTlyK3ymhveXmMVTKY5uaT
         BaWHvYSX9VAQjlTo8eDBXoPtv4wJ6h0SJUBwujDTK1gMVzY7lm58f/Po4q+VJuHOZ6V4
         wWuw==
X-Received: by 10.50.82.66 with SMTP id g2mr6088967igy.19.1419038127719;
        Fri, 19 Dec 2014 17:15:27 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id m127sm5303491ioe.32.2014.12.19.17.15.27
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 19 Dec 2014 17:15:27 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id sBK1FPnT030304;
        Fri, 19 Dec 2014 17:15:25 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id sBK1FP6C030303;
        Fri, 19 Dec 2014 17:15:25 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: [PATCH] MIPS: Fix C0_Pagegrain[IEC] support.
Date:   Fri, 19 Dec 2014 17:15:23 -0800
Message-Id: <1419038123-30270-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44858
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

If we are generating TLB exception expecting separate vectors, we must
enable the feature.

Cc: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: David Daney <david.daney@cavium.com>
---

Very lightly tested, but it seems to make my XI and RI tests work on
OCTEON II CPUs, which have the C0_Pagegrain[IEC] bit.

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
