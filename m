From: Manuel Lauss <mlau@msc-ge.com>
Date: Wed, 7 May 2008 13:42:55 +0200
Subject: [PATCH] Alchemy: export get_au1x00_speed for modules
Message-ID: <20080507114255.uv2Qzdal9C1GnPV-EzE9XimFtSHfH2fULWZdr5TPMUY@z>

au1xmmc.c driver depends on it, so export it for modules.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/au1000/common/clocks.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/au1000/common/clocks.c b/arch/mips/au1000/common/clocks.c
index 3ce6cac..6dbc87a 100644
--- a/arch/mips/au1000/common/clocks.c
+++ b/arch/mips/au1000/common/clocks.c
@@ -46,7 +46,7 @@ unsigned int get_au1x00_speed(void)
 {
 	return au1x00_clock;
 }
-
+EXPORT_SYMBOL(get_au1x00_speed);
 
 
 /*
-- 
1.5.5.1
