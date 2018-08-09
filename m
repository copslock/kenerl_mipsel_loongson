Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2018 19:45:51 +0200 (CEST)
Received: from mail-eopbgr730138.outbound.protection.outlook.com ([40.107.73.138]:44640
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994757AbeHIRpsbz2Lm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Aug 2018 19:45:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wn22MFSyLfXZ/Xcq4jWoqQTa1rfQQbQNIed8GitWTt4=;
 b=J8jlSM1t3+PNTlPR+Yw/P9GKXTDwKiZp9/14ftPHfG0J4B5LHA1IkEOOh6JajoLAwa2M/pYsljVwsUag0QjXCxywWrYdZdOogIoEXA64EXCz7dw1ErXUzKSDdEsGpRlb4rt8iM8FlIGpEFCfuAvyY7w+ScRVsWLrQYTVe4Sc14U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 BN7PR08MB4929.namprd08.prod.outlook.com (2603:10b6:408:28::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.21; Thu, 9 Aug 2018 17:45:35 +0000
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
Subject: [PATCH v6 0/4] MIPS: Override barrier_before_unreachable() to fix microMIPS
Date:   Thu,  9 Aug 2018 10:44:40 -0700
Message-Id: <20180809174444.31705-1-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BN6PR2001CA0025.namprd20.prod.outlook.com
 (2603:10b6:405:16::11) To BN7PR08MB4929.namprd08.prod.outlook.com
 (2603:10b6:408:28::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0646c6ce-3f19-4b95-8f2a-08d5fe1fe9f4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4929;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;3:MndYJGQjFLSOo16aysOIotLQ6ikv+aCUp3+hrrDubnb2amm9HUiJ1PPtw/teLYz7qSg2j/bjkmF7NpVTuqsOHdYbb9bbDCdwKmkK0RJFv4XVyA2UaI7hGE5VAcBSRAQ5w9GTyjL7dvc+nB2+VYnoKZYODFLJLAb2yEwNzzfEP4Z329p3oZyaRFEt45AiZiGts81VDqU1nhZ6BuVVNwG9bDCzcdHvMPS17yjieEktNYSrmnCPy61AhCgHK6uLBhKt;25:wV04namp68P/gVCXVnnASwhUEmIB0AQ1MszqGNd+smzZb6M8xLEOQpAXO+umXYYcrhKJ0wJxC+1Xc/vLoHjekubwGHqMbD8zacis8FtQTOJNMX4dYDFpNiC6UfnfYiBQga7GGp7f6KjL4U4EjmE+vECISeT9R7NWgpvNXxKa1p3Xm4LOFkJXOsXpoiV9ZhBOUqG2sBqI8yuR9w0A8rVqv1ORNa/SBp/QlATCk/lVN9W7EtbaD4oUk/is/jEdrDIlii+ByXyj+1XDj5k8F3pl18NrIjkmfNd/duo32PEmUGygQBykN1L9FTk9/sy6zO0jlP+bW9X+4qNo0jrrVtNyfg==;31:A6HHvNoE2W/eqkuy++/FB8FWyiw9mvaSsmOvRXS24SbqiR32J8rNECfT0qFZ1y41wntGge9Q7/oXAL2yKC3jOawR+MBsNE7wjZxGC+UkvxK0WZoFCeciyoHivKGgJukt16BmxocpKCWEcyI6SixsKH37P0bndzgYYa30CQdHvHoeBlpisnYsSo3cGC912bk67gV5d/ZqiDvR/f3LRobDJhll6yjrZcX3eLfTIjkpIU8=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4929:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;20:3UNRAw4IWDo1SSVCR8vAcceB6oqgT+udEiPGNMMNqFE1vnuCuCtuUkNAMT+610ok0db6H3Ls98q+HFaCtX6RI/1GOoqzNYXRZ6s8zxT+vy4hmmwV1LLZYQXXIuyDUArzas/RIHi7sF/l0Dq4xrSxT8N6VyxsgIq2O5V6l/wk24Y9XFAF5OG21OaNjwITgGa3beXcrY4j6klW80gShCcCEbUy8X91dANQMh0a56UdigRNzWhArcsv3gI5ztobKNAN;4:ZbDodM7SmdN/Ku6CPittJkzB2/7SX9r4NclQC56VZQ7WdK+KiEtdiE5jw+6jvMZmgn83djIOPtDqZKqxFSkTvqoaIiiWhPv09mIO3JPBLQ5UtZUgehOUR2S+5IkA5r7oq0qlozK6MK1oHNzM6M77IxHh4LHOKa7rnCnwtSZZ3Nwq357hLmfTmLN799dILiWKgy69GvYnyBUqgxS4kJ4F+EGrmBhJ3fw2gMPTztK7vaDrt2smDXPFyMPjXXKh/uYS/Xw2UQYrJh578pl/HRSUaw==
X-Microsoft-Antispam-PRVS: <BN7PR08MB4929ADF55E28E54B10CF72C0C1250@BN7PR08MB4929.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BN7PR08MB4929;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4929;
X-Forefront-PRVS: 0759F7A50A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(39850400004)(396003)(366004)(199004)(189003)(47776003)(2351001)(7736002)(81166006)(81156014)(6116002)(3846002)(186003)(16526019)(6506007)(386003)(107886003)(5660300001)(39060400002)(25786009)(1076002)(26005)(14444005)(8676002)(6666003)(53936002)(478600001)(6512007)(105586002)(106356001)(2361001)(66066001)(53416004)(6486002)(305945005)(6916009)(4326008)(50226002)(8936002)(69596002)(476003)(486006)(97736004)(316002)(68736007)(51416003)(52116002)(44832011)(16586007)(42882007)(54906003)(50466002)(2906002)(7416002)(48376002)(956004)(2616005)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4929;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4929;23:/xTsqJmwtgFFATI3du4rR3i3V28FD7yl/aoEMgrEn?=
 =?us-ascii?Q?S7F3Hg+y4s8qlkOktnJgH63FC+2LGLEqEC4TxtbL3kIHthLRHQES+2kyP6H+?=
 =?us-ascii?Q?Ukm+fqwABo/4MHdnbSqbfAR8yJnbqcLfkC0nbTMKNtE+ZK/XGHUiqycVxmgH?=
 =?us-ascii?Q?M4j/lqLBE3GpkM2YW7eCoFZ3ofhAddG5j1TK+Swzm5NtmZ9aE+QD7JMQgBb1?=
 =?us-ascii?Q?YQw9FUWbVQFTe+zkugkLp7SA5do5EHSOrKWi0XnKWadGyDkTRWXaUL7Zdzy6?=
 =?us-ascii?Q?8KlnsZtuCGXJ5nYBjl9X2Uu5/WGdCawdLkzmAYEKv7Cn81kQ1I6LwHC+vs1l?=
 =?us-ascii?Q?6YjLJJu3QCWZGLoRTv9a1QEMlFL6KkgR/igSVNuhMHtL2wR8o2tku0zrLwSH?=
 =?us-ascii?Q?J/AInemL1MEpDzNTWMyokSki3eUM9hD4ZnRFNKR4RMtSJX/Wzy5BzIPW3YtI?=
 =?us-ascii?Q?x+NDW2i/FoZcZQq145x41s2tlKHQUhSU7zuayzbKmAmDzBAs66jYtqyI/0M/?=
 =?us-ascii?Q?q2ifi3j5n5h0V51jrCqDcWGPIHweCI5Oo8Wf7RBB48oKHqdqQTH6VaY+5ay/?=
 =?us-ascii?Q?6aLaXptBOEio8q7Ry1kEW6EBu5aA+Ddqavme+fNO8Zi9SQpGVYdjDzIe+AN6?=
 =?us-ascii?Q?FnZKtnjVYnmPAmRCj7goOgfGihifH7yevWfvPR4xfMLrn8CPPrDOhGWy5FNF?=
 =?us-ascii?Q?poAEgM3nNRiJ1/zjRXRH0fpjJQwYcCtaJ3QccRnPlVpQ2+KycxU3ZWp8A3bM?=
 =?us-ascii?Q?YEjlGrfbU5ZGn304j8C1aLlcYy9j2ORmPeNHPjVq6w9ljTPE4K28QEGDbX90?=
 =?us-ascii?Q?dJT33RfKDqqYc2n086ZoYceIWoL8ri/KFAnKVa0WGZl0Ms4rFlNeNjmJu0u8?=
 =?us-ascii?Q?y5oXx3p74bKdh2NIYOSTp5LzYSZbAN1tGgHDsvVT6feJWe7ZVm/EmASqIfoP?=
 =?us-ascii?Q?CK8KxGJcN8n03X5vZLN0FuJ17SMJm9FF3bljTeFmlbMamSsmF8gdsr1s9r8m?=
 =?us-ascii?Q?0HP3Ugu9RrKktqrgw4ZTFg0b5+m+fqF31GCjZncueemRaaU6ynJ+u4kWIN6J?=
 =?us-ascii?Q?vVx/dwMX2TyBfsY73KkPjGPZY/7gHX2xGGS3Nd8fV0wJ7o1PD4ZHT2YVK8MY?=
 =?us-ascii?Q?ufKZgOV8FDW7KCFcIRhQG06tzKhvXHUvwS8BqiHJgslefbfXMnVnW1ErlCr6?=
 =?us-ascii?Q?rQEDcdWImu0ipeoAC2sEPnt8MZy+4XocYf2SBEji/2CGISeSPiJiNACxx7pG?=
 =?us-ascii?Q?GTDhSvbmtJJ9lwG3IisMOG8fgIDeNuEz3hzfjC+0xhzvXHICPcD6j+gSQm90?=
 =?us-ascii?Q?2DR7GywmikpZLz+dOF/i/MiKU0hMFK+DTBuYZHsKsDY?=
X-Microsoft-Antispam-Message-Info: KuXrt1GOtfOVzTqaUUCvQnvyqLwsN80CuMz99q0SqSbcNrezdffyb+nKtO1+assw2TD/iKJbERVSDnqXiLW1GwsCGciD9410DzRk51VELDYx0bpDqKrt7cT0nk0TuxJisu2kCRnprBrybnqo/Jhl4BOoWr0HEjsTugFNksmWFUKkhFMWNE2tc+WOMD3T5Oz6DlnN6L0iov/rB9pIiOLhmU558WiFrxkxs3yvKZG0XHgBTg0kZ2PspWzd4HLh7bhkigbEUp1O4mNjF7h1YtOmiLhIuZE52Uv2LMttGWbJGE0gSqXlQMBK8Xb8ytTMJlrEsxvsQ7Kcp+iyQGcwrHBy1yIyYcxqcIX3cYKjXfqRda8=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;6:/rHuhlAGvvpJ3SohGJ/U5r7mewARoN4AXc2unYgzlpzKIkWB4eyDvZANhWggmTrUFedjUoXuYWkOwCSN4UI46pC9dDmM4A5sgSmExnSLylrM7Y6ARzFUZvW36Rk2yYVLGukvCkjMuRhJnD30sK565TtFvLSols6eojt/y290B3t8xoUItLf+JtUG9WS/KF3Swz/8cb6bnEyxynePfcDXGKYqv/hU/ARXrG/FTUXXvxOhSsL6zmvYjMrtz0/uW9jzjZeeL3JNflVKW3waNnOfYkxwoT7ugLl3DQCwxugSGCgLFSlfgsYZlsmwFseKZQfHXW1WjD917pcUErGdhK0j8fTT5qdlAeUv20M26DFxNJlHAVz8LxjPddt6WW/uJEfzjQFJEAGwbqUlosptIV3HhLy0MF9zMNLzNU7bZGRKOxBKoprilAvz52HS6m/zWdw5fAWUGKPloBzS/hQdbO73IQ==;5:Vnhs487rnWb1Y3iTe/McuLP26YRm+Vc+2VRk1J2XKCaEhiDBUhg4qYXTpUh1QF8e0lQhkjQ0A7ShesFXN9k+yQ5oxjhpwZ+Brw5QGvfkTt07XNhJg3xLBXo0FYXZECUGcvjWHMP3llIDHdRR8CPsD5w2SsnP5/a0FjoqWbopic8=;7:Iq87gh5Gb6KYCavOKIAD9aJwUuA47O97ogGd5qpJmpr4JzMPCx72n04g33ufRVyN9Ps+30K0WVpWwSxf6GB6wpvrQeNoW4WbicCNQES5uR68MnlIwRoTs/DatB2kMcUg05/Ydx0tdOl5Pn8u9ANrRrqEYX1RIVp1RMjAQTjS28UJI2IJpS1G5YhGNGGmPGZlN8HGX8yV19xUOPlZR0obLjKMRIXXjsVA8fW/jrv4AZfD189bOOQSwrZqrL3EWCd6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2018 17:45:35.4135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0646c6ce-3f19-4b95-8f2a-08d5fe1fe9f4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4929
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65498
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

This series overrides barrier_before_unreachable() for MIPS to add a
.insn assembler directive.

Due to the subsequent __builtin_unreachable(), the assembler can't tell
that a label on the empty inline asm is code rather than data, so any
microMIPS branches targeting it (which sadly can't be removed) raise
errors due to the mismatching ISA mode, Adding the .insn in patch 4
tells the assembler that it should be treated as code.

To do this we add a new standard asm/compiler.h for architecture
overrides in patch 3. There are a few existing asm/compiler.h files
already existing, most of which are fairly simple and don't include
anything else (arm, arm64, mips). Unfortunately the alpha one includes
linux/compiler.h though, so it can undefine some inline macros. On
Arnd's suggestion this is converted to use OPTIMIZE_INLINING instead in
patch 1. A build of alpha's defconfig on GCC 7.3 before and after this
series results in the following size differences, which appear harmless
to me:

$ ./scripts/bloat-o-meter vmlinux.1 vmlinux.2
add/remove: 1/1 grow/shrink: 3/0 up/down: 264/-348 (-84)
Function                                     old     new   delta
cap_bprm_set_creds                          1496    1664    +168
cap_issubset                                   -      68     +68
flex_array_put                               328     344     +16
cap_capset                                   488     500     +12
nonroot_raised_pE.constprop                  348       -    -348
Total: Before=5823709, After=5823625, chg -0.00%

Also um needs the generated/ include directory adding to the include
paths in patch 2 so that an asm-generic wrapper asm/compiler.h can be
included from automatically included headers.

Applies cleanly atop v4.18-rc8.

Changes in v6 (Paul):
- Fix patch 2 to find the generated headers in $(objtree).
- Remove CC's for defunct MIPS email addresses (Matthew & Robert).
- CC linux-um@lists.infradead.org.

Changes in v5 (Paul):
- Rebase atop v4.18-rc8.
- Comment & commit message tweaks.
- Add SPDX-License-Identifier to asm-generic/compiler.h.

Changes in v4 (James):
- Fix asm-generic/compiler.h include from check, compiler_types.h is
  included on the command line so linux/compiler.h may not be included
  (kbuild test robot).
- New patch 2 to fix um (kbuild test robot).

Changes in v3 (James):
- New patch 1.
- Rebase after 4.17 arch removal and update commit messages.
- Use asm/compiler.h instead of compiler-gcc.h (Arnd).
- Drop stable tag for now.

Changes in v2 (Paul):
- Add generic-y entries to arch Kbuild files. Oops!

James Hogan (2):
  alpha: Use OPTIMIZE_INLINING instead of asm/compiler.h
  um: Add generated/ to MODE_INCLUDE

Paul Burton (2):
  compiler.h: Allow arch-specific overrides
  MIPS: Workaround GCC __builtin_unreachable reordering bug

 arch/alpha/Kconfig                 |  6 ++++++
 arch/alpha/include/asm/compiler.h  | 11 -----------
 arch/arc/include/asm/Kbuild        |  1 +
 arch/c6x/include/asm/Kbuild        |  1 +
 arch/h8300/include/asm/Kbuild      |  1 +
 arch/hexagon/include/asm/Kbuild    |  1 +
 arch/ia64/include/asm/Kbuild       |  1 +
 arch/m68k/include/asm/Kbuild       |  1 +
 arch/microblaze/include/asm/Kbuild |  1 +
 arch/mips/include/asm/compiler.h   | 30 ++++++++++++++++++++++++++++++
 arch/nds32/include/asm/Kbuild      |  1 +
 arch/nios2/include/asm/Kbuild      |  1 +
 arch/openrisc/include/asm/Kbuild   |  1 +
 arch/parisc/include/asm/Kbuild     |  1 +
 arch/powerpc/include/asm/Kbuild    |  1 +
 arch/riscv/include/asm/Kbuild      |  1 +
 arch/s390/include/asm/Kbuild       |  1 +
 arch/sh/include/asm/Kbuild         |  1 +
 arch/sparc/include/asm/Kbuild      |  1 +
 arch/um/Makefile                   |  1 +
 arch/um/include/asm/Kbuild         |  1 +
 arch/unicore32/include/asm/Kbuild  |  1 +
 arch/x86/include/asm/Kbuild        |  1 +
 arch/xtensa/include/asm/Kbuild     |  1 +
 include/asm-generic/compiler.h     | 10 ++++++++++
 include/linux/compiler-gcc.h       |  2 ++
 include/linux/compiler_types.h     |  3 +++
 27 files changed, 72 insertions(+), 11 deletions(-)
 create mode 100644 include/asm-generic/compiler.h

-- 
2.18.0
