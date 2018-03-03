Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Mar 2018 23:35:42 +0100 (CET)
Received: from mail-sn1nam02on0117.outbound.protection.outlook.com ([104.47.36.117]:64257
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994615AbeCCWfLfek8R convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Mar 2018 23:35:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=mTnGJL1Fxh0QinD/COuhWgso/CYbjXpUKc6Q/IEJido=;
 b=FSQQJDXwTsU4HELnoU0WaXdZlAmt8k76feHSo81WiB7HPMEnbjFUzKyAVfTYoDYBn+GxLCrCCkwvdfuOgTGy3tX140x7amG3L4iWhEK4JzFhrEgdRLtJ3ug4y1yPy/xX6letYF/kOKhiTiOOA7QA0qJmyF6Ys5tG0CvayUhLXNU=
Received: from MW2PR2101MB1034.namprd21.prod.outlook.com (52.132.149.10) by
 MW2PR2101MB0924.namprd21.prod.outlook.com (52.132.152.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.588.3; Sat, 3 Mar 2018 22:34:54 +0000
Received: from MW2PR2101MB1034.namprd21.prod.outlook.com
 ([fe80::1d56:338f:e2b:cec0]) by MW2PR2101MB1034.namprd21.prod.outlook.com
 ([fe80::1d56:338f:e2b:cec0%3]) with mapi id 15.20.0567.006; Sat, 3 Mar 2018
 22:34:54 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtech.com>,
        Aleksandar Markovic <aleksandar.markovic@imgtech.com>,
        "james.hogan@imgtec.com" <james.hogan@imgtec.com>,
        "petar.jovanovic@imgtec.com" <petar.jovanovic@imgtec.com>,
        "goran.ferenc@imgtec.com" <goran.ferenc@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 138/219] MIPS: r2-on-r6-emu: Fix BLEZL and
 BGTZL identification
Thread-Topic: [PATCH AUTOSEL for 4.9 138/219] MIPS: r2-on-r6-emu: Fix BLEZL
 and BGTZL identification
Thread-Index: AQHTsz8QdrbDSzchvEGasdnRyEGxMg==
Date:   Sat, 3 Mar 2018 22:29:16 +0000
Message-ID: <20180303222716.26640-138-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0924;6:5LNwd0GTMkKvfxGPxhhBn+i6jX569fKSylhMl6oq+rIzTkndg/an1aXLzp8NcwqPdUk8kEXwJ0rl2JINdXW3M7OfmYfkz1wy2J52iD4Ls3MvSszwqaTSIffSBmCq4qS+J4VssSjA3ZjRKyqtIjI/Sw+GY4YAE5iTOmG6K4tF8sFb3CuDRpFOoDP0ALik4WvZ7yI1Un4xoPNJswGSjK1erecfDOs9WA27kls45yysbY99bq34Y2cCkFFjJ5CelSFJMlgUtP9dXvbqfSj+jENSsRRr8SEjB2lBrkMlXBO5R57DInnePPIQ1o6qw+4eSykfnMSBMAgs84GQ6/PYDtR1YNvjY3iy/e9+AeyIgkrmrhk=;5:dyhrFF2+ZEvqAoPod5KnLahIlG2zmG2XjB4GWnAnvOhYPmpMaBIULbd1wvU0T+SDU4mn3Lc57kh+hUxb7EAT1CeFjCRVpUvRcWDUaCqLbw/nEB+nW+czkWsyUS8+Cy489dGvbjh5VsuMg/19q4QQhJAuvR/he1X1ciVIiMKtVn0=;24:YJWiUW9IrN1iXaGPtQu0GDmvAWt9uXhoDPge+r2gTkv3qmxDMLjPgMURQLyqK76YKm/gvsIpgSWAfIPk7SMWleqMOxB6qmB7OpRWopB0gNk=;7:EFMcHbPKKfBiPVOIGvy0aiKFw/VTkYnylwUN0y+L0GOFunbLG5c9+QC+Y3ysDMyZ9RybER24D26FrwK0PLJV/G7iDepqn7CmDeLHVdMlO9EZmSEgQ+9cGjCl7gZSyylZT6zMNx7yYOnUNnuLf7kdUG0JJDeyUa3xzTzifrwnJ/DakK78c983Ac/a1jr2jEi5bO0tkvWmK87FSXN0JLOJ/CPJLUkZvRCs0jGaIL6n4CHVZ+Ub4Cmvje9mzViWkgkG
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 01b3c708-7a73-4488-ed2c-08d58156fcad
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0924;
x-ms-traffictypediagnostic: MW2PR2101MB0924:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB09247FCA4DC97E5F0BCF2159FBC40@MW2PR2101MB0924.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0924;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0924;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(366004)(39380400002)(189003)(199004)(102836004)(2950100002)(10090500001)(6666003)(316002)(26005)(186003)(25786009)(2900100001)(2906002)(7416002)(54906003)(22452003)(110136005)(97736004)(6506007)(59450400001)(7736002)(4326008)(305945005)(5250100002)(86362001)(2501003)(99286004)(68736007)(72206003)(53936002)(6436002)(6116002)(3846002)(5660300001)(66066001)(1076002)(76176011)(14454004)(966005)(36756003)(3660700001)(6486002)(86612001)(81156014)(8676002)(81166006)(10290500003)(6512007)(8936002)(3280700002)(478600001)(107886003)(106356001)(6306002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0924;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b3c708-7a73-4488-ed2c-08d58156fcad
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:16.7132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0924
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62795
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Alexander.Levin@microsoft.com
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

[ Upstream commit 5bba7aa4958e271c3ffceb70d47d3206524cf489 ]

Fix the problem of inaccurate identification of instructions BLEZL and
BGTZL in R2 emulation code by making sure all necessary encoding
specifications are met.

Previously, certain R6 instructions could be identified as BLEZL or
BGTZL. R2 emulation routine didn't take into account that both BLEZL
and BGTZL instructions require their rt field (bits 20 to 16 of
instruction encoding) to be 0, and that, at same time, if the value in
that field is not 0, the encoding may represent a legitimate MIPS R6
instruction.

This means that a problem could occur after emulation optimization,
when emulation routine tried to pipeline emulation, picked up a next
candidate, and subsequently misrecognized an R6 instruction as BLEZL
or BGTZL.

It should be said that for single pass strategy, the problem does not
happen because CPU doesn't trap on branch-compacts which share opcode
space with BLEZL/BGTZL (but have rt field != 0, of course).

Signed-off-by: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtech.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtech.com>
Reported-by: Douglas Leung <douglas.leung@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Cc: james.hogan@imgtec.com
Cc: petar.jovanovic@imgtec.com
Cc: goran.ferenc@imgtec.com
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/15456/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/kernel/mips-r2-to-r6-emul.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/mips-r2-to-r6-emul.c b/arch/mips/kernel/mips-r2-to-r6-emul.c
index d8227f289d7f..9a46e52864a1 100644
--- a/arch/mips/kernel/mips-r2-to-r6-emul.c
+++ b/arch/mips/kernel/mips-r2-to-r6-emul.c
@@ -1096,10 +1096,20 @@ repeat:
 		}
 		break;
 
-	case beql_op:
-	case bnel_op:
 	case blezl_op:
 	case bgtzl_op:
+		/*
+		 * For BLEZL and BGTZL, rt field must be set to 0. If this
+		 * is not the case, this may be an encoding of a MIPS R6
+		 * instruction, so return to CPU execution if this occurs
+		 */
+		if (MIPSInst_RT(inst)) {
+			err = SIGILL;
+			break;
+		}
+		/* fall through */
+	case beql_op:
+	case bnel_op:
 		if (delay_slot(regs)) {
 			err = SIGILL;
 			break;
-- 
2.14.1
