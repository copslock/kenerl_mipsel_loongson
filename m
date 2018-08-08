Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2018 00:57:07 +0200 (CEST)
Received: from mail-cys01nam02on0104.outbound.protection.outlook.com ([104.47.37.104]:45072
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994738AbeHHW5E19RmA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Aug 2018 00:57:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yd9zqHVNwyDcQicslfWg3pWchN0XwHdlK9IhdDFNRw=;
 b=dgvl3X7hIa5GTzvX3/O0Rov4BEf3Q3sb8cdjbtEqomLoi39VhNc3Vg4Hmj0WFK0KXqmWc/YUQM+TAvppmRpW+vYucnyWxfQ5FqpMUm1jqxDMXb8r/kZNsu4keT+wi7Oy8E+NUrjcqv5eFW2w25KssaDUYc2+XdJaj2gu7NlYhBM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 SN6PR08MB4942.namprd08.prod.outlook.com (2603:10b6:805:69::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Wed, 8 Aug 2018 22:56:52 +0000
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
        linux-arch@vger.kernel.org, Paul Burton <paul.burton@mips.com>
Subject: [PATCH v5 0/4] MIPS: Override barrier_before_unreachable() to fix microMIPS
Date:   Wed,  8 Aug 2018 15:52:21 -0700
Message-Id: <20180808225225.24450-1-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR2001CA0004.namprd20.prod.outlook.com
 (2603:10b6:301:15::14) To SN6PR08MB4942.namprd08.prod.outlook.com
 (2603:10b6:805:69::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cfbb42f-178e-4c00-9e0a-08d5fd823bcc
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN6PR08MB4942;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;3:pjDhw0d9aofuH9p6fw8PrrvTn4GicmC/i/OGcK4rl/QYBmRwpFkBVsZjzEYAii5tqo2dNL6yMaCI/YtZudSTO86egDDC1I7vBMmzlc0K4fbPBXyqtKnY25kBVXc8Hov9cCFHt38BLHmgS45xBGTZ5F/LHHWZpOhWw9poXludiF4PgFKePKZWImi3qCqX6ntVWPb1br6Ui1R5n/gqgpLjFQfe8tLYcrpAqScRbKUSlz/bU+RxwLHmGKm0CibniC9s;25:DQevpCzHPR96BYvdYrE1zM+MZ9TOK9jzqJkzDK2YT/9B25VKB1gml5iX9WGPr+q2RsP7/VlIqmZSksKW2vPz1fBVcfc3OiyOtKeqJJqdJwV57u3EUKJIKHXnlwob9ApfHd19xqFAxbu9CFEfh3P5/PRscreTGPdptLlegtth4Hoan3VSRjag90SAdS62l14WhtoTCjLdfn0BFe8h/46tqdEEt9mfu3QAEsna2ZxL4XktQuKFvVRQTGqfEdV4vG5dEVF48TY4liwUXdX2Rvrm9/1sBVCbYAHN4Kw2yfIGfk7qmStL0jFC521wsFmghT3oWw+gF+sL116np89iPtU1+Q==;31:wcJvE4BkjpfUEFxcKzQW8nMNAtuMi9WLeU23SkXCYfkx9aJUhmhmrMwPqD4GBTqRkdpHIaOCuk0K1w3AqJTXmI25ccI6xRw5myg8bNUx0XVWTY/fl7y9vugDc7haW1ifUGQRNlA6ZDMHByq6pomzwD+bpMtvM7iCehADP66Qlxv/mAXoYantWA8AAlcC6xqvguCho4TRIHof65EIx4PKE1DP4DMDSlI7OCdwejLdaF8=
X-MS-TrafficTypeDiagnostic: SN6PR08MB4942:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;20:fsDPqq2nEIuQ6VzHm4axehQse9Ru58b2JRrKx4iKouszswXqKaPwSiS00uWpIlWncxV6dGIkWG7KERX5NkLwWkvw+DnMpL/Rzt8BnxlGYG7Dfkxbx9xxZ/gk9q63yuq+dqo5040gsiG0DUWJ8GnsFDNxEdQXwimEuqnJ8pDf8viPkSFYrqqm/o0pg8qWIk4IGJmhg7Ovl83EDUXA1Rm8qbG0MwBPatL6mbatIhJRRubOMGYEiHjtkpuzjG1NFRgX;4:XO0nHyzDa+YbxQtV6hE7OxrgeYUmLg6gE6DIXS8kpl+jgJXUZj+4KqctAy4XdqhmdmpniM3x/0z30ZxdCPLmpSuWR5OegMbbqvNL8iCaFhdHxUdI1LcUPuAOtABKhSWNpyAiTEAONfVWA8hLkgvU6do8+ZEZDcO5AhTAZkSRVijaJ/6EyQtW37E4tPhONtGlUuMO6XSY/23hO30x3YJDG3hr9atsJlEY4CYo3h0CVnc8xzu1IBI4LmsbFl/muO2qhaGU/NKjvaR2hzIxuX06BQ==
X-Microsoft-Antispam-PRVS: <SN6PR08MB494247B40713AF1CF9B34FA8C1260@SN6PR08MB4942.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN6PR08MB4942;BCL:0;PCL:0;RULEID:;SRVR:SN6PR08MB4942;
X-Forefront-PRVS: 07584EDBCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39840400004)(376002)(346002)(136003)(366004)(199004)(189003)(6486002)(25786009)(44832011)(66066001)(47776003)(42882007)(476003)(2616005)(16586007)(53936002)(14444005)(107886003)(956004)(486006)(39060400002)(316002)(6512007)(54906003)(2906002)(4326008)(386003)(1076002)(69596002)(3846002)(305945005)(6116002)(36756003)(2361001)(478600001)(50466002)(7416002)(48376002)(97736004)(7736002)(186003)(16526019)(2351001)(8936002)(6506007)(50226002)(53416004)(8676002)(106356001)(68736007)(51416003)(81156014)(81166006)(6916009)(105586002)(26005)(52116002)(6666003)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR08MB4942;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR08MB4942;23:bRayDZkdo7K9HJ/CPGF1VS/fg4mjOXlbw8zLL67m6?=
 =?us-ascii?Q?T4hPd7CteRx7OxsuyyhvUHf5pk0vjtcUa1GOPl4ykWTV9jJrOL9oxrTFGvN3?=
 =?us-ascii?Q?hnJWfAzIqmbNLlxjU6Gpu99HmXqne5r6xOKSrHiZoHQIQtFyrt1/5ubgsl4M?=
 =?us-ascii?Q?KROMEBSUSfh8B+kvkDM+oV3N44j8nzaRBGvK/7a2skTG3XfSbtWAQ4lTMykb?=
 =?us-ascii?Q?XUVFxjLXW6mDF02hell0WU4DL0YBBCeuTpXzxsJvGiEybvHnKMA2M3kPC1Ik?=
 =?us-ascii?Q?4fOUodKmn/p1+r2sAk/CB66ukTD/YcCNwNi57uoNgQ6XHbdY0YamAGvUTm4t?=
 =?us-ascii?Q?UqQxEJC60Db6dvIBcM5vUy5K3bN4C7PoiwIZb2i6z5KL4KZtsYbU0zNEBHl6?=
 =?us-ascii?Q?K/lXxtiET4wTFWhEDt3YTipAyoJuXZrs/kUCf2x30umf5/NdyQntDuWoCN7K?=
 =?us-ascii?Q?QC4SUZ08qKwBR+C9v0TDek+2GrrBvwLvvBGBOblUqNvInTnaYwOWsJW3Wee4?=
 =?us-ascii?Q?IB6ij59uUpvZgEI+wgF5qOTGuXnt5uMBJADr7YGQwBCenELypV5guN9QkDuX?=
 =?us-ascii?Q?+9lZThJgE06fpknP/dGexn9rxohYgdtVJ1q3k9F9cDq3zMPimb+nk6PiOFds?=
 =?us-ascii?Q?wdpOik0Oc7Cq2s5BC084/A5Eu27dRFTwcPO3MEa9kyJzitJcmX6TmjLppjnb?=
 =?us-ascii?Q?nCM6LVRz5PjJIvhddMfOSKLGAdxvRFOyJzQReLMc/9nKWJj+TeAscG/dPCAV?=
 =?us-ascii?Q?c9ZmlDXj4x3EPrwbIZFCDBLPSJyy+Ch279Kq+OEaEyCYAS30Nz71Y5EG0AIm?=
 =?us-ascii?Q?9dNX+lxqlCl5HZ+QkQfPkwHKraMfTBwGDN/mUtTQmLhpmN6vzpC33/5Q6SS4?=
 =?us-ascii?Q?CdC4e6UXMCZdmKc7RU6iiDl92coavR7fH81jhdzktsIM98l6UGFwhKLWeh+d?=
 =?us-ascii?Q?BiY39ZBos233bSFcmnuxCauc0Z8asTGRtcdHVpB0miFZmv/InSzJa6JPBzNc?=
 =?us-ascii?Q?sc12iZWMxyWBHWWAW7Gq8BohAT7Y89k/EfzTGk7VNzypP/87ZN0i9KG1y1kT?=
 =?us-ascii?Q?eB6vexwUWB6INOGvvHcb+K61ARAUbTr3cdxDlPHXvzGj4goDbpsouboJmE8+?=
 =?us-ascii?Q?42rLonUJotJ/S/NLRG+9lN+Bu/VjqX6sl/iPhtuQj0nllmLyENShs5hqd261?=
 =?us-ascii?Q?X5QoGlRIGcNoZ1cJgFsDwU3dm4+j398BxBxVx1FWcAIddeTnXcc9s32ss/Ac?=
 =?us-ascii?Q?Lw8zs3Ywp2vd4PsqpmzOcrNJmQz3KxNpzBVRjQ0+tb1SY0Se0CJpvvwwBB8C?=
 =?us-ascii?Q?fwUtODyF58ljl03UiAnLHV022kyv3gQnrAx/MihnWMh?=
X-Microsoft-Antispam-Message-Info: qgNvNPsmgu8o3Even8hGogmtZncjGlq7UPaaWf1Nv0q8Dz3u2vYAp1GFRZYfILJ+nVaazDCjX4/dI6dIQSxTWavWi/N0sB+wMecOBkX+2cwUameMzl/0iL/J189jUeUsj4NBQvcOpAqm0TlUBU5VXGQhLw0GkChqPVqL6aPn2L2URGf3VQuc4N+p4lfg0jkhwVfFJDIV0f8vM+TQ7SOwThisTIEyA58H5xI6i2iU8cVy0MYTTvmY2BYUCKhjlGZ2uJcE9SbURa9ya5m4bODwZzvmpL92C3edmqqzuBQ0BGd+5q2ZZFavruzVUngmz6og2wI0Zuzrnli6kjF1mwUMKrmskR31UTw4oihd1yimlgM=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;6:OqluYbobbU4aJVwFLUODsARbhQ26516OZfIcu+Ee9fVXWprH7NtLeOXJHN6jX5RzTCxOKyec0o+hlAW8QF5m0fgBwsEKC1LHszGapnhUD5aKTBfYNR98PppOgcDXP0YCQ2o0AM4urjOKzaZ7fIsAg9B0urHdI87tuHLHq7cLTqdqt6SauB09v3nyb0JyKhZs09XZMhCtnGJWxkOa5nILR9x1sslLAnf2EjwtJXFYw8QWpcPcXKLb2NihdeyD+OOnwX3TRZ1c0NT3tLh8L3UKw29zGmGBgf7YNIukJ/m5Qzj/WY0UYCQVVG1mgXiaD7UiWRodnnuDklFOJUNkAwtEAW4Zaj+IDwNQVCEvABrRr74yWhgl7/QTy8JIHG5+kymTuGzoao0BxvfwZvne+dgQMqzN4rb3sSXFb+SoYmHyuItDqYX3PWFsRNJOsKoXsXBoA+gVUTgJZbOGaXHkgNjeGw==;5:SUuNGlCtbSe8r7lbObrxkP64NrEL87Sc3pE3uGcMWB5f1DoIdhTmWT2QTMRZlMeJ9jOU1r2RkGvQwLIqt6t8TcUMo3V6fzdVNOrWjAWru3cRhweIG0LyribFE8/Q+J+hr1S9WtCVQhTKwLJnV+JInKkveSqFGiQAN/cK9HRWHbY=;7:hUCp8m2zDyYezfS8JnsOrB9O6SV27hjuenLfxPonLnNA3rwuR4my4tpUW5CK0AsXOUVPvtIeP23xLBiEgZY+AevrnCe10EFElhGIQS/xB4/s3ZClCEJzEhOwze7eTLKZ8r8ht1JWz54LLdepSeHT6tui3lEOy10RF/jKNaoXV94xP/0bgZw60547g4SbrIvPfvZDRQvvDL9pL/HhTfl8AGL2BkhxYzf6V9yqndt/ecl8CYLnqGVDaRXoV753561T
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2018 22:56:52.3417 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cfbb42f-178e-4c00-9e0a-08d5fd823bcc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4942
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65481
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

Changes in v5 (Paul):
- Rebase atop v4.18-rc8.

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
