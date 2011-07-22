Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2011 13:09:21 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:35032 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490966Ab1GVLJR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jul 2011 13:09:17 +0200
Received: by fxd20 with SMTP id 20so3731881fxd.36
        for <linux-mips@linux-mips.org>; Fri, 22 Jul 2011 04:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Skqc8tPQZjkn/okVgeXhoAHUzBEbI5DzKnqLvdnNk5k=;
        b=Qfma7QBWnSATuZpBa4nvxioR0tJjv38pxVzuwzBS68ikye2qrAEuqBPtdj0CqnfssH
         49A5qjbg7yXzjkhDmb6HmBfpS+WidUDOJjyYw+zD9LvcMer5oHbC4e2hrX564VWH86jk
         4pvE5jrabb2Ofl4PGISO0Dp741aE32H0X4Mvo=
Received: by 10.223.102.78 with SMTP id f14mr1986429fao.30.1311332952285;
        Fri, 22 Jul 2011 04:09:12 -0700 (PDT)
Received: from localhost.localdomain (178-191-13-216.adsl.highway.telekom.at [178.191.13.216])
        by mx.google.com with ESMTPS id 28sm1978093fax.27.2011.07.22.04.09.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Jul 2011 04:09:11 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     alsa-devel@vger.kernel.org
Cc:     Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Liam Girdwood <lrg@ti.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH V3 0/3] ASoC for Alchemy Au1000/1500/1100
Date:   Fri, 22 Jul 2011 13:09:05 +0200
Message-Id: <1311332948-29406-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.6
X-archive-position: 30671
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15934

Hello,

These 3 patches implement ASoC drivers for the AC97 and I2S
controllers found on early Alchemy chips.  They are largely
based on the old mips/au1x00.c driver which they replace.

AC97 Tested on a Db1500 development board; I2S untested since none
of the testboards I have actually have an I2S codec (just testpoints).

Changes since V2:
- implemented changes after feedback from Lars-Peter Clausen:
* split patch 1 in two, one for the ASoC drivers, and a separate for
  DB1000 machine code.
* get rid of automatic dma device registration
* tidied the I2S/AC97 sources
- mark sound/mips/au1x00.c as DEPRECATED instead of removing it outright.

Changes since V1:
- added untested I2S controller driver for completeness, removed the audio
  defines from the au1000 header.

Manuel Lauss (3):
  ASoC: Alchemy AC97C/I2SC audio support
  ASoC: Add a DB1x00 AC97 machine driver
  ALSA: deprecate MIPS AU1X00 AC97 driver

 arch/mips/alchemy/devboards/db1x00/platform.c |   48 +++
 arch/mips/include/asm/mach-au1x00/au1000.h    |   31 --
 sound/mips/Kconfig                            |    5 +-
 sound/soc/au1x/Kconfig                        |   28 ++
 sound/soc/au1x/Makefile                       |   10 +
 sound/soc/au1x/ac97c.c                        |  375 ++++++++++++++++++++++++
 sound/soc/au1x/db1000.c                       |   75 +++++
 sound/soc/au1x/dma.c                          |  381 +++++++++++++++++++++++++
 sound/soc/au1x/i2sc.c                         |  348 ++++++++++++++++++++++
 sound/soc/au1x/psc.h                          |   22 +-
 10 files changed, 1282 insertions(+), 41 deletions(-)
 create mode 100644 sound/soc/au1x/ac97c.c
 create mode 100644 sound/soc/au1x/db1000.c
 create mode 100644 sound/soc/au1x/dma.c
 create mode 100644 sound/soc/au1x/i2sc.c

-- 
1.7.6
