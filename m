Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 May 2012 14:32:28 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:48075 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903760Ab2EBM30 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 May 2012 14:29:26 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Thomas Langer <thomas.langer@lantiq.com>,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 12/14] MIPS: lantiq: fix cmdline parsing
Date:   Wed,  2 May 2012 14:27:39 +0200
Message-Id: <1335961659-21358-8-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1335961659-21358-1-git-send-email-blogic@openwrt.org>
References: <1335961659-21358-1-git-send-email-blogic@openwrt.org>
X-archive-position: 33122
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Thomas Langer <thomas.langer@lantiq.com>

The code tested if the KSEG1 mapped address of argv was != 0. We need to use
CPHYSADDR instead to make the conditional actually work.

Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
Signed-off-by: John Crispin <blogic@openwrt.org>
---
Changes in V2
* set Author to Thomas

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
