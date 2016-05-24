Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2016 16:12:08 +0200 (CEST)
Received: from demumfd001.nsn-inter.net ([93.183.12.32]:54946 "EHLO
        demumfd001.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27033277AbcEXOLpA-Ed6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 May 2016 16:11:45 +0200
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55])
        by demumfd001.nsn-inter.net (8.15.2/8.15.2) with ESMTPS id u4OEBcto032179
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 24 May 2016 14:11:39 GMT
Received: from localhost.localdomain ([10.144.47.5])
        by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id u4OEBaNM031508;
        Tue, 24 May 2016 16:11:36 +0200
From:   Aaro Koskinen <aaro.koskinen@nokia.com>
To:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     Sivasubramanian Palanisamy <sivasubramanian.palanisamy@nokia.com>
Subject: [PATCH 1/2] MIPS: OCTEON: take all memory into use by default
Date:   Tue, 24 May 2016 17:09:30 +0300
Message-Id: <1464098971-9362-1-git-send-email-aaro.koskinen@nokia.com>
X-Mailer: git-send-email 2.8.0
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 815
X-purgate-ID: 151667::1464099099-00001B3D-01AE68D3/0/0
Return-Path: <aaro.koskinen@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53640
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@nokia.com
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

Take all memory into use by default, instead of limiting to 512 MB.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---

	This supersedes this patch: http://marc.info/?t=146401648900005&r=1&w=2

 arch/mips/cavium-octeon/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index cd7101f..53c1234 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -49,7 +49,7 @@ extern struct plat_smp_ops octeon_smp_ops;
 extern void pci_console_init(const char *arg);
 #endif
 
-static unsigned long long MAX_MEMORY = 512ull << 20;
+static unsigned long long MAX_MEMORY = ULLONG_MAX;
 
 DEFINE_SEMAPHORE(octeon_bootbus_sem);
 EXPORT_SYMBOL(octeon_bootbus_sem);
-- 
2.8.0
