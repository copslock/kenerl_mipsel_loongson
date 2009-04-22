From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Wed, 22 Apr 2009 08:01:48 +0200
Subject: [PATCH] MIPS: Alchemy: timer build fix
Message-ID: <20090422060148.55e5apFKlJgF9r0j1OLWbg9d8ZYUkgbh6lxdzUUF5sU@z>

Fix breakage introduced by 8e19608e8b5c001e4a66ce482edc474f05fb7355.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 on top of 2.6.30-rc3

 arch/mips/alchemy/common/time.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/alchemy/common/time.c b/arch/mips/alchemy/common/time.c
index f58d4ff..33fbae7 100644
--- a/arch/mips/alchemy/common/time.c
+++ b/arch/mips/alchemy/common/time.c
@@ -44,7 +44,7 @@
 
 extern int allow_au1k_wait; /* default off for CP0 Counter */
 
-static cycle_t au1x_counter1_read(void)
+static cycle_t au1x_counter1_read(struct clocksource *cs)
 {
 	return au_readl(SYS_RTCREAD);
 }
-- 
1.6.2.3
