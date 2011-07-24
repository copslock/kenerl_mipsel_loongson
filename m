Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Jul 2011 12:13:32 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:63270 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491760Ab1GXKMH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 Jul 2011 12:12:07 +0200
Received: by fxd20 with SMTP id 20so5693854fxd.36
        for <multiple recipients>; Sun, 24 Jul 2011 03:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ljHgsOvMzLCyRM5BJSXkNTHMCWYea+kvee1kE3jKxro=;
        b=FWl65tNPsLJUm1Vz90Q596Pvlt+vEcvzmCfpt/NnAwH53xGUy2EK8nICeyWLJxB7cl
         sMRUtIOXF+uvpSgY/Sn7uPEMyi7a98VGDjjmGKaO/Nj0mEizB6W6dHTAj2KLlBIZKINX
         aSslq97uk+SSzoG8C8rX1F3UCbroM1uPQjT9c=
Received: by 10.223.91.75 with SMTP id l11mr4942119fam.66.1311502321710;
        Sun, 24 Jul 2011 03:12:01 -0700 (PDT)
Received: from localhost.localdomain (178-191-7-51.adsl.highway.telekom.at [178.191.7.51])
        by mx.google.com with ESMTPS id f7sm2358798faa.8.2011.07.24.03.12.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 24 Jul 2011 03:12:01 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     alsa-devel@vger.kernel.org,
        Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc:     Liam Girdwood <lrg@ti.com>, Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH V4 3/3] ALSA: deprecate MIPS AU1X00 AC97 driver
Date:   Sun, 24 Jul 2011 12:11:51 +0200
Message-Id: <1311502311-16916-4-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1311502311-16916-1-git-send-email-manuel.lauss@googlemail.com>
References: <1311502311-16916-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 30702
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17086

Now that an ASoC variant is available, tell users that this
driver is now living on borrowed time...

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
V4: no changes.
V3: mark driver DEPRECATED instead of removing it outright.

 sound/mips/Kconfig |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/sound/mips/Kconfig b/sound/mips/Kconfig
index a9823fa..77dd0a1 100644
--- a/sound/mips/Kconfig
+++ b/sound/mips/Kconfig
@@ -23,12 +23,15 @@ config SND_SGI_HAL2
 
 
 config SND_AU1X00
-	tristate "Au1x00 AC97 Port Driver"
+	tristate "Au1x00 AC97 Port Driver (DEPRECATED)"
 	depends on SOC_AU1000 || SOC_AU1100 || SOC_AU1500
 	select SND_PCM
 	select SND_AC97_CODEC
 	help
 	  ALSA Sound driver for the Au1x00's AC97 port.
 
+	  Newer drivers for ASoC are available, please do not use
+	  this driver as it will be removed in the future.
+
 endif	# SND_MIPS
 
-- 
1.7.6
