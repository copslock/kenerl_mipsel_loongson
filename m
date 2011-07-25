Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jul 2011 13:45:01 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:45682 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490992Ab1GYLo5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Jul 2011 13:44:57 +0200
Received: by fxd20 with SMTP id 20so6754251fxd.36
        for <linux-mips@linux-mips.org>; Mon, 25 Jul 2011 04:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=orMMNjIw0z+/OVh/pRzro+QAYe1jmWXpPkyFciNCrdE=;
        b=tdf5Zl0dnvnnHZMHeXsm/rZtxsDHNhhpjPIJfhfoHBG18Sf0Nl9maibHnNmW3d6eB0
         8XeDqODwmnAzvwe27pQNuGXbqL4sib/2LbRwixBbcIEdNoQwB8wmbrvCfkkabkAQOB1L
         sNE772mc1yrHwDuNyqJg688N92eufSS7tKKVs=
Received: by 10.223.15.138 with SMTP id k10mr4408986faa.101.1311594291537;
        Mon, 25 Jul 2011 04:44:51 -0700 (PDT)
Received: from localhost.localdomain (188-22-157-52.adsl.highway.telekom.at [188.22.157.52])
        by mx.google.com with ESMTPS id n18sm2723648fam.31.2011.07.25.04.44.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Jul 2011 04:44:50 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     alsa-devel@vger.kernel.org,
        Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc:     Liam Girdwood <lrg@ti.com>, Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH V5 0/3] ASoC for Alchemy Au1000/1500/1100
Date:   Mon, 25 Jul 2011 13:44:44 +0200
Message-Id: <1311594287-31576-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.6
X-archive-position: 30712
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17607

Hello,

Here's V5 of the AC97/I2S ASoC patchset for early Alchemy
chips and their respective evaluation boards. 
The patches are largely based on the old mips/au1x00.c driver which
they replace.

AC97 Tested on a Db1500 development board; I2S untested since none
of the testboards I have actually have an I2S codec (just testpoints).

Changes since V4:
- incorporate feedback from Liam Girdwood.
- rediff against latest ASoC changes

Changes since V3:
- dropped the hunk which removed the I2S constants from the au1000.h header
  to avoid merge conflicts with other patches.
- use the context structure declared in psc.h.  Follow-up patches for psc* code
  depend on this.

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

 arch/mips/alchemy/devboards/db1x00/platform.c |   48 ++++
 sound/mips/Kconfig                            |    5 +-
 sound/soc/au1x/Kconfig                        |   28 ++
 sound/soc/au1x/Makefile                       |   10 +
 sound/soc/au1x/ac97c.c                        |  365 ++++++++++++++++++++++++
 sound/soc/au1x/db1000.c                       |   75 +++++
 sound/soc/au1x/dma.c                          |  377 +++++++++++++++++++++++++
 sound/soc/au1x/i2sc.c                         |  347 +++++++++++++++++++++++
 sound/soc/au1x/psc.h                          |   19 +-
 9 files changed, 1264 insertions(+), 10 deletions(-)
 create mode 100644 sound/soc/au1x/ac97c.c
 create mode 100644 sound/soc/au1x/db1000.c
 create mode 100644 sound/soc/au1x/dma.c
 create mode 100644 sound/soc/au1x/i2sc.c

-- 
1.7.6
