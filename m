Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Jul 2011 15:11:42 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:65532 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490981Ab1GXNLi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 Jul 2011 15:11:38 +0200
Received: by fxd20 with SMTP id 20so5793629fxd.36
        for <linux-mips@linux-mips.org>; Sun, 24 Jul 2011 06:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=+USl1578k26mTuNVbTw0YBVrw8lKZpldR5WThNpa0U0=;
        b=GKbd7j6w00uo4UYI/7jXjQdok+Gk3MzX4DTci0uhABfoeYLqralNeBJxfAfd//ehvv
         S02SMH5gy+hO/oSTn4u9mcen8QgceU3nmIHpTPz7SG33bWUpkTrAYQnxHbLLT0Y0LrXm
         wOw1yS9KVpGmmhOw06nUDSy9JwXqfy0MaX0SQ=
Received: by 10.223.132.207 with SMTP id c15mr5096383fat.73.1311513092962;
        Sun, 24 Jul 2011 06:11:32 -0700 (PDT)
Received: from localhost.localdomain (188-22-2-77.adsl.highway.telekom.at [188.22.2.77])
        by mx.google.com with ESMTPS id h10sm3192115fai.19.2011.07.24.06.11.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 24 Jul 2011 06:11:31 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     alsa-devel@vger.kernel.org,
        Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc:     Liam Girdwood <lrg@ti.com>, Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 0/2] ASoC: au1x: update PSC AC97/I2S code
Date:   Sun, 24 Jul 2011 15:11:26 +0200
Message-Id: <1311513088-18802-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.6
X-archive-position: 30703
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17128

The following two patches depend on patchset "ASoC for Alchemy Au1000/1500/1100"
to apply and work.
Patch #1 moves the DBDMA (PCM) device registration from the AC97/I2S drivers
  into the board code.
Patch #2 changes use of "soc-audio" platform device int db1200 machine code to
  the new way.

Run-tested on DB1200, DB1300 and DB1550 boards.

Manuel Lauss (2):
  ASoC: au1x: remove automatic DMA device registration from PSC drivers
  ASoC: au1x: update db1200 machine to the new way of things

 arch/mips/alchemy/devboards/db1200/platform.c |   16 +++++
 sound/soc/au1x/db1200.c                       |   64 +++++++++++++------
 sound/soc/au1x/dbdma2.c                       |   83 ++++---------------------
 sound/soc/au1x/psc-ac97.c                     |   34 +++++++---
 sound/soc/au1x/psc-i2s.c                      |   32 +++++++---
 sound/soc/au1x/psc.h                          |    5 --
 6 files changed, 117 insertions(+), 117 deletions(-)

-- 
1.7.6
