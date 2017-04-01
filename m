Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Apr 2017 15:23:38 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:45992 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990778AbdDANWjHzSQ- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 1 Apr 2017 15:22:39 +0200
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1cuIzF-00042R-1W; Sat, 01 Apr 2017 14:22:37 +0100
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1cuIzE-0004et-4C; Sat, 01 Apr 2017 14:22:36 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Arnd Bergmann" <arnd@arndb.de>,
        linux-mips@linux-mips.org, "John Crispin" <john@phrozen.org>,
        "Ralf Baechle" <ralf@linux-mips.org>
Date:   Sat, 01 Apr 2017 14:17:50 +0100
Message-ID: <lsq.1491052670.982828511@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 13/19] MIPS: ralink: Cosmetic change to prom_init().
In-Reply-To: <lsq.1491052670.319419763@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57521
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.43-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: John Crispin <john@phrozen.org>

commit 9c48568b3692f1a56cbf1935e4eea835e6b185b1 upstream.

Over the years the code has been changed various times leading to
argc/argv being defined in a different function to where we actually
use the variables. Clean this up by moving them to prom_init_cmdline().

Signed-off-by: John Crispin <john@phrozen.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14902/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/ralink/prom.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

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
@@ -54,14 +56,11 @@ static __init void prom_init_cmdline(int
 
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
