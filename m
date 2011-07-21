Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jul 2011 18:34:26 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:44461 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491141Ab1GUQeU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Jul 2011 18:34:20 +0200
Received: by fxd20 with SMTP id 20so2711731fxd.36
        for <multiple recipients>; Thu, 21 Jul 2011 09:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ckQSLqNQcXhGbA07ONgK71iCDeymrFLXaWCxtEkyBF4=;
        b=Cni00reMDPWoKaIavYrsIdM4KgLEBeGYLpo0jlzm32IXsEylCeGn5WOzA9bdrghpe7
         579qwDfJsgT9EhRHYkukiLJQXld06lT1P+NJFT0XgmLgvoz0VDhRRLvV1GIMpwVdCz7V
         4Y0m80451L8KrGft4T9EnDE22hmTyyQWHsUzw=
Received: by 10.223.160.144 with SMTP id n16mr533406fax.88.1311266055001;
        Thu, 21 Jul 2011 09:34:15 -0700 (PDT)
Received: from localhost.localdomain (188-22-154-193.adsl.highway.telekom.at [188.22.154.193])
        by mx.google.com with ESMTPS id j19sm1490495faa.41.2011.07.21.09.34.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Jul 2011 09:34:13 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     alsa-devel@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH V2 0/2] ALSA: ASoC for Au1000/1500/1100
Date:   Thu, 21 Jul 2011 18:34:08 +0200
Message-Id: <1311266050-22199-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.6
X-archive-position: 30652
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15238

Hello,

These 2 patches implement ASoC drivers for the AC97 and I2S
controllers found on early Alchemy chips.  They are largely
based on the old mips/au1x00.c driver which they replace.

AC97 Tested on a Db1500 development board; I2S untested since none
of the testboards I have actually have an I2S codec (just testpoints).

Changes since V1:
- added untested I2S controller driver for completeness, removed the audio
  defines from the au1000 header.

Manuel Lauss (2):
  ALSA: Alchemy AC97C/I2SC audio support
  ALSA: delete MIPS au1x00 driver

 arch/mips/alchemy/devboards/db1x00/platform.c |   37 ++
 arch/mips/include/asm/mach-au1x00/au1000.h    |   61 ---
 sound/mips/Kconfig                            |    8 -
 sound/mips/Makefile                           |    2 -
 sound/mips/au1x00.c                           |  695 -------------------------
 sound/soc/au1x/Kconfig                        |   28 +
 sound/soc/au1x/Makefile                       |   10 +
 sound/soc/au1x/ac97c.c                        |  398 ++++++++++++++
 sound/soc/au1x/db1000.c                       |   75 +++
 sound/soc/au1x/dma.c                          |  470 +++++++++++++++++
 sound/soc/au1x/i2sc.c                         |  353 +++++++++++++
 sound/soc/au1x/psc.h                          |   31 +-
 12 files changed, 1393 insertions(+), 775 deletions(-)
 delete mode 100644 sound/mips/au1x00.c
 create mode 100644 sound/soc/au1x/ac97c.c
 create mode 100644 sound/soc/au1x/db1000.c
 create mode 100644 sound/soc/au1x/dma.c
 create mode 100644 sound/soc/au1x/i2sc.c

-- 
1.7.6
