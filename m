Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2018 21:38:28 +0200 (CEST)
Received: from mail-wr0-x22f.google.com ([IPv6:2a00:1450:400c:c0c::22f]:43052
        "EHLO mail-wr0-x22f.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994720AbeFFTiW0MVg5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Jun 2018 21:38:22 +0200
Received: by mail-wr0-x22f.google.com with SMTP id d2-v6so7487478wrm.10;
        Wed, 06 Jun 2018 12:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=Z1ZeCDzzHPpIAtG+J58n8zm1/TreNJEVzd+QikzxCg4=;
        b=svOePnVOQSFIipDP3xsYwkV9Fc7u5l/WJSOXrR1XKKppB6b/dkI8SbMOXgKLtSa9og
         7OWHug449yQxhAMvklScx84kNP2uKFcxpg1af0idaSmmUIuE8cXTvnr3/dzx/u9w1F0Z
         6VVff6jvqzxSC7p1MhY3yY604LPN68CZIspMUYcyD0iaP+mxCvjMdxQvufUF30wN41Ol
         YwqvbOU2Fg3YOAX9hXUEJj/nF3ZIX+cnb0+AludRhHlPN7CCJOLxKdA5tJtZCb8QDD7g
         Ok45crvAYzUpcKETFVOnthZ1snEingD5vla8EaHJLTwtcyWIr9izUdMfrMsSXPDabDMv
         2K8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=Z1ZeCDzzHPpIAtG+J58n8zm1/TreNJEVzd+QikzxCg4=;
        b=jIC7eEqALjkAJy4xnLzszKeYh4I8LPYWoLHaruX+6trQJUL/TZr9NMywiCgF+82Krp
         s/CU/Zab8qjWzXqIPeQO8RLkTxtSGDW6DQNJ/RrGYibDFjmV5eo1XmYZpwk+rjyAgSGx
         UxIAN+whgF8Y2DdrDc7yt9azRlxzZZfRMKhFRHL7gGWScJMZIblCt6QkWj93sMYncIN2
         zPvIRVPR2rr5Qi4mMp+aE8K7/KzMdYdGYeSbT2JCNuYg7h5/059UOLu4ZdOq6AYhottO
         x2fFpACy6+e1KIGm7gjJs/LJKj/vhqowfG/HJO/EELdrUwBx/8+1+NKlxfaFfTTqzU+x
         iKLg==
X-Gm-Message-State: APt69E2J0U1B7YDYpWVRUoi7NBpaEJAfI/MJivAQtEDHhJME2FlFgJUL
        /Oe0gNgHIlOiUde725SGkpA+ZYan
X-Google-Smtp-Source: ADUXVKIdPYjME0V4hu0RwCEQFDNdhtD9DGuNFFDwfqZzQUHu00pkFUhD6Qsa10w0AhvdPfsdWpkViQ==
X-Received: by 2002:adf:8e30:: with SMTP id n45-v6mr3208621wrb.27.1528313897095;
        Wed, 06 Jun 2018 12:38:17 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-226-121.fbx.proxad.net. [78.225.226.121])
        by smtp.gmail.com with ESMTPSA id o13-v6sm4060590wmc.33.2018.06.06.12.38.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 12:38:16 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 9519F10C2B80; Wed,  6 Jun 2018 21:38:15 +0200 (CEST)
From:   Mathieu Malaterre <malat@debian.org>
To:     James Hogan <jhogan@kernel.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: [PATCH 1/3] MIPS: jz4780: Allow access to jz4740-i2s
Date:   Wed,  6 Jun 2018 21:38:08 +0200
Message-Id: <20180606193811.16007-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64200
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

Make it possible to select SND_JZ4740_SOC_I2S on MACH_JZ4780

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 sound/soc/jz4740/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/jz4740/Kconfig b/sound/soc/jz4740/Kconfig
index 1a354a6b6e87..35d82d96e781 100644
--- a/sound/soc/jz4740/Kconfig
+++ b/sound/soc/jz4740/Kconfig
@@ -1,20 +1,20 @@
 config SND_JZ4740_SOC
-	tristate "SoC Audio for Ingenic JZ4740 SoC"
-	depends on MACH_JZ4740 || COMPILE_TEST
+	tristate "SoC Audio for Ingenic JZ4740/JZ4780 SoC"
+	depends on MACH_JZ4740 || MACH_JZ4780 || COMPILE_TEST
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Say Y or M if you want to add support for codecs attached to
-	  the JZ4740 I2S interface. You will also need to select the audio
+	  the JZ4740/JZ4780 I2S interface. You will also need to select the audio
 	  interfaces to support below.
 
 if SND_JZ4740_SOC
 
 config SND_JZ4740_SOC_I2S
-	tristate "SoC Audio (I2S protocol) for Ingenic JZ4740 SoC"
+	tristate "SoC Audio (I2S protocol) for Ingenic JZ4740/JZ4780 SoC"
 	depends on HAS_IOMEM
 	help
 	  Say Y if you want to use I2S protocol and I2S codec on Ingenic JZ4740
-	  based boards.
+	  or JZ4780 based boards.
 
 config SND_JZ4740_SOC_QI_LB60
 	tristate "SoC Audio support for Qi LB60"
-- 
2.11.0
