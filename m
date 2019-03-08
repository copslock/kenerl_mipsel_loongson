Return-Path: <SRS0=hlE+=RL=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08639C43381
	for <linux-mips@archiver.kernel.org>; Fri,  8 Mar 2019 03:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B502220840
	for <linux-mips@archiver.kernel.org>; Fri,  8 Mar 2019 03:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="e1MKnrMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbfCHD3Y (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 7 Mar 2019 22:29:24 -0500
Received: from mail-eopbgr770138.outbound.protection.outlook.com ([40.107.77.138]:8462
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726270AbfCHD3Y (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 7 Mar 2019 22:29:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ks/6rNt885oyOq5h1jgkozgobX9BhlqX4Pwtxmu3Xt4=;
 b=e1MKnrMZNJIZL3Ga1XAStmPXeC/hn3kFKCpKcnhCn27bJHMtBoQnBp4VLKUsjK+honb5/uMdyNalTGPAKop6T/HTR/sY/ScKjKIHXxk//Uu0IMLsvNOcof+g2kxqBcgDOyra3gNYfaQ//QJVv5Q2c/5ZH7f11waU6wAbDtUsOMI=
Received: from BN6PR2201MB1124.namprd22.prod.outlook.com (10.174.90.167) by
 BN6PR2201MB1027.namprd22.prod.outlook.com (10.174.88.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.16; Fri, 8 Mar 2019 03:29:19 +0000
Received: from BN6PR2201MB1124.namprd22.prod.outlook.com
 ([fe80::d98e:5f7f:1b58:1cc0]) by BN6PR2201MB1124.namprd22.prod.outlook.com
 ([fe80::d98e:5f7f:1b58:1cc0%6]) with mapi id 15.20.1665.021; Fri, 8 Mar 2019
 03:29:19 +0000
From:   Archer Yan <ayan@wavecomp.com>
To:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
CC:     Archer Yan <ayan@wavecomp.com>
Subject: [PATCH] Fix Kernel crash for MIPS rel6 in jump label branch function.
Thread-Topic: [PATCH] Fix Kernel crash for MIPS rel6 in jump label branch
 function.
Thread-Index: AQHU1V8dzO7oBULX/0Sep/akK9JeAw==
Date:   Fri, 8 Mar 2019 03:29:19 +0000
Message-ID: <20190308032907.10110-1-ayan@wavecomp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR13CA0036.namprd13.prod.outlook.com
 (2603:10b6:a03:180::49) To BN6PR2201MB1124.namprd22.prod.outlook.com
 (2603:10b6:405:35::39)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ayan@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [115.205.2.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ac58d48-2412-48ad-3427-08d6a3763fba
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BN6PR2201MB1027;
x-ms-traffictypediagnostic: BN6PR2201MB1027:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;BN6PR2201MB1027;23:eJ0aPRJUQzttujM76eVEseVYUs9pITgPsbYI3?=
 =?iso-8859-1?Q?Jer1YWtTmse+6i764bN+7GJdSJM+GhUjZ9PvJO8PxKM04s7jAKAb28hLgO?=
 =?iso-8859-1?Q?QdOXH2eXcu8+FRk7wo7CGBBYailNM3d7Slan2rxMKutGT6s9z3DP6enfTk?=
 =?iso-8859-1?Q?6mQeXSlRiQn0IqueCzZDsct4u9OPOEbgsG6uGtZZ9Yfq7Si5fK/TFQSM91?=
 =?iso-8859-1?Q?RvXAWK5TFYQLD+xH/S2NNY9UJeg6K6PrbnkQ3D3TPB51vp3OA2jvvrGTj1?=
 =?iso-8859-1?Q?JivtmLc5ZLskyqElp4EsC/KfX4P3C9V102qKfSRvDNKLlo//V4eHpi5Q85?=
 =?iso-8859-1?Q?TLiuMo2tyBmDiXJ2lH1C1ZWoq4bY5yNMP4867ZC6MrxZCnCivdt9l7TVAN?=
 =?iso-8859-1?Q?mzzK7wxBzmz0Qv3RETISa/7SBHAIgWckZV1HJai70QVzMRsHrzJ5oFgz3t?=
 =?iso-8859-1?Q?wzJ0Sjsy5O0Dn6EESxU7MAyBSt2fjp1zySumISzDvOS/xm4XU4w/UD57oh?=
 =?iso-8859-1?Q?ILnoiHCLwBcPZSDvpgvmoPKOSBoagzcOjZfAelUjROCi8DGO1H/XqgNhfo?=
 =?iso-8859-1?Q?HhtUN62Z+PyqBbt78QCO9Z0kuiv5XkJHxXjAJOQ+hpmyqm97EVSf2llELf?=
 =?iso-8859-1?Q?tMOqIL4oPPnCdc8G4/+qR42+L5MU/gzBM/wtP7T7rHkEf95LOYbMMlp154?=
 =?iso-8859-1?Q?Zx37sTSfmjEp1agbBZEle2HMi+tL83LKvEfo5MS1WWbbXCs+UQkzJQtdkV?=
 =?iso-8859-1?Q?HpYKqYY2nIf/SsvSqeeH/OmOpZ5xkVnBMm5k+ILaVe6v5H7GCf+EiNfFXg?=
 =?iso-8859-1?Q?on6RJ22W7b8kyrgQgPLdw3nA0lMBIwVhbnaI1jyeMBmgmTj7WO5xC/zvLF?=
 =?iso-8859-1?Q?pATODExZm512+ukJ/73/kpO5lIZ+7Yh45oRwFq4BWpRf2mnDYvTxrmWdNf?=
 =?iso-8859-1?Q?WU5kBseqinDa/lch6KZ7JidVpX2HpoiL4jKC8ckTFJnQH4djPhiUZejWsP?=
 =?iso-8859-1?Q?3tkk8gSNSP5E8gl6R5l69bbzNSXpGee9mu5klKMZHtJiL+MqdO6RuHSP/P?=
 =?iso-8859-1?Q?xCsV5sb5soRv0ZBGOuYRr6O9PcoXzmL1Kyit2AURsRtaxdngVrHiJTKAFq?=
 =?iso-8859-1?Q?A5Zqek58kXvfMtFhduKGNGykW+eSpyhjHMrmXgZTn3iZqauyettfMhaV7Q?=
 =?iso-8859-1?Q?rljJO5LHIPtAtM3gcfTv+gsqM6fplERLvv9CZSWgUPr1Dpz/fuet/UDrhj?=
 =?iso-8859-1?Q?RGwks2FWUqAmnFacSyY?=
x-microsoft-antispam-prvs: <BN6PR2201MB102790C63447535897338A62B64D0@BN6PR2201MB1027.namprd22.prod.outlook.com>
x-forefront-prvs: 0970508454
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(396003)(366004)(39850400004)(189003)(199004)(386003)(6506007)(305945005)(6916009)(2501003)(14454004)(5660300002)(36756003)(50226002)(25786009)(478600001)(2351001)(2616005)(486006)(6512007)(186003)(7736002)(97736004)(6436002)(107886003)(2906002)(476003)(53936002)(6486002)(8936002)(106356001)(5640700003)(66066001)(8676002)(68736007)(86362001)(1076003)(52116002)(71200400001)(81166006)(81156014)(6116002)(316002)(26005)(256004)(3846002)(99286004)(4326008)(71190400001)(102836004)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR2201MB1027;H:BN6PR2201MB1124.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5YktIaoGL6sL5fT7NwvD8qJGgkHqs9FREQeemVoI06tVAABCGxRM8AjmdWz6FcVOVl51CsC2t5f+pzRqey/WUEqCY+stkhzgA3zz8vnd10s25JNTwFgBBH4Wcpsur4TIogoBWP7Nt1BHjB08ucvEUDcz22Ja6tj1JXcpJFPOuAEP43MdjRaWc3wJ41Rumz7T2SVoFP2U43j2pv8z8XyHOuQINYFmuGMJQa0tjyiJexYq9Q2B9P83aKfHkoAKr5IKNIFa63tEfEGHHQMRfD0Mmb7j+YSBwdvVqlxzlZd+nBy0jK2JFOlc7BivNqAkbORfQ/N+EwL8b8Tw/9ZrHraUBwGqgbJ1Jn0VIyn86o3jNzzO8pQv77LQAOj51bkTcdng0Fg0YmO5vkNjYH/AUTXxREK7pYlf6ro14msF5AIb5Ug=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac58d48-2412-48ad-3427-08d6a3763fba
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2019 03:29:19.4803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1027
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Insert Branch instruction instead of NOP to make sure assembler don't
patch code in forbidden slot. In jump label function, it might
be possible to patch Control Transfer Instructions(CTIs) into
forbidden slot, which will generate Reserved Instruction exception
in MIPS release 6.

Signed-off-by: Archer Yan <ayan@wavecomp.com>
Reviewed-by: Paul Burton <paul.burton@mips.com>
---
 arch/mips/include/asm/jump_label.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/jump_label.h b/arch/mips/include/asm/jum=
p_label.h
index e77672539e8e..e4456e450f94 100644
--- a/arch/mips/include/asm/jump_label.h
+++ b/arch/mips/include/asm/jump_label.h
@@ -21,15 +21,15 @@
 #endif
=20
 #ifdef CONFIG_CPU_MICROMIPS
-#define NOP_INSN "nop32"
+#define B_INSN "b32"
 #else
-#define NOP_INSN "nop"
+#define B_INSN "b"
 #endif
=20
 static __always_inline bool arch_static_branch(struct static_key *key, boo=
l branch)
 {
-	asm_volatile_goto("1:\t" NOP_INSN "\n\t"
-		"nop\n\t"
+	asm_volatile_goto("1:\t" B_INSN " 2f\n\t"
+		"2:\tnop\n\t"
 		".pushsection __jump_table,  \"aw\"\n\t"
 		WORD_INSN " 1b, %l[l_yes], %0\n\t"
 		".popsection\n\t"
--=20
2.17.1

