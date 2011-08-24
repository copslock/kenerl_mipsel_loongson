Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Aug 2011 10:30:59 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:53095 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493617Ab1HXIaC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Aug 2011 10:30:02 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        Thomas Langer <thomas.langer@lantiq.com>,
        linux-mips@linux-mips.org
Subject: [PATCH 2/8] MIPS: lantiq: fix cmdline parsing
Date:   Wed, 24 Aug 2011 10:31:38 +0200
Message-Id: <1314174704-15549-3-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1314174704-15549-1-git-send-email-blogic@openwrt.org>
References: <1314174704-15549-1-git-send-email-blogic@openwrt.org>
X-archive-position: 30967
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17644

The code tested if the KSEG1 mapped address of argv was != 0. We need to use
CPHYSADDR instead to make the conditional actually work.

Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/lantiq/prom.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index 56ba007..5035c10 100644
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
1.7.2.3
