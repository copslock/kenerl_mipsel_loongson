Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:37:41 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:44846 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827335AbaA0U2DD7WPt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:28:03 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 53/58] MIPS: malta: malta-memory: Add support for the 'ememsize' variable
Date:   Mon, 27 Jan 2014 20:19:40 +0000
Message-ID: <1390853985-14246-54-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_27_58
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39171
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

The 'ememsize' variable is used to denote the real RAM which is
present on the Malta board. This is different compared to 'memsize'
which is capped to 256MB. The 'ememsize' is used to get the actual
physical memory when setting up the Malta memory layout. This only
makes sense in case the core operates in the EVA mode, and it's
ignored otherwise.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/fw/fw.h      |  2 +-
 arch/mips/mti-malta/malta-memory.c | 36 +++++++++++++++++++++++++++---------
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/arch/mips/include/asm/fw/fw.h b/arch/mips/include/asm/fw/fw.h
index d6c50a7..f3e6978 100644
--- a/arch/mips/include/asm/fw/fw.h
+++ b/arch/mips/include/asm/fw/fw.h
@@ -38,7 +38,7 @@ extern int *_fw_envp;
 
 extern void fw_init_cmdline(void);
 extern char *fw_getcmdline(void);
-extern fw_memblock_t *fw_getmdesc(void);
+extern fw_memblock_t *fw_getmdesc(int);
 extern void fw_meminit(void);
 extern char *fw_getenv(char *name);
 extern unsigned long fw_getenvl(char *name);
diff --git a/arch/mips/mti-malta/malta-memory.c b/arch/mips/mti-malta/malta-memory.c
index 1f73d63..cd04008 100644
--- a/arch/mips/mti-malta/malta-memory.c
+++ b/arch/mips/mti-malta/malta-memory.c
@@ -24,22 +24,30 @@ static fw_memblock_t mdesc[FW_MAX_MEMBLOCKS];
 /* determined physical memory size, not overridden by command line args	 */
 unsigned long physical_memsize = 0L;
 
-fw_memblock_t * __init fw_getmdesc(void)
+fw_memblock_t * __init fw_getmdesc(int eva)
 {
-	char *memsize_str, *ptr;
-	unsigned int memsize;
+	char *memsize_str, *ememsize_str __maybe_unused = NULL, *ptr;
+	unsigned long memsize, ememsize __maybe_unused = 0;
 	static char cmdline[COMMAND_LINE_SIZE] __initdata;
-	long val;
 	int tmp;
 
 	/* otherwise look in the environment */
+
 	memsize_str = fw_getenv("memsize");
-	if (!memsize_str) {
+	if (memsize_str)
+		tmp = kstrtol(memsize_str, 0, &memsize);
+	if (eva) {
+	/* Look for ememsize for EVA */
+		ememsize_str = fw_getenv("ememsize");
+		if (ememsize_str)
+			tmp = kstrtol(ememsize_str, 0, &ememsize);
+	}
+	if (!memsize && !ememsize) {
 		pr_warn("memsize not set in YAMON, set to default (32Mb)\n");
 		physical_memsize = 0x02000000;
 	} else {
-		tmp = kstrtol(memsize_str, 0, &val);
-		physical_memsize = (unsigned long)val;
+		/* If ememsize is set, then set physical_memsize to that */
+		physical_memsize = ememsize ? : memsize;
 	}
 
 #ifdef CONFIG_CPU_BIG_ENDIAN
@@ -54,12 +62,22 @@ fw_memblock_t * __init fw_getmdesc(void)
 	ptr = strstr(cmdline, "memsize=");
 	if (ptr && (ptr != cmdline) && (*(ptr - 1) != ' '))
 		ptr = strstr(ptr, " memsize=");
+	/* And now look for ememsize */
+	if (eva) {
+		ptr = strstr(cmdline, "ememsize=");
+		if (ptr && (ptr != cmdline) && (*(ptr - 1) != ' '))
+			ptr = strstr(ptr, " ememsize=");
+	}
 
 	if (ptr)
-		memsize = memparse(ptr + 8, &ptr);
+		memsize = memparse(ptr + 8 + (eva ? 1 : 0), &ptr);
 	else
 		memsize = physical_memsize;
 
+	/* Last 64K for HIGHMEM arithmetics */
+	if (memsize > 0x7fff0000)
+		memsize = 0x7fff0000;
+
 	memset(mdesc, 0, sizeof(mdesc));
 
 	mdesc[0].type = fw_dontuse;
@@ -109,7 +127,7 @@ void __init fw_meminit(void)
 {
 	fw_memblock_t *p;
 
-	p = fw_getmdesc();
+	p = fw_getmdesc(config_enabled(CONFIG_EVA));
 
 	while (p->size) {
 		long type;
-- 
1.8.5.3
