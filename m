Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Feb 2011 10:02:59 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:61072 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491041Ab1BKJC4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Feb 2011 10:02:56 +0100
Received: by bwz5 with SMTP id 5so2812469bwz.36
        for <linux-mips@linux-mips.org>; Fri, 11 Feb 2011 01:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=dxnb/N0tDC5L3m2KQ2yzHHZAuHWyLbZO4cbJzaQJZmc=;
        b=Y0V97I+tM7K/+dOLJR5i5avIlz40DXXcQmHFcZS9pOUsgtW66cuhqX3NYFpH24JMOq
         oFn+ZPSpuEqRsTiBCKZTkdDBse1xLojnwyw0wJLMSuX+pqo8RJX03j5i8STc3zWE/ZIt
         tj02SJvZqZUm+8ZqBoqR062cNq/r9KqYDM/nM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Gzbq+uxVsi/aRTDNrK9eLlMsWiqYzCqWDvBawkV2SbKyIxajmVTGDIRXKFYlBSGiQM
         4VcfY5Ed6cYD1rZP5GbCNIQaae9HPiUevtkaAV4kZZ3+9iUD8r9BTq9dYLIzZCBBAEIm
         drgDAd06CLZQNkPdh4RYCGHGWBLrxkYf7juh0=
Received: by 10.204.98.75 with SMTP id p11mr213076bkn.12.1297414971258;
        Fri, 11 Feb 2011 01:02:51 -0800 (PST)
Received: from localhost.localdomain (188-22-147-70.adsl.highway.telekom.at [188.22.147.70])
        by mx.google.com with ESMTPS id u23sm295835bkw.21.2011.02.11.01.02.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 Feb 2011 01:02:50 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH V2] MIPS/DB1200: Set Config[OD] for improved stability.
Date:   Fri, 11 Feb 2011 10:02:46 +0100
Message-Id: <1297414966-3805-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.4
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29161
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Setting Config[OD] gets rid of a _LOT_ of spurious CPLD interrupts,
but also decreases overall performance a bit.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
v2: improvements and fixes, thanks to Sergei Shtylyov.

 arch/mips/alchemy/common/setup.c           |    4 ++--
 arch/mips/alchemy/devboards/db1200/setup.c |    7 +++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/mips/alchemy/common/setup.c b/arch/mips/alchemy/common/setup.c
index 561e5da..1b887c8 100644
--- a/arch/mips/alchemy/common/setup.c
+++ b/arch/mips/alchemy/common/setup.c
@@ -52,8 +52,6 @@ void __init plat_mem_setup(void)
 	/* this is faster than wasting cycles trying to approximate it */
 	preset_lpj = (est_freq >> 1) / HZ;
 
-	board_setup();  /* board specific setup */
-
 	if (au1xxx_cpu_needs_config_od())
 		/* Various early Au1xx0 errata corrected by this */
 		set_c0_config(1 << 19); /* Set Config[OD] */
@@ -61,6 +59,8 @@ void __init plat_mem_setup(void)
 		/* Clear to obtain best system bus performance */
 		clear_c0_config(1 << 19); /* Clear Config[OD] */
 
+	board_setup();  /* board specific setup */
+
 	/* IO/MEM resources. */
 	set_io_port_base(0);
 	ioport_resource.start = IOPORT_RESOURCE_START;
diff --git a/arch/mips/alchemy/devboards/db1200/setup.c b/arch/mips/alchemy/devboards/db1200/setup.c
index 8876195..be788c8 100644
--- a/arch/mips/alchemy/devboards/db1200/setup.c
+++ b/arch/mips/alchemy/devboards/db1200/setup.c
@@ -23,6 +23,13 @@ void __init board_setup(void)
 	unsigned long freq0, clksrc, div, pfc;
 	unsigned short whoami;
 
+	/* Set Config[OD] (disable overlapping bus transaction):
+	 * This gets rid of a _lot_ of spurious interrupts (especially
+	 * wrt. IDE); but incurs ~10% performance hit in some
+	 * cpu-bound applications.
+	 */
+	set_c0_config(1 << 19);
+
 	bcsr_init(DB1200_BCSR_PHYS_ADDR,
 		  DB1200_BCSR_PHYS_ADDR + DB1200_BCSR_HEXLED_OFS);
 
-- 
1.7.4
