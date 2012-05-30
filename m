Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 May 2012 00:12:53 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:43487 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903648Ab2E3WLK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 May 2012 00:11:10 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SZr6e-00012l-NP; Wed, 30 May 2012 17:11:04 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH 4/5] MIPS: Clean up YAMON support for PMC Sierra platforms.
Date:   Wed, 30 May 2012 17:10:54 -0500
Message-Id: <1338415855-11401-5-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1338415855-11401-1-git-send-email-sjhill@mips.com>
References: <1338415855-11401-1-git-send-email-sjhill@mips.com>
X-archive-position: 33496
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 .../mips/include/asm/pmc-sierra/msp71xx/msp_prom.h |   26 -------
 arch/mips/pmc-sierra/msp71xx/msp_prom.c            |   76 +-------------------
 arch/mips/pmc-sierra/msp71xx/msp_setup.c           |    2 +-
 3 files changed, 3 insertions(+), 101 deletions(-)

diff --git a/arch/mips/include/asm/pmc-sierra/msp71xx/msp_prom.h b/arch/mips/include/asm/pmc-sierra/msp71xx/msp_prom.h
index 786d82d..c9bc42f 100644
--- a/arch/mips/include/asm/pmc-sierra/msp71xx/msp_prom.h
+++ b/arch/mips/include/asm/pmc-sierra/msp71xx/msp_prom.h
@@ -118,13 +118,6 @@
 #define ZSP_DUET		'D'	/* one DUET zsp engine */
 #define ZSP_TRIAD		'T'	/* two TRIAD zsp engines */
 
-extern char *prom_getenv(char *name);
-extern void prom_init_cmdline(void);
-extern void prom_meminit(void);
-extern void prom_fixup_mem_map(unsigned long start_mem,
-			       unsigned long end_mem);
-
-extern int get_ethernet_addr(char *ethaddr_name, char *ethernet_addr);
 extern unsigned long get_deviceid(void);
 extern char identify_enet(unsigned long interface_num);
 extern char identify_enetTxD(unsigned long interface_num);
@@ -147,25 +140,6 @@ extern unsigned long identify_revision(void);
 		printk(_f, ## x); \
 	} while (0)
 
-/* Memory descriptor management. */
-#define PROM_MAX_PMEMBLOCKS    7	/* 6 used */
-
-enum yamon_memtypes {
-	yamon_dontuse,
-	yamon_prom,
-	yamon_free,
-};
-
-struct prom_pmemblock {
-	unsigned long base; /* Within KSEG0. */
-	unsigned int size;  /* In bytes. */
-	unsigned int type;  /* free or prom memory */
-};
-
-extern int prom_argc;
-extern char **prom_argv;
-extern char **prom_envp;
 extern int *prom_vec;
-extern struct prom_pmemblock *prom_getmdesc(void);
 
 #endif /* !_ASM_MSP_PROM_H */
diff --git a/arch/mips/pmc-sierra/msp71xx/msp_prom.c b/arch/mips/pmc-sierra/msp71xx/msp_prom.c
index db00deb..a0f4fb6 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_prom.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_prom.c
@@ -46,13 +46,12 @@
 #include <asm/bootinfo.h>
 #include <asm-generic/sections.h>
 #include <asm/page.h>
+#include <asm/fw/yamon/yamon.h>
 
 #include <msp_prom.h>
 #include <msp_regs.h>
 
-/* global PROM environment variables and pointers */
-int prom_argc;
-char **prom_argv, **prom_envp;
+/* Global PROM vector */
 int *prom_vec;
 
 /* debug flag */
@@ -137,35 +136,6 @@ const char *get_system_type(void)
 #endif
 }
 
-int get_ethernet_addr(char *ethaddr_name, char *ethernet_addr)
-{
-	char *ethaddr_str;
-
-	ethaddr_str = prom_getenv(ethaddr_name);
-	if (!ethaddr_str) {
-		printk(KERN_WARNING "%s not set in boot prom\n", ethaddr_name);
-		return -1;
-	}
-
-	if (str2eaddr(ethernet_addr, ethaddr_str) == -1) {
-		printk(KERN_WARNING "%s badly formatted-<%s>\n",
-			ethaddr_name, ethaddr_str);
-		return -1;
-	}
-
-	if (init_debug > 1) {
-		int i;
-		printk(KERN_DEBUG "get_ethernet_addr: for %s ", ethaddr_name);
-		for (i = 0; i < 5; i++)
-			printk(KERN_DEBUG "%02x:",
-				(unsigned char)*(ethernet_addr+i));
-		printk(KERN_DEBUG "%02x\n", *(ethernet_addr+i));
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(get_ethernet_addr);
-
 static char *get_features(void)
 {
 	char *feature = prom_getenv(FEATURES);
@@ -281,48 +251,6 @@ unsigned long identify_revision(void)
 }
 EXPORT_SYMBOL(identify_revision);
 
-/* PROM environment functions */
-char *prom_getenv(char *env_name)
-{
-	/*
-	 * Return a pointer to the given environment variable.  prom_envp
-	 * points to a null terminated array of pointers to variables.
-	 * Environment variables are stored in the form of "memsize=64"
-	 */
-
-	char **var = prom_envp;
-	int i = strlen(env_name);
-
-	while (*var) {
-		if (strncmp(env_name, *var, i) == 0) {
-			return (*var + strlen(env_name) + 1);
-		}
-		var++;
-	}
-
-	return NULL;
-}
-
-/* PROM commandline functions */
-void  __init prom_init_cmdline(void)
-{
-	char *cp;
-	int actr;
-
-	actr = 1; /* Always ignore argv[0] */
-
-	cp = &(arcs_cmdline[0]);
-	while (actr < prom_argc) {
-		strcpy(cp, prom_argv[actr]);
-		cp += strlen(prom_argv[actr]);
-		*cp++ = ' ';
-		actr++;
-	}
-	if (cp != &(arcs_cmdline[0])) /* get rid of trailing space */
-		--cp;
-	*cp = '\0';
-}
-
 /* memory allocation functions */
 static int __init prom_memtype_classify(unsigned int type)
 {
diff --git a/arch/mips/pmc-sierra/msp71xx/msp_setup.c b/arch/mips/pmc-sierra/msp71xx/msp_setup.c
index 7a834b2..fce1cbf 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_setup.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_setup.c
@@ -156,7 +156,7 @@ void __init prom_init(void)
 
 	prom_argc = fw_arg0;
 	prom_argv = (char **)fw_arg1;
-	prom_envp = (char **)fw_arg2;
+	_prom_envp = (int *)fw_arg2;
 
 	/*
 	 * Someday we can use this with PMON2000 to get a
-- 
1.7.10
