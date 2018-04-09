Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2018 02:41:52 +0200 (CEST)
Received: from mail-bl2nam02on0114.outbound.protection.outlook.com ([104.47.38.114]:39280
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992615AbeDIAlcMem-V convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2018 02:41:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=eYs6vcigFz1CUWlzAi7UOxb2IfBD50RqdL5VbEUAjvU=;
 b=lxB9tulDF+En9jh9wz/wtlGOeGKOukvz4pHXFqtTFoWiuvQe60E4Y7QJ4HlaDHys4EeCfztI4MBDdl/oxpUdGVr88aOBXqonExKRtOA77I1FlGnV2Aj2Uav6nkd5EZa1ZZMZzbZCVv8sQLg3G96qv6xFCqfYMaFDWUJN+v0h4+o=
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
Subject: [PATCH AUTOSEL for 3.18 056/101] MIPS: Handle tlbex-tlbp race
 condition
Thread-Topic: [PATCH AUTOSEL for 3.18 056/101] MIPS: Handle tlbex-tlbp race
 condition
Thread-Index: AQHTz5t6/VF1ZzXlukGzrM7ArnXD0g==
Date:   Mon, 9 Apr 2018 00:41:20 +0000
Message-ID: <20180409004042.164920-6-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0901;7:62XCOP6wyO0Z4FTdZXyO4H6Ejli/LvZ2EIcbjzqtxHb1Mbd84tC4zWz8rGFXsIcB3WDE4dQCWLXiqLbpW0iA/9pSrTMBSP6MXX+dnzm7Jte0puk0AEh18KIkiS1nyWWLFf+LeUodjueUWg946aPOSptHGt5atsp1RQ+TEP/CHWQ4PvW/2F+2FULDinngZurwJhTjwyvbhgm1hK1q4DffhdRR36wcCx7QYczsYu3UOwnBbHdADP3PrkfUxqmUI6rl;20:ZPsQkEx3kt67owDJcm3pYD9wbfxWSmmuhwvLMwGMj3shXIYbrvaKzTH3hzoiv3OK7hi6Y1DrPaUiQeGL+0RSCFmaL+8afx3qBsQupyx5QwGGcfYoPiHWmQA4mXp8/JLcAtx8OS9Cx0Y5KKcguLz4u911hGUN0xzsSW290Bb9gkQ=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: ef23419d-39f8-4cc8-f025-08d59db29dc3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0901;
x-ms-traffictypediagnostic: DM5PR2101MB0901:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB090156C9845C8F9A323B68CFFBBF0@DM5PR2101MB0901.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0901;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0901;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(59450400001)(99286004)(68736007)(10290500003)(25786009)(86612001)(6116002)(66066001)(97736004)(3846002)(76176011)(6512007)(6306002)(54906003)(6436002)(4326008)(53936002)(105586002)(110136005)(6486002)(3280700002)(1076002)(107886003)(8676002)(10090500001)(2501003)(966005)(81156014)(81166006)(5660300001)(14454004)(186003)(3660700001)(102836004)(7736002)(2906002)(26005)(5250100002)(36756003)(478600001)(446003)(316002)(6506007)(2616005)(106356001)(8936002)(11346002)(22452003)(2900100001)(86362001)(486006)(476003)(305945005)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0901;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pQ0Yc9ZFdEjbJ6qn8yK0DJCui+CBkcdz2etSqyVLRyqIUDtY/FZwFp5VkKPoS1LK8y/MBkk8cscbxQ9myflY/9oiaXZlfnIx4rCbOGzweUbyha/5QxE4lk1xcuwEDCDSmJjgyrSFIBlqeFRI88N52AHKW+SD1FHOgUnuWAv60LUvbD496JMccmFNWJyea/LkAEosKdPKYsYBB86cKpGuLtpFBr1WX7a9xSjzAdiPoJOz/LNsv6egJ3OwDcWiUMy3KjEY/9Q1C2lwxT5aCCkGPmofuqWM2D7D6YyyU3ft0OjOcRLuTnZK/gRbhIkkIfHXrBJfD9HcEd/42OAOvDjaQuzLWu2u+ZYLaV4tabA/B8i4mpESzYivHVF5xC4ATBx/kbunX04O6sNeqVWX10lFgrct8FaFZjnj4t8XA3aMvcM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef23419d-39f8-4cc8-f025-08d59db29dc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:20.4865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0901
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63471
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

[ Upstream commit f39878cc5b09c75d35eaf52131e920b872e3feb4 ]

In systems where there are multiple actors updating the TLB, the
potential exists for a race condition wherein a CPU hits a TLB exception
but by the time it reaches a TLBP instruction the affected TLB entry may
have been replaced. This can happen if, for example, a CPU shares the
TLB between hardware threads (VPs) within a core and one of them
replaces the entry that another has just taken a TLB exception for.

We handle this race in the case of the Hardware Table Walker (HTW) being
the other actor already, but didn't take into account the potential for
multiple threads racing. Include the code for aborting TLB exception
handling in affected multi-threaded systems, those being the I6400 &
I6500 CPUs which share TLB entries between VPs.

In the case of using RiXi without dedicated exceptions we have never
handled this race even for HTW. This patch adds WARN()s to these cases
which ought never to be hit because all CPUs with either HTW or shared
FTLB RAMs also include dedicated RiXi exceptions, but the WARN()s will
ensure this is always the case.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/16203/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/mm/tlbex.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index e3328a96e809..4be16c81be9f 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1838,6 +1838,26 @@ static void build_r3000_tlb_modify_handler(void)
 }
 #endif /* CONFIG_MIPS_PGD_C0_CONTEXT */
 
+static bool cpu_has_tlbex_tlbp_race(void)
+{
+	/*
+	 * When a Hardware Table Walker is running it can replace TLB entries
+	 * at any time, leading to a race between it & the CPU.
+	 */
+	if (cpu_has_htw)
+		return true;
+
+	/*
+	 * If the CPU shares FTLB RAM with its siblings then our entry may be
+	 * replaced at any time by a sibling performing a write to the FTLB.
+	 */
+	if (cpu_has_shared_ftlb_ram)
+		return true;
+
+	/* In all other cases there ought to be no race condition to handle */
+	return false;
+}
+
 /*
  * R4000 style TLB load/store/modify handlers.
  */
@@ -1874,7 +1894,7 @@ build_r4000_tlbchange_handler_head(u32 **p, struct uasm_label **l,
 	iPTE_LW(p, wr.r1, wr.r2); /* get even pte */
 	if (!m4kc_tlbp_war()) {
 		build_tlb_probe_entry(p);
-		if (cpu_has_htw) {
+		if (cpu_has_tlbex_tlbp_race()) {
 			/* race condition happens, leaving */
 			uasm_i_ehb(p);
 			uasm_i_mfc0(p, wr.r3, C0_INDEX);
@@ -1948,6 +1968,14 @@ static void build_r4000_tlb_load_handler(void)
 		}
 		uasm_i_nop(&p);
 
+		/*
+		 * Warn if something may race with us & replace the TLB entry
+		 * before we read it here. Everything with such races should
+		 * also have dedicated RiXi exception handlers, so this
+		 * shouldn't be hit.
+		 */
+		WARN(cpu_has_tlbex_tlbp_race(), "Unhandled race in RiXi path");
+
 		uasm_i_tlbr(&p);
 
 		switch (current_cpu_type()) {
@@ -2015,6 +2043,14 @@ static void build_r4000_tlb_load_handler(void)
 		}
 		uasm_i_nop(&p);
 
+		/*
+		 * Warn if something may race with us & replace the TLB entry
+		 * before we read it here. Everything with such races should
+		 * also have dedicated RiXi exception handlers, so this
+		 * shouldn't be hit.
+		 */
+		WARN(cpu_has_tlbex_tlbp_race(), "Unhandled race in RiXi path");
+
 		uasm_i_tlbr(&p);
 
 		switch (current_cpu_type()) {
-- 
2.15.1
