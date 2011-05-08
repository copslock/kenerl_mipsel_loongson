Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 May 2011 10:43:26 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:36067 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491004Ab1EHImd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 8 May 2011 10:42:33 +0200
Received: by wyb28 with SMTP id 28so4138955wyb.36
        for <linux-mips@linux-mips.org>; Sun, 08 May 2011 01:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=J4RKxbs9181p595Cd4T/UEI8Iim0Rs4bzKCl7bY0Dg8=;
        b=ICRet7yKvanqqGRL9COADppiHXdrcqhiYwFbvus9l9AM7u5ZTmuOaK3h3Yj05GJZ1w
         ReT1tUz06wJdUau16vwr7YuhKqPCx7Zc/zKQQiXENBQzVuSAqqcOnzxesLJ7bOuxhzor
         kEEcWZN5p78jwhYQZBEHqmHNIl+IdPis2Xb/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZSDIkOnU4GQPSaB/v1qygLqSE88vp5JwEYNc+n7DtvVEyfpRhR+m4NefylUaOguE9m
         GMnFKO5aJ+Ds6OVAzPRBGjE1ywpd3p8ZJPBaeU5/sL/MyzXEmUtyz/lCAjrBJrjrPSdk
         KGbugF4OFOpPSvjaU2Rhl+V1bHmvfXTWZBJhU=
Received: by 10.227.100.219 with SMTP id z27mr3205318wbn.45.1304844146683;
        Sun, 08 May 2011 01:42:26 -0700 (PDT)
Received: from localhost.localdomain (178-191-5-255.adsl.highway.telekom.at [178.191.5.255])
        by mx.google.com with ESMTPS id z9sm3022884wbx.34.2011.05.08.01.42.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 08 May 2011 01:42:26 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Florian Fainelli <florian@openwrt.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 1/9] MIPS: DB1200: Set Config[OD] for improved stability.
Date:   Sun,  8 May 2011 10:42:12 +0200
Message-Id: <1304844140-3259-2-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.5.rc3
In-Reply-To: <1304844140-3259-1-git-send-email-manuel.lauss@googlemail.com>
References: <1304844140-3259-1-git-send-email-manuel.lauss@googlemail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29868
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
Resend of a patch I submitted earlier.
V2: fix up issues pointed out by Sergei Shtylyov.

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
index 4a89800..1dac4f2 100644
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
1.7.5.rc3
