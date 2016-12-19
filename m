Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Dec 2016 03:09:52 +0100 (CET)
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35823 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992562AbcLSCIC7WS2K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Dec 2016 03:08:02 +0100
Received: by mail-lf0-f65.google.com with SMTP id p100so6143908lfg.2;
        Sun, 18 Dec 2016 18:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DJ+LoA1Msu/dP9d+8cLKleSZtQLAWmKiOUEmaizwHCA=;
        b=SNjenYGAEZR34UwE7zSLDj4BngwWqGTBroofr7DtRmKaOg2SJNSJuTr3Xxn6jqVzju
         1PvaprMweqSzHKpsoRSfXZWzoozk7kNWRH65ixl3LHJep4IsPWsmZRplKuHnQMGwSbHM
         QGZSpZrWT0KdOCWTkk11uo53auMsVepyPRK3p9XL2R6+Jy4udLnqqCuyUzOtY4wS9XPR
         C6AgChj3QZciijYt5+8qBqxIo3MCxhchOP/hXBm+uBBPMefI2drbc3iUNIIG/6hWJ/uG
         4Cs2Uvd4qlG2w0Qm3loaIZ9pJUqZAzxVVDP1/am/zpDMB9i2Y01Vo08PyEJwWVoN3mIi
         XkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DJ+LoA1Msu/dP9d+8cLKleSZtQLAWmKiOUEmaizwHCA=;
        b=fsC39vWOKkLz4EfLvH78PRuRc7tL9zE3VFJlQKVEax3E6AZVia8O9t0MDVbtCCKQ8R
         3UOu/USKIMw/pnX6X8O2fOSyBJTtRnNACxXknRhn391hssBj7wNoVQD5mKak3S/34JHi
         i5ASYwfknKRaXgwT2yLwZQjjzKtxfO+wpTO925F9tr7U5DmyHm9TPQs/rJdwqQNiY70o
         JCXA2mV4y2TvIIa+PQpXQiHFGphJrlUHoceAUXGi/86mhODkSCZ9dHCfps4guuLeBbq4
         H1m0HtYYDCE2qsbf+paEBgY1wFLgSr8AuN06lez6nK0Sf+vF3AJlIV4roHh8x2xsaCOz
         FQhA==
X-Gm-Message-State: AIkVDXLJ3Pk+sEAcWGUbgoE6SsRPHETEJ7ul/S6FQTEAvhdf6CkG8v1dYY5Oy9f/0hMIcw==
X-Received: by 10.46.74.9 with SMTP id x9mr6345877lja.40.1482113277510;
        Sun, 18 Dec 2016 18:07:57 -0800 (PST)
Received: from linux.local ([95.79.144.28])
        by smtp.gmail.com with ESMTPSA id 9sm3362103ljn.20.2016.12.18.18.07.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Dec 2016 18:07:57 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     ralf@linux-mips.org, paul.burton@imgtec.com, rabinv@axis.com,
        matt.redfearn@imgtec.com, james.hogan@imgtec.com,
        alexander.sverdlin@nokia.com, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     Sergey.Semin@t-platforms.ru, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 04/21] MIPS memblock: Alter user-defined memory parameter parser
Date:   Mon, 19 Dec 2016 05:07:29 +0300
Message-Id: <1482113266-13207-5-git-send-email-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
References: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56067
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fancer.lancer@gmail.com
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

Both new memblock and boot_mem_map subsystems need to be fully
cleared before a new memory region is added. So the early parser is
correspondingly modified.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 67 +++++++++++++++++-------------
 1 file changed, 37 insertions(+), 30 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 9da6f8a..789aafe 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -229,6 +229,43 @@ static void __init print_memory_map(void)
 }
 
 /*
+ * Parse "mem=size@start" parameter rewriting a defined memory map
+ * We look for mem=size@start, where start and size are "value[KkMm]"
+ */
+static int __init early_parse_mem(char *p)
+{
+	static int usermem;
+	phys_addr_t start, size;
+
+	start = PHYS_OFFSET;
+	size = memparse(p, &p);
+	if (*p == '@')
+		start = memparse(p + 1, &p);
+
+	/*
+	 * If a user specifies memory size, we blow away any automatically
+	 * generated regions.
+	 */
+	if (usermem == 0) {
+		phys_addr_t ram_start = memblock_start_of_DRAM();
+		phys_addr_t ram_end = memblock_end_of_DRAM() - ram_start;
+
+		pr_notice("Discard memory layout %pa - %pa",
+			  &ram_start, &ram_end);
+
+		memblock_remove(ram_start, ram_end - ram_start);
+		boot_mem_map.nr_map = 0;
+		usermem = 1;
+	}
+	pr_notice("Add userdefined memory region %08zx @ %pa",
+		  (size_t)size, &start);
+
+	add_memory_region(start, size, BOOT_MEM_RAM);
+	return 0;
+}
+early_param("mem", early_parse_mem);
+
+/*
  * Manage initrd
  */
 #ifdef CONFIG_BLK_DEV_INITRD
@@ -613,31 +650,6 @@ static void __init bootmem_init(void)
  * initialization hook for anything else was introduced.
  */
 
-static int usermem __initdata;
-
-static int __init early_parse_mem(char *p)
-{
-	phys_addr_t start, size;
-
-	/*
-	 * If a user specifies memory size, we
-	 * blow away any automatically generated
-	 * size.
-	 */
-	if (usermem == 0) {
-		boot_mem_map.nr_map = 0;
-		usermem = 1;
-	}
-	start = 0;
-	size = memparse(p, &p);
-	if (*p == '@')
-		start = memparse(p + 1, &p);
-
-	add_memory_region(start, size, BOOT_MEM_RAM);
-	return 0;
-}
-early_param("mem", early_parse_mem);
-
 #ifdef CONFIG_PROC_VMCORE
 unsigned long setup_elfcorehdr, setup_elfcorehdr_size;
 static int __init early_parse_elfcorehdr(char *p)
@@ -797,11 +809,6 @@ static void __init arch_mem_init(char **cmdline_p)
 
 	parse_early_param();
 
-	if (usermem) {
-		pr_info("User-defined physical RAM map:\n");
-		print_memory_map();
-	}
-
 	bootmem_init();
 #ifdef CONFIG_PROC_VMCORE
 	if (setup_elfcorehdr && setup_elfcorehdr_size) {
-- 
2.6.6
