Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Mar 2018 04:00:09 +0100 (CET)
Received: from mail-pf0-x241.google.com ([IPv6:2607:f8b0:400e:c00::241]:45338
        "EHLO mail-pf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994554AbeCPDACX6me8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Mar 2018 04:00:02 +0100
Received: by mail-pf0-x241.google.com with SMTP id h19so3633026pfd.12;
        Thu, 15 Mar 2018 20:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5xgQ3AZfC+567uVL3cPPtOw7CZt7vJNjaYz8uUOk9Gk=;
        b=Iqe8c7tmdFNAvDS4tLi7m4Is9PlhDiDxxUhR5drpN0fcSyQuNstGwmo03Gw50VQ8ki
         PG90IGudgA6aAAexwWErlPwat6FvOzy2buFT/OGjzTo2a9+SkRYcpyzJilyO6KAxNmRL
         KwWGV3G3LMiUEX8GmkV3/I/qm2AhIDn4EX66Mohc90vUk38Cex3DwCluHGZmGK34Dzhy
         6sDrohGM57hgwoP9Lxug+MxGtcYKia9u1K80guI4GiCAyoqov+QkTLv9eXH4gNYA8Lok
         BcwwZPtyJ9JFYPmEFIll65rjUFkIwLIVuH/CvYZ5yL63nKbW5VlXFLnihSR89oAUJG1K
         fPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5xgQ3AZfC+567uVL3cPPtOw7CZt7vJNjaYz8uUOk9Gk=;
        b=ee9jSxzGIzBF2N/HebKuCoKigeAZx7Us/cgaT+C1xLfLh6yBbWYn45IZMWuO0PJ90e
         Um/xE0YURLr5pHZeA8AgeV8R/Fcuz/rwrtIcCs2Spzy/zNgaPwTQZ1XcPdEHImKdg36v
         ZYgd4kPEFnH1Ls6b102kWei5Ye5UCmau3ZMmmYaSOCLUDunTP6T6fvqUw5sD2O0Q5LAR
         RY1Z6CdHkvAmozL8I0uQ0SFVBkkgfXz16QK5V6z9bTMzDNYUa7OTvIAa9o7DyNk36IjU
         nIKGGemyI03yFYstxYNbb0/9XULFzQ8ocnPbhiMo+9penyk7opEXUfHfw0Yr2uv3lRwT
         dhhg==
X-Gm-Message-State: AElRT7E4UDBd5rT7fnOdEBkziZAeCiCcMX6fYGtHedxwip5g6H6ySLBC
        WJDoQ2HNplavuroJeOSfP1LseJb2
X-Google-Smtp-Source: AG47ELt/5Qv5/pZUTcfqk1MvT0KdAPiJA/QlSkrdlisCEUVQGTBDw9KhSRGAnKKcSGrKTfzxtEW/VA==
X-Received: by 10.101.92.6 with SMTP id u6mr165976pgr.440.1521169194908;
        Thu, 15 Mar 2018 19:59:54 -0700 (PDT)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id y21sm12119751pfm.31.2018.03.15.19.59.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Mar 2018 19:59:54 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>
Cc:     Mathieu Malaterre <malat@debian.org>, linux-mips@linux-mips.org,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH] MIPS: Fix missing arcs_cmdline
Date:   Fri, 16 Mar 2018 11:59:39 +0900
Message-Id: <20180316025939.5416-1-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.16.2
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62994
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaedon.shin@gmail.com
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

Due to commit 8ce355cf2e38 ("MIPS: Setup boot_command_line before
plat_mem_setup"), the value of arcs_command by prom_init is removed.
boot_command_line is initialized with __dt_setup_arch from
plat_mem_setup, but arcs_command is copied to boot_command_line before
plat_mem_setup by previous commit. This commit recover missing
arcs_command by prom_init.

Fixes: 8ce355cf2e38 ("MIPS: Setup boot_command_line before plat_mem_setup")
Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/kernel/setup.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 5f8b0a9e30b3..e87f468f76dc 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -836,30 +836,12 @@ static void __init arch_mem_init(char **cmdline_p)
 
 #if defined(CONFIG_CMDLINE_BOOL) && defined(CONFIG_CMDLINE_OVERRIDE)
 	strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
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
+#elif defined(CONFIG_CMDLINE_BOOL)
 	if (builtin_cmdline[0]) {
 		if (boot_command_line[0])
 			strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
 		strlcat(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
 	}
-
-	if (BUILTIN_EXTEND_WITH_PROM && arcs_cmdline[0]) {
-		if (boot_command_line[0])
-			strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
-		strlcat(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
-	}
-#endif
 #endif
 
 	/* call board setup routine */
@@ -881,6 +863,22 @@ static void __init arch_mem_init(char **cmdline_p)
 	pr_info("Determined physical RAM map:\n");
 	print_memory_map();
 
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
+	if (BUILTIN_EXTEND_WITH_PROM && arcs_cmdline[0]) {
+		if (boot_command_line[0])
+			strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
+		strlcat(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
+	}
+
 	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
 
 	*cmdline_p = command_line;
-- 
2.16.2
