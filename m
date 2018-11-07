Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2018 00:06:12 +0100 (CET)
Received: from mail-bl2nam02on0092.outbound.protection.outlook.com ([104.47.38.92]:7296
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992824AbeKGXFPY0HeU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Nov 2018 00:05:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBQVjMOyR0JwVPesWddB1TSIOUKwI3VzUrjNj3TOg0o=;
 b=pn/wFEQSnDnTuGxNltITSwIW6O/hK2FPhyFE/W1qxXBkbXE7o1Gle84KEU+DzKK9fRtxDonlBkf+eNUUIGPS6OdUVEtAI43siayje9Hzn7fqFr6Wkdpr/mxRynKkJ3Uj/j3e6UvklHWEP/8JIKppyCDHuvPx3BwLXovPZ9nWLLE=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1119.namprd22.prod.outlook.com (10.174.169.157) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.28; Wed, 7 Nov 2018 23:05:08 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 23:05:08 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH] MIPS: Remove GCC_IMM_ASM & GCC_REG_ACCUM macros
Thread-Topic: [PATCH] MIPS: Remove GCC_IMM_ASM & GCC_REG_ACCUM macros
Thread-Index: AQHUdu5THmlJicKOe0em0G//s/og1A==
Date:   Wed, 7 Nov 2018 23:05:07 +0000
Message-ID: <20181107230454.3232-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0051.namprd19.prod.outlook.com
 (2603:10b6:300:94::13) To MWHSPR00MB117.namprd22.prod.outlook.com
 (2603:10b6:300:10c::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1119;6:zT3Np1kbQfg16+Jtfwk8p6w6jMlispCvkawWiAgfSYpI46QllWLiUAXmAVj1cKmPiBzAl1E6+e7OCmyqGwrIZKODlg+XdhVosQvPPJ/NveaEX4A4eA1lIbnezPdJOWLu1fE5Rgr33GQtJRz+XdD5OuOjA7oDiMAw8n6YgfEKYR6VhvsCfSCtXEl+jqB2bXFtMAGaVtmPnls3UDcKbnAa97946C43jr9WwpktmtPXKqxhi5AZmMTjuozq1ZcE9n3kmgqs5zsWAZHycTjl7nK4XAd9+QmiNhzSYB3Zchu/UbCg5Dn4m0+3f1JOGOTL/ff3vr5CwfOmEFfRYepX8RrrB7ry9jPFdVH6emldVyAybSPogTDBQPFz2kZjXyxqwAJjvDpnkBmQv9MFsGMfUQuSAiWvNt41+Ab30eRA4tvkDKdc7yPAQOUXfXeF9vK//p/fUGEBsMlucpsyoisMnUGXtA==;5:Z0WtyOn1/fk8rigApGzz3e4mE7yScYyRVUPxtsshMyPFAGANoqcX1GNN7/XG0JfwWg17WAX+Va3uFVnuaWz0CUhXzJVxeMPhy9WCiIfUp+BFPyY4MIfwI45nf+1dHNyGvMsUBdI1Z4PQwHBBv7Vg7kTU/mTuTQIPrO+YNOjc4Sg=;7:b/nOBdawh3alYwndcLO8c6qAVtiykAlomEnkrKSnSG/8ZQ0f0ElX1deX7WfUj0xcVDEFSXUB4rSOuBLx55ll4kwkl+nTNrg+TO3gOd8T9uDBot3YBNgTGn0uawCAN3h0H1SVZ8wkTIDB9kolo9wZ2Q==
x-ms-office365-filtering-correlation-id: 7c362edb-4844-460c-709d-08d645057576
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1119;
x-ms-traffictypediagnostic: MWHPR2201MB1119:
x-microsoft-antispam-prvs: <MWHPR2201MB1119123911C2ECDD696B9455C1C40@MWHPR2201MB1119.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(93006095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1119;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1119;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(346002)(39840400004)(396003)(189003)(199004)(2900100001)(6512007)(81166006)(81156014)(68736007)(256004)(107886003)(8936002)(386003)(6486002)(6506007)(52116002)(6436002)(99286004)(42882007)(2906002)(7736002)(71190400001)(5660300001)(486006)(6116002)(3846002)(1076002)(102836004)(44832011)(2616005)(186003)(26005)(53936002)(476003)(8676002)(25786009)(2501003)(36756003)(508600001)(316002)(2351001)(14454004)(66066001)(97736004)(105586002)(106356001)(5640700003)(1857600001)(71200400001)(305945005)(4326008)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1119;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: PbSqXNtp5f6lADv0eRX7g/bcJ/pKvx0BHaK3xIXAgN9S/p5CzyWS9OK3dok/QoJwYyODFoQBlFS02yZ7CPvOHiWzjmKh1bkiku3zLQnkeoKuTR9WgaCQh/TfZFrEe4cobaRIUTUdTl7befXUBNI6bNyMWv0Rq4tvb/VVf+q+WiX6KJuqQp7Pq/Bz0jbqmnrHUTYSAhH3BSnYo5duu5DVsd45J7MlUfKik4S8lH66QTjwVQiBI9Y6qiWM98hOk2KJ9nnogLjfolilkAG1NpXGvSIroafgBAsskFNjSAQMowFc6o2kjLo62VclnqNLUlRb5ij6bK0PBp/TtzjaCMgzYeThsSTUQ8KAkDgJv4ZaLZ8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c362edb-4844-460c-709d-08d645057576
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 23:05:08.0564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1119
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67135
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

asm/compiler.h defined GCC_IMM_ASM & GCC_REG_ACCUM macros, both of which
are defined differently for GCC pre-3.4 or GCC 3.4 & higher. We only
support building with GCC 4.6 & higher since commit cafa0010cd51 ("Raise
the minimum required gcc version to 4.6"), which makes the pre-3.4
definition dead code.

Rather than leave the macro definitions around, inline the GCC 3.4 &
higher definitions into the single file that uses them & remove the
macros entirely.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/include/asm/compiler.h | 8 --------
 arch/mips/kernel/cpu-bugs64.c    | 4 ++--
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/mips/include/asm/compiler.h b/arch/mips/include/asm/compiler.h
index cc2eb1b06050..9196fca4335d 100644
--- a/arch/mips/include/asm/compiler.h
+++ b/arch/mips/include/asm/compiler.h
@@ -43,14 +43,6 @@
 #undef barrier_before_unreachable
 #define barrier_before_unreachable() asm volatile(".insn")
 
-#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 4)
-#define GCC_IMM_ASM() "n"
-#define GCC_REG_ACCUM "$0"
-#else
-#define GCC_IMM_ASM() "rn"
-#define GCC_REG_ACCUM "accum"
-#endif
-
 #ifdef CONFIG_CPU_MIPSR6
 /* All MIPS R6 toolchains support the ZC constrain */
 #define GCC_OFF_SMALL_ASM() "ZC"
diff --git a/arch/mips/kernel/cpu-bugs64.c b/arch/mips/kernel/cpu-bugs64.c
index c9e8622b5a16..bada74af7641 100644
--- a/arch/mips/kernel/cpu-bugs64.c
+++ b/arch/mips/kernel/cpu-bugs64.c
@@ -39,7 +39,7 @@ static inline void align_mod(const int align, const int mod)
 		".endr\n\t"
 		".set	pop"
 		:
-		: GCC_IMM_ASM() (align), GCC_IMM_ASM() (mod));
+		: "n"(align), "n"(mod));
 }
 
 static inline void mult_sh_align_mod(long *v1, long *v2, long *w,
@@ -92,7 +92,7 @@ static inline void mult_sh_align_mod(long *v1, long *v2, long *w,
 		".set	pop"
 		: "=&r" (lv1), "=r" (lw)
 		: "r" (m1), "r" (m2), "r" (s), "I" (0)
-		: "hi", "lo", GCC_REG_ACCUM);
+		: "hi", "lo", "$0");
 	/* We have to use single integers for m1 and m2 and a double
 	 * one for p to be sure the mulsidi3 gcc's RTL multiplication
 	 * instruction has the workaround applied.  Older versions of
-- 
2.19.1
