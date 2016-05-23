Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 May 2016 17:14:13 +0200 (CEST)
Received: from demumfd001.nsn-inter.net ([93.183.12.32]:55539 "EHLO
        demumfd001.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27030105AbcEWPOMXk0bu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 May 2016 17:14:12 +0200
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55])
        by demumfd001.nsn-inter.net (8.15.2/8.15.2) with ESMTPS id u4NFE6It023820
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 23 May 2016 15:14:06 GMT
Received: from localhost.localdomain ([10.144.47.5])
        by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id u4NFE5eD025960;
        Mon, 23 May 2016 17:14:05 +0200
From:   Aaro Koskinen <aaro.koskinen@nokia.com>
To:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     Sivasubramanian Palanisamy <sivasubramanian.palanisamy@nokia.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH] MIPS: OCTEON: use bootloader provided value for max memory
Date:   Mon, 23 May 2016 18:11:59 +0300
Message-Id: <1464016319-5266-1-git-send-email-aaro.koskinen@nokia.com>
X-Mailer: git-send-email 2.8.0
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 1026
X-purgate-ID: 151667::1464016446-00001B3D-6C60F2D3/0/0
Return-Path: <aaro.koskinen@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53612
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

From: Sivasubramanian Palanisamy <sivasubramanian.palanisamy@nokia.com>

Currently the maximum memory on OCTEON boards is limited to 512 MB unless
user passes the mem= parameter. Use bootloader provided value for max
memory instead of the hardcoded default limit.

Signed-off-by: Sivasubramanian Palanisamy <sivasubramanian.palanisamy@nokia.com>
Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/mips/cavium-octeon/setup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index cd7101f..ef9705d 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -800,6 +800,8 @@ void __init prom_init(void)
 	/* Default to 64MB in the simulator to speed things up */
 	if (octeon_is_simulation())
 		MAX_MEMORY = 64ull << 20;
+	else if (octeon_bootinfo->dram_size)
+		MAX_MEMORY = octeon_bootinfo->dram_size * 1024ull * 1024ull;
 
 	arg = strstr(arcs_cmdline, "mem=");
 	if (arg) {
-- 
2.8.0
