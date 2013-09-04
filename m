Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Sep 2013 19:57:12 +0200 (CEST)
Received: from mail-pd0-f177.google.com ([209.85.192.177]:60748 "EHLO
        mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825118Ab3IDR4p6yNCW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Sep 2013 19:56:45 +0200
Received: by mail-pd0-f177.google.com with SMTP id y10so640646pdj.8
        for <linux-mips@linux-mips.org>; Wed, 04 Sep 2013 10:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=3F3DdT1MFFQcXGdY7OByugAu2NVAramtyV8liiMYcOE=;
        b=dX38Dx67RBAAsL6eTs42DFE1qJhpRoAE/HW+x05X92waQFBidnSyrqLxfy6Naz6Q+m
         gdc9kFtX7W60APMNwFue23HcugbAZ4crYOnz7TLfDhIbGSFoUamMkFbSINCj+L8kqLGc
         2WsP7FsC+FXD7+/+hPc+rwmjagufVOoVU1qx/v0o4AkT3zzkEcVg2Z9om865q7W5SR0S
         87550Q8Lj24STdlZN1CS9tiKxDQN3smOv2c2C/zq8gLbJ0dM+iZYV2h9duzksFN1vPxG
         HkB5eaUULqQ+kwkku9PACV+mWb09fF13fKYupN5vBmfyATqMBNgeQIdR2z+rOjKG8JEa
         Qb/g==
X-Received: by 10.68.167.132 with SMTP id zo4mr4580158pbb.129.1378317399068;
        Wed, 04 Sep 2013 10:56:39 -0700 (PDT)
Received: from localhost ([115.115.74.130])
        by mx.google.com with ESMTPSA id fk4sm32189997pab.23.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 04 Sep 2013 10:56:37 -0700 (PDT)
From:   Prem Mallappa <prem.mallappa@gmail.com>
To:     linux-mips <linux-mips@linux-mips.org>
Cc:     Prem Mallappa <pmallappa@caviumnetworks.com>
Subject: [PATCH v2 2/2] MIPS: KEXEC: Fixes Random crashes while loading crashkernel
Date:   Wed,  4 Sep 2013 23:26:24 +0530
Message-Id: <1378317384-9923-1-git-send-email-pmallappa@caviumnetworks.com>
X-Mailer: git-send-email 1.8.4
Return-Path: <prem.mallappa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37757
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

Fixed compilation errors in case of non-KEXEC kernel
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
index c7f9051..c538d6e 100644
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
@@ -608,6 +654,8 @@ static void __init arch_mem_init(char **cmdline_p)
 				BOOTMEM_DEFAULT);
 	}
 #endif
+
+	mips_parse_crashkernel();
 #ifdef CONFIG_KEXEC
 	if (crashk_res.start != crashk_res.end)
 		reserve_bootmem(crashk_res.start,
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
