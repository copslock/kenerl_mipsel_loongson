Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jul 2011 13:46:19 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:45682 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491022Ab1GYLpB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Jul 2011 13:45:01 +0200
Received: by mail-fx0-f49.google.com with SMTP id 20so6754251fxd.36
        for <linux-mips@linux-mips.org>; Mon, 25 Jul 2011 04:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=tRDP1UosB4DwgEWYkLqmU1kOxeiA63a23ecSFHwB80c=;
        b=quZI/wI6xLoJrGlyF1ONJbBTVUK/Kwbj5xvAenK7b+rA/lJ8RDpFcvkAnpn7++qZy5
         y4GhT8HHwMUGeMUINxruhnodhxTgUWqeZzF+gh0wbeBKqX3CFf4317N5jBbfoV4lmh58
         gp81YQizngQYDxDiFp3PLd92JxLbnT2+W69DQ=
Received: by 10.223.127.195 with SMTP id h3mr6629546fas.135.1311594300953;
        Mon, 25 Jul 2011 04:45:00 -0700 (PDT)
Received: from localhost.localdomain (188-22-157-52.adsl.highway.telekom.at [188.22.157.52])
        by mx.google.com with ESMTPS id n18sm2723648fam.31.2011.07.25.04.44.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Jul 2011 04:45:00 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     alsa-devel@vger.kernel.org,
        Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc:     Liam Girdwood <lrg@ti.com>, Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH V5 3/3] ALSA: deprecate MIPS AU1X00 AC97 driver
Date:   Mon, 25 Jul 2011 13:44:47 +0200
Message-Id: <1311594287-31576-4-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1311594287-31576-1-git-send-email-manuel.lauss@googlemail.com>
References: <1311594287-31576-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 30715
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17610

Now that an ASoC variant is available, tell users that this
driver is now living on borrowed time...

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
V4/V5: no changes.
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
