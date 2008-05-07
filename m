From: Manuel Lauss <mlau@msc-ge.com>
Date: Wed, 7 May 2008 13:45:23 +0200
Subject: [PATCH] Alchemy: dbdma: add API to delete custom DDMA device ids.
Message-ID: <20080507114523.Cpm3TqxB56sVy3KCkGKWPmaMVtm97_LwefRlfljV2g4@z>

Add API to delete custom DDMA device ids create with
au1xxx_ddma_device_add().

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/au1000/common/dbdma.c             |   10 ++++++++++
 include/asm-mips/mach-au1x00/au1xxx_dbdma.h |    1 +
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/mips/au1000/common/dbdma.c b/arch/mips/au1000/common/dbdma.c
index 42d5552..e7cb64e 100644
--- a/arch/mips/au1000/common/dbdma.c
+++ b/arch/mips/au1000/common/dbdma.c
@@ -216,6 +216,16 @@ u32 au1xxx_ddma_add_device(dbdev_tab_t *dev)
 }
 EXPORT_SYMBOL(au1xxx_ddma_add_device);
 
+void au1xxx_ddma_del_device(u32 devid)
+{
+	dbdev_tab_t *p = find_dbdev_id(devid);
+	if (p != NULL) {
+		memset(p, 0, sizeof(dbdev_tab_t));
+		p->dev_id = ~0;
+	}
+}
+EXPORT_SYMBOL(au1xxx_ddma_del_device);
+
 /* Allocate a channel and return a non-zero descriptor if successful. */
 u32 au1xxx_dbdma_chan_alloc(u32 srcid, u32 destid,
        void (*callback)(int, void *), void *callparam)
diff --git a/include/asm-mips/mach-au1x00/au1xxx_dbdma.h b/include/asm-mips/mach-au1x00/au1xxx_dbdma.h
index ad17d7c..9077763 100644
--- a/include/asm-mips/mach-au1x00/au1xxx_dbdma.h
+++ b/include/asm-mips/mach-au1x00/au1xxx_dbdma.h
@@ -355,6 +355,7 @@ void au1xxx_dbdma_dump(u32 chanid);
 u32 au1xxx_dbdma_put_dscr(u32 chanid, au1x_ddma_desc_t *dscr);
 
 u32 au1xxx_ddma_add_device(dbdev_tab_t *dev);
+void au1xxx_ddma_del_device(u32 devid);
 void *au1xxx_ddma_get_nextptr_virt(au1x_ddma_desc_t *dp);
 
 /*
-- 
1.5.5.1
