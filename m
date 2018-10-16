Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Oct 2018 19:15:52 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:48832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994649AbeJPRPoWGDnN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Oct 2018 19:15:44 +0200
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 199D62089E;
        Tue, 16 Oct 2018 17:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710136;
        bh=wmPdhtzpAGAX/GabuZk1t53+G79BPXWMX8QiR5XZ2xw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OrrB23bS4G5YJQpP9H3ZFBgn1mBiKtvbIyr7wDQ1k8NXsHun85ayvN1hYDgfute4X
         EoXL+ywEY+77AmDxiwMd4KQ8kTmz6DCNfH8nMMJ/0hhnbiBK7LHpBBStS09xOsFRuZ
         kg6aZjKRiReAKsVeZ8T75FDJql7q5rljmbG8oEsY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Jaedon Shin <jaedon.shin@gmail.com>,
        Mathieu Malaterre <malat@debian.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH 4.18 113/135] MIPS: Fix CONFIG_CMDLINE handling
Date:   Tue, 16 Oct 2018 19:05:43 +0200
Message-Id: <20181016170523.124003229@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <SRS0=yPgj=M4=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66875
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@mips.com>

commit 951d223c6c16ed5d2a71a4d1f13c1e65d6882156 upstream.

Commit 8ce355cf2e38 ("MIPS: Setup boot_command_line before
plat_mem_setup") fixed a problem for systems which have
CONFIG_CMDLINE_BOOL=y & use a DT with a chosen node that has either no
bootargs property or an empty one. In this configuration
early_init_dt_scan_chosen() copies CONFIG_CMDLINE into
boot_command_line, but the MIPS code doesn't know this so it appends
CONFIG_CMDLINE (via builtin_cmdline) to boot_command_line again. The
result is that boot_command_line contains the arguments from
CONFIG_CMDLINE twice.

That commit took the approach of simply setting up boot_command_line
from the MIPS code before early_init_dt_scan_chosen() runs, causing it
not to copy CONFIG_CMDLINE to boot_command_line if a chosen node with no
bootargs property is found.

Unfortunately this is problematic for systems which do have a non-empty
bootargs property & CONFIG_CMDLINE_BOOL=y. There
early_init_dt_scan_chosen() will overwrite boot_command_line with the
arguments from DT, which means we lose those from CONFIG_CMDLINE
entirely. This breaks CONFIG_MIPS_CMDLINE_DTB_EXTEND. If we have
CONFIG_MIPS_CMDLINE_FROM_BOOTLOADER or
CONFIG_MIPS_CMDLINE_BUILTIN_EXTEND selected and the DT has a bootargs
property which we should ignore, it will instead be honoured breaking
those configurations too.

Fix this by reverting commit 8ce355cf2e38 ("MIPS: Setup
boot_command_line before plat_mem_setup") to restore the former
behaviour, and fixing the CONFIG_CMDLINE duplication issue by
initializing boot_command_line to a non-empty string that
early_init_dt_scan_chosen() will not overwrite with CONFIG_CMDLINE.

This is a little ugly, but cleanup in this area is on its way. In the
meantime this is at least easy to backport & contains the ugliness
within arch/mips/.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: 8ce355cf2e38 ("MIPS: Setup boot_command_line before plat_mem_setup")
References: https://patchwork.linux-mips.org/patch/18804/
Patchwork: https://patchwork.linux-mips.org/patch/20813/
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Jaedon Shin <jaedon.shin@gmail.com>
Cc: Mathieu Malaterre <malat@debian.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org # v4.16+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/setup.c |   48 +++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -835,6 +835,34 @@ static void __init arch_mem_init(char **
 	struct memblock_region *reg;
 	extern void plat_mem_setup(void);
 
+	/*
+	 * Initialize boot_command_line to an innocuous but non-empty string in
+	 * order to prevent early_init_dt_scan_chosen() from copying
+	 * CONFIG_CMDLINE into it without our knowledge. We handle
+	 * CONFIG_CMDLINE ourselves below & don't want to duplicate its
+	 * content because repeating arguments can be problematic.
+	 */
+	strlcpy(boot_command_line, " ", COMMAND_LINE_SIZE);
+
+	/* call board setup routine */
+	plat_mem_setup();
+
+	/*
+	 * Make sure all kernel memory is in the maps.  The "UP" and
+	 * "DOWN" are opposite for initdata since if it crosses over
+	 * into another memory section you don't want that to be
+	 * freed when the initdata is freed.
+	 */
+	arch_mem_addpart(PFN_DOWN(__pa_symbol(&_text)) << PAGE_SHIFT,
+			 PFN_UP(__pa_symbol(&_edata)) << PAGE_SHIFT,
+			 BOOT_MEM_RAM);
+	arch_mem_addpart(PFN_UP(__pa_symbol(&__init_begin)) << PAGE_SHIFT,
+			 PFN_DOWN(__pa_symbol(&__init_end)) << PAGE_SHIFT,
+			 BOOT_MEM_INIT_RAM);
+
+	pr_info("Determined physical RAM map:\n");
+	print_memory_map();
+
 #if defined(CONFIG_CMDLINE_BOOL) && defined(CONFIG_CMDLINE_OVERRIDE)
 	strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
 #else
@@ -862,26 +890,6 @@ static void __init arch_mem_init(char **
 	}
 #endif
 #endif
-
-	/* call board setup routine */
-	plat_mem_setup();
-
-	/*
-	 * Make sure all kernel memory is in the maps.  The "UP" and
-	 * "DOWN" are opposite for initdata since if it crosses over
-	 * into another memory section you don't want that to be
-	 * freed when the initdata is freed.
-	 */
-	arch_mem_addpart(PFN_DOWN(__pa_symbol(&_text)) << PAGE_SHIFT,
-			 PFN_UP(__pa_symbol(&_edata)) << PAGE_SHIFT,
-			 BOOT_MEM_RAM);
-	arch_mem_addpart(PFN_UP(__pa_symbol(&__init_begin)) << PAGE_SHIFT,
-			 PFN_DOWN(__pa_symbol(&__init_end)) << PAGE_SHIFT,
-			 BOOT_MEM_INIT_RAM);
-
-	pr_info("Determined physical RAM map:\n");
-	print_memory_map();
-
 	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
 
 	*cmdline_p = command_line;
