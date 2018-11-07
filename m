Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2018 00:14:47 +0100 (CET)
Received: from mail-eopbgr740095.outbound.protection.outlook.com ([40.107.74.95]:44352
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992922AbeKGXOJWnb3U convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Nov 2018 00:14:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIJvW3LvdAgkbe4ORaRWR0cHSxMMe4ZXnUSjQUHNzfM=;
 b=Aud2H1gOhp0PyFY/Wr4HDmNQc9ehqhh18rD+Dy2CggFBk7X6o+sM3FucdaWv0xRhRs/cgMj2T/VagTsHeTwghJ7zn7BCeHrL/+H0NVIpcsj4t4euo3gCf+YRFT2+Cr78OW6kgq7owHpyhkTux4hC9cBFElZuWsRcrp2JS24faUU=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1566.namprd22.prod.outlook.com (10.172.63.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Wed, 7 Nov 2018 23:14:06 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 23:14:06 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 12/20] MIPS: branch: Remove FP branch handling when
 CONFIG_MIPS_FP_SUPPORT=n
Thread-Topic: [PATCH 12/20] MIPS: branch: Remove FP branch handling when
 CONFIG_MIPS_FP_SUPPORT=n
Thread-Index: AQHUdu+UZCTbAZCJhUunp6vT+kE1pg==
Date:   Wed, 7 Nov 2018 23:14:06 +0000
Message-ID: <20181107231341.4614-13-paul.burton@mips.com>
References: <20181107231341.4614-1-paul.burton@mips.com>
In-Reply-To: <20181107231341.4614-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0028.namprd21.prod.outlook.com
 (2603:10b6:300:129::14) To MWHSPR00MB117.namprd22.prod.outlook.com
 (2603:10b6:300:10c::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1566;6:p5BzuKBLYefrbqA1Ska19sWrZdRk+WpB79cg+tJoeoVM60vQ2lsSNorwuFIqnkOH01tOMaUUsx2nXKnuj1aKbSbqhBvGIihok//2PoL8vPAJ4mEFXQtt/fkZJLxenlSP00lgnMz2VEjNo4n8pH+SGFB6/QmfLkInjybtZY8ApEtvqTZGPcsX0kP8sIYl0uiFAnAE4uZqY5vidJ+j3iMXDIwQNJw1sTySko1AiBL3SoNaelXS5ZAVGckkaHceYNwnxOvicCyeOZeaK459wlUk4wgGb5CD328puxAaVHZjl8UGnNrgI/8karHqlvR9F3QrqcX4WFRbmNGhC92UYC3sq8lppww++LBsxyG9z448SCWonN90bZ70gWJK+K7eAIYnaqWgG8MjKvbL6HZm25C1I3BGSI0cpk4aEPTclrwyZ8hxgJJY2Uk0W/C+7EhrYeTtfBGpitcHgPDhESQ6Mkgcug==;5:P6uh2ZF+FmRMGaWn50p6QN5taW0ciM/hjSJDVFsL4XHWK7g63G+aoL2g6Lx7rLyYdbRM4TLT6mfV+VmM0df4C6AqabYUppRqNUkfMiW0GrZacAKnBU95m277v/tJ7JnIp+4c/t6BZi8Bt3OQd39KQAQcVsveYooKrzJpupZbSok=;7:jnRf0VG82FlLlJFr0/kQgo7zksH1a8ATPosiA3+Yjf6VugwDWAUCkRGZYfJQJYiomhaye8UnxCaYOCW5yxicBbFjUA7+jbr/ZPRJW3ue7qNQyEMcF1fqJq/+rCI6B/+6b/tKjNRONS8kAKoNe+/qFw==
x-ms-office365-filtering-correlation-id: 59dba92e-f830-44c3-a4ed-08d64506b702
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1566;
x-ms-traffictypediagnostic: MWHPR2201MB1566:
x-microsoft-antispam-prvs: <MWHPR2201MB15666E8CBAF9BE3ACEC90985C1C40@MWHPR2201MB1566.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3231382)(944501410)(52105095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1566;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1566;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39840400004)(136003)(199004)(189003)(66066001)(2501003)(386003)(6512007)(53936002)(8936002)(6486002)(81156014)(81166006)(2906002)(3846002)(25786009)(6436002)(6116002)(71200400001)(102836004)(2900100001)(5640700003)(97736004)(1076002)(99286004)(476003)(4326008)(106356001)(186003)(42882007)(52116002)(105586002)(6916009)(71190400001)(2351001)(44832011)(36756003)(76176011)(6506007)(107886003)(508600001)(8676002)(68736007)(305945005)(316002)(5660300001)(11346002)(2616005)(14454004)(26005)(256004)(486006)(446003)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1566;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ozUqOv33nf7RBNe/+/X/T6mKgz8NGUicjWbSZNzDoaK45nVVZ1NFbExCA6FDqHebZuIkRU8ukFDPs47OLFrAQc7JDgGdjn0PJe+EpDvU5PtXaPFU9l7GJ6XwYQgLhrZmJOKNRvKkntL9ZIf5tq9L5aPcvwkpB/SQfGrsprpIclbr+G8WaCPxEb9y0BgmajFY44/nB1lXQwOvaqZ8fKDleVTFC+6hBgOcgfd8CZ5NbdiYtMbVSu6+kjL7F+76Id3jqqGjrQ283TfTlz9T/rml99wjjvRAHvzQXowv79YmvCpPfJsfU/v4k3u3jBlulC2CLdksTzOzN7dE17nTE/a444FFDRBBGLGJVqBn7+Mi74k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59dba92e-f830-44c3-a4ed-08d64506b702
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 23:14:06.5250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1566
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67147
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

When CONFIG_MIPS_FP_SUPPORT=n we don't support floating point, so remove
the floating point branch support from __compute_return_epc_for_insn() &
__mm_isBranchInstr(). This code should never be needed & more
importantly relies upon FPU state in struct task_struct which will later
be removed.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/kernel/branch.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index 74f12a91bfb4..2077a4dce763 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -58,9 +58,6 @@ int __mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 		       unsigned long *contpc)
 {
 	union mips_instruction insn = (union mips_instruction)dec_insn.insn;
-	int bc_false = 0;
-	unsigned int fcr31;
-	unsigned int bit;
 
 	if (!cpu_has_mmips)
 		return 0;
@@ -139,8 +136,13 @@ int __mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 					dec_insn.pc_inc +
 					dec_insn.next_pc_inc;
 			return 1;
+#ifdef CONFIG_MIPS_FP_SUPPORT
 		case mm_bc2f_op:
-		case mm_bc1f_op:
+		case mm_bc1f_op: {
+			int bc_false = 0;
+			unsigned int fcr31;
+			unsigned int bit;
+
 			bc_false = 1;
 			/* Fall through */
 		case mm_bc2t_op:
@@ -167,6 +169,8 @@ int __mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 					dec_insn.pc_inc + dec_insn.next_pc_inc;
 			return 1;
 		}
+#endif /* CONFIG_MIPS_FP_SUPPORT */
+		}
 		break;
 	case mm_pool16c_op:
 		switch (insn.mm_i_format.rt) {
@@ -416,8 +420,8 @@ int __MIPS16e_compute_return_epc(struct pt_regs *regs)
 int __compute_return_epc_for_insn(struct pt_regs *regs,
 				   union mips_instruction insn)
 {
-	unsigned int bit, fcr31, dspcontrol, reg;
 	long epc = regs->cp0_epc;
+	unsigned int dspcontrol;
 	int ret = 0;
 
 	switch (insn.i_format.opcode) {
@@ -667,10 +671,13 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 		regs->cp0_epc = epc;
 		break;
 
+#ifdef CONFIG_MIPS_FP_SUPPORT
 	/*
 	 * And now the FPA/cp1 branch instructions.
 	 */
-	case cop1_op:
+	case cop1_op: {
+		unsigned int bit, fcr31, reg;
+
 		if (cpu_has_mips_r6 &&
 		    ((insn.i_format.rs == bc1eqz_op) ||
 		     (insn.i_format.rs == bc1nez_op))) {
@@ -728,6 +735,9 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 			}
 			break;
 		}
+	}
+#endif /* CONFIG_MIPS_FP_SUPPORT */
+
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
 	case lwc2_op: /* This is bbit0 on Octeon */
 		if ((regs->regs[insn.i_format.rs] & (1ull<<insn.i_format.rt))
-- 
2.19.1
