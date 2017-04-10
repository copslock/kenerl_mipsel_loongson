Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Apr 2017 17:34:49 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:45930 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993909AbdDJPdwj84aY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Apr 2017 17:33:52 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 77827AAB1;
        Mon, 10 Apr 2017 15:33:52 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, John Crispin <john@phrozen.org>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3.12 011/142] MIPS: ralink: Cosmetic change to prom_init().
Date:   Mon, 10 Apr 2017 17:31:32 +0200
Message-Id: <8c585d84626e76930725689a5e198c4d19220c4e.1491838390.git.jslaby@suse.cz>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <d4b83d12d815bafc24064e91de353edb2478d8f7.1491838390.git.jslaby@suse.cz>
References: <d4b83d12d815bafc24064e91de353edb2478d8f7.1491838390.git.jslaby@suse.cz>
In-Reply-To: <cover.1491838390.git.jslaby@suse.cz>
References: <cover.1491838390.git.jslaby@suse.cz>
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57637
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

From: John Crispin <john@phrozen.org>

3.12-stable review patch.  If anyone has any objections, please let me know.

===============

commit 9c48568b3692f1a56cbf1935e4eea835e6b185b1 upstream.

Over the years the code has been changed various times leading to
argc/argv being defined in a different function to where we actually
use the variables. Clean this up by moving them to prom_init_cmdline().

Signed-off-by: John Crispin <john@phrozen.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14902/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/ralink/prom.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/mips/ralink/prom.c b/arch/mips/ralink/prom.c
index 9c64f029d047..87312dfcee38 100644
--- a/arch/mips/ralink/prom.c
+++ b/arch/mips/ralink/prom.c
@@ -24,8 +24,10 @@ const char *get_system_type(void)
 	return soc_info.sys_type;
 }
 
-static __init void prom_init_cmdline(int argc, char **argv)
+static __init void prom_init_cmdline(void)
 {
+	int argc;
+	char **argv;
 	int i;
 
 	pr_debug("prom: fw_arg0=%08x fw_arg1=%08x fw_arg2=%08x fw_arg3=%08x\n",
@@ -54,14 +56,11 @@ static __init void prom_init_cmdline(int argc, char **argv)
 
 void __init prom_init(void)
 {
-	int argc;
-	char **argv;
-
 	prom_soc_init(&soc_info);
 
 	pr_info("SoC Type: %s\n", get_system_type());
 
-	prom_init_cmdline(argc, argv);
+	prom_init_cmdline();
 }
 
 void __init prom_free_prom_memory(void)
-- 
2.12.2
