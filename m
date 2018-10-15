Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2018 20:34:56 +0200 (CEST)
Received: from mail-eopbgr680115.outbound.protection.outlook.com ([40.107.68.115]:9041
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992328AbeJOSddlsBf2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Oct 2018 20:33:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiStIHqlsHg1/2ZpyLPA4AKGzhjeRBZ6M2gK9Y5oFkA=;
 b=RNM7/uwYKw5gQxGkljp5icipAyz7/1r0ugl4aWuFMf0eteKm5JKY/hT/Kq/aeQ1xyKPtd8cS8tf/AefRiCFLrZNWzrklA4Bwc2CVY5eEj62TrmDgAz/4g1E/eZJluSrbymILP7MP9AirgOFbBPdsGOkAt7VbI5QzbCNkfuTxwyI=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1710.namprd22.prod.outlook.com (10.164.206.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Mon, 15 Oct 2018 18:33:19 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::781f:63:481a:efdf]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::781f:63:481a:efdf%10]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 18:33:19 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 1/7] MIPS: Remove unused MOVN & MOVZ macros
Thread-Topic: [PATCH 1/7] MIPS: Remove unused MOVN & MOVZ macros
Thread-Index: AQHUZLWLs+fhNkruUUaTIS6LTXgG0g==
Date:   Mon, 15 Oct 2018 18:33:19 +0000
Message-ID: <20181015183304.16782-2-paul.burton@mips.com>
References: <20181015183304.16782-1-paul.burton@mips.com>
In-Reply-To: <20181015183304.16782-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1701CA0018.namprd17.prod.outlook.com
 (2603:10b6:301:14::28) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1710;6:w3NeZqIL3g2WUiI6LdwKv+o2fTXvflZ+zgHkYDoTFIIIrvoe9mgAXT/Dzs5aArCtAInVty5OEE5oQS1F/GfITrYzvf9wQ19rIS+uwzHejjF/D3YovGDmE25yCZhvnFV2IeyW8om2+88ZCc5vgfqeqX501sKpBVg5e1P5Xdsqnt7+Qf7yiv6PH9n9Kv9qywCxQZx7Jk3GA6G1dWIuq/xTlnHSr6p8fsY2h4Sh/3uBYFJgAcFetlfBXGkQ2B2m612vNrWaMnKFc8GLwbbkkbM+w/R5bS4j/yWZHuiLoxN5wtRL5/3ha9FmunRkmruLSd9naBPmo/dr9nOAxvmAKvOT6Taw6srfkC9XY4J3n7TihG0ibq/yIj+G6ba6ablUsKHLrTLuh8CTfJIfQd1QBr5U7L7AzLaSS+d9TqJdcPRb2l7CQ0F+j2XdEhK1hn37/g85tUN9fRk7un0RUwfCW7L5MQ==;5:usY3zr9BKvmCHEq1KoPlCO7m3i2pOFr4pQO9gWhIcBONvbX4RIptZ9w3+FDpDi5KHxbCPHyf8hL/uK+V/8D0ahE9kvyqwHcR77dE9/sO49q2N/d3jyZzbrAaYK1/ywi6S8bN1rhCoaA6j24SeNtXeGJ1QKqeH4pS8awLJjU0n8o=;7:A/grytT/5w+kNDRIHjwaeXrNK/WLHEPq/vVLCqBUO8jiQjwmXv7suUd8hyXeB+mh35FL4DprcYwrMRvs5bZatOLXAqisgcSgs+842dk0A+/clllNaBouZldpnD8F7FEVlqTEO/ZMJNJqtlgVvEkje6z5hGnnh7lio4b8wjxpFw+fLWEQsWQ7ko2Q76FXYEl2OG7mBTw59c/qyNWGRHs3wgHe6Km4Lrgzj2cBDIwgHlEnPZZtgHjXA3FJcsYZCeHC
x-ms-office365-filtering-correlation-id: 8d527dda-952e-4fdb-706d-08d632ccadcc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1710;
x-ms-traffictypediagnostic: MWHPR2201MB1710:
x-microsoft-antispam-prvs: <MWHPR2201MB17109546D9949EF4B55A2ACAC1FD0@MWHPR2201MB1710.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3002001)(3231355)(944501410)(52105095)(10201501046)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(2016111802025)(20161123560045)(6043046)(201708071742011)(7699051)(76991067);SRVR:MWHPR2201MB1710;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1710;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(136003)(39840400004)(396003)(189003)(199004)(107886003)(5660300001)(14454004)(97736004)(81156014)(81166006)(1076002)(8676002)(106356001)(26005)(71190400001)(71200400001)(186003)(8936002)(3846002)(76176011)(25786009)(102836004)(66066001)(6486002)(6116002)(105586002)(4326008)(2351001)(5640700003)(508600001)(52116002)(486006)(6436002)(2900100001)(386003)(44832011)(6506007)(99286004)(5250100002)(476003)(36756003)(2906002)(7736002)(305945005)(2616005)(42882007)(6512007)(316002)(446003)(256004)(6916009)(2501003)(53936002)(11346002)(14444005)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1710;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: eKb1yiPPWQsMv1ZdP2vYL6RYKdmwSxTbg0g4CMRJKajYsEaq+HR8B6V2mktM/cNC11aDaUHm83DFF2rOxmLdBCMmFE8j8kyV4oF74VYT6fFEYnUQoZ4o0ja2gwrv6Xftcg4lyScGHaiDaI6/qL5UtDRv7937CALRl+DtslHcK9RveLdSx6jNNMe9B+XjA4KlLKngfTuLbvKTUR73Gg3aKnwV5QG0bTQlPCMAECqCN/XXigp2hJ+wGzxKrhP++v2lqzHptCIE1+L/RVKYrh4CPoAtYqOBesMQSFX7Mu9+ymEXa9Hx48//QpYDY06Tf1a6O4pZUQCV9Eu88P1Y2p/i7f1Px58zNSTgAxhnvkkGQDo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d527dda-952e-4fdb-706d-08d632ccadcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 18:33:19.3827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1710
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66855
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

We have macros in asm/asm.h to allow for use of the MOVN & MOVZ
instructions with compare-and-branch sequences providing compatibility
for ISA versions which don't include those instructions. However the
macros are unused, and appear to have always been unused. Delete the
dead code.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/include/asm/asm.h | 43 -------------------------------------
 1 file changed, 43 deletions(-)

diff --git a/arch/mips/include/asm/asm.h b/arch/mips/include/asm/asm.h
index 81fae23ce7cd..4e4f60597c72 100644
--- a/arch/mips/include/asm/asm.h
+++ b/arch/mips/include/asm/asm.h
@@ -176,49 +176,6 @@ symbol		=	value
 
 #endif /* !CONFIG_CPU_HAS_PREFETCH */
 
-/*
- * MIPS ISA IV/V movn/movz instructions and equivalents for older CPUs.
- */
-#if (_MIPS_ISA == _MIPS_ISA_MIPS1)
-#define MOVN(rd, rs, rt)				\
-		.set	push;				\
-		.set	reorder;			\
-		beqz	rt, 9f;				\
-		move	rd, rs;				\
-		.set	pop;				\
-9:
-#define MOVZ(rd, rs, rt)				\
-		.set	push;				\
-		.set	reorder;			\
-		bnez	rt, 9f;				\
-		move	rd, rs;				\
-		.set	pop;				\
-9:
-#endif /* _MIPS_ISA == _MIPS_ISA_MIPS1 */
-#if (_MIPS_ISA == _MIPS_ISA_MIPS2) || (_MIPS_ISA == _MIPS_ISA_MIPS3)
-#define MOVN(rd, rs, rt)				\
-		.set	push;				\
-		.set	noreorder;			\
-		bnezl	rt, 9f;				\
-		 move	rd, rs;				\
-		.set	pop;				\
-9:
-#define MOVZ(rd, rs, rt)				\
-		.set	push;				\
-		.set	noreorder;			\
-		beqzl	rt, 9f;				\
-		 move	rd, rs;				\
-		.set	pop;				\
-9:
-#endif /* (_MIPS_ISA == _MIPS_ISA_MIPS2) || (_MIPS_ISA == _MIPS_ISA_MIPS3) */
-#if (_MIPS_ISA == _MIPS_ISA_MIPS4 ) || (_MIPS_ISA == _MIPS_ISA_MIPS5) || \
-    (_MIPS_ISA == _MIPS_ISA_MIPS32) || (_MIPS_ISA == _MIPS_ISA_MIPS64)
-#define MOVN(rd, rs, rt)				\
-		movn	rd, rs, rt
-#define MOVZ(rd, rs, rt)				\
-		movz	rd, rs, rt
-#endif /* MIPS IV, MIPS V, MIPS32 or MIPS64 */
-
 /*
  * Stack alignment
  */
-- 
2.19.1
