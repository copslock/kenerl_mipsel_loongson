Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2011 16:43:14 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:63869 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903837Ab1KPPmn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Nov 2011 16:42:43 +0100
Received: by faar25 with SMTP id r25so2091232faa.36
        for <multiple recipients>; Wed, 16 Nov 2011 07:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=PhmUAt9Akp8sW58o3OHu/t2wNArXpyZo1BTKrLhZGCI=;
        b=kLaG1WpUdwefvfM4Jj02sit0XBMlk6jepSelQKCMIsPwYebQVSuZPc5KdtwiIZy0LX
         rYFFzxpBvl9Wi2e0gCh9xH4GxOKBGV+UGpPqdQst8N/h70l8yra7t1ISQgd7Jdj6Safw
         IZzfScQ0yJW4aSXbRXYruNnuRcjReRDjQH1wE=
Received: by 10.152.132.72 with SMTP id os8mr20781411lab.4.1321458158185;
        Wed, 16 Nov 2011 07:42:38 -0800 (PST)
Received: from flagship.roarinelk.net (188-22-3-28.adsl.highway.telekom.at. [188.22.3.28])
        by mx.google.com with ESMTPS id pi7sm17044221lab.5.2011.11.16.07.42.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Nov 2011 07:42:37 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 2/3] MIPS: Alchemy: update cpu-feature-overrides
Date:   Wed, 16 Nov 2011 16:42:27 +0100
Message-Id: <1321458148-7894-2-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.8.rc1
In-Reply-To: <1321458148-7894-1-git-send-email-manuel.lauss@googlemail.com>
References: <1321458148-7894-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 31675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13529

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 .../asm/mach-au1x00/cpu-feature-overrides.h        |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h b/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h
index d5df0ca..3f741af 100644
--- a/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h
@@ -13,12 +13,14 @@
 #define cpu_has_4k_cache		1
 #define cpu_has_tx39_cache		0
 #define cpu_has_fpu			0
+#define cpu_has_32fpr			0
 #define cpu_has_counter			1
 #define cpu_has_watch			1
 #define cpu_has_divec			1
 #define cpu_has_vce			0
 #define cpu_has_cache_cdex_p		0
 #define cpu_has_cache_cdex_s		0
+#define cpu_has_prefetch		1
 #define cpu_has_mcheck			1
 #define cpu_has_ejtag			1
 #define cpu_has_llsc			1
@@ -29,6 +31,7 @@
 #define cpu_has_vtag_icache		0
 #define cpu_has_dc_aliases		0
 #define cpu_has_ic_fills_f_dc		1
+#define cpu_has_pindexed_dcache		0
 #define cpu_has_mips32r1		1
 #define cpu_has_mips32r2		0
 #define cpu_has_mips64r1		0
-- 
1.7.8.rc1
