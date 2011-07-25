Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jul 2011 13:46:46 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:62371 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491079Ab1GYLpH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Jul 2011 13:45:07 +0200
Received: by mail-fx0-f49.google.com with SMTP id 20so6754283fxd.36
        for <linux-mips@linux-mips.org>; Mon, 25 Jul 2011 04:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=wKZiNsFz5GbiWNfPdHWWhkFHKfTFTNdhvFSHhnWcHpg=;
        b=L2B3EbQkFdBkp0HukUxpjiz4f/fJZcioq7IIyB+IH/cg7OuHylTHsas/Nqsz2sUQxk
         4rIZJ11OT+S7R03oYN09OnP2c4QDwojgA1t9KcSj0XsFn8T+24dD3TnDT8laVCffPDwA
         ggxG92vuhXHQMHJCNcfwKfc3aHx/RKTJ+aBjk=
Received: by 10.223.4.202 with SMTP id 10mr6662549fas.129.1311594307335;
        Mon, 25 Jul 2011 04:45:07 -0700 (PDT)
Received: from localhost.localdomain (188-22-157-52.adsl.highway.telekom.at [188.22.157.52])
        by mx.google.com with ESMTPS id 9sm3744387far.37.2011.07.25.04.45.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Jul 2011 04:45:06 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     alsa-devel@vger.kernel.org,
        Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc:     Liam Girdwood <lrg@ti.com>, Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH V2 0/3] ASoC: au1x: update PSC AC97/I2S code
Date:   Mon, 25 Jul 2011 13:45:01 +0200
Message-Id: <1311594304-31605-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.6
X-archive-position: 30716
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17611

The following two patches depend on patchset "ASoC for Alchemy Au1000/1500/1100"
to apply and work.
Patch #1 moves the DBDMA (PCM) device registration from the AC97/I2S drivers
  into the board code.
Patch #2 changes use of "soc-audio" platform device int db1200 machine code to
  the new way.
Patch #3 removes the use of custom PCM_TX/RX constants in favour of the
  established SNDRV_PCM_SUBTREAM_PLAYBACK/CAPTURE.

Changes since V1:
- added patch #3
- tidied patch #1 a bit more.

Run-tested on DB1200, DB1300 and DB1550 boards.

Manuel Lauss (3):
  ASoC: au1x: remove automatic DMA device registration from PSC drivers
  ASoC: au1x: update db1200 machine to the new way of things
  ASoC: au1x: use substream stream info directly

 arch/mips/alchemy/devboards/db1200/platform.c |   16 +++++
 sound/soc/au1x/db1200.c                       |   64 ++++++++++++------
 sound/soc/au1x/dbdma2.c                       |   91 +++++--------------------
 sound/soc/au1x/psc-ac97.c                     |   48 +++++++++-----
 sound/soc/au1x/psc-i2s.c                      |   42 +++++++----
 sound/soc/au1x/psc.h                          |   11 ---
 6 files changed, 133 insertions(+), 139 deletions(-)

-- 
1.7.6
