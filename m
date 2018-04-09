Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2018 02:41:39 +0200 (CEST)
Received: from mail-bl2nam02on0114.outbound.protection.outlook.com ([104.47.38.114]:39280
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994649AbeDIAlbr0RQV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2018 02:41:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ETpSDIUmctZFBuoiMugmT91mErHtLTaZfDZu+n5RGoo=;
 b=ljfiD1S/meIrqP28OzPdLDqY4XbdX0red57irhOeeZhaI/kgI/yetM7/Gj0705izyPRZEdwdezHEWvNcxi5R/OVx3TZmahX+CphUQP9oUXjTvcWu+7j6/ZQ8ZWRFespU28t3dfeDL3zF0q1XodYr3s2+d5LW4k/WqWCbaRS1l94=
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com (52.132.128.13) by
 DM5PR2101MB0901.namprd21.prod.outlook.com (52.132.132.158) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Mon, 9 Apr 2018 00:41:21 +0000
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059]) by DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059%2]) with mapi id 15.20.0696.003; Mon, 9 Apr 2018
 00:41:21 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 055/101] MIPS: CPS: Prevent multi-core with
 dcache aliasing
Thread-Topic: [PATCH AUTOSEL for 3.18 055/101] MIPS: CPS: Prevent multi-core
 with dcache aliasing
Thread-Index: AQHTz5t5hfy9AXwF2UONPkjHDuMJ6Q==
Date:   Mon, 9 Apr 2018 00:41:19 +0000
Message-ID: <20180409004042.164920-5-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0901;7:DdzenvLVrQyUzckLwLgeXi1mrXwDUfSuUOrPkjjs8N80PCCUCtkjDmguDerKZKSNEVyF19uPnYIznSzgFAawy6JT1fSeF1cQ/2US1N41MSmB3Sofd+kGEq9h0K0eJKkLwPuqfJZ8nF36K50Gxq1ldTcUroV8GMzcOwHDxSn4r2FGG2dTYRSLQ2lgmhCYxJncxIhu69lN6GZ8VvYhqFSYY4PqdmVgckRoLdDgz457GoHeF3eIK712+Pm+a3Sx3UPo;20:ewDi7JcVk5/pLnge9cxPzb+1A8SXq/kbUAI2MV4g4QDoCqLBsm9alY4xVb6avnd+ppbVI/2omwfsDglY6cdQrDMn7XbsY9aZcBcH1UBDCEd2VItDFv2sNohojhmJs2aNYUQbPXSyYWHn+17AwRbFKiIURGFVSa5eOkKq2I+ctU4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1cf96232-a29a-4a53-0722-08d59db29d7a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0901;
x-ms-traffictypediagnostic: DM5PR2101MB0901:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB0901DA603103FFFE072BD719FBBF0@DM5PR2101MB0901.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0901;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0901;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(99286004)(68736007)(10290500003)(25786009)(86612001)(6116002)(66066001)(97736004)(3846002)(76176011)(6512007)(6306002)(54906003)(6436002)(4326008)(53936002)(105586002)(110136005)(6486002)(3280700002)(1076002)(107886003)(8676002)(10090500001)(2501003)(966005)(81156014)(81166006)(5660300001)(14454004)(186003)(3660700001)(102836004)(7736002)(2906002)(26005)(5250100002)(36756003)(478600001)(446003)(316002)(6506007)(2616005)(106356001)(8936002)(11346002)(22452003)(2900100001)(86362001)(486006)(476003)(305945005)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0901;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Kiev7TG0NIhFzX+2H0Ix6tMHs2lUYI198IXYRHBKMx5JYtjyQVDEcNaZlu0x+CStukei/EICEqoppyxl3Og+v18qWgbzhsRCnHzi7UsJzc07rFGCO4Ga1LrlQyPLBn9Fmj1gW0ZHRCoSD/bSknN8y1+qiSN29jgvmWdn1SnQTG0OZVeoGuaLPgnNu9Q48DnoRkHuVEL5zyr/xAq8uZ2BnE+bf8BP8mhAkz0H6ELcO3fgFuZVZ0AYYn2SCDl3V3onL0U9vJZOk1AmcWUthyjk4zI8qzOQ8FGcgKjMvKk2wtNAMlDFDJT1BUZepi1PvD1vIhvyqmWtxUB5S8mO87TPqRW+eO7Sh+fRs64mK81thiRsKzzDwEgujM2Clnxh2C2Xge0B95BBtaXJu3e7uPA1Io7CGja8oZmvw1G4x8bWvr0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf96232-a29a-4a53-0722-08d59db29d7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:19.7677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0901
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63470
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

From: Paul Burton <paul.burton@imgtec.com>

[ Upstream commit 5570ba2ee920de4e7760a2802b842771845b2c32 ]

Systems using the MIPS Coherence Manager (CM) cannot support multi-core
SMP with dcache aliasing. This is because CPU caches are VIPT, but
interventions in CM-based systems provide only the physical address to
remote caches. This means that interventions may behave incorrectly in
the presence of an aliasing dcache, since the physical address used
when handling an intervention may lead to operation on an aliased cache
line rather than the correct line.

Prevent us from running into this issue by refusing to boot secondary
cores in systems where dcache aliasing may occur.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/16196/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/kernel/smp-cps.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 0854f17829f3..0e5ef72c8978 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -120,9 +120,11 @@ static void __init cps_prepare_cpus(unsigned int max_cpus)
 
 	/* Warn the user if the CCA prevents multi-core */
 	ncores = mips_cm_numcores();
-	if (cca_unsuitable && ncores > 1) {
-		pr_warn("Using only one core due to unsuitable CCA 0x%x\n",
-			cca);
+	if ((cca_unsuitable || cpu_has_dc_aliases) && ncores > 1) {
+		pr_warn("Using only one core due to %s%s%s\n",
+			cca_unsuitable ? "unsuitable CCA" : "",
+			(cca_unsuitable && cpu_has_dc_aliases) ? " & " : "",
+			cpu_has_dc_aliases ? "dcache aliasing" : "");
 
 		for_each_present_cpu(c) {
 			if (cpu_data[c].core)
-- 
2.15.1
