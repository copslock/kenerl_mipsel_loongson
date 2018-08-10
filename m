Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Aug 2018 19:05:58 +0200 (CEST)
Received: from mail-bl2nam02on0128.outbound.protection.outlook.com ([104.47.38.128]:53280
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993848AbeHJRFxN0K22 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 Aug 2018 19:05:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pv0criDiwdKU54Zeu5uzezH5PuQQMp8hpCGL19Cz+/U=;
 b=HmIjbXnr27Xr6jUvhFN8/jTttAEA7vX5RP3aQhYwQfo4yL50MG72h2cuJNsY+sic77khY1qubv0uPCgz3oe5fRHcqfNmz/h8f/m36nbRKNkxCsPuNx0JptulmgCFDjX8Jed83y05e7B7rU4h9NH1sLx/t9HQLogHKGXG1R7vD6A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 BYAPR08MB4936.namprd08.prod.outlook.com (2603:10b6:a03:6a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Fri, 10 Aug 2018 17:05:40 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-alpha@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-arch@vger.kernel.org, linux-um@lists.infradead.org,
        Paul Burton <paul.burton@mips.com>
Subject: [PATCH v7 4/4] MIPS: Workaround GCC __builtin_unreachable reordering bug
Date:   Fri, 10 Aug 2018 10:05:11 -0700
Message-Id: <20180810170511.10621-1-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809185604.qqamyfd3etdacy3a@pburton-laptop>
References: <20180809185604.qqamyfd3etdacy3a@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BN6PR10CA0031.namprd10.prod.outlook.com
 (2603:10b6:404:109::17) To BYAPR08MB4936.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4f31f34-178f-453e-4d8c-08d5fee3814a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4936;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4936;3:7yH2fk5yfb3SIB0JDsyboTFRPdqpWVbp4lWW8w2TaldUyQ3MYY9iX/1qrFPQVsuJxWv0bCYJAjx1vhnUCRN2vq92CqjYuYdiA4Q6M6M8WwOWCkJExJuEjRIyGIW038b4uAgqr0c0xYbrBLm8rGB/TsTLybN5egUJKcaIeiwnRUuXhslpbpOeTYMoP44zWR2EJuO0thl0qJbTJPBCyF/+n+MgU/LbJqUpzlqhIYKClG2CBn6Y+NJe337rJLunBgBl;25:jpccjaagC5+Er4umev4Z4N2N8AygxMrYnnKx106Rt8WHKyVh8YwKwPV74Lr6CkTG2ElM5e20nP7GIr8PoUWtweHPPHcxev0Y3U3PZF+NX4r+xpTonyQ0mcvWQKmrBUQBPeIfaIjeBDnRJFIdHtM5f3glXykP6mRKKTUj12GCkFWdhwbSej4B7sY8vyH4l6hR91aKOHMsMkQLQPKhGOw647UDEn4lvvOBSmizlrBdDpk+k+HuRKH7fUCRDxYqsHurBq7rcv+8LxKoJ1zjEpqcz0oZYmbB/ooqDiwKrcpN8EhdaCVeS4ANhu90CaEhil4lcAc7psyFOKCshLdPplk9tw==;31:DbsZ1maIpO1Ljv+0qfoQ+wrhAXPgJPJBsWoz75QdI32y6IsQHq1KU5gXcgpRXqjCWru+hqFQ4oCjBAIAFMhy+8i+KNwEdHcL0BFAhRfHeQAaF2W+kcMLFg7EBXlpZufEOr2nwongEf2tYTEjeZnk0e3RoaxR8ehKffTXPljTmYEy0eyy6SFpS9a2B84NDrnb+93s0H3IQrvo38cDzmIGzayLEz5hOABBCuv3Iyvv/yI=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4936:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4936;20:35K1SdruJXUssOa7nCVAO7qKSkCu3IKIOmAotRA3iNq5X6M8no8eVvUgykACGK47sOff+52nKmFSehI2bBTMskLFmsqtERDD3Wk+sYleltuUI4WOiX4w83pvShshg6+SLjjJKzx39FI9h16v9DrZcr93tlKXhVCUVRxxyyzJ36vPgU8jBqs4FL7oPeYBEv2X59xV1IV7R7koYpcjAhfdlXYh9YXxvb1AHGqrqtBfNioLl+txp54P/l4BYZFVutkG;4:hnv0d9KEJd7UXchbIZYmXKFnddARAw2RTieLKNo/4I7JADvDe1AqBuGxRPvLKkIKCz8X2YkEI0dSBWsnQ1t/rZxK/2ZHYrhhzXpBWQbHx6bRMJPPBXmLQrR3iVhr3SkyPHN+DRTBGp7swZ9fOpuPOCCVQgIRa+fdFVHLcVVvq9yB1NG2VHM5N3HIQlFyguwMA6SYHiCifuBml8njfVPd//iKkBsquZA6Nm227mIyfo/1hXQXNqIrQFaoR1fSRsBNTUQT4Opbne8baz3k7Xt5jV6DjU2L53HTbDNsk8NaQ2So1BbuqNZOTY2zlOCkZdKKZYr8WDdDCuqRzytqrNX7lVZIu7MhKgMzpINXmN5kLfw=
X-Microsoft-Antispam-PRVS: <BYAPR08MB4936BADE27FCCECD455E291AC1240@BYAPR08MB4936.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(22074186197030)(183786458502308);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BYAPR08MB4936;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4936;
X-Forefront-PRVS: 07607ED19A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(136003)(346002)(376002)(396003)(39840400004)(199004)(189003)(8936002)(6666003)(6116002)(50466002)(50226002)(3846002)(107886003)(6916009)(25786009)(4326008)(42882007)(486006)(2616005)(476003)(44832011)(956004)(1076002)(39060400002)(11346002)(446003)(7416002)(54906003)(5660300001)(36756003)(48376002)(2906002)(16586007)(316002)(53416004)(106356001)(105586002)(478600001)(7736002)(305945005)(52116002)(66066001)(51416003)(16526019)(76176011)(966005)(47776003)(6506007)(386003)(68736007)(14444005)(97736004)(186003)(26005)(6512007)(6306002)(8676002)(81166006)(81156014)(69596002)(6486002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4936;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4936;23:ebR4Zuy6HaItGOYwBqBzZKynfDqp3tAnM/1XZWrdf?=
 =?us-ascii?Q?kNEtI/Zj98cbMiMZOE0AxROobEOWZApsfZshSY98wJn7lrDonwFTjvRU1LWz?=
 =?us-ascii?Q?5McOCXjVkkNKviV6imRYGBqD2oz9lPEej9yinSaNoGma8gyD3FJ8Cb9/IRC2?=
 =?us-ascii?Q?c631yHap34jjKIHI/hsuVzxz2sFzW2L1moZT+0Umf030dZt685vD39NRmj7i?=
 =?us-ascii?Q?tHMRnLphsI4OMMWOQR3SY5c3+i+MKgy4YdZfQL2nBJDofIpH3E0e1ecbdZj/?=
 =?us-ascii?Q?TZmr4G0ehsia6LBaoEqGUaQgYTzWPsqkXCZSNDXA+9E5ZP+P0rngzFW8sggp?=
 =?us-ascii?Q?e6zh5jYiGfwk/b+7ITb6O1rIkOHR5yHxngnQUHtwtJnJ6w086bRi0echJkbq?=
 =?us-ascii?Q?LVz05IUStJQ0UvoxzRGxbfKrUP5kYbwKPcRwxlTESXjzmtAnXhc/y9xMgEZS?=
 =?us-ascii?Q?FjMhEkRMxeiB8DRCT/h4BFZKWCn3NFM/D3Ma9o4K5tB594xQ5IqKtJ+chSLq?=
 =?us-ascii?Q?PKYD5JUl/av1ngYKAh10E9lYqL+CQp3E7XESb6S0ejieEa9OcKRYagTOkJi/?=
 =?us-ascii?Q?u0wAXs1KhvNXQ48Ap14s5O+j9+buW8e+G9nu6DKIdFLVNUr/Rxnwj4iIsPvi?=
 =?us-ascii?Q?lkxDBXw0xU3dCSVz1pMfSGDz32pxajpyj/yhSrIggEaVN5RQBaOisTrwRwTJ?=
 =?us-ascii?Q?a/5UQYKZOirfzLQ0dkgIOREct8Pz/0nKJ2sraoHrzzsZurQHRzUfHvn+OJP0?=
 =?us-ascii?Q?I72RjBfHdNjxVtoJCycu4k5GvBZiCMnY10kcNdf+b/c96uGOpx8zdY6l8SSb?=
 =?us-ascii?Q?VjRapt/ZkLAg63YlclDotr8/pQD/rfQAprVKIlYar0dsaMScp3si0/FHNYHv?=
 =?us-ascii?Q?58sUvoA50sBYR4QzKqMwArtrlHacAiHsdRZlXZlEirgT00Eh/E7E7xVzDPoQ?=
 =?us-ascii?Q?G3/k+8ooLe5cuaqzOagbQLEi7c0Ps8Vs7WsiE2b3SixE1OPcYirQjShhF3Z5?=
 =?us-ascii?Q?mvjO+yzt+4ooPaUfYQl+ECvo0JgtmCEx+OW+m/byRz2OEGzxo+9tspqIEsw2?=
 =?us-ascii?Q?q/LHghiDy9ckbZn3APELZbLiWWDiBnznpR/uf8lncwO/cWXg3PrA+i1+2ReN?=
 =?us-ascii?Q?huK04EAxpYZB+VVmNudDRLwuf1kPIjYCOL3NFJwOQSM86L+I8SmypEE4l7Xd?=
 =?us-ascii?Q?H8mLFskgpg5LGNMkMUMVWXNth7jCzV9YvTEbmfLynMaFjLcV98mOqG99AlKY?=
 =?us-ascii?Q?litGppeD/88ty1PA8vvlET6Pn8SX0l5VdV9Xdn762BgW2DpKs+JUVRjDz4IC?=
 =?us-ascii?Q?6RCdZUAuTGm+izmoijSqeInTPLdL9VFITySeky0kA14oIQU2I1A3DxYeZu5Z?=
 =?us-ascii?Q?VmSC/vP6ZQheCR7bFKOqOdtHH6FjwLtxggbDDte5wVRQ9ai?=
X-Microsoft-Antispam-Message-Info: ctQEYgy7w+752jMW9Zn6a+ijiQBjDE5osqhZM6qSYu0c++VnTTMSCOUBk9DafQQ69TNZwQDFpYsfeOIBwWTQL9WfQMs3Z/UazA+WzLULX4kCrJ9pberY2ITLsuVptxEEoOszjUB+R4+gY5EB9jzaJBRRpYZmAWeyBeplqWGaNeoHgjOklIlctFRXGvY6jDOu+2yyboEDHDirrHhq2GxROlsBCTRHKiGBdgqp+A4LtXLKw6GOQ3zhXt2d+t2rDypNzQAemMscqRDGUkJNuWFUEcbr3U4gOzShhUXjhc6/2/0Dmghc88Ysl0FDGmn+WIMrVZBLjuq37aBlqM6n43H/Grmfypj04sAR1tuDs8qwqoQ=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4936;6:Tn/fGk854W/MPXz/hY1AjlgmqxHot2uVZhp0GWi94ZuwCleJRf8otEVC9jrLvXMm43YN6sd8L0sbe5hkhdZJH6Ntaipaz6yFCV20S2yDBaa2dLUBOjXcM290bCAseKyo/Qw9q0BmBSem60bw0EnwwsGtKY1bFbW10+oYv2DKYZwBnx4Uzx/AmWPaz1ZadzJxpnIJAD4UYEV5wDaUJW5FLMqRKe2bduDErhBk4oXbDbtcOypYSPbPRPjYvD9DXniR2gJHsiOO1H59WMtKUGJvZdnSnX8YTxemBR76jeLkD1KkPzitYyESymKhbDTxrnoIFoLVhpiIqlOdYstgaWSKyy6j8UdZwwAuELCfU6tTny3XajNkWH/uvJxVEZfrC72jff8HDYrU0IbZ/6qBLzrWlOEE5euKEvnWohx6+trEJqmCQAdi/pKnwvsw4Jmyh7aQDJ8W+E8Eq67fM97E4641Qg==;5:kYofoFdgVep9bYeRAhGmSFNklZUpDqdXapEWYMMjbRtJh9c4M3NiP5wLr1/mIIQV6XLeYlED4Q7RimXggglwOsXR5JP5VZsGFfAC+AyFstIlb8bRy0iX0UQGJqTOSkOSKox6RLJE1+MSGHMfSpIADEs56rDJmV8I570jadlIR+M=;7:K4D3c7Xwxdn9zYnFJbr+5QP4lAmGaZguL7cqxUpHO8JGYKTlqaTyy9JVO4Vy9VZScnAPYoVlcU23JBBSzN9gFhK7xF/wZCQPw6fZBTvUHRmMScE7y5Y9Lkc1EVWf1+UgHJxjXtKdzlPrTaYj1ya7wNNT35Iep73PRntBZd9fSjGo5+2GPypjRrlZDAnE/uACgRb3u44xgGm1DOLTEdg6gdVMtYviBeio3O72KsxSpnOe5T2dvZFdNpZstmyD7UZ/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2018 17:05:40.2310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f31f34-178f-453e-4d8c-08d5fee3814a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4936
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65538
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

Some versions of GCC for the MIPS architecture suffer from a bug which
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
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mips@linux-mips.org

---

Changes in v7:
- Elaborate on affected GCC versions in comment.

Changes in v6: None
Changes in v5:
- Comment & commit message tweaks.

Changes in v4: None
Changes in v3:
- Forward port to v4.17-rc and update commit message.
- Drop stable tag for now.

Changes in v2:
- Remove generic-y entry.

 arch/mips/include/asm/compiler.h | 34 ++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/mips/include/asm/compiler.h b/arch/mips/include/asm/compiler.h
index e081a265f422..4c06b41cd258 100644
--- a/arch/mips/include/asm/compiler.h
+++ b/arch/mips/include/asm/compiler.h
@@ -8,6 +8,40 @@
 #ifndef _ASM_COMPILER_H
 #define _ASM_COMPILER_H
 
+/*
+ * With GCC 4.5 onwards can use __builtin_unreachable to indicate to the
+ * compiler that a particular code path will never be hit. This allows it to be
+ * optimised out of the generated binary.
+ *
+ * Unfortunately at least GCC 4.6.3 through 7.3.0 inclusive suffer from a bug
+ * that can lead to instructions from beyond an unreachable statement being
+ * incorrectly reordered into earlier delay slots if the unreachable statement
+ * is the only content of a case in a switch statement. This can lead to
+ * seemingly random behaviour, such as invalid memory accesses from incorrectly
+ * reordered loads or stores. See this potential GCC fix for details:
+ *
+ *   https://gcc.gnu.org/ml/gcc-patches/2015-09/msg00360.html
+ *
+ * It is unclear whether GCC 8 onwards suffer from the same issue - nothing
+ * relevant is mentioned in GCC 8 release notes and nothing obviously relevant
+ * stands out in GCC commit logs, but these newer GCC versions generate very
+ * different code for the testcase which doesn't exhibit the bug.
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
