From: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Date: Tue, 17 Jun 2008 11:44:55 +0300
Subject: [PATCH 1/1] [MIPS] Get rid of module_init() in core kernel code
Message-ID: <20080617084455.4MlMKp3SWO2zwVeRvdNOCHIsYuXA7_PoHdo-3sQajVg@z>

Now that the Malta MTD driver cannot be compiled as a module
due to commit b8157180ccd8bb3752f510c6c434b86394636093, arrange
calling the driver initialization routine via device_initcall()
macro instead of module_init().

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movail.fi>
---
 arch/mips/mips-boards/malta/malta_mtd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/mips-boards/malta/malta_mtd.c b/arch/mips/mips-boards/malta/malta_mtd.c
index 8ad9bdf..f24f654 100644
--- a/arch/mips/mips-boards/malta/malta_mtd.c
+++ b/arch/mips/mips-boards/malta/malta_mtd.c
@@ -60,4 +60,4 @@ static int __init malta_mtd_init(void)
 	return 0;
 }
 
-module_init(malta_mtd_init)
+device_initcall(malta_mtd_init);
-- 
1.5.5.GIT


--------------030806050307080309070502--
