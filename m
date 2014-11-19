Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Nov 2014 22:53:17 +0100 (CET)
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:52857 "EHLO
        filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014055AbaKSVw620RGx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Nov 2014 22:52:58 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri1.pp.htv.fi (Postfix) with ESMTP id 03AFD21BA68;
        Wed, 19 Nov 2014 23:52:58 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
        with ESMTP id SxZzilf4ibFZ; Wed, 19 Nov 2014 23:52:51 +0200 (EET)
Received: from amd-fx-6350.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp5.welho.com (Postfix) with ESMTP id 6CF0C5BC007;
        Wed, 19 Nov 2014 23:52:51 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 1/7] MIPS: loongson: common: fix array initializer syntax
Date:   Wed, 19 Nov 2014 23:52:45 +0200
Message-Id: <1416433971-18604-2-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.1.2
In-Reply-To: <1416433971-18604-1-git-send-email-aaro.koskinen@iki.fi>
References: <1416433971-18604-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44303
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Fix array initializer syntax to get rid of the following sparse warnings:
"obsolete array initializer, use C99 syntax".

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/loongson/common/cs5536/cs5536_pci.c | 24 ++++++++++++------------
 arch/mips/loongson/common/machtype.c          | 26 +++++++++++++-------------
 arch/mips/loongson/common/serial.c            | 26 +++++++++++++-------------
 3 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/arch/mips/loongson/common/cs5536/cs5536_pci.c b/arch/mips/loongson/common/cs5536/cs5536_pci.c
index 81bed9d..ee78d9e 100644
--- a/arch/mips/loongson/common/cs5536/cs5536_pci.c
+++ b/arch/mips/loongson/common/cs5536/cs5536_pci.c
@@ -35,21 +35,21 @@ enum {
 };
 
 static const cs5536_pci_vsm_write vsm_conf_write[] = {
-	[CS5536_ISA_FUNC]	pci_isa_write_reg,
-	[reserved_func]		NULL,
-	[CS5536_IDE_FUNC]	pci_ide_write_reg,
-	[CS5536_ACC_FUNC]	pci_acc_write_reg,
-	[CS5536_OHCI_FUNC]	pci_ohci_write_reg,
-	[CS5536_EHCI_FUNC]	pci_ehci_write_reg,
+	[CS5536_ISA_FUNC]	= pci_isa_write_reg,
+	[reserved_func]		= NULL,
+	[CS5536_IDE_FUNC]	= pci_ide_write_reg,
+	[CS5536_ACC_FUNC]	= pci_acc_write_reg,
+	[CS5536_OHCI_FUNC]	= pci_ohci_write_reg,
+	[CS5536_EHCI_FUNC]	= pci_ehci_write_reg,
 };
 
 static const cs5536_pci_vsm_read vsm_conf_read[] = {
-	[CS5536_ISA_FUNC]	pci_isa_read_reg,
-	[reserved_func]		NULL,
-	[CS5536_IDE_FUNC]	pci_ide_read_reg,
-	[CS5536_ACC_FUNC]	pci_acc_read_reg,
-	[CS5536_OHCI_FUNC]	pci_ohci_read_reg,
-	[CS5536_EHCI_FUNC]	pci_ehci_read_reg,
+	[CS5536_ISA_FUNC]	= pci_isa_read_reg,
+	[reserved_func]		= NULL,
+	[CS5536_IDE_FUNC]	= pci_ide_read_reg,
+	[CS5536_ACC_FUNC]	= pci_acc_read_reg,
+	[CS5536_OHCI_FUNC]	= pci_ohci_read_reg,
+	[CS5536_EHCI_FUNC]	= pci_ehci_read_reg,
 };
 
 /*
diff --git a/arch/mips/loongson/common/machtype.c b/arch/mips/loongson/common/machtype.c
index 1a47979..03d80bb 100644
--- a/arch/mips/loongson/common/machtype.c
+++ b/arch/mips/loongson/common/machtype.c
@@ -19,19 +19,19 @@
 #define MACHTYPE_LEN 50
 
 static const char *system_types[] = {
-	[MACH_LOONGSON_UNKNOWN]		"unknown loongson machine",
-	[MACH_LEMOTE_FL2E]		"lemote-fuloong-2e-box",
-	[MACH_LEMOTE_FL2F]		"lemote-fuloong-2f-box",
-	[MACH_LEMOTE_ML2F7]		"lemote-mengloong-2f-7inches",
-	[MACH_LEMOTE_YL2F89]		"lemote-yeeloong-2f-8.9inches",
-	[MACH_DEXXON_GDIUM2F10]		"dexxon-gdium-2f",
-	[MACH_LEMOTE_NAS]		"lemote-nas-2f",
-	[MACH_LEMOTE_LL2F]		"lemote-lynloong-2f",
-	[MACH_LEMOTE_A1004]		"lemote-3a-notebook-a1004",
-	[MACH_LEMOTE_A1101]		"lemote-3a-itx-a1101",
-	[MACH_LEMOTE_A1201]		"lemote-2gq-notebook-a1201",
-	[MACH_LEMOTE_A1205]		"lemote-2gq-aio-a1205",
-	[MACH_LOONGSON_END]		NULL,
+	[MACH_LOONGSON_UNKNOWN]	= "unknown loongson machine",
+	[MACH_LEMOTE_FL2E]	= "lemote-fuloong-2e-box",
+	[MACH_LEMOTE_FL2F]	= "lemote-fuloong-2f-box",
+	[MACH_LEMOTE_ML2F7]	= "lemote-mengloong-2f-7inches",
+	[MACH_LEMOTE_YL2F89]	= "lemote-yeeloong-2f-8.9inches",
+	[MACH_DEXXON_GDIUM2F10]	= "dexxon-gdium-2f",
+	[MACH_LEMOTE_NAS]	= "lemote-nas-2f",
+	[MACH_LEMOTE_LL2F]	= "lemote-lynloong-2f",
+	[MACH_LEMOTE_A1004]	= "lemote-3a-notebook-a1004",
+	[MACH_LEMOTE_A1101]	= "lemote-3a-itx-a1101",
+	[MACH_LEMOTE_A1201]	= "lemote-2gq-notebook-a1201",
+	[MACH_LEMOTE_A1205]	= "lemote-2gq-aio-a1205",
+	[MACH_LOONGSON_END]	= NULL,
 };
 
 const char *get_system_type(void)
diff --git a/arch/mips/loongson/common/serial.c b/arch/mips/loongson/common/serial.c
index bd2b709..7b4a5ab 100644
--- a/arch/mips/loongson/common/serial.c
+++ b/arch/mips/loongson/common/serial.c
@@ -39,19 +39,19 @@
 }
 
 static struct plat_serial8250_port uart8250_data[][2] = {
-	[MACH_LOONGSON_UNKNOWN]		{},
-	[MACH_LEMOTE_FL2E]              {PORT(4, 1843200), {} },
-	[MACH_LEMOTE_FL2F]              {PORT(3, 1843200), {} },
-	[MACH_LEMOTE_ML2F7]             {PORT_M(3, 3686400), {} },
-	[MACH_LEMOTE_YL2F89]            {PORT_M(3, 3686400), {} },
-	[MACH_DEXXON_GDIUM2F10]         {PORT_M(3, 3686400), {} },
-	[MACH_LEMOTE_NAS]               {PORT_M(3, 3686400), {} },
-	[MACH_LEMOTE_LL2F]              {PORT(3, 1843200), {} },
-	[MACH_LEMOTE_A1004]             {PORT_M(2, 33177600), {} },
-	[MACH_LEMOTE_A1101]             {PORT_M(2, 25000000), {} },
-	[MACH_LEMOTE_A1201]             {PORT_M(2, 25000000), {} },
-	[MACH_LEMOTE_A1205]             {PORT_M(2, 25000000), {} },
-	[MACH_LOONGSON_END]		{},
+	[MACH_LOONGSON_UNKNOWN]	= {},
+	[MACH_LEMOTE_FL2E]	= {PORT(4, 1843200), {} },
+	[MACH_LEMOTE_FL2F]	= {PORT(3, 1843200), {} },
+	[MACH_LEMOTE_ML2F7]	= {PORT_M(3, 3686400), {} },
+	[MACH_LEMOTE_YL2F89]	= {PORT_M(3, 3686400), {} },
+	[MACH_DEXXON_GDIUM2F10] = {PORT_M(3, 3686400), {} },
+	[MACH_LEMOTE_NAS]	= {PORT_M(3, 3686400), {} },
+	[MACH_LEMOTE_LL2F]	= {PORT(3, 1843200), {} },
+	[MACH_LEMOTE_A1004]	= {PORT_M(2, 33177600), {} },
+	[MACH_LEMOTE_A1101]	= {PORT_M(2, 25000000), {} },
+	[MACH_LEMOTE_A1201]	= {PORT_M(2, 25000000), {} },
+	[MACH_LEMOTE_A1205]	= {PORT_M(2, 25000000), {} },
+	[MACH_LOONGSON_END]	= {},
 };
 
 static struct platform_device uart8250_device = {
-- 
2.1.2
