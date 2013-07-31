Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Jul 2013 10:15:31 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:34072 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822674Ab3GaIP2XevLY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 31 Jul 2013 10:15:28 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r6V8FMYj019179;
        Wed, 31 Jul 2013 10:15:22 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r6V8FJse019178;
        Wed, 31 Jul 2013 10:15:19 +0200
Date:   Wed, 31 Jul 2013 10:15:19 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Manuel Lauss <manuel.lauss@gmail.com>,
        Mark Brown <broonie@linaro.org>, linux-mips@linux-mips.org
Subject: [PATCH] SOUND: au1x: Fix build
Message-ID: <20130731081519.GA18756@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37405
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

d8b51c11ff5a70244753ba60abfd47088cf4dcd4 [ASoC: ac97c: Use
module_platform_driver()] broke the build:

 CC      sound/soc/au1x/ac97c.o
/home/ralf/src/linux/upstream-sfr/sound/soc/au1x/ac97c.c:344:1: error: expected identifier or ‘(’ before ‘&’ token
/home/ralf/src/linux/upstream-sfr/sound/soc/au1x/ac97c.c:344:1: error: pasting "__initcall_" and "&" does not give a valid preprocessing token
/home/ralf/src/linux/upstream-sfr/sound/soc/au1x/ac97c.c:344:1: error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or ‘__attribute__’ before ‘&’ token
/home/ralf/src/linux/upstream-sfr/sound/soc/au1x/ac97c.c:344:1: error: expected identifier or ‘(’ before ‘&’ token
/home/ralf/src/linux/upstream-sfr/sound/soc/au1x/ac97c.c:344:1: error: pasting "__exitcall_" and "&" does not give a valid preprocessing token
/home/ralf/src/linux/upstream-sfr/sound/soc/au1x/ac97c.c:344:1: error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or ‘__attribute__’ before ‘&’ token
/home/ralf/src/linux/upstream-sfr/sound/soc/au1x/ac97c.c:334:31: warning: ‘au1xac97c_driver’ defined but not used [-Wunused-variable]
make[5]: *** [sound/soc/au1x/ac97c.o] Error 1
make[4]: *** [sound/soc/au1x] Error 2
make[3]: *** [sound/soc] Error 2

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/sound/soc/au1x/ac97c.c b/sound/soc/au1x/ac97c.c
index d6f7694..c8a2de1 100644
--- a/sound/soc/au1x/ac97c.c
+++ b/sound/soc/au1x/ac97c.c
@@ -341,7 +341,7 @@ static struct platform_driver au1xac97c_driver = {
 	.remove		= au1xac97c_drvremove,
 };
 
-module_platform_driver(&au1xac97c_driver);
+module_platform_driver(au1xac97c_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Au1000/1500/1100 AC97C ASoC driver");
