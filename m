Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2011 12:56:20 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:52544 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903688Ab1KJL4N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Nov 2011 12:56:13 +0100
Received: by faaq17 with SMTP id q17so3530341faa.36
        for <multiple recipients>; Thu, 10 Nov 2011 03:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=FUo4McqarYLNqIax70Y+DjVhoVhKsIdFuL/T0vo39JM=;
        b=NjKrU/q0arY5ATRvSWmXX2oPeN/tcnX//QEh47y74fH8AC62bcKMqhThDOskelT66h
         EIDGCDEZ/mWuGnjyJ3aVumnbtKF4DwbpDO1VeeIHFDyhQY4BqRB8TrAiXGMRvHW3Xm0r
         GXMHpaTRdtLukJhWAZFtoH1IMsMAFTmyaZkYo=
Received: by 10.152.0.130 with SMTP id 2mr4374785lae.0.1320926168635;
        Thu, 10 Nov 2011 03:56:08 -0800 (PST)
Received: from flagship.roarinelk.net (188-22-148-122.adsl.highway.telekom.at. [188.22.148.122])
        by mx.google.com with ESMTPS id ps2sm7081959lab.12.2011.11.10.03.56.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Nov 2011 03:56:07 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH mips-next] MIPS: Alchemy: DB1200 audio support depends on MIPS arch
Date:   Thu, 10 Nov 2011 12:56:03 +0100
Message-Id: <1320926163-27311-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.7.2
X-archive-position: 31497
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9243

Fix the x86-allmodconfig build failure reported by Stephen Rothwell.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
Please fold into patch "[PATCH 05/18] MIPS: Alchemy: DB1300 support"; it applies
in top of it.  The next patch in the series will then throw a reject in this
file because of the change.

 sound/soc/au1x/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/au1x/Kconfig b/sound/soc/au1x/Kconfig
index 5981ecc..78b6649 100644
--- a/sound/soc/au1x/Kconfig
+++ b/sound/soc/au1x/Kconfig
@@ -52,7 +52,7 @@ config SND_SOC_DB1000
 
 config SND_SOC_DB1200
 	tristate "DB1200/DB1300 Audio support"
-	select SND_SOC_AU1XPSC
+	depends on SND_SOC_AU1XPSC
 	select SND_SOC_AU1XPSC_AC97
 	select SND_SOC_AC97_CODEC
 	select SND_SOC_WM9712
-- 
1.7.7.2
