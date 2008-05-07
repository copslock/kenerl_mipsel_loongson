From: Manuel Lauss <mlau@msc-ge.com>
Date: Wed, 7 May 2008 13:42:55 +0200
Subject: [PATCH] Alchemy: export get_au1x00_speed for modules
Message-ID: <20080507114255.Znz5fqoBDUSuzKJ4GkWM-LA_HbBYELPwHmuliOXnsto@z>

au1xmmc.c driver depends on it, so export it for modules.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/au1000/common/clocks.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/au1000/common/clocks.c b/arch/mips/au1000/common/clocks.c
index 46f8ee0..043429d 100644
--- a/arch/mips/au1000/common/clocks.c
+++ b/arch/mips/au1000/common/clocks.c
@@ -45,6 +45,7 @@ unsigned int get_au1x00_speed(void)
 {
 	return au1x00_clock;
 }
+EXPORT_SYMBOL(get_au1x00_speed);
 
 /*
  * The UART baud base is not known at compile time ... if
-- 
1.5.5.1
