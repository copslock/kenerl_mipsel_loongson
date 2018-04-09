Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2018 02:37:22 +0200 (CEST)
Received: from mail-cys01nam02on0726.outbound.protection.outlook.com ([IPv6:2a01:111:f400:fe45::726]:17059
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992243AbeDIAhPZLYvV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2018 02:37:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=tusPP0etyVizF48I1TUvwHdcrkotY8q8IWwcepcuQ3E=;
 b=GA7dB92BR4qKgmPjdwjygEIDBL2G/yc0wEq75JPGcqlzTXOY3hH+QPWOMbxEjCsaS/7B5JL9swAQhHb34iFsGSo1laoleg2dZprZktLanh+JriYOyXzQksk/wQezp+cRXP3UwAlQzszQYRAzXp0TYlQSo892ojn+fAdy2erHnE0=
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com (52.132.128.13) by
 DM5PR2101MB1031.namprd21.prod.outlook.com (52.132.128.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Mon, 9 Apr 2018 00:37:05 +0000
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059]) by DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059%2]) with mapi id 15.20.0696.003; Mon, 9 Apr 2018
 00:37:05 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 085/162] MIPS: CPS: Prevent multi-core with
 dcache aliasing
Thread-Topic: [PATCH AUTOSEL for 4.4 085/162] MIPS: CPS: Prevent multi-core
 with dcache aliasing
Thread-Index: AQHTz5m4jPCq/48YGk2450rvjMCLug==
Date:   Mon, 9 Apr 2018 00:28:45 +0000
Message-ID: <20180409002738.163941-85-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:l/krA5maP751xcMEcjkk+Q416SZ83EJXgpYoWzfD7Hv9pSp7iTuSv5a8RYq8oaPcFc5I1HzYXw50d+HPioS1bsjfF7Jc1ubuE6ANxn0PRe8873iJVQgmO708yQLN9wGpDWiRWN187JaH7Q7ctE2QH4Gj9XDx8vOpy6r+YacBEaWTKMbZ16tBPr1TyeyqkD4v0dpbzbwgjokKj0n39qg2PF1zDgiSRJ18+Onk37oiprF8A0UD5OWCbh6/IaIy39C7;20:cxlClMkvuFj4viGLreiFrkGNnpciKd5Sl+ske5uukj06Uw+j4x6rBSm6pYnN9sPmw37hfxNS/nHq9lFTQzx3QIbXc7T+KvzXLYI5iQIez75ij/hEDLuhZPtCC3NnLU/VUnvUw69HbvxmIIniWGwABmU1/2WGcRIw5v78n/2arCo=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: af529c92-7317-48b7-481e-08d59db2049e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB103123A1159B9A906F82C740FBBF0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(2900100001)(10290500003)(99286004)(76176011)(14454004)(966005)(7736002)(11346002)(26005)(6666003)(86612001)(72206003)(478600001)(36756003)(106356001)(66066001)(2616005)(186003)(22452003)(86362001)(68736007)(305945005)(54906003)(102836004)(486006)(110136005)(316002)(6506007)(446003)(107886003)(53936002)(4326008)(105586002)(6306002)(6436002)(6486002)(476003)(6512007)(5660300001)(5250100002)(25786009)(3846002)(6116002)(1076002)(97736004)(3280700002)(2501003)(2906002)(81156014)(8676002)(10090500001)(81166006)(8936002)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WffPFkdITJJe0wqa2IUgAbIl4kr5KjPQgSE3q11ChnJLl0GdFucMi84tV95e3b2tJU3SRbNnAdp4Kuijn4zSnx7+/ztyehnSsaW7PBgQGi7ezz3paLAwWk8+kGVcyNfyWVNQAFee1rFyw5Wc7zUr10ZVRLbE/IweCQgQ6iPK3mLfJlFxdu/ATyOUMioOZMzAq1sjOCOxtXU53ql4r857U1C192QbLOLYgFmEec6sHexmbr9CkPB0wbttlv7VHmdIEfdFNCtCyXOeoNu6iqIj5EOLy7L35MBkzkrsPEv9bW1mVXEn5vC2BSQpK3os3l3P3gRH7lgN3MwUAxSYw74UWJ35bqd6SXgo6iN5UHVVqKb63ZX6dOvVMMGNtE8rZJHBbE1BWTMnRnw3la+0jXTyZ4gmeU0dSWlDWX8eFkXKYJw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af529c92-7317-48b7-481e-08d59db2049e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:45.4271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63461
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
index e04c8057b882..ff0993dfeb08 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -122,9 +122,11 @@ static void __init cps_prepare_cpus(unsigned int max_cpus)
 
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
