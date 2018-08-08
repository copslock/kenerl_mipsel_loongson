Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2018 00:58:00 +0200 (CEST)
Received: from mail-cys01nam02on0099.outbound.protection.outlook.com ([104.47.37.99]:29872
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994749AbeHHW5MLvbfA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Aug 2018 00:57:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiTkL2ewMZPGJwaaCuW9vFlOwYVgo97I4CE6ProNI3w=;
 b=bxqewGG2VxdSTj9pz+5QjWJROVxE+sZtX95++ulSXiX1EE1kxGSzyC6+qpgrfRORKuOXTxP6jyRGX+SLuWsQn7DG5S/FjU7YVvuKjXC/EWsFgwsL2F+opmTfOLi+cTPTfK858NSUbJ7GIBkfDu8AWS1hwbjN8igPnU63MXsU81k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 SN6PR08MB4942.namprd08.prod.outlook.com (2603:10b6:805:69::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Wed, 8 Aug 2018 22:56:58 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     linux-mips@linux-mips.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-alpha@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-arch@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        Matthew Fortune <matthew.fortune@mips.com>,
        Robert Suchanek <robert.suchanek@mips.com>
Subject: [PATCH v5 4/4] MIPS: Workaround GCC __builtin_unreachable reordering bug
Date:   Wed,  8 Aug 2018 15:52:25 -0700
Message-Id: <20180808225225.24450-5-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808225225.24450-1-paul.burton@mips.com>
References: <20180808225225.24450-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR2001CA0004.namprd20.prod.outlook.com
 (2603:10b6:301:15::14) To SN6PR08MB4942.namprd08.prod.outlook.com
 (2603:10b6:805:69::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e657357-0c61-4a81-c4aa-08d5fd823f45
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN6PR08MB4942;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;3:Nf+hqMnQ96iUusiNBi/WYYj6dz37l8NxAcjgbHt1NNZSQ3LNpvUcmtK1jqoGOsB6xN37C2al4N3jkugI7ZbYmkV6XKpNi0hbcjc5n+1WBIqhAuddQdESTfml4RPoGZ/L89el3hIn8j2K91JpQ2KT2/VNzysUgz05Az/mPAL1pke0ikOv9ucmNwgbUlZGEhB6fm065XygaX4E22WTZiMiF6PLWFJMkgSS5z7yOtBEzLGVcq/RgeQKSqjvX4D7yTHi;25:SWl5zreKl7Ns4laQ5rJoNVVwEm6iV4HeXL50TuHhSLeBndyzPT+97vQC82RB5gXtuMwCijYLiNI26/wGn54NgncY4DfqQhmBF/HyJQuPoFq+tL2UY5LTGHkNubfJFPYjuA0QIsWGBjTzlmeOf0WuG3Dn0E9ZCu1jAJciS+gD7eC9qd1DZYyH2E8bIay3X5R5/PidZCSJwAHqiCp2mG/WzcAB9aRGaM03uBKEB1ZhZlMO135N4GMXepjeW6Prx3td98ZwP+VSiQPTEOSKfMHO/xoYZLJhwemF1vXL7Yqrf00Bn1pb2i/93lcHb7GcM7Cbc7C2cZcqj82lzsIfftB1vQ==;31:IRwQP4tgvY7Cc5ETwzvY0yhPYrk9lBxUmMRgHkdRlSFOr6yCswXq18bR38j999k4JboQUH/+bI2eVhOm2WAZkQNM3X2vlWmU5D1TNfobYDbaOPv2L4UWFg4XlsAw9B7RGyT3K0ahcoOdNZ59JTydpn6BhC0kBehbUc5S/3/hm6enRxJBz5bxDSTNP9sCpK3OTDPuwcqI/BwLXdaaY1WB9il3Kn9OSFdeUI0vVV+ir5M=
X-MS-TrafficTypeDiagnostic: SN6PR08MB4942:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;20:6Fg5w4cBkFsCJsuV3/ThwbU6WuhOLohhtob0QB6h6OzLM0PrcQ04qLvfxC0TXYK9S+qYtJ5duvZ0wj1VQHKw3N55t0QzibCOynopld9MWwhhZV6HjBQ7PjUA+o71n+TPI46DwSAibFWOZfiW8hGCbqjpHWRLJ5A6oIVlYCN7OFut//MIIRQS11f6TmDL1PxCowXphXOnNXA95KU8ry2O95dRYL644XpdAfvVjUNuyCDDznj+mief8Wz/7dzR5lbU;4:CYbVDggaTn1lzzwXmRNJUn6I8HLIJ3wVO5z4soMjyhXNC2NApjHpDlyuxrS4E9sU4DCQ4PNuXxHwXXtOw08VY8NOjB32WzPFJpOxtZ96ZRlGh4NhI+/p4H67+Y4HuCRckIu898of7redmWxDxn4o/3A/SVXcaMrJ+ubipvvqvd/7BpXkGct0/jKYX7ueuj894LlTJCYtApEHJ56vUolIzF3v0ZyaO/FUw8dBSgJKguBh9kwue1zwR1DfMEzC+4dYAhw27qmNe59/3v/v73uuJBmhqQK6woEfNhAi6UitKBefwpDDF5YasmtEfkny1i73OqBFrsdWTEGL5VgLHfxdMZWCxHDlhbmxyN+pAO/KA0c=
X-Microsoft-Antispam-PRVS: <SN6PR08MB494275C4807C3DA89946F230C1260@SN6PR08MB4942.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(22074186197030)(183786458502308);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN6PR08MB4942;BCL:0;PCL:0;RULEID:;SRVR:SN6PR08MB4942;
X-Forefront-PRVS: 07584EDBCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39840400004)(376002)(346002)(136003)(366004)(199004)(189003)(6306002)(6486002)(25786009)(44832011)(66066001)(47776003)(42882007)(476003)(2616005)(16586007)(446003)(11346002)(53936002)(14444005)(107886003)(956004)(486006)(39060400002)(316002)(6512007)(54906003)(2906002)(4326008)(386003)(1076002)(69596002)(3846002)(305945005)(6116002)(36756003)(2361001)(478600001)(50466002)(7416002)(48376002)(97736004)(7736002)(76176011)(186003)(16526019)(2351001)(8936002)(966005)(6506007)(50226002)(53416004)(8676002)(106356001)(68736007)(51416003)(81156014)(81166006)(6916009)(105586002)(26005)(52116002)(6666003)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR08MB4942;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR08MB4942;23:3777XSSdiExfDPKhgpJdBdYCYu95bzkFbPMtJ86cf?=
 =?us-ascii?Q?WBv+Z4PkdnUixrbAWycggxH4PKX9ZHEXBqPcq5tmY6/CPYrPsEo//0kj0YZ0?=
 =?us-ascii?Q?9hcai8pHjlPeGX+RkGBR2PZ3bI10to2TbgDc3RwyVZ9kFEq6KdxLRA6qgarV?=
 =?us-ascii?Q?D61g7gAM6RvVKGFQ+qnTsVQ5ujCHv+ia8aOjNyoRS4iCaVKHTStorbXtiIKR?=
 =?us-ascii?Q?nIUvj+lQXYDyMDS5cYUEIrlOVkc3Uyn/sUUGN3tk25pEP0q7rbB3zBCY9Wvl?=
 =?us-ascii?Q?XnMrDQa0pS0yEPfZn8g+72otBKzFqDmBRGiwhoQqlZNNqE5I3yWwgHiTxO8B?=
 =?us-ascii?Q?OtCBpNAboUYqtO+0erShJZ5udJjkAUvf8Cq5+rCIrRVjok2lHmnpNaJBU97n?=
 =?us-ascii?Q?6ThCTjyeck7yNogzrDiUCXmiLIehmLpNQi+TfhX0dbMHcZZL2i2f3HmTrvjO?=
 =?us-ascii?Q?hst2VnhPLc8IbtGAYiMP5D6KucNj2saqwSyKVNbVvbCLKJdGNVBiKY/D8aX2?=
 =?us-ascii?Q?YuJI7g9p/IZwLF/yFva9xDrMZYjJ7+V5s1BjZTltVPMMzIiyJyfJWbC20gW5?=
 =?us-ascii?Q?6wJavOnUEmEQ/l8p8ZLPJyEJOjGoGmhVXqHJ2tmjFVzqMuhe4N2QfVxd/rnV?=
 =?us-ascii?Q?GjN4ZBeELk+qNBkToM9AnUQXCHW4nAAnO4JNtBdO+6sPPtbtp0zfZ5+0buLk?=
 =?us-ascii?Q?ZtiBC4GLkbBbA5/K6I1HPXPL/1MukICaXns/NS1yUeQCENQdfrJHLl+GxgmX?=
 =?us-ascii?Q?4tIUkjZVdjOJ1N6v0YqKG1iSgVsoEHCvnBF+JDMkZZQuwJUu7oAohyZ36Udw?=
 =?us-ascii?Q?Tvjkn+bwJNKghQ8UCAgFKLzBwRZ77i46WTwiZL/vRpLAnWtq/lSmLgkoiu63?=
 =?us-ascii?Q?9UH9l8561pwa5I0vbHXdRzafhphzOCxHror95H+af4xuyyBcTvu2tQ+UGFyv?=
 =?us-ascii?Q?rwZoHIdcUSJJPXrmQxKm001COhTzypCXw1YwHEuX9wcps75DddNp8p2fW8en?=
 =?us-ascii?Q?zz1JoIeCBKR7oz5sbsOB/7Jzq8+dd6p0c/dzqST3V4DfsNwIwtK2HZJH/Na0?=
 =?us-ascii?Q?/leOanIsckaGFGvzH7GxKWTyZ2rtuO6obdhQ3ZdiFBzeNKl0C7O3pT10WomI?=
 =?us-ascii?Q?pQzpC3nA0tPdLwzBAck6KJ5mMdOAeu2wOsF3jJEw8EeEuOzvTtAH9/xmqXot?=
 =?us-ascii?Q?EmILL5DrFnduNGIUhU0nVZNnKN1Mk0ihCXH7Y6daHIrEmFGc5EsnKQYBBrr0?=
 =?us-ascii?Q?VqtJCIc0vXTuLbRv+gd/TV+fkH1YGLwdJNxzfXA3BxuymL8UYJ8P26v0DRfz?=
 =?us-ascii?Q?/fMegoUzb3ap6BU/joKTPsZbFaSPNcTZJ5fNpsPNppFxWgO+xv5rkPh04675?=
 =?us-ascii?Q?3cwReao63PcB7KGrWwTD8Sbtu4JJqT5iuQ1gQSnxUi6P5mMDBj9/d23vj/3E?=
 =?us-ascii?Q?LSWtdooCA=3D=3D?=
X-Microsoft-Antispam-Message-Info: Dd559bVNjphbT5ddJpTuvYBZOBQttAjRX0skNzg7bVyHuyv/Yw2V1HlawBsgD5xEf/Oe+6x29X7pPggv3vk1vhdU0j3C8seuaby3pFc0rF5JXdBZmH77rGaW0pVS6km/mdeGECpmDHJrEK9me07E/F8zIOL+Sv8vjKXFzMOmM1xziJualLg2N3uvhDK+vh293zfjz7hyUSWbV/K2hraWZnTcpqtlwKYnDh/84fAZci+KI5PBrZ0s+kjZa08M5Fni8k7hW7WZc6EgGmTxzknmiYIQIbpuaI72Q6IIc9hUA4rezP+eB3wrjxrULZi6HZa8v0PmDrvpGZotaFB/jVn1QZJ1w6MdPGGv0xcZSCLevG4=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;6:sHsdNrMeXlimIBI8ZFknpLJUDy618O8VdLu7Eq/jnB0KC78pkKkrkuHcofVprxBY0xMIEb0bssKjNIwKVII+wNHNrpzA5kaSPL/GYa2Mjyf9iVq9pZwnexGc4jgp6NDCygNNOJKcl29DTeI8c6utdS4nStSBWKjcnj7b/n2f36NCfSdijn9uW/MzJxslgltdYk0mo3NYB7aOi9mUUPMFk6W8F3L3KtW1Z+Ip94gYYTYYcMMrLBiT6dvdLRJIvrH77yjVO4mTe6T1MNieLltGsHHAxY1nGjAog1WiTMkf8aGRMcK4xk6ODiy1KMa5vaz4zqHgFOHHq8AZyTltLbt8TLhmeA+RJmA16RterscdN41m6fhtLONJ8oH8n/sYcNzWREoqAlA8+LWwxmpwtA9NteHqBftFUdLpEeL4TwVeO7R4NfgKfPkDoThPJiMuzui5wYJkahhum/lRdsOjx7SbTg==;5:xWN2fhU0+7fRrUJATyj9D/WajDp2oQcVVZzWdio850uMtkkjvJt1YhvYfC6E93RkaErg0SmgYu4ourSWPCCGuMJMy1fwtjG0zz11AZmSYN1ho+ZC1dVxURx1JUbTVw0PNMMRG57luXlQjoPvO4RNHtKQ2Or+nBqd+rBaLAxCTuk=;7:pV4FznTNy/z++esjmj7qWg3vg0sXrJi8J6Nqcyh72ypKY99j2qqxNECnwX9R0kk2rBKAasHCp1ZiyhFVnxHg8fITZmOXAHSLwTkInzTN8K+HhWY8dwsToYc6QcVAdEF6tSlwkscXj//9Q9WRyjSDYlNRP5+fXJtpkrYGgSmmNvJB/ED8hWPuiJ1ieQSe6pFOjRoo3QlMcGd9ryshBezuxsrOFB2tpo9T/lcEYg+Do5ga6BJkNzSqLu27aBBeHS+f
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2018 22:56:58.0357 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e657357-0c61-4a81-c4aa-08d5fd823f45
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4942
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65485
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

Older versions of GCC for the MIPS architecture suffer from a bug which
can lead to instructions from beyond an unreachable statement being
incorrectly reordered into earlier branch delay slots if the unreachable
statement is the only content of a case in a switch statement. This can
lead to seemingly random behaviour, such as invalid memory accesses from
incorrectly reordered loads or stores, and link failures on microMIPS
builds.

See this potential GCC fix for details:

    https://gcc.gnu.org/ml/gcc-patches/2015-09/msg00360.html

This bug can be worked around by placing a volatile asm statement, which
GCC is prevented from reordering past, prior to the
__builtin_unreachable call.

This was actually done already for other reasons by commit 173a3efd3edb
("bug.h: work around GCC PR82365 in BUG()"), but without the MIPS
specific .insn, which broke microMIPS builds on newer GCC 7.2 toolchains
with errors like the following:

    arch/mips/mm/dma-default.s:3265: Error: branch to a symbol in another ISA mode
    arch/mips/mm/dma-default.s:5027: Error: branch to a symbol in another ISA mode

Add a MIPS-specific definition of barrier_before_unreachable() which
includes the .insn directive in order to satisfy the assembler that
branch targets are in fact code.

The original bug affects at least a maltasmvp_defconfig kernel built
from the v4.4 tag using GCC 4.9.2 (from a Codescape SDK 2015.06-05
toolchain), with the result being an address exception taken after log
messages about the L1 caches (during probe of the L2 cache):

    Initmem setup node 0 [mem 0x0000000080000000-0x000000009fffffff]
    VPE topology {2,2} total 4
    Primary instruction cache 64kB, VIPT, 4-way, linesize 32 bytes.
    Primary data cache 64kB, 4-way, PIPT, no aliases, linesize 32 bytes
    <AdEL exception here>

This is early enough that the kernel exception vectors are not in use,
so any further output depends upon the bootloader. This is reproducible
in QEMU where no further output occurs - ie. the system hangs here.
Given the nature of the bug it may potentially be hit with differing
symptoms.

Fixes: 173a3efd3edb ("bug.h: work around GCC PR82365 in BUG()")
Signed-off-by: Paul Burton <paul.burton@mips.com>
[jhogan@kernel.org: Forward port and use asm/compiler.h instead of
 asm/compiler-gcc.h]
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Matthew Fortune <matthew.fortune@mips.com>
Cc: Robert Suchanek <robert.suchanek@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mips@linux-mips.org

---

Changes in v5:
- Comment & commit message tweaks.

Changes in v4: None
Changes in v3:
- Forward port to v4.17-rc and update commit message.
- Drop stable tag for now.

Changes in v2:
- Remove generic-y entry.

 arch/mips/include/asm/compiler.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/mips/include/asm/compiler.h b/arch/mips/include/asm/compiler.h
index e081a265f422..1e9548faf9c7 100644
--- a/arch/mips/include/asm/compiler.h
+++ b/arch/mips/include/asm/compiler.h
@@ -8,6 +8,36 @@
 #ifndef _ASM_COMPILER_H
 #define _ASM_COMPILER_H
 
+/*
+ * With GCC v4.5 onwards can use __builtin_unreachable to indicate to the
+ * compiler that a particular code path will never be hit. This allows it to be
+ * optimised out of the generated binary.
+ *
+ * Unfortunately GCC from at least v4.9.2 to current head of tree as of May
+ * 2016 suffer from a bug that can lead to instructions from beyond an
+ * unreachable statement being incorrectly reordered into earlier delay slots
+ * if the unreachable statement is the only content of a case in a switch
+ * statement. This can lead to seemingly random behaviour, such as invalid
+ * memory accesses from incorrectly reordered loads or stores. See this
+ * potential GCC fix for details:
+ *
+ *   https://gcc.gnu.org/ml/gcc-patches/2015-09/msg00360.html
+ *
+ * GCC also handles stack allocation suboptimally when calling noreturn
+ * functions or calling __builtin_unreachable():
+ *
+ *   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82365
+ *
+ * We work around both of these issues by placing a volatile asm statement,
+ * which GCC is prevented from reordering past, prior to __builtin_unreachable
+ * calls.
+ *
+ * The .insn statement is required to ensure that any branches to the
+ * statement, which sadly must be kept due to the asm statement, are known to
+ * be branches to code and satisfy linker requirements for microMIPS kernels.
+ */
+#define barrier_before_unreachable() asm volatile(".insn")
+
 #if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 4)
 #define GCC_IMM_ASM() "n"
 #define GCC_REG_ACCUM "$0"
-- 
2.18.0
