Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Apr 2014 22:46:51 +0200 (CEST)
Received: from smtp-out-121.synserver.de ([212.40.185.121]:1117 "EHLO
        smtp-out-072.synserver.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6834667AbaDVUqtCdWu- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Apr 2014 22:46:49 +0200
Received: (qmail 18475 invoked by uid 0); 22 Apr 2014 20:46:43 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@metafoo.de
X-SynServer-PPID: 18380
Received: from ppp-188-174-45-35.dynamic.mnet-online.de (HELO lars-adi-laptop.fritz.box) [188.174.45.35]
  by 217.119.54.96 with SMTP; 22 Apr 2014 20:46:43 -0000
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, alsa-devel@alsa-project.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/6] ASoC: jz4740: Remove Makefile entry for removed file
Date:   Tue, 22 Apr 2014 22:46:31 +0200
Message-Id: <1398199596-23649-1-git-send-email-lars@metafoo.de>
X-Mailer: git-send-email 1.8.0
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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

Commit 0406a40a0 ("ASoC: jz4740: Use the generic dmaengine PCM driver")
jz4740-pcm.c file, but neglected to remove the Makefile entries.

Fixes: 0406a40a0 ("ASoC: jz4740: Use the generic dmaengine PCM driver")
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Reported-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/jz4740/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/jz4740/Makefile b/sound/soc/jz4740/Makefile
index be873c1..d32c540 100644
--- a/sound/soc/jz4740/Makefile
+++ b/sound/soc/jz4740/Makefile
@@ -1,10 +1,8 @@
 #
 # Jz4740 Platform Support
 #
-snd-soc-jz4740-objs := jz4740-pcm.o
 snd-soc-jz4740-i2s-objs := jz4740-i2s.o
 
-obj-$(CONFIG_SND_JZ4740_SOC) += snd-soc-jz4740.o
 obj-$(CONFIG_SND_JZ4740_SOC_I2S) += snd-soc-jz4740-i2s.o
 
 # Jz4740 Machine Support
-- 
1.8.0
