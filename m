Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jun 2014 13:24:00 +0200 (CEST)
Received: from mail-by2lp0237.outbound.protection.outlook.com ([207.46.163.237]:53525
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6859947AbaFTLX55ImW9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Jun 2014 13:23:57 +0200
Received: from ixro-sdumitru.ixiacom.com (205.168.23.154) by
 CO2PR0601MB0950.namprd06.prod.outlook.com (25.160.10.22) with Microsoft SMTP
 Server (TLS) id 15.0.969.15; Fri, 20 Jun 2014 11:23:49 +0000
From:   Sorin Dumitru <sdumitru@ixiacom.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>
CC:     <ralf@linux-mips.org>, <sdumitru@ixiacom.com>
Subject: [PATCH v2] mips: n32: use compat getsockopt syscall
Date:   Fri, 20 Jun 2014 14:23:35 +0300
Message-ID: <1403263415-15765-1-git-send-email-sdumitru@ixiacom.com>
X-Mailer: git-send-email 2.0.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [205.168.23.154]
X-ClientProxiedBy: CO2PR04CA046.namprd04.prod.outlook.com (10.141.240.174) To
 CO2PR0601MB0950.namprd06.prod.outlook.com (25.160.10.22)
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6009001)(428001)(199002)(189002)(81156003)(85306003)(53416004)(77096002)(42186005)(74662001)(99396002)(104166001)(46102001)(77156001)(36756003)(19580395003)(50226001)(83322001)(77982001)(76482001)(79102001)(4396001)(19580405001)(31966008)(69596002)(21056001)(102836001)(92566001)(92726001)(33646001)(74502001)(93916002)(86362001)(50986999)(50466002)(88136002)(85852003)(89996001)(105586002)(47776003)(62966002)(64706001)(95666004)(83072002)(87976001)(48376002)(87286001)(80022001)(81342001)(101416001)(20776003)(81542001)(106356001)(66066001)(2101003);DIR:OUT;SFP:;SCL:1;SRVR:CO2PR0601MB0950;H:ixro-sdumitru.ixiacom.com;FPR:;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (: ixiacom.com does not designate permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=sdumitru@ixiacom.com; 
X-OriginatorOrg: ixiacom.com
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 205.168.23.154
X-MS-Exchange-CrossPremises-AuthSource: CO2PR0601MB0950.namprd06.prod.outlook.com
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 06
X-MS-Exchange-CrossPremises-AVStamp-Service: 1.0
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Antispam-ScanContext: DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: CO2PR0601MB0950.namprd06.prod.outlook.com
Return-Path: <sdumitru@ixiacom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40647
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

The IP_PKTOPTIONS sockopt puts control messages
in option_values, these need to be handled
differently in the compat case. This is already
done through the MSG_CMSG_COMPAT flag, we just
need to use compat_sys_getsockopt which sets that
flag.

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
