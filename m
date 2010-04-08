From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 8 Apr 2010 20:46:28 +0200
Subject: [PATCH] mips/txx9: Add missing MODULE_ALIAS definitions for
txx9 platform devices
Message-ID: <20100408184628.MLlwW9hHqAsdlMdfoNz3bOUCrG05HRYRB_qWzMfqhYo@z>

This enables autoloading of the TXx9 sound driver on my RBTX4927.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/dma/txx9dmac.c            |    2 ++
 sound/soc/txx9/txx9aclc-ac97.c    |    1 +
 sound/soc/txx9/txx9aclc-generic.c |    1 +
 3 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/txx9dmac.c b/drivers/dma/txx9dmac.c
index 3ebc610..75fcf1a 100644
--- a/drivers/dma/txx9dmac.c
+++ b/drivers/dma/txx9dmac.c
@@ -1359,3 +1359,5 @@ module_exit(txx9dmac_exit);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("TXx9 DMA Controller driver");
 MODULE_AUTHOR("Atsushi Nemoto <anemo@mba.ocn.ne.jp>");
+MODULE_ALIAS("platform:txx9dmac");
+MODULE_ALIAS("platform:txx9dmac-chan");
diff --git a/sound/soc/txx9/txx9aclc-ac97.c b/sound/soc/txx9/txx9aclc-ac97.c
index 612e18b..0ec20b6 100644
--- a/sound/soc/txx9/txx9aclc-ac97.c
+++ b/sound/soc/txx9/txx9aclc-ac97.c
@@ -254,3 +254,4 @@ module_exit(txx9aclc_ac97_exit);
 MODULE_AUTHOR("Atsushi Nemoto <anemo@mba.ocn.ne.jp>");
 MODULE_DESCRIPTION("TXx9 ACLC AC97 driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:txx9aclc-ac97");
diff --git a/sound/soc/txx9/txx9aclc-generic.c
b/sound/soc/txx9/txx9aclc-generic.c
index 3175de9..95b17f7 100644
--- a/sound/soc/txx9/txx9aclc-generic.c
+++ b/sound/soc/txx9/txx9aclc-generic.c
@@ -96,3 +96,4 @@ module_exit(txx9aclc_generic_exit);
 MODULE_AUTHOR("Atsushi Nemoto <anemo@mba.ocn.ne.jp>");
 MODULE_DESCRIPTION("Generic TXx9 ACLC ALSA SoC audio driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:txx9aclc-generic");
-- 
1.6.0.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
