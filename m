Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2018 02:35:47 +0200 (CEST)
Received: from mail-by2nam01on0113.outbound.protection.outlook.com ([104.47.34.113]:17210
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991096AbeDIAfEHDqDV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2018 02:35:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fO5hYRPcF3Gc7qg+DmbRLNDSUBftWJoCoPGykGQY4MY=;
 b=fFxKXZ0nt1X1oROncoTtM7BXd460XWxESjO5oFuGZj5ol/p7aHKdtHWnOzc9/8KSwIrIBzo6TIVWnogxD7pUnQ+5sRzJgPQVcPTe/JFqr03s1zNy7tuNcU+KnKyKE30dGeDGBN6s5MFxmSrygQAq3p72LwKzYNR4Ri+67jYERnM=
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com (52.132.128.13) by
 DM5PR2101MB0806.namprd21.prod.outlook.com (10.167.107.156) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.3; Mon, 9 Apr 2018 00:34:52 +0000
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059]) by DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059%2]) with mapi id 15.20.0696.003; Mon, 9 Apr 2018
 00:34:52 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 005/162] MIPS: kprobes: flush_insn_slot should
 flush only if probe initialised
Thread-Topic: [PATCH AUTOSEL for 4.4 005/162] MIPS: kprobes: flush_insn_slot
 should flush only if probe initialised
Thread-Index: AQHTz5mVq/s529bU5Eev+r5672+hQg==
Date:   Mon, 9 Apr 2018 00:27:46 +0000
Message-ID: <20180409002738.163941-5-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:SDvTOsWQwwHiA51LazWc/hKpi66oKnJDU81S4nMxRfYXBraQNKdhO39NOw6P8iz8VpHMx0dok5Gl7BW1sqeKFxfPWknooD9hYosOVC6gJORqsu+nolo1KDBkQZiaFfZvO6p1pWbq74FIONpKcAENZ4KKXvb42BlNodK166hjeVM2PTogVyk1NfVCybAvpi9hATCE9VeBaWtzNgzNKSRgC8bG3/I+MClmszOJYgDe7if2AMDAUBhBfj9cR3ynrxQv;20:nXBkO5k6yitRUj3Y4rj2BzCPTjKAdnsC0LRhG+B2SKVYzEd+UBjmoRVkCfU4FFiMKE9u+o3mO/Nwec/+6JXbI1i4tPG9D+xg2b7hHjhlbeMwA3uyxA8WSuXDgnb2m823YGXG92CDUfTB1w6kmYWaqRTHNltpaEP3Sx7Y0oZtMSE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9d674a07-a22d-42f4-d2b1-08d59db1b5c5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB0806D07A4E2F24FC9AB1F3BCFBBF0@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(39380400002)(199004)(189003)(2906002)(25786009)(2501003)(10290500003)(476003)(11346002)(446003)(97736004)(5250100002)(68736007)(2616005)(102836004)(6506007)(59450400001)(3846002)(3660700001)(486006)(3280700002)(305945005)(6666003)(99286004)(5660300001)(76176011)(1076002)(186003)(26005)(7736002)(6116002)(81156014)(81166006)(86612001)(4326008)(105586002)(10090500001)(2900100001)(54906003)(22452003)(316002)(36756003)(110136005)(107886003)(8676002)(6436002)(478600001)(53936002)(66066001)(6486002)(6512007)(6306002)(86362001)(966005)(14454004)(72206003)(8936002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bWLRexXteMuhyW55zB+mExA2NTZngTSm+9kYudwjAkNX6Ik9MugOuj0LCcDDTPQiEpNQasLHX+rvU6UZWdo8bm6UAuHTvReh/FciAmwYuob7u0A2mezKdH9Ri9mvOb08Qd3mT/X/3g7Y7yMjVnXLRZpi4afJOJ3E/iGrbrRDgcKZSB5MRkTD7UvI3AHpeZRoDwHcte2V0QYajmLfCsi+dXxA4Yt9N0GTVUg2r+aye7NMcohHijQXFGZ/LmbwimKeeTgEbZzbEHH808vf/QbPJ5xcJpSM6dFdMuiO+PPqFF6dxP5Migrzy37SAHh2hEyNLUyibKyzt3WJ1gfeYFg0LWnIX6N/UPEpV1Eq/WbMxKSJ76D0n6puDPaGBk2pPIe8QswcPnMgj613nmJJb3V+3n8npVQ9NtehhjYccJQk+xk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d674a07-a22d-42f4-d2b1-08d59db1b5c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:27:46.7703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63460
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

From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>

[ Upstream commit 698b851073ddf5a894910d63ca04605e0473414e ]

When ftrace is used with kprobes, it is possible for a kprobe to contain
an invalid location (ie. only initialised to 0 and not to a specific
location in the code). Trying to perform a cache flush on such location
leads to a crash r4k_flush_icache_range().

Fixes: c1bf207d6ee1 ("MIPS: kprobe: Add support.")
Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/16296/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/include/asm/kprobes.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/kprobes.h b/arch/mips/include/asm/kprobes.h
index daba1f9a4f79..174aedce3167 100644
--- a/arch/mips/include/asm/kprobes.h
+++ b/arch/mips/include/asm/kprobes.h
@@ -40,7 +40,8 @@ typedef union mips_instruction kprobe_opcode_t;
 
 #define flush_insn_slot(p)						\
 do {									\
-	flush_icache_range((unsigned long)p->addr,			\
+	if (p->addr)							\
+		flush_icache_range((unsigned long)p->addr,		\
 			   (unsigned long)p->addr +			\
 			   (MAX_INSN_SIZE * sizeof(kprobe_opcode_t)));	\
 } while (0)
-- 
2.15.1
