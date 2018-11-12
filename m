Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Nov 2018 23:18:15 +0100 (CET)
Received: from mail-eopbgr780103.outbound.protection.outlook.com ([40.107.78.103]:36317
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992934AbeKLWSFAHyge convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Nov 2018 23:18:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnfnRfl/TXMPB8eZZoeO9DPwPEeUNQr+YjHKZXlEKhM=;
 b=SByz0VrVh6Tp3yt2UUMSc7q7fYMWL9HBHcA2qsQvxHtAoHWMwWVhc4plhdelFOTrYVhx5BXHMMA2epdQHwV6QjPI5pCUy3kWaYK1sFm0Fq5bM2RpeCTDCYdaYIhJo6EtmrB1AN09kmaJmBs9MrB8/+yp7E6DbIy/9ILowt8vQ1k=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1310.namprd22.prod.outlook.com (10.174.162.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Mon, 12 Nov 2018 22:18:01 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.045; Mon, 12 Nov 2018
 22:18:01 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>,
        Huacai Chen <chenhc@lemote.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>
Subject: [PATCH] MIPS: Loongson3,SGI-IP27: Simplify max_low_pfn calculation
Thread-Topic: [PATCH] MIPS: Loongson3,SGI-IP27: Simplify max_low_pfn
 calculation
Thread-Index: AQHUetWT91JwGrXCmUCrq7i3nDCSAw==
Date:   Mon, 12 Nov 2018 22:18:01 +0000
Message-ID: <20181112221742.4900-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2201CA0037.namprd22.prod.outlook.com
 (2603:10b6:301:16::11) To MWHSPR00MB117.namprd22.prod.outlook.com
 (2603:10b6:300:10c::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1310;6:WwNOlNACS91CpZcu+bC7SWVmJ6verM52ASGjSFo/KPuHbvELC10YSvvEK6axsaWWy85p+BuC5YL+m/WEEzUXEAJNV453+VkCIdUK3LNoyhxZgm1qEqK0sl/C/ju1QecHMgq+mRqzxJVW0JH9KPEzenAMH6KAlrDrwpoHc4Vv85kD8Pnb47LAlZ8sx3nOMHAe8i/Xzp/xZrItSl1NgguD9gcxbhxV6D0mZsBEDB+AknrEzoqoJH/raeN6gFwGTuu5iBv7T+asR/wYCYEvyNRJwNPFQEWoXnDyR1Dzk4GF+WgulU+PYKZ/YP2pDX3fK4d2NSdVnzdekoiXw+LKAYY7W/I0ewysnpA45Szjq7IsV4pZ0HTTC2NTeaoxjrc2hGyAWJyxLJOkBwP2fqN3CxDLRx1sYiQtgNxL+hnGvfJMLCZKf9DAWaW/D/bVxdRpT3FX+BnpJPtPCymvZBimjR0xBg==;5:qsIfts+FOMFprTvRnW2e1RElwxyimIKiUa0JWsN3cM/4A9HIgcNFLD8lEKQAC94b3GXOw9LZCjwzeyUR9skIPsg46E5CskpiSqjqFWazEZxYkZVMwPn8QCY0MhS1TNrijEIX/L5yleW736HC/OUc6M/uKnQevHFvPQj4m0N3F24=;7:w9mtTrKa/ahtg7aRTHn6u+A80ycpsfCJgf6Ex+UTsKVZ8CCbrMx1XQMazdjaB1C/eA8VQ7qnY15Cv9Cdg7r+HsXsoeuCPPH0oxznARWq8M89g5P3KfxVOSEFv3o3pTZtVYwX1yiurVxhjNSxioAAbA==
x-ms-office365-filtering-correlation-id: 2bedf371-5066-4b94-fe23-08d648ecb530
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1310;
x-ms-traffictypediagnostic: MWHPR2201MB1310:
x-microsoft-antispam-prvs: <MWHPR2201MB13106D2A7B3FCA5BC03E45CCC1C10@MWHPR2201MB1310.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3002001)(3231382)(944501410)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1310;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1310;
x-forefront-prvs: 0854128AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(376002)(366004)(39840400004)(396003)(136003)(189003)(199004)(53936002)(316002)(6916009)(476003)(8936002)(5640700003)(305945005)(68736007)(4326008)(6306002)(1076002)(7736002)(5660300001)(26005)(6436002)(186003)(44832011)(486006)(8676002)(6512007)(6486002)(81166006)(81156014)(54906003)(256004)(386003)(36756003)(575784001)(102836004)(42882007)(52116002)(2501003)(2900100001)(1857600001)(25786009)(97736004)(966005)(106356001)(99286004)(71200400001)(71190400001)(508600001)(3846002)(6116002)(105586002)(14454004)(2906002)(66066001)(2351001)(2616005)(6506007)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1310;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lV/2sbiKSJ53LKMma3fi8Xmnpj1mPzf97vdMJ8oCGMgtjArM76zkJL2wg7ZEoz34jISTqxeaBIdV3oMX98kzTAh908pkAnGiLRDsbGpHHtgKJW+e+xAR2AToWvd+X2gd4/HpahL7uvDb+1tNv1WJfLbRlZnYrKO1NRBtBL2CxWfXJxiJRLuyDKcD2V+NdtP3y3g/lKGa379yKhjcUPLOTwbgdY6ZkIOgU9FSVsPMONALIGyqQNIsX+O/sfaOoXUlYzrcsH6o8hmgh6csY2eKo4PsiaR/FahgUYI49KNbBaYWjVcPBe/LjW+FJoMDyT2RzM/kRZvwMo1bJs5+e9RIs+kAetUB7Jr+8uS5UO+M7cM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bedf371-5066-4b94-fe23-08d648ecb530
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2018 22:18:01.5628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1310
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67256
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

Both the Loongson3 & SGI-IP27 platforms set max_low_pfn to the last
available PFN describing memory. They both do it in paging_init() which
is later than ideal since max_low_pfn is used before that function is
called. Simplify both platforms to trivially initialize max_low_pfn
using the end address of DRAM, and do it earlier in prom_meminit().

Signed-off-by: Paul Burton <paul.burton@mips.com>
Suggested-by: Mike Rapoport <rppt@linux.ibm.com>
References: https://patchwork.linux-mips.org/patch/21031/
Cc: Huacai Chen <chenhc@lemote.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---

 arch/mips/loongson64/loongson-3/numa.c | 12 ++----------
 arch/mips/sgi-ip27/ip27-memory.c       | 11 +----------
 2 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/arch/mips/loongson64/loongson-3/numa.c b/arch/mips/loongson64/loongson-3/numa.c
index 622761878cd1..60bf0a1cb757 100644
--- a/arch/mips/loongson64/loongson-3/numa.c
+++ b/arch/mips/loongson64/loongson-3/numa.c
@@ -231,6 +231,8 @@ static __init void prom_meminit(void)
 			cpumask_clear(&__node_data[(node)]->cpumask);
 		}
 	}
+	max_low_pfn = PHYS_PFN(memblock_end_of_DRAM());
+
 	for (cpu = 0; cpu < loongson_sysconf.nr_cpus; cpu++) {
 		node = cpu / loongson_sysconf.cores_per_node;
 		if (node >= num_online_nodes())
@@ -248,19 +250,9 @@ static __init void prom_meminit(void)
 
 void __init paging_init(void)
 {
-	unsigned node;
 	unsigned long zones_size[MAX_NR_ZONES] = {0, };
 
 	pagetable_init();
-
-	for_each_online_node(node) {
-		unsigned long  start_pfn, end_pfn;
-
-		get_pfn_range_for_nid(node, &start_pfn, &end_pfn);
-
-		if (end_pfn > max_low_pfn)
-			max_low_pfn = end_pfn;
-	}
 #ifdef CONFIG_ZONE_DMA32
 	zones_size[ZONE_DMA32] = MAX_DMA32_PFN;
 #endif
diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
index d8b8444d6795..813d13f92957 100644
--- a/arch/mips/sgi-ip27/ip27-memory.c
+++ b/arch/mips/sgi-ip27/ip27-memory.c
@@ -435,6 +435,7 @@ void __init prom_meminit(void)
 
 	mlreset();
 	szmem();
+	max_low_pfn = PHYS_PFN(memblock_end_of_DRAM());
 
 	for (node = 0; node < MAX_COMPACT_NODES; node++) {
 		if (node_online(node)) {
@@ -455,18 +456,8 @@ extern void setup_zero_pages(void);
 void __init paging_init(void)
 {
 	unsigned long zones_size[MAX_NR_ZONES] = {0, };
-	unsigned node;
 
 	pagetable_init();
-
-	for_each_online_node(node) {
-		unsigned long start_pfn, end_pfn;
-
-		get_pfn_range_for_nid(node, &start_pfn, &end_pfn);
-
-		if (end_pfn > max_low_pfn)
-			max_low_pfn = end_pfn;
-	}
 	zones_size[ZONE_NORMAL] = max_low_pfn;
 	free_area_init_nodes(zones_size);
 }
-- 
2.19.1
