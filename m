Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Dec 2016 03:11:33 +0100 (CET)
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35835 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992844AbcLSCIHhWmfK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Dec 2016 03:08:07 +0100
Received: by mail-lf0-f65.google.com with SMTP id p100so6143987lfg.2;
        Sun, 18 Dec 2016 18:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0pprW2ggFQghEokrbOvTk6VvmgCmi68QgSVnurj1mYo=;
        b=DYJBRhIFk15fQrN8wWLdv7uIi42zRrD8OOfnqaQ0lRKPAY4jFhgQ0HIjHBURmHVaS/
         xG+BRutA+Ogv0bFocvJ9xHSNuiPDVNJe5+ZQTtfwW4GUiPovWbk4e2Cd461OwdqwNi90
         iJq3H6tO6Re0tRRqeVj6ua442ElfAcOZM1CMpaApPJO2YIPdyH/K33yLsUALU7SbbjBF
         +ViR7QUnTV8190DAQDEjx05Xe2JDTUYv1fnSo7yjrDvMXnqimEIOUOEOyeok3KSGccSy
         PuVnNtvSyM4sMNfF/C8iG60/pg1bddYRzH6na3ayBrWc9XF562Zko+sYNjL91W6WlNm4
         BXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0pprW2ggFQghEokrbOvTk6VvmgCmi68QgSVnurj1mYo=;
        b=JCCms+GTu50dG2hyJfTa0DYawSWbdG1JYJWlHcmO+ILW2+T1pcygN13qEemQMYlUoH
         IDV8mCLszii5Tp32+Q4csswLjnw+AvXQE2cwR/i46Bn0ie9046dEs/V+7cKhjLIbYIuY
         0ddAa8GAH2F+3cqdbOortnenhAZTPXzHfY/P1MRfT9OT/BVITWIf46PU5Jsxof96OI8x
         SbATEmISNAfcq9n6T8HvazIGsm9gD4wHs0xsLHrwTWuItHg+qJorJ9ZuH6G38O6UZ09M
         lJiUYp4pK4SVH5jeJi6lryvgQCOEKQZq5zQySqi7hHayM9TdytRyL4pg08wqrASOC7WM
         zS2w==
X-Gm-Message-State: AIkVDXIt4FKL1RdSUdq21+Gz746NnxhnkWysh7qKb/EZHN99UIDh7hPQdZMHwWFrqC1bAw==
X-Received: by 10.46.70.26 with SMTP id t26mr3684987lja.33.1482113282129;
        Sun, 18 Dec 2016 18:08:02 -0800 (PST)
Received: from linux.local ([95.79.144.28])
        by smtp.gmail.com with ESMTPSA id 9sm3362103ljn.20.2016.12.18.18.08.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Dec 2016 18:08:01 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     ralf@linux-mips.org, paul.burton@imgtec.com, rabinv@axis.com,
        matt.redfearn@imgtec.com, james.hogan@imgtec.com,
        alexander.sverdlin@nokia.com, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     Sergey.Semin@t-platforms.ru, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 08/21] MIPS memblock: Move kernel parameters parser into individual method
Date:   Mon, 19 Dec 2016 05:07:33 +0300
Message-Id: <1482113266-13207-9-git-send-email-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
References: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56071
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

Main memory initialization method looks messy with cmd line parser
built-in. So it's better for readability to put it into a separated
method.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 87 ++++++++++++++++--------------
 1 file changed, 48 insertions(+), 39 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 52205fb..9c1a60d 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -231,6 +231,51 @@ static void __init print_memory_map(void)
 }
 
 /*
+ * Parse passed cmdline
+ */
+#define USE_PROM_CMDLINE	IS_ENABLED(CONFIG_MIPS_CMDLINE_FROM_BOOTLOADER)
+#define USE_DTB_CMDLINE		IS_ENABLED(CONFIG_MIPS_CMDLINE_FROM_DTB)
+#define EXTEND_WITH_PROM	IS_ENABLED(CONFIG_MIPS_CMDLINE_EXTEND)
+#define BUILTIN_EXTEND_WITH_PROM	\
+	IS_ENABLED(CONFIG_MIPS_CMDLINE_BUILTIN_EXTEND)
+
+static void __init mips_parse_param(char **cmdline_p)
+{
+#if defined(CONFIG_CMDLINE_BOOL) && defined(CONFIG_CMDLINE_OVERRIDE)
+	strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
+#else
+	if ((USE_PROM_CMDLINE && arcs_cmdline[0]) ||
+	    (USE_DTB_CMDLINE && !boot_command_line[0]))
+		strlcpy(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
+
+	if (EXTEND_WITH_PROM && arcs_cmdline[0]) {
+		if (boot_command_line[0])
+			strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
+		strlcat(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
+	}
+
+#if defined(CONFIG_CMDLINE_BOOL)
+	if (builtin_cmdline[0]) {
+		if (boot_command_line[0])
+			strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
+		strlcat(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
+	}
+
+	if (BUILTIN_EXTEND_WITH_PROM && arcs_cmdline[0]) {
+		if (boot_command_line[0])
+			strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
+		strlcat(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
+	}
+#endif
+#endif
+	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
+
+	*cmdline_p = command_line;
+
+	parse_early_param();
+}
+
+/*
  * Parse "mem=size@start" parameter rewriting a defined memory map
  * We look for mem=size@start, where start and size are "value[KkMm]"
  */
@@ -790,12 +835,6 @@ static void __init arch_mem_addpart(phys_addr_t mem, phys_addr_t end, int type)
 	add_memory_region(mem, size, type);
 }
 
-#define USE_PROM_CMDLINE	IS_ENABLED(CONFIG_MIPS_CMDLINE_FROM_BOOTLOADER)
-#define USE_DTB_CMDLINE		IS_ENABLED(CONFIG_MIPS_CMDLINE_FROM_DTB)
-#define EXTEND_WITH_PROM	IS_ENABLED(CONFIG_MIPS_CMDLINE_DTB_EXTEND)
-#define BUILTIN_EXTEND_WITH_PROM	\
-	IS_ENABLED(CONFIG_MIPS_CMDLINE_BUILTIN_EXTEND)
-
 static void __init arch_mem_init(char **cmdline_p)
 {
 	struct memblock_region *reg;
@@ -804,6 +843,9 @@ static void __init arch_mem_init(char **cmdline_p)
 	/* call board setup routine */
 	plat_mem_setup();
 
+	/* Parse passed parameters */
+	mips_parse_param(cmdline_p);
+
 	/*
 	 * Make sure all kernel memory is in the maps.  The "UP" and
 	 * "DOWN" are opposite for initdata since if it crosses over
@@ -820,39 +862,6 @@ static void __init arch_mem_init(char **cmdline_p)
 	pr_info("Determined physical RAM map:\n");
 	print_memory_map();
 
-#if defined(CONFIG_CMDLINE_BOOL) && defined(CONFIG_CMDLINE_OVERRIDE)
-	strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
-#else
-	if ((USE_PROM_CMDLINE && arcs_cmdline[0]) ||
-	    (USE_DTB_CMDLINE && !boot_command_line[0]))
-		strlcpy(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
-
-	if (EXTEND_WITH_PROM && arcs_cmdline[0]) {
-		if (boot_command_line[0])
-			strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
-		strlcat(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
-	}
-
-#if defined(CONFIG_CMDLINE_BOOL)
-	if (builtin_cmdline[0]) {
-		if (boot_command_line[0])
-			strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
-		strlcat(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
-	}
-
-	if (BUILTIN_EXTEND_WITH_PROM && arcs_cmdline[0]) {
-		if (boot_command_line[0])
-			strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
-		strlcat(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
-	}
-#endif
-#endif
-	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
-
-	*cmdline_p = command_line;
-
-	parse_early_param();
-
 	bootmem_init();
 
 	device_tree_init();
-- 
2.6.6
