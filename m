Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2018 19:46:47 +0200 (CEST)
Received: from mail-eopbgr730138.outbound.protection.outlook.com ([40.107.73.138]:44640
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994762AbeHIRpuYS0Um (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Aug 2018 19:45:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNuybKGSU1gWlhttY/lpT4sPm/hey1hj8yJR5hAgEGg=;
 b=Z9Ulw2X483JhosypaL5NDfpLtd/jsfic1bEK0TOMdgPBzXiyivptSTPxo1jWeTrpdIdR2dtgmRtdb38KFpFshVg6cV8ubOMUdN+6Inf31RgGOsxGFuYYdTml0fPos/fVa35Xsu1cjwhS9wwi1djg6L/CNRedm9pySoV6v/GNXPw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 BN7PR08MB4929.namprd08.prod.outlook.com (2603:10b6:408:28::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.21; Thu, 9 Aug 2018 17:45:42 +0000
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
        linux-arch@vger.kernel.org, linux-um@lists.infradead.org,
        Paul Burton <paul.burton@mips.com>
Subject: [PATCH v6 4/4] MIPS: Workaround GCC __builtin_unreachable reordering bug
Date:   Thu,  9 Aug 2018 10:44:44 -0700
Message-Id: <20180809174444.31705-5-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809174444.31705-1-paul.burton@mips.com>
References: <20180809174444.31705-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BN6PR2001CA0025.namprd20.prod.outlook.com
 (2603:10b6:405:16::11) To BN7PR08MB4929.namprd08.prod.outlook.com
 (2603:10b6:408:28::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 456c049d-b996-48fb-20a3-08d5fe1fee2c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4929;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;3:CBjSPAxW4BudW3qWAhQ9AVlNclaNHPVmdHE+baJ3xDbYc093po6QWlIpfhYCF+5K1xwwn9yHXkhfJu56nw5X5To0gSd23kKQYB0gV4p6rXSd8HiyS/jUn2QEpy0E7pVWb0i5ZbayRFDgq65IcdtOEl48wSCYVogMcNN8tGQRpGBnld1H6PjXkEQifdwRLSBtOvMAP6NosbCZgVEhpIvEp39o3SZBrKy5GyHQefAizNNajUR5ot3B8CArhV8pw+Fu;25:3ZUBM9bjKj2MOrJnwA/k0dGq2jnBqWPDKKuCZFUnFlqAP/1vc6DvOetH5VovEbLxFaWMcOQOiHFe4JhxBw07Qp6oVSrHews5a7JHPMk9sYcWnDx/DpKtE+ud0diLN3qYLC3+C0mvBg+pgTT7X1YD5fJB1lTMJwY52e+JFHi5weXGOAwFOoVsbECGp3XX1N/FPIFR9YLtEk+Y0hsTwFRcM6nag9VqWripVHmNDuxbbST3vM4PGHieY2Vv+4VybX1MFtNlSfWTMmleDTjH6+554F1R58Y+scJLQR7xOhpgypQsfv1GlTKhWivjYSdp85ysymOM7SO0ZStvevTzc+Px7g==;31:wZNoMzaqMkGT9m8ZJreORyKFhlpCODaUdUqDh4CQ7XbRn2iSTVbjmQiQKO4LOIBU7KrTDMt6T7Y/ZMALdy41VpAqi27CCLUlX035nyKHKfXUoW1lyzQrdz+JWU/5vTfdfsCUgLa6Zklxf3C/fWzpP1AWa/r2nzqdlfwWgHRID1wlljVx/Xxqwmps41suuXtQhY0UTDbxkJbO1TuHN/UReBq0v3G8VFFuucnY6NxVzfU=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4929:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;20:ibiQnBT+4EGcIixnj4eq+HgAqE84ZO5nD+9SoEpFOcmwpCDSHKZLctyPGBSjtE7VNE9yoHaevM+hz1fQr1bUFTlTgrpw+VIG6XheXOu8HlXNTVx6hk+u5XJjSMC5X05tVQ0bc6IBAIQ83dEXo37F2pSRA7CjPI26Vxgt7SrMDuw7LmPjtUM0gWefkU6H4xIEPwPWc6yDEFzNEsc/+D3FV0iy7PWVxs6fuRAKmzVUHdQh1wxaR5geO5IgQIGIAvI1;4:G/kurT0YazIhvWNms/T1Eu4NBbywwyP7kTI1gKg5pAcpMIE5NDemFZuSRHmJK3ocF3/A2/AjSJUybzpgA28VqC/uMDchJOTnsjZkSD19VQQjVXBiHoO7vBYJkwwPsnL1IVM/yOz9IHx3eqAv7+u2sIS80MFMFxHlgVqnM6rFsk8s/VFvWSK+04AjM2Dz+aXLgLkHxij15nQaz5Sr+G8DLoJgV9Ikb3gXrfmQtcORcC9rP1t6Kjgt7kpjgwfQcMv0yIwlyKG2pmJQlTcSAJdrNcT04Ub3j2QX+ityX12UpZ7Q8Mw/RQBPVcktiB6S8fhATc4fRX2J0VRSw2L6kuXBz0D090aumzEXGvSMWGMcOH8=
X-Microsoft-Antispam-PRVS: <BN7PR08MB49294C5421A2D77D4EEBE577C1250@BN7PR08MB4929.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(22074186197030)(183786458502308);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BN7PR08MB4929;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4929;
X-Forefront-PRVS: 0759F7A50A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(39850400004)(396003)(366004)(199004)(189003)(47776003)(2351001)(7736002)(81166006)(81156014)(6116002)(3846002)(186003)(16526019)(6506007)(386003)(107886003)(5660300001)(39060400002)(25786009)(1076002)(26005)(14444005)(8676002)(53936002)(478600001)(6512007)(6306002)(105586002)(106356001)(2361001)(66066001)(53416004)(966005)(6486002)(305945005)(6916009)(4326008)(11346002)(50226002)(8936002)(69596002)(476003)(486006)(97736004)(316002)(68736007)(51416003)(52116002)(44832011)(76176011)(16586007)(42882007)(54906003)(50466002)(446003)(2906002)(7416002)(48376002)(956004)(2616005)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4929;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4929;23:2PbYi23jNIOIWCNlaaxZuAHJABwPfqWO8795fYpW6?=
 =?us-ascii?Q?oq2KjcIJlZhiKYVGes08jN7L2NYHjcJjYZJpiJLv4AGntyB31U+nzBEpnij2?=
 =?us-ascii?Q?O3zKjzpfvKbmRJoC4KTxOq1N/AjecFgZHwkM0IUxwTeu0sJfreBHPVeiLU1x?=
 =?us-ascii?Q?cmQh92IFmAdh9RjuKavBxcHmbXIqFbCoCHjSjuYWWyLu1a1I1catSHF6or3d?=
 =?us-ascii?Q?1a1ibBbFqVU3t31E4lgZSlaHMulZ30qrVwTurEgL/37IinwfWvBtIF0C+OTD?=
 =?us-ascii?Q?8B5ChZmGsv3dbsg4p4YZfwwivx9MkJno8I8vTwcORQEXTICvAu7wQVCzZ25W?=
 =?us-ascii?Q?eMa7UVLHpDTVWcldFhNr63EsZmh89R4n8g9HS8Ul0HzspXN5aiVO9pO4vVw1?=
 =?us-ascii?Q?ZZ/+fRjvVHdfKl3VczcfipdRjjQyHT/giK6r5xm4omerg+GTFxd8TIYA8eY0?=
 =?us-ascii?Q?f9hehHFpRu1DSRqZFuZgdE4ue1vyiOmSsAH7tAVxH6VbZxfntuWTWKuHoMvb?=
 =?us-ascii?Q?bUgvHR+AVYRU/yzmGOSRxM7AggzbgYCBltG7vk5vCkbnSz57w/uNgFiZnIOT?=
 =?us-ascii?Q?uNTmX2xWizrZpi5+0Teh3PGaSdhtPoAMSt+Iwrx7xJDubTpv+YeXTwtwQhYW?=
 =?us-ascii?Q?oVI9KYuwo6Gb1GTOTilNKnaQr3rEejbpKREa3StEsMuMItjanELLPTU04tKF?=
 =?us-ascii?Q?OuxBkyZoKQTEn+CSUJa2VX5RsoN/ByWBl+1I9DQOvIKWnq7EKIay3Nd1EAjc?=
 =?us-ascii?Q?0ZjP8mWxWP7AFZyEEc0UGP1O1UW0nRIwCL0mXvWUEQKWBh8mx7UVrsEKkjRU?=
 =?us-ascii?Q?OFeGNC38vZYSMW9tnC1j4S/Yz2gD55Qaqq7G56H3pe/oSGswHauepyOAWoZM?=
 =?us-ascii?Q?DwJeKWBaoxWl0kjdqSgQBDElHmseOWOyXR7l6bDP3fHJw1hzdmDocKvwqPXB?=
 =?us-ascii?Q?0riaDr1ta2rolvrQeXJ5DWrTFCuTBTAEF0H0pTMMDhEo2w3dm3IqfntmAJj6?=
 =?us-ascii?Q?ZCqPWXL0I6imJa+xkoJLKN17qbMUlGY/MFUzR4yV5z2ZXRwJY02OdVBXIyiD?=
 =?us-ascii?Q?bhBEQl7gKTDmRtyBsfVwK2B+KdGfZ3UpCrnP74cBDWxNM/oq+0WMosWgqXBL?=
 =?us-ascii?Q?gXI/GKNKaz5e6YCAsussxhqbRwboEThDpHOQNfCDgTCX0PIjgUanAVZDzOKA?=
 =?us-ascii?Q?/PhHm6X/WQyllsdjUQWsAkAhJEAPdUnWM2ce9lT+a+3QIbw8JbW+t7h62j5A?=
 =?us-ascii?Q?+TjtUN7cHrr6g7asmQ0jRvZ0/0VwoDiF9yfC18xPN9eg5sYPfmjAnZ6UYJXP?=
 =?us-ascii?Q?RE+ZFXB6dTLSwJINlmFu0o0A8KXBeAIiNQCSLcXnG/8VLXIowPWl9rkk8WBG?=
 =?us-ascii?Q?JxnvTLZjNjKCbV9vEY/FfUlk4uRirQ6Bsu3hvM83oVznlS14YqEOvO+XYYZi?=
 =?us-ascii?Q?g89OA7Ysw=3D=3D?=
X-Microsoft-Antispam-Message-Info: XvJwbkQ/+YYT0e0k0OMvaO8M+76du8U2nSHBuVEhdurJQc4OeUdUCoVDO8D4qPRo0/hsRiP1WhYkoYdmcIvIUT/W26d2QafKMXMbZRLYWfHaccs/a3AvOxZ9+ulHei+LX0Rmwjlja3qR81mRcWYvzM35vxBo/ucFWKpf+LMfLC4rFSvvXO7qC5VI3H6UduVX6Vo/kiV6RKtCetiJewDb7tqQgxqKckcxfKqQnIEFJ6TsNCialFGOjNRnBYBRbsyE8ZrKepP3e3dXFvYhP/S4U1xc8x8LQZbJ9B0RzlvT6igxaUa9ChXoWcrfyy7sGIwWbvI20IKxiEk5Go3GQl3GeFI6cna916XOw+QWf+yYsxY=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;6:d89sN1kvEtfVVFDFizO7WchD2RKXpmrvNf4mxHR84l9A2Z2KSnDsFeREZiD+q3s73kCpmcUWuzJM9B4vPXBZFIQuS4OCp8yFaicXJJwk91LFn0D175uiuhBe1Q7iB27/rEi4a943jNgeqzpI3VIMf6E6JIHwsyHge7uiZo2TcCeOEWddmPOEhiMoRdqmm5HG7z5kIoEfntIESDnsZaOGWdbGS6bIWHDry5o35UYtnP4lwflmKXnUJimfs6YvNgknqdAx7OkZ5wAwf+KKpPxQmLBfw10bayuqKKSpfZYn/yOfrERZpR3M93KvNiQ1QnwZ2nDaYNo1ffhFMiR2GxZ68yiZix1dw+tVAgPnqNpnA2vHaLPksdFqKLXDGIKaxYmAnZq74zAhLuhNT6gsJEaiR04xD5JrwGLT139L7kl9TtFiSRvYDuydEGZub0x6LjprFRJapug8cACTAGDykjS1Mg==;5:ZRmwMzZNyD1DnBCpWRVL23KA2junTTNOYfJ5OaUcylpyQ42AtsG+xuEkTJH9K/nXhHVtmnYfpMGevfutheXuPuMRlRFUJn/rrLk/y7oORMYO3xqn95q/FMqH8YKKVghalZKk2O2kKcfdI4y4vIe9/xOGFJOD8P6Q9B/mXdNgJ7M=;7:uTOik7xloRL6+YONxaCOfS4n/sJXDQqZxbYUdFrMroINByV72+IRMm1AtKDmdRojwgzzDzSEy9r1MQeYWkGAIRKzniiZrvwwfZQCrDnCs9iD4Pb3yciBITTrgFtc4BLrip/R5Sj3dJJHNykQzB0U4cOIXJ8DwCRvgpsnSCrAF0yIhvkqfu5JOUwre7YNCYcz91zJNQ2Dz7G0JlGBoiwvoTiy+i9lmZwoR54X8+AkpD2LVgiilkG0oUl7fFzJ+e/A
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2018 17:45:42.4875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 456c049d-b996-48fb-20a3-08d5fe1fee2c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4929
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65502
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
Reviewed-by: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mips@linux-mips.org

---

Changes in v6: None
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
