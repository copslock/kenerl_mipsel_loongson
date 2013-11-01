Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Nov 2013 16:12:23 +0100 (CET)
Received: from demumfd002.nsn-inter.net ([93.183.12.31]:11893 "EHLO
        demumfd002.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822679Ab3KAPL5R0Uqj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Nov 2013 16:11:57 +0100
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55])
        by demumfd002.nsn-inter.net (8.12.11.20060308/8.12.11) with ESMTP id rA1FBgO6009012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 1 Nov 2013 16:11:42 +0100
Received: from ak-desktop.emea.nsn-net.net ([10.144.36.74])
        by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id rA1FBeBm032091;
        Fri, 1 Nov 2013 16:11:41 +0100
From:   Aaro Koskinen <aaro.koskinen@nsn.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Aaro Koskinen <aaro.koskinen@nsn.com>
Subject: [PATCH v2 1/2] MIPS: cavium-octeon: fix out-of-bounds array access
Date:   Fri,  1 Nov 2013 17:06:03 +0200
Message-Id: <1383318364-30312-1-git-send-email-aaro.koskinen@nsn.com>
X-Mailer: git-send-email 1.8.4.rc3
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 1039
X-purgate-ID: 151667::1383318702-00005753-E406F5E2/0-0/0-0
Return-Path: <aaro.koskinen@nsn.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38438
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

When booting with in-kernel DTBs, the pruning code will enumerate
interfaces 0-4. However, there is memory reserved only for 4 so some
other data will get overwritten by cvmx_helper_interface_enumerate().

Signed-off-by: Aaro Koskinen <aaro.koskinen@nsn.com>
---

	v2: a new patch in the series

 arch/mips/cavium-octeon/executive/cvmx-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c b/arch/mips/cavium-octeon/executive/cvmx-helper.c
index d63d20d..0e4b340 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
@@ -67,7 +67,7 @@ void (*cvmx_override_pko_queue_priority) (int pko_port,
 void (*cvmx_override_ipd_port_setup) (int ipd_port);
 
 /* Port count per interface */
-static int interface_port_count[4] = { 0, 0, 0, 0 };
+static int interface_port_count[5];
 
 /* Port last configured link info index by IPD/PKO port */
 static cvmx_helper_link_info_t
-- 
1.8.4.rc3
