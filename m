Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Nov 2010 19:09:23 +0100 (CET)
Received: from smtp-out-138.synserver.de ([212.40.180.138]:1037 "HELO
        smtp-out-138.synserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1492041Ab0KKSJV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Nov 2010 19:09:21 +0100
Received: (qmail 27567 invoked by uid 0); 11 Nov 2010 18:09:12 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@laprican.de
X-SynServer-PPID: 27496
Received: from d124041.adsl.hansenet.de (HELO localhost.localdomain) [80.171.124.41]
  by 217.119.54.81 with SMTP; 11 Nov 2010 18:09:12 -0000
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] MIPS: JZ4740: Fix pcm device name
Date:   Thu, 11 Nov 2010 19:08:52 +0100
Message-Id: <1289498933-12836-1-git-send-email-lars@metafoo.de>
X-Mailer: git-send-email 1.5.6.5
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28359
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips

As part the ASoC multi-component patch (commit f0fba2ad) the jz4740 pcm driver
was renamed to 'jz4740-pcm-audio'. Adjust the device name accordingly.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/jz4740/platform.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/jz4740/platform.c b/arch/mips/jz4740/platform.c
index c860b01..a17a17b 100644
--- a/arch/mips/jz4740/platform.c
+++ b/arch/mips/jz4740/platform.c
@@ -208,7 +208,7 @@ struct platform_device jz4740_i2s_device = {
 
 /* PCM */
 struct platform_device jz4740_pcm_device = {
-	.name		= "jz4740-pcm",
+	.name		= "jz4740-pcm-audio",
 	.id		= -1,
 };
 
-- 
1.5.6.5
