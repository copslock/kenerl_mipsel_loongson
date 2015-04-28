Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2015 16:42:10 +0200 (CEST)
Received: from mail-db3on0084.outbound.protection.outlook.com ([157.55.234.84]:45664
        "EHLO emea01-db3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27026211AbbD1OmIkm6bt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Apr 2015 16:42:08 +0200
Received: from DB3PR02CA0026.eurprd02.prod.outlook.com (10.242.134.36) by
 AM2PR02MB0770.eurprd02.prod.outlook.com (25.163.146.155) with Microsoft SMTP
 Server (TLS) id 15.1.148.16; Tue, 28 Apr 2015 14:42:03 +0000
Received: from AM1FFO11FD037.protection.gbl (2a01:111:f400:7e00::107) by
 DB3PR02CA0026.outlook.office365.com (2a01:111:e400:9814::36) with Microsoft
 SMTP Server (TLS) id 15.1.148.16 via Frontend Transport; Tue, 28 Apr 2015
 14:42:02 +0000
Authentication-Results: spf=fail (sender IP is 12.216.194.146)
 smtp.mailfrom=ezchip.com; linux.intel.com; dkim=none (message not signed)
 header.d=none;
Received-SPF: Fail (protection.outlook.com: domain of ezchip.com does not
 designate 12.216.194.146 as permitted sender)
 receiver=protection.outlook.com; client-ip=12.216.194.146;
 helo=ld-1.internal.tilera.com;
Received: from ld-1.internal.tilera.com (12.216.194.146) by
 AM1FFO11FD037.mail.protection.outlook.com (10.174.64.226) with Microsoft SMTP
 Server (TLS) id 15.1.154.14 via Frontend Transport; Tue, 28 Apr 2015 14:42:01
 +0000
Received: (from cmetcalf@localhost)
        by ld-1.internal.tilera.com (8.14.4/8.14.4/Submit) id t3SEg0gT015083;
        Tue, 28 Apr 2015 10:42:00 -0400
From:   Chris Metcalf <cmetcalf@ezchip.com>
To:     "Geert Uytterhoeven <geert@linux-m68k.org> Rusty Russell" 
        <rusty@rustcorp.com.au>
CC:     Chris Metcalf <cmetcalf@ezchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Mark Brown <broonie@kernel.org>,
        "DRI Development" <dri-devel@lists.freedesktop.org>,
        Matthew Wilcox <willy@linux.intel.com>
Subject: [PATCH] tile: properly use node_isset() on a nodemask_t
Date:   Tue, 28 Apr 2015 10:41:47 -0400
Message-ID: <1430232107-15041-1-git-send-email-cmetcalf@ezchip.com>
X-Mailer: git-send-email 2.1.2
In-Reply-To: <CAMuHMdXEH6ZnTSdBi2uJzPriqTLvJvd0bPYH3NPWV5LjZB5S=A@mail.gmail.com>
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:12.216.194.146;CTRY:US;IPV:NLI;EFV:NLI;BMV:1;SFV:NSPM;SFS:(10009020)(6009001)(339900001)(189002)(199003)(106466001)(2950100001)(229853001)(33646002)(42186005)(85426001)(6806004)(50466002)(105606002)(104016003)(86362001)(92566002)(46102003)(48376002)(110136001)(47776003)(77156002)(50226001)(19580405001)(62966003)(19580395003)(50986999)(36756003)(87936001)(4001450100001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM2PR02MB0770;H:ld-1.internal.tilera.com;FPR:;SPF:Fail;MLV:sfv;MX:1;A:1;LANG:en;
MIME-Version: 1.0
Content-Type: text/plain
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:AM2PR02MB0770;
X-Microsoft-Antispam-PRVS: <AM2PR02MB0770996EAD2C75D8DACD5A85AFE80@AM2PR02MB0770.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(5002010)(5005006)(3002001);SRVR:AM2PR02MB0770;BCL:0;PCL:0;RULEID:;SRVR:AM2PR02MB0770;
X-Forefront-PRVS: 0560A2214D
X-OriginatorOrg: ezchip.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2015 14:42:01.1428
 (UTC)
X-MS-Exchange-CrossTenant-Id: 0fc16e0a-3cd3-4092-8b2f-0a42cff122c3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0fc16e0a-3cd3-4092-8b2f-0a42cff122c3;Ip=[12.216.194.146];Helo=[ld-1.internal.tilera.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM2PR02MB0770
Return-Path: <cmetcalf@ezchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47135
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cmetcalf@ezchip.com
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

The code accidentally used cpu_isset() previously in one place
(though properly node_isset() elsewhere).

Signed-off-by: Chris Metcalf <cmetcalf@ezchip.com>
---
 arch/tile/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/tile/kernel/setup.c b/arch/tile/kernel/setup.c
index 6873f006f7d0..d366675e4bf8 100644
--- a/arch/tile/kernel/setup.c
+++ b/arch/tile/kernel/setup.c
@@ -774,7 +774,7 @@ static void __init zone_sizes_init(void)
 		 * though, there'll be no lowmem, so we just alloc_bootmem
 		 * the memmap.  There will be no percpu memory either.
 		 */
-		if (i != 0 && cpumask_test_cpu(i, &isolnodes)) {
+		if (i != 0 && node_isset(i, isolnodes)) {
 			node_memmap_pfn[i] =
 				alloc_bootmem_pfn(0, memmap_size, 0);
 			BUG_ON(node_percpu[i] != 0);
-- 
2.1.2
