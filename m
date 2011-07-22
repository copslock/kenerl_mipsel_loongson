Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2011 13:10:12 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:35032 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491171Ab1GVLJT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jul 2011 13:09:19 +0200
Received: by mail-fx0-f49.google.com with SMTP id 20so3731881fxd.36
        for <linux-mips@linux-mips.org>; Fri, 22 Jul 2011 04:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=mV1w5liCNery2Q04UeJO8xmcFuOzqbALKWaNoBYXJTI=;
        b=uhD1WMt0gu2sdjbngpqOY0QvLIq14jmRJ+LLwgWWLVwiaD4iHiTELXmWv0tjCGEPAZ
         pQd+14VeRYuJpwuyxVfS8suvHmqdYyiMnMTDVVPJvkGeqjbg52hmVDD0Fblzz3I823Nb
         EFFAri6eC0kwTvSLXn9+Ua/q0TNBKCR53IEb8=
Received: by 10.223.24.17 with SMTP id t17mr1890981fab.143.1311332959651;
        Fri, 22 Jul 2011 04:09:19 -0700 (PDT)
Received: from localhost.localdomain (178-191-13-216.adsl.highway.telekom.at [178.191.13.216])
        by mx.google.com with ESMTPS id 28sm1978093fax.27.2011.07.22.04.09.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Jul 2011 04:09:19 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     alsa-devel@vger.kernel.org
Cc:     Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Liam Girdwood <lrg@ti.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH V3 3/3] ALSA: deprecate MIPS AU1X00 AC97 driver
Date:   Fri, 22 Jul 2011 13:09:08 +0200
Message-Id: <1311332948-29406-4-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1311332948-29406-1-git-send-email-manuel.lauss@googlemail.com>
References: <1311332948-29406-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 30673
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15937

Now that an ASoC variant is available, tell users that this
driver is now living on borrowed time...

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
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
