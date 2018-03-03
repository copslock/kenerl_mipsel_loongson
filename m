Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Mar 2018 23:40:43 +0100 (CET)
Received: from mail-bl2nam02on0092.outbound.protection.outlook.com ([104.47.38.92]:62080
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994591AbeCCWkJ6mrcR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Mar 2018 23:40:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=sd4gbDGvuTP8uce9Zd7kcRmt147rCNKml4/lIBq/RvU=;
 b=mFHvxa0fKWockr9hzB5mvIONcwoulsTNZFIfeBXXIC+ixvAJTRDqlJB/F4jIf70dwcFcxPpxno9RA4B46rlrs4Mtgw3OuZwCRapt6se12xP+tR4FKKGhVi0FGDUw7A83vmQVEqTT/DekNioKET4I97Edr094E5sq7RjQMxLSy30=
Received: from MW2PR2101MB1034.namprd21.prod.outlook.com (52.132.149.10) by
 MW2PR2101MB1033.namprd21.prod.outlook.com (52.132.146.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.567.3; Sat, 3 Mar 2018 22:39:55 +0000
Received: from MW2PR2101MB1034.namprd21.prod.outlook.com
 ([fe80::1d56:338f:e2b:cec0]) by MW2PR2101MB1034.namprd21.prod.outlook.com
 ([fe80::1d56:338f:e2b:cec0%3]) with mapi id 15.20.0567.006; Sat, 3 Mar 2018
 22:39:55 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     David Daney <david.daney@cavium.com>,
        James Hogan <james.hogan@imgtec.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "Steven J . Hill" <steven.hill@cavium.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 068/115] MIPS: BPF: Fix multiple problems in
 JIT skb access helpers.
Thread-Topic: [PATCH AUTOSEL for 4.4 068/115] MIPS: BPF: Fix multiple problems
 in JIT skb access helpers.
Thread-Index: AQHTsz9fDZxyKfTsgk+cDdf5t8ju6g==
Date:   Sat, 3 Mar 2018 22:31:28 +0000
Message-ID: <20180303223010.27106-68-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1033;7:AJp3haetHW3hY2H32K1G1bE6jzK+fZeppEj8ssUQBCPloeRZmFR6HPSQ7MvIV48TvfAolU7D36BDfFOtc4Tcf+qMsLOWwdRUvCvK1gwcVhEEAx4ZlgRZo7O6exNY5I0NlZxh4kAh+Jz+B5EyQruIriNd1+QlLLeLBAC2zr0P5N0HG4RtDYTQiWIpFXNix45BbaJEpFTuqY4gCHMQsAQ7Dg2SUyBT/w5Jd23EOBFdwAmM9fER3OYpMOIQvgzxRgzb
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b68b7b9d-c706-48c1-1bdd-08d58157afef
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1033;
x-ms-traffictypediagnostic: MW2PR2101MB1033:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB1033CAA2FBE4C47BA1D9A008FBC40@MW2PR2101MB1033.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1033;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1033;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(366004)(346002)(396003)(189003)(199004)(3280700002)(3846002)(316002)(6666003)(99286004)(110136005)(2900100001)(54906003)(2501003)(10090500001)(53936002)(5250100002)(106356001)(76176011)(36756003)(107886003)(2950100002)(6486002)(22452003)(6306002)(6512007)(6436002)(575784001)(86362001)(6116002)(1076002)(6506007)(2906002)(68736007)(102836004)(4326008)(97736004)(186003)(478600001)(72206003)(26005)(3660700001)(8676002)(25786009)(966005)(66066001)(14454004)(5660300001)(305945005)(86612001)(81166006)(8936002)(10290500003)(105586002)(7736002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1033;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WXMFyoxMrjgIy1KXz0lA7ZI1/z6bhy9ziThtfLJJtH/ANNZMNIBo0sN6nwRy/IVIDp1ZDQFksOrSRhNLlsvXS1NaxMTDegu2ROf6mew7poo78QF3CgjmRJW/lWnSyqXR8zhEK7sSIxHz/9MopoMrhaxmJmZtGg+4wIwsQA5+XYw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b68b7b9d-c706-48c1-1bdd-08d58157afef
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:28.6509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1033
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62799
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

From: David Daney <david.daney@cavium.com>

[ Upstream commit a81507c79f4ae9a0f9fb1054b59b62a090620dd9 ]

o Socket data is unsigned, so use unsigned accessors instructions.

 o Fix path result pointer generation arithmetic.

 o Fix half-word byte swapping code for unsigned semantics.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Steven J. Hill <steven.hill@cavium.com>
Cc: linux-mips@linux-mips.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/15747/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/net/bpf_jit_asm.S | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/mips/net/bpf_jit_asm.S b/arch/mips/net/bpf_jit_asm.S
index 5d2e0c8d29c0..88a2075305d1 100644
--- a/arch/mips/net/bpf_jit_asm.S
+++ b/arch/mips/net/bpf_jit_asm.S
@@ -90,18 +90,14 @@ FEXPORT(sk_load_half_positive)
 	is_offset_in_header(2, half)
 	/* Offset within header boundaries */
 	PTR_ADDU t1, $r_skb_data, offset
-	.set	reorder
-	lh	$r_A, 0(t1)
-	.set	noreorder
+	lhu	$r_A, 0(t1)
 #ifdef CONFIG_CPU_LITTLE_ENDIAN
 # if defined(__mips_isa_rev) && (__mips_isa_rev >= 2)
-	wsbh	t0, $r_A
-	seh	$r_A, t0
+	wsbh	$r_A, $r_A
 # else
-	sll	t0, $r_A, 24
-	andi	t1, $r_A, 0xff00
-	sra	t0, t0, 16
-	srl	t1, t1, 8
+	sll	t0, $r_A, 8
+	srl	t1, $r_A, 8
+	andi	t0, t0, 0xff00
 	or	$r_A, t0, t1
 # endif
 #endif
@@ -115,7 +111,7 @@ FEXPORT(sk_load_byte_positive)
 	is_offset_in_header(1, byte)
 	/* Offset within header boundaries */
 	PTR_ADDU t1, $r_skb_data, offset
-	lb	$r_A, 0(t1)
+	lbu	$r_A, 0(t1)
 	jr	$r_ra
 	 move	$r_ret, zero
 	END(sk_load_byte)
@@ -139,6 +135,11 @@ FEXPORT(sk_load_byte_positive)
  * (void *to) is returned in r_s0
  *
  */
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+#define DS_OFFSET(SIZE) (4 * SZREG)
+#else
+#define DS_OFFSET(SIZE) ((4 * SZREG) + (4 - SIZE))
+#endif
 #define bpf_slow_path_common(SIZE)				\
 	/* Quick check. Are we within reasonable boundaries? */ \
 	LONG_ADDIU	$r_s1, $r_skb_len, -SIZE;		\
@@ -150,7 +151,7 @@ FEXPORT(sk_load_byte_positive)
 	PTR_LA		t0, skb_copy_bits;			\
 	PTR_S		$r_ra, (5 * SZREG)($r_sp);		\
 	/* Assign low slot to a2 */				\
-	move		a2, $r_sp;				\
+	PTR_ADDIU	a2, $r_sp, DS_OFFSET(SIZE);		\
 	jalr		t0;					\
 	/* Reset our destination slot (DS but it's ok) */	\
 	 INT_S		zero, (4 * SZREG)($r_sp);		\
-- 
2.14.1
