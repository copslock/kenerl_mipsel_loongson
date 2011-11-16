Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2011 14:32:10 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:47428 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903820Ab1KPN3M (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 16 Nov 2011 14:29:12 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>,
        Thomas Langer <thomas.langer@lantiq.com>
Subject: [PATCH V2 2/6] MIPS: lantiq: fix cmdline parsing
Date:   Wed, 16 Nov 2011 15:28:38 +0100
Message-Id: <1321453722-2689-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1321453722-2689-1-git-send-email-blogic@openwrt.org>
References: <1321453722-2689-1-git-send-email-blogic@openwrt.org>
X-archive-position: 31665
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13398

The code tested if the KSEG1 mapped address of argv was != 0. We need to use
CPHYSADDR instead to make the conditional actually work.

Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/prom.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index e3b1e25..acb8921 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -49,10 +49,12 @@ static void __init prom_init_cmdline(void)
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
1.7.7.1
