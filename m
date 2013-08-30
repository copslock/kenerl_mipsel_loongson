Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Aug 2013 12:05:55 +0200 (CEST)
Received: from mail-pb0-f53.google.com ([209.85.160.53]:49455 "EHLO
        mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822682Ab3H3KFgjgA1A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Aug 2013 12:05:36 +0200
Received: by mail-pb0-f53.google.com with SMTP id up15so1654687pbc.40
        for <linux-mips@linux-mips.org>; Fri, 30 Aug 2013 03:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+jRBqx9HU2g4NZL8ALJ+yYwonmV204o0P08wAnHCS34=;
        b=Y4LFO6W3CnJslIdoxIhZ3/KePHpnO83aTBeUg58m2Ob5rZQG5wZk9cH6/mp/nqmFoK
         KpI1C52FkBFF+IfhpvbhJUd2YkWX6/4J42dSlkVqwltRO74tN3jqaG7ILiGoWe6CAOb4
         uQ6GKE8ouhAXPdQILjmVEd9n3ZjTiWagnRZtJY7ab1wTQPFsYQGTLkJ9U0aJm82Q8ujW
         Z3ToDmTh6Zlz7hsGrLBi9DE1iyyae/dwMFQw4e+HRk5vA+/cc2jglOW2pyu9EUi+LLHy
         cAz6mVcZWVXr22YAnxIPCvRVDP1dCaT5VQf2rZee8pvjKe+ZAJIngMjrAJt8slMyTbat
         t6oA==
X-Received: by 10.66.250.138 with SMTP id zc10mr9867300pac.72.1377857130439;
        Fri, 30 Aug 2013 03:05:30 -0700 (PDT)
Received: from localhost ([115.115.74.130])
        by mx.google.com with ESMTPSA id fk4sm46745236pab.23.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 30 Aug 2013 03:05:29 -0700 (PDT)
From:   Prem Mallappa <prem.mallappa@gmail.com>
To:     linux-mips <linux-mips@linux-mips.org>
Cc:     Prem Mallappa <pmallappa@caviumnetworks.com>
Subject: [PATCH 2/2] MIPS: KEXEC: Fixes Random crashes while loading crashkernel
Date:   Fri, 30 Aug 2013 15:35:11 +0530
Message-Id: <1377857111-15493-2-git-send-email-pmallappa@caviumnetworks.com>
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1377857111-15493-1-git-send-email-pmallappa@caviumnetworks.com>
References: <1377857111-15493-1-git-send-email-pmallappa@caviumnetworks.com>
Return-Path: <prem.mallappa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37711
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prem.mallappa@gmail.com
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

MIPS: KEXEC: Fixes Random crashes while loading crashkernel

Rearranging code so that crashk_res gets updated.
- crashk_res is updated after mips_parse_crashkernel(),
   after resource_init(), which is after arch_mem_init().
- The reserved memory is actually treated as Usable memory,
   Unless we load the crash kernel, everything works.

Signed-off-by: Prem Mallappa <pmallappa@caviumnetworks.com>
---
 arch/mips/kernel/setup.c | 99 +++++++++++++++++++++++-------------------------
 1 file changed, 48 insertions(+), 51 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index c7f9051..e98a256 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -552,6 +552,52 @@ static void __init arch_mem_addpart(phys_t mem, phys_t end, int type)
 	add_memory_region(mem, size, type);
 }
 
+#ifdef CONFIG_KEXEC
+static inline unsigned long long get_total_mem(void)
+{
+	unsigned long long total;
+
+	total = max_pfn - min_low_pfn;
+	return total << PAGE_SHIFT;
+}
+
+static void __init mips_parse_crashkernel(void)
+{
+	unsigned long long total_mem;
+	unsigned long long crash_size, crash_base;
+	int ret;
+
+	total_mem = get_total_mem();
+	ret = parse_crashkernel(boot_command_line, total_mem,
+				&crash_size, &crash_base);
+	if (ret != 0 || crash_size <= 0)
+		return;
+
+	crashk_res.start = crash_base;
+	crashk_res.end	 = crash_base + crash_size - 1;
+}
+
+static void __init request_crashkernel(struct resource *res)
+{
+	int ret;
+
+	ret = request_resource(res, &crashk_res);
+	if (!ret)
+		pr_info("Reserving %ldMB of memory at %ldMB for crashkernel\n",
+			(unsigned long)((crashk_res.end -
+					 crashk_res.start + 1) >> 20),
+			(unsigned long)(crashk_res.start  >> 20));
+}
+#else /* !defined(CONFIG_KEXEC)		*/
+static void __init mips_parse_crashkernel(void)
+{
+}
+
+static void __init request_crashkernel(struct resource *res)
+{
+}
+#endif /* !defined(CONFIG_KEXEC)  */
+
 static void __init arch_mem_init(char **cmdline_p)
 {
 	extern void plat_mem_setup(void);
@@ -609,6 +655,8 @@ static void __init arch_mem_init(char **cmdline_p)
 	}
 #endif
 #ifdef CONFIG_KEXEC
+	mips_parse_crashkernel();
+
 	if (crashk_res.start != crashk_res.end)
 		reserve_bootmem(crashk_res.start,
 				crashk_res.end - crashk_res.start + 1,
@@ -620,52 +668,6 @@ static void __init arch_mem_init(char **cmdline_p)
 	paging_init();
 }
 
-#ifdef CONFIG_KEXEC
-static inline unsigned long long get_total_mem(void)
-{
-	unsigned long long total;
-
-	total = max_pfn - min_low_pfn;
-	return total << PAGE_SHIFT;
-}
-
-static void __init mips_parse_crashkernel(void)
-{
-	unsigned long long total_mem;
-	unsigned long long crash_size, crash_base;
-	int ret;
-
-	total_mem = get_total_mem();
-	ret = parse_crashkernel(boot_command_line, total_mem,
-				&crash_size, &crash_base);
-	if (ret != 0 || crash_size <= 0)
-		return;
-
-	crashk_res.start = crash_base;
-	crashk_res.end	 = crash_base + crash_size - 1;
-}
-
-static void __init request_crashkernel(struct resource *res)
-{
-	int ret;
-
-	ret = request_resource(res, &crashk_res);
-	if (!ret)
-		pr_info("Reserving %ldMB of memory at %ldMB for crashkernel\n",
-			(unsigned long)((crashk_res.end -
-				crashk_res.start + 1) >> 20),
-			(unsigned long)(crashk_res.start  >> 20));
-}
-#else /* !defined(CONFIG_KEXEC)	 */
-static void __init mips_parse_crashkernel(void)
-{
-}
-
-static void __init request_crashkernel(struct resource *res)
-{
-}
-#endif /* !defined(CONFIG_KEXEC)  */
-
 static void __init resource_init(void)
 {
 	int i;
@@ -678,11 +680,6 @@ static void __init resource_init(void)
 	data_resource.start = __pa_symbol(&_etext);
 	data_resource.end = __pa_symbol(&_edata) - 1;
 
-	/*
-	 * Request address space for all standard RAM.
-	 */
-	mips_parse_crashkernel();
-
 	for (i = 0; i < boot_mem_map.nr_map; i++) {
 		struct resource *res;
 		unsigned long start, end;
-- 
1.8.4
