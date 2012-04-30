Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Apr 2012 13:51:35 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:53154 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903711Ab2D3LuW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Apr 2012 13:50:22 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Thomas Langer <thomas.langer@lantiq.com>
Subject: [PATCH 12/14] MIPS: lantiq: fix cmdline parsing
Date:   Mon, 30 Apr 2012 13:33:07 +0200
Message-Id: <1335785589-32532-12-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1335785589-32532-1-git-send-email-blogic@openwrt.org>
References: <1335785589-32532-1-git-send-email-blogic@openwrt.org>
X-archive-position: 33094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

The code tested if the KSEG1 mapped address of argv was != 0. We need to use
CPHYSADDR instead to make the conditional actually work.

Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/prom.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index 664b7b7..cd56892 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -45,10 +45,12 @@ static void __init prom_init_cmdline(void)
 	char **argv = (char **) KSEG1ADDR(fw_arg1);
 	int i;
 
+	arcs_cmdline[0] = '\0';
+
 	for (i = 0; i < argc; i++) {
-		char *p = (char *)  KSEG1ADDR(argv[i]);
+		char *p = (char *) KSEG1ADDR(argv[i]);
 
-		if (p && *p) {
+		if (CPHYSADDR(p) && *p) {
 			strlcat(arcs_cmdline, p, sizeof(arcs_cmdline));
 			strlcat(arcs_cmdline, " ", sizeof(arcs_cmdline));
 		}
-- 
1.7.9.1
