Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 20:57:42 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56272 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008799AbbIVS5js9z-P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 20:57:39 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7EA8983990C;
        Tue, 22 Sep 2015 19:57:27 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Sep 2015 19:57:31 +0100
Received: from localhost (192.168.159.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 22 Sep
 2015 19:57:30 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 2/3] MIPS: malta: remove fw_memblock_t abstraction
Date:   Tue, 22 Sep 2015 11:56:37 -0700
Message-ID: <1442948198-14507-3-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <1442948198-14507-1-git-send-email-paul.burton@imgtec.com>
References: <1442948198-14507-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.189]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49326
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The fw_getmdesc function & fw_memblock_t abstraction is only used by
Malta, and so far as I can tell serves no purpose beyond making the code
less clear than it could be. Remove the useless level of abstraction.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/include/asm/fw/fw.h      | 16 -------
 arch/mips/mti-malta/malta-memory.c | 93 ++++++++++++--------------------------
 2 files changed, 29 insertions(+), 80 deletions(-)

diff --git a/arch/mips/include/asm/fw/fw.h b/arch/mips/include/asm/fw/fw.h
index f3e6978..d0ef8b4 100644
--- a/arch/mips/include/asm/fw/fw.h
+++ b/arch/mips/include/asm/fw/fw.h
@@ -10,21 +10,6 @@
 
 #include <asm/bootinfo.h>	/* For cleaner code... */
 
-enum fw_memtypes {
-	fw_dontuse,
-	fw_code,
-	fw_free,
-};
-
-typedef struct {
-	unsigned long base;	/* Within KSEG0 */
-	unsigned int size;	/* bytes */
-	enum fw_memtypes type;	/* fw_memtypes */
-} fw_memblock_t;
-
-/* Maximum number of memory block descriptors. */
-#define FW_MAX_MEMBLOCKS	32
-
 extern int fw_argc;
 extern int *_fw_argv;
 extern int *_fw_envp;
@@ -38,7 +23,6 @@ extern int *_fw_envp;
 
 extern void fw_init_cmdline(void);
 extern char *fw_getcmdline(void);
-extern fw_memblock_t *fw_getmdesc(int);
 extern void fw_meminit(void);
 extern char *fw_getenv(char *name);
 extern unsigned long fw_getenvl(char *name);
diff --git a/arch/mips/mti-malta/malta-memory.c b/arch/mips/mti-malta/malta-memory.c
index dadeb83..93ace96 100644
--- a/arch/mips/mti-malta/malta-memory.c
+++ b/arch/mips/mti-malta/malta-memory.c
@@ -21,19 +21,25 @@
 #include <asm/sections.h>
 #include <asm/fw/fw.h>
 
-static fw_memblock_t mdesc[FW_MAX_MEMBLOCKS];
-
 /* determined physical memory size, not overridden by command line args	 */
 unsigned long physical_memsize = 0L;
 
-fw_memblock_t * __init fw_getmdesc(int eva)
+static void free_init_pages_eva_malta(void *begin, void *end)
+{
+	free_init_pages("unused kernel", __pa_symbol((unsigned long *)begin),
+			__pa_symbol((unsigned long *)end));
+}
+
+void __init fw_meminit(void)
 {
 	char *memsize_str, *ememsize_str = NULL, *ptr;
 	unsigned long memsize = 0, ememsize = 0;
+	unsigned long kernel_start_phys, kernel_end_phys;
 	static char cmdline[COMMAND_LINE_SIZE] __initdata;
+	bool eva = config_enabled(CONFIG_EVA);
 	int tmp;
 
-	/* otherwise look in the environment */
+	free_init_pages_eva = eva ? free_init_pages_eva_malta : NULL;
 
 	memsize_str = fw_getenv("memsize");
 	if (memsize_str) {
@@ -92,15 +98,14 @@ fw_memblock_t * __init fw_getmdesc(int eva)
 	if (memsize > 0x7fff0000)
 		memsize = 0x7fff0000;
 
-	memset(mdesc, 0, sizeof(mdesc));
-
-	mdesc[0].type = fw_dontuse;
-	mdesc[0].base = PHYS_OFFSET;
-	mdesc[0].size = 0x00001000;
+	add_memory_region(PHYS_OFFSET, 0x00001000, BOOT_MEM_RESERVED);
 
-	mdesc[1].type = fw_code;
-	mdesc[1].base = mdesc[0].base + 0x00001000UL;
-	mdesc[1].size = 0x000ef000;
+	/*
+	 * YAMON may still be using the region of memory from 0x1000 to 0xfffff
+	 * if it has started secondary CPUs.
+	 */
+	add_memory_region(PHYS_OFFSET + 0x00001000, 0x000ef000,
+			  BOOT_MEM_ROM_DATA);
 
 	/*
 	 * The area 0x000f0000-0x000fffff is allocated for BIOS memory by the
@@ -109,59 +114,19 @@ fw_memblock_t * __init fw_getmdesc(int eva)
 	 * This mean that this area can't be used as DMA memory for PCI
 	 * devices.
 	 */
-	mdesc[2].type = fw_dontuse;
-	mdesc[2].base = mdesc[0].base + 0x000f0000UL;
-	mdesc[2].size = 0x00010000;
-
-	mdesc[3].type = fw_dontuse;
-	mdesc[3].base = mdesc[0].base + 0x00100000UL;
-	mdesc[3].size = CPHYSADDR(PFN_ALIGN((unsigned long)&_end)) -
-		0x00100000UL;
-
-	mdesc[4].type = fw_free;
-	mdesc[4].base = mdesc[0].base + CPHYSADDR(PFN_ALIGN(&_end));
-	mdesc[4].size = memsize - CPHYSADDR(mdesc[4].base);
-
-	return &mdesc[0];
-}
-
-static void free_init_pages_eva_malta(void *begin, void *end)
-{
-	free_init_pages("unused kernel", __pa_symbol((unsigned long *)begin),
-			__pa_symbol((unsigned long *)end));
-}
+	add_memory_region(PHYS_OFFSET + 0x000f0000, 0x00010000,
+			  BOOT_MEM_RESERVED);
 
-static int __init fw_memtype_classify(unsigned int type)
-{
-	switch (type) {
-	case fw_free:
-		return BOOT_MEM_RAM;
-	case fw_code:
-		return BOOT_MEM_ROM_DATA;
-	default:
-		return BOOT_MEM_RESERVED;
-	}
-}
-
-void __init fw_meminit(void)
-{
-	fw_memblock_t *p;
-
-	p = fw_getmdesc(config_enabled(CONFIG_EVA));
-	free_init_pages_eva = (config_enabled(CONFIG_EVA) ?
-			       free_init_pages_eva_malta : NULL);
-
-	while (p->size) {
-		long type;
-		unsigned long base, size;
-
-		type = fw_memtype_classify(p->type);
-		base = p->base;
-		size = p->size;
-
-		add_memory_region(base, size, type);
-		p++;
-	}
+	/*
+	 * Reserve the memory used by kernel code, and allow the rest of RAM to
+	 * be used.
+	 */
+	kernel_start_phys = PHYS_OFFSET + 0x00100000;
+	kernel_end_phys = PHYS_OFFSET + CPHYSADDR(PFN_ALIGN(&_end));
+	add_memory_region(kernel_start_phys, kernel_end_phys,
+			  BOOT_MEM_RESERVED);
+	add_memory_region(kernel_end_phys, memsize - kernel_end_phys,
+			  BOOT_MEM_RAM);
 }
 
 void __init prom_free_prom_memory(void)
-- 
2.5.3
