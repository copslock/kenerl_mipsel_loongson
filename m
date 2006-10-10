From: Maarten Lankhorst <M.B.Lankhorst@gmail.com>
Date: Tue, 10 Oct 2006 13:14:12 +0200
Subject: [PATCH] Detect-wrt54gl-flashchip
Message-ID: <20061010111412.6DXlj8tRCIgI3ZMteNc2F3kw4fzd8WUXYdNtilxFKVk@z>

---
 drivers/mtd/chips/cfi_cmdset_0002.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c b/drivers/mtd/chips/cfi_cmdset_0002.c
index 702ae4c..1a7a756 100644
--- a/drivers/mtd/chips/cfi_cmdset_0002.c
+++ b/drivers/mtd/chips/cfi_cmdset_0002.c
@@ -291,8 +291,10 @@ struct mtd_info *cfi_cmdset_0002(struct 
 			return NULL;
 		}
 
-		if (extp->MajorVersion != '1' ||
-		    (extp->MinorVersion < '0' || extp->MinorVersion > '4')) {
+		/* Apparantly Major/Minor 3.3 is supported too */
+		if (!(extp->MajorVersion == '3' && extp->MinorVersion == '3') &&
+		    (extp->MajorVersion != '1' ||
+		    (extp->MinorVersion < '0' || extp->MinorVersion > '4'))) {
 			printk(KERN_ERR "  Unknown Amd/Fujitsu Extended Query "
 			       "version %c.%c.\n",  extp->MajorVersion,
 			       extp->MinorVersion);
-- 
1.4.1
