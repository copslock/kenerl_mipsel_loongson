Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jun 2014 09:53:36 +0200 (CEST)
Received: from mail-bn1blp0185.outbound.protection.outlook.com ([207.46.163.185]:49203
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6816288AbaFTHxa4Klfn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Jun 2014 09:53:30 +0200
Received: from BLUPR0601MB0946.namprd06.prod.outlook.com (25.160.35.22) by
 BLUPR0601MB772.namprd06.prod.outlook.com (10.141.254.140) with Microsoft SMTP
 Server (TLS) id 15.0.959.24; Fri, 20 Jun 2014 07:53:23 +0000
Received: from ixro-sdumitru.ixiacom.com (205.168.23.154) by
 BLUPR0601MB0946.namprd06.prod.outlook.com (25.160.35.22) with Microsoft SMTP
 Server (TLS) id 15.0.969.15; Fri, 20 Jun 2014 07:53:22 +0000
From:   Sorin Dumitru <sdumitru@ixiacom.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>
CC:     <ralf@linux-mips.org>, <sdumitru@ixiacom.com>
Subject: [PATCH] mips: n32: use compat getsockopt syscall
Date:   Fri, 20 Jun 2014 10:53:06 +0300
Message-ID: <1403250786-9763-1-git-send-email-sdumitru@ixiacom.com>
X-Mailer: git-send-email 2.0.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [205.168.23.154]
X-ClientProxiedBy: CO2PR05CA030.namprd05.prod.outlook.com (10.141.241.158) To
 BLUPR0601MB0946.namprd06.prod.outlook.com (25.160.35.22)
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6009001)(428001)(189002)(199002)(81156003)(95666004)(93916002)(86362001)(33646001)(77096002)(50986999)(21056001)(101416001)(85306003)(46102001)(92726001)(76482001)(69596002)(19580395003)(19580405001)(83322001)(62966002)(77982001)(64706001)(79102001)(66066001)(106356001)(81542001)(80022001)(81342001)(47776003)(20776003)(42186005)(53416004)(87286001)(105586002)(4396001)(104166001)(99396002)(74662001)(50226001)(50466002)(87976001)(88136002)(48376002)(36756003)(83072002)(85852003)(77156001)(89996001)(102836001)(74502001)(2101003);DIR:OUT;SFP:;SCL:1;SRVR:BLUPR0601MB0946;H:ixro-sdumitru.ixiacom.com;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (: ixiacom.com does not designate permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=sdumitru@ixiacom.com; 
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 205.168.23.154
X-MS-Exchange-CrossPremises-AuthSource: BLUPR0601MB0946.namprd06.prod.outlook.com
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 06
X-MS-Exchange-CrossPremises-AVStamp-Service: 1.0
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Antispam-ScanContext: DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: BLUPR0601MB0946.namprd06.prod.outlook.com
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:
X-OriginatorOrg: ixiacom.com
Return-Path: <sdumitru@ixiacom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40643
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sdumitru@ixiacom.com
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

Signed-off-by: Sorin Dumitru <sdumitru@ixiacom.com>
---
 arch/mips/kernel/scall64-n32.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index c1dbcda..e543861 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -162,7 +162,7 @@ EXPORT(sysn32_call_table)
 	PTR	sys_getpeername
 	PTR	sys_socketpair
 	PTR	compat_sys_setsockopt
-	PTR	sys_getsockopt
+	PTR	compat_sys_getsockopt
 	PTR	__sys_clone			/* 6055 */
 	PTR	__sys_fork
 	PTR	compat_sys_execve
-- 
2.0.0
