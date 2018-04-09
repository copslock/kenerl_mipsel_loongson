Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2018 02:33:00 +0200 (CEST)
Received: from mail-co1nam03on0131.outbound.protection.outlook.com ([104.47.40.131]:60385
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994667AbeDIAbab17gV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2018 02:31:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=OrK/YufRSFGaf34JYiYgPGoUInDdm8+8xiRDuGp2hgw=;
 b=MHNNUfqX+OboAAAb8RlTRunPOr8tMReIN+wyXuWLAPj7ejl7Ns2oh2cGnQ8S64IHD+bWMmaMMafpWi8SWWOm1a4hbFpSrZ6PJW5l2Me+ojkVqnRSK0nRdkCEwNbOjCBnEiKFSHmCeukLPhlk05+lEg5ufwFtWbBZMojW/Mb3noA=
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com (52.132.128.13) by
 DM5PR2101MB1126.namprd21.prod.outlook.com (52.132.132.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Mon, 9 Apr 2018 00:31:19 +0000
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059]) by DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059%2]) with mapi id 15.20.0696.003; Mon, 9 Apr 2018
 00:31:19 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 173/293] MIPS: Handle tlbex-tlbp race
 condition
Thread-Topic: [PATCH AUTOSEL for 4.9 173/293] MIPS: Handle tlbex-tlbp race
 condition
Thread-Index: AQHTz5k3A1DpCo+ELUiwZOCakMmBGA==
Date:   Mon, 9 Apr 2018 00:25:09 +0000
Message-ID: <20180409002239.163177-173-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1126;7:dcIPx95Uf8FQdS5nLMCW6mQ8FFSvu8nrDPF1INSMidnaCJbMsb1Q8+UaqIbHGwE9RAvEkRIEbNDSZEvoYRF711hvDwoj9S9VKDuIm5JfUIJ7mmeAl3IAdB3lDr1sfYfqHrVrMX8pmxI0udq2WyRcRuuSd8OGYGAZDrw+9DwCVSoOPbOnBC3+HKvLpV2U2lG2sYi2ep6+MUxWnFmnrhy46uFdA6Ck3u8wxc25dnnSRajOn5dqfW9QCVv6hSZSRCvc;20:Ka2ENz/sovKIl6uCneIpNIsG54/mCOzp59+VHlLUG2vFGIUThVjhZ9mPV1HrfP/1cs3O6hW3/ZTDNrhTVCLmRLAmg+GhGqKpdTZpCWOfTE4k3ulGFFnlBnwu9GO7xRuVeBB9U10IqumHTBRoUBag0RTDlJ9mI9g2bsmSpPboo2A=
X-MS-Office365-Filtering-Correlation-Id: efa4d53a-2649-4e25-a8d7-08d59db136c0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1126;
x-ms-traffictypediagnostic: DM5PR2101MB1126:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB1126BF5717C8DAD61F98FF9AFBBF0@DM5PR2101MB1126.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1126;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1126;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(39860400002)(346002)(376002)(189003)(199004)(2616005)(476003)(81156014)(8676002)(81166006)(3846002)(486006)(2900100001)(6436002)(186003)(478600001)(72206003)(110136005)(54906003)(6306002)(2906002)(86612001)(6666003)(2501003)(26005)(10090500001)(102836004)(6512007)(6116002)(14454004)(966005)(5250100002)(10290500003)(1076002)(446003)(3280700002)(3660700001)(11346002)(8936002)(25786009)(59450400001)(6506007)(106356001)(4326008)(107886003)(36756003)(105586002)(53936002)(86362001)(66066001)(6486002)(99286004)(5660300001)(316002)(22452003)(305945005)(76176011)(97736004)(68736007)(7736002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1126;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: e7MtLJFIAed2JPcOK7cQNnXkG/Uj5RfHaMHYVqAoo5hoxn+H21wHZ5dy6XajozCZ+7gHo1a7k7S1I86MVAMsSJkd5FWAO5OgKtCXb0oHsD9IC6DUHthZYZ0Po5jvCVvcBva6cQ5eyhh/XuWt4BXFfxEG4TFBv92dkqk/LQO03xMzRiaoB1SmDGD2YluNBUCLLc8Q1KUZwqsGfYbVoRsaT4YojTHkvVfJiRivPrCS3SPx0YqwqnJOcWeiai8yOvptKy/sBg2AMe2biYZLNO688hTN1QnumggC1hzUtVROTM3lIVLRxFp4kQLKTxavkYUItKrg3z+yxEUCKv9IcAteZ78pfZHWyT65LnikyqXpLKh5yxBgSw6ybkt6sh4u7z4HnHs+r4EqXOOuet+KKTdCDIj7JfX8mBvTvtXmNSjx9kk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efa4d53a-2649-4e25-a8d7-08d59db136c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:09.9095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1126
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63452
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
index 2da5649fc545..6f1821547233 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1991,6 +1991,26 @@ static void build_r3000_tlb_modify_handler(void)
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
@@ -2027,7 +2047,7 @@ build_r4000_tlbchange_handler_head(u32 **p, struct uasm_label **l,
 	iPTE_LW(p, wr.r1, wr.r2); /* get even pte */
 	if (!m4kc_tlbp_war()) {
 		build_tlb_probe_entry(p);
-		if (cpu_has_htw) {
+		if (cpu_has_tlbex_tlbp_race()) {
 			/* race condition happens, leaving */
 			uasm_i_ehb(p);
 			uasm_i_mfc0(p, wr.r3, C0_INDEX);
@@ -2101,6 +2121,14 @@ static void build_r4000_tlb_load_handler(void)
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
@@ -2168,6 +2196,14 @@ static void build_r4000_tlb_load_handler(void)
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
