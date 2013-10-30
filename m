Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Oct 2013 15:12:03 +0100 (CET)
Received: from demumfd002.nsn-inter.net ([93.183.12.31]:13986 "EHLO
        demumfd002.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823120Ab3J3OLzvQ0C8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Oct 2013 15:11:55 +0100
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55])
        by demumfd002.nsn-inter.net (8.12.11.20060308/8.12.11) with ESMTP id r9UEBeQq032187
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Wed, 30 Oct 2013 15:11:40 +0100
Received: from ak-desktop.emea.nsn-net.net ([10.144.36.74])
        by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id r9UEBc2M025168;
        Wed, 30 Oct 2013 15:11:39 +0100
From:   Aaro Koskinen <aaro.koskinen@nsn.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Aaro Koskinen <aaro.koskinen@nsn.com>
Subject: [PATCH] MIPS: cavium-octeon: fix early boot hang on EBH5600 board
Date:   Wed, 30 Oct 2013 16:08:07 +0200
Message-Id: <1383142087-25995-1-git-send-email-aaro.koskinen@nsn.com>
X-Mailer: git-send-email 1.8.4.rc3
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 1201
X-purgate-ID: 151667::1383142301-00005753-5C02A745/0-0/0-0
Return-Path: <aaro.koskinen@nsn.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38413
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@nsn.com
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

The boot hangs early on EBH5600 board when octeon_fdt_pip_iface() is
trying enumerate a non-existant interface. We can avoid this situation
by first checking that the interface exists in the DTB.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nsn.com>
---
 arch/mips/cavium-octeon/octeon-platform.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 1830874..f68c75a 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -336,14 +336,14 @@ static void __init octeon_fdt_pip_iface(int pip, int idx, u64 *pmac)
 	int p;
 	int count = 0;
 
-	if (cvmx_helper_interface_enumerate(idx) == 0)
-		count = cvmx_helper_ports_on_interface(idx);
-
 	snprintf(name_buffer, sizeof(name_buffer), "interface@%d", idx);
 	iface = fdt_subnode_offset(initial_boot_params, pip, name_buffer);
 	if (iface < 0)
 		return;
 
+	if (cvmx_helper_interface_enumerate(idx) == 0)
+		count = cvmx_helper_ports_on_interface(idx);
+
 	for (p = 0; p < 16; p++)
 		octeon_fdt_pip_port(iface, idx, p, count - 1, pmac);
 }
-- 
1.8.4.rc3
