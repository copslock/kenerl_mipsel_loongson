Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Aug 2018 19:56:15 +0200 (CEST)
Received: from mail-by2nam03on0130.outbound.protection.outlook.com ([104.47.42.130]:38639
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994077AbeHWR4JuE2kW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Aug 2018 19:56:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qitb6SQUw3VLY1kGDg8eqwSC9vkb/Df/01aWvvrekjQ=;
 b=M2wwES+qJvBhjGM+th3FgrXzHcAgVjGYRhXOZkAz0NA51HHxDkSpGze31pzuubKrm6CeGodlSq6yjndvK3YafK/YLV9eIV8RM0Gr8uEKHgGNj0EBY1Su3m49CnSlL7psPxuOsAa7GMiXWck/sCr5RJLcrbbLk34eleuB+KgEd+g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BN7PR08MB4930.namprd08.prod.outlook.com (2603:10b6:408:28::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.13; Thu, 23 Aug 2018 17:55:55 +0000
Date:   Thu, 23 Aug 2018 10:55:52 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [GIT PULL] MIPS fixes for 4.19-rc1
Message-ID: <20180823175552.vcvct6im553gqpxj@pburton-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="knq5u2lkkg7y2qpq"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM6PR08CA0014.namprd08.prod.outlook.com
 (2603:10b6:5:80::27) To BN7PR08MB4930.namprd08.prod.outlook.com
 (2603:10b6:408:28::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c0819e4-a558-4c3b-2e94-08d60921acc4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4930;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4930;3:nNJYFnF/OoljX1Kj7WoKk2jVrAZ9vLj+ZDCOw0Rp7FtDtbr4HJCY6obcsne62GQTHzRMN7s1e7u6KO/qQqpaX3rwL9ssmeqlb6psctAOZB4iEFS1AVPUa4kErLC3qR3Zxt0kcueRki72mViKsJGTGTC7lIdnSr8i2ltBMC/eEk2EFPkVAmUbJatnks24G23mfZVq9skEVZRhkZ+HYkhMgMv8GDYaeYCNIYdWj06KOLeKWIlUJKoohPeEBrR0GRhJ;25:WqpK2aBtfU5I0XFYj3p2ukbBX5m7jfxg/7MNFxAUCPzSPmkZYLlenw7lKRAkJBUTeIMegU3bOVRs1tfTxLNk2Y2pcYGN1PyXY5pMiw/GnsaQ5hvkMZFG6l1QiLVcglzBtqIS7NxV67RIHgh1X6+opnGDa/ZRAQP1eJ4P3tTt8dJrbUK8DnLhXxEu7iKNjRis/iOsfVW3wAPII96SWSfhd9cGHCk+2adhhQlEgZylapom9iRns1b30xLkrrgRFiiJa/DZQbCt7V/S0UyRO4kwFUGmRWye+6Zmz9vCvZEfIDq5NKHGod+wKgwtEZDMPMaPwefGkcpEJzIBQQfDJ2/Ymg==;31:z0OtR+PijxeZT2ARWsT3OFLUXojDiULmlmPrkBV9FJN2mz9Ls8WpEUPwaTS363Hvw4ZMC1+JS/jKzqdM8LkJt6tIdwU2PeVt1BbWferreJXXDMvi0T6iRE7Wb5HA5I5teP+L+s4xYodkfm1zj5fY+FCuf0VEPKf7vlSXGUVdnfXR4webrgDisjJlu6uezTK5oTO2RN5nLhxgfXqrO0d/zTMp9xP5p4/uHOkaiAtbek8=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4930:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4930;20:e9miFboh6zJr8+cZVy4sOT48TqChFWHr+f1Xvw8BiSXunzXwoulBEC/Wo1I/I7lcfjwGNsvLjhgVTw+22DMwQA4o6oksjH9Naso1Y98/O5RU2fIXcEqt4gQdhItuiE55yy0TdvEEREMzgWwx3+R5k73dLjhjbSDLK4/27f/YE3v3Jc1MG8R+c+mQF8PALogCTklv1zLbx+yvXJfzxd9SPaMMp1IOkiZJLARurPTsIoC2vZmv8RYQqE9Uf6Qq1MCU;4:xZbqM51u8QWiV7R1epNf8pZHfA3r3ImoRFoGyJ9X/+9Mh3GvQJnFO7qXBoFuCEjsejSzP2ITtbzCnnhXcVdRR5UV9O+AWsN7AkGezTXJoiShci8zQTUx95gUPoXfXgM3SWijWU4O1uooov+TAUS32b8pIzT92ry8tr8RsDoqwixmoquqe8WiswghmD1xz7q6R8SS/LsyZKp/cq8g+EmCWABa9sKPMjP2bVlm0DvMiKwHzSc9Ju3aAcdD+ugbcbZH6qcZypOrwrIo+Q1sgU168eBchQuW1jUt5jIJoXhStzk5Rjk25h1DPnXeSR5mGbMurfueY9wQ/K5xFRdPhF8/52rkquKo0pL7IiDiGZOCSw4=
X-Microsoft-Antispam-PRVS: <BN7PR08MB493039FC3EE10A835C125A8CC1370@BN7PR08MB4930.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699016);SRVR:BN7PR08MB4930;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4930;
X-Forefront-PRVS: 0773BB46AC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(39840400004)(396003)(136003)(346002)(376002)(366004)(189003)(199004)(3846002)(6116002)(53936002)(5660300001)(76506005)(956004)(52116002)(476003)(8936002)(81166006)(81156014)(6486002)(68736007)(575784001)(8676002)(21480400003)(6496006)(6666003)(9686003)(6916009)(486006)(97736004)(44144004)(1076002)(105586002)(33896004)(66066001)(33716001)(42882007)(84326002)(106356001)(7736002)(305945005)(478600001)(14444005)(2906002)(44832011)(316002)(16586007)(16526019)(54906003)(186003)(26005)(4326008)(25786009)(386003)(58126008)(63394003)(2700100001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4930;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4930;23:GcRuFINBKdZOluiGnCfrXjexuUpj2/rPW/DQXqzQw?=
 =?us-ascii?Q?70hxMGcjmK8UV/efV3AYHF+0HQA5Z2G8p/ZeSZHNli77oHuJjFzIs/QAK1/B?=
 =?us-ascii?Q?dUMS2xltGjl8zTYOaJhyB2bfbjP8H/BR6eBzBFYlO6hIRm/cQ2NH8LN2ENN9?=
 =?us-ascii?Q?qGhZS5A0FgvASMtvOaipGt3u45zaOcZZLgDM5M/nFty9bVlX9k0JiuVNQRVz?=
 =?us-ascii?Q?y5cHWsCK+izNgFE4y5+YOHfG6KM4bkgRN/884GaMTTUd5NU/eyMcEFqW/y3J?=
 =?us-ascii?Q?Ev5jEIsGLSLJwihZpI4p0p5NFlg5UNIj3pmq810KIZHrpNjoQhAXyKc0DUw1?=
 =?us-ascii?Q?ZZrHnnJ6aIxS1wB96x+KOwxDtSC/wr94zpD8nfPq+H9tVwPHj/Cx9h6lZ6gC?=
 =?us-ascii?Q?EmQ6sC3pmjd8JjN6bVEA8QgwrO6T9Hz/sjtH3GWqfVi9NsVRuomjaqoJdve9?=
 =?us-ascii?Q?6M1pDwxFFTkxnlkBAYrAOiJ+CM92bdexcPpg54/mcRNSAx8SplG3ybezuv8n?=
 =?us-ascii?Q?8wkufLWdLz+/5Dj7uKVd5tEDu7VLwzUhoi0pKrpPRofNIAICBAPiFsgR3PdO?=
 =?us-ascii?Q?UO7Yd8gbGcCY2vcMU+3+N3LnoZ+W4iAmzmaDcU49f9syROH2AjRyyOKCW1qw?=
 =?us-ascii?Q?X3BIPM9bphpVFE6OmLcuIr9CPNbpgjG7dJVhw1vWtjPjVXBC8zARnos62yHa?=
 =?us-ascii?Q?+3uqMBKMBdZV3EF97TCMocdaOB3xGPzhi7h9JEsppGPpbBMt7FCecBL8rJOk?=
 =?us-ascii?Q?D/AWfbC0cFl2RsRtGJQx2Kj287PWCyd7F8ltqj76R4fhtlipH9yaiSsB8+Ke?=
 =?us-ascii?Q?Ugg5HXZir1BSj4naJEYMnT0uP2Il8j/NJpyj6hJV/IM74RESe8AuKsw51s+c?=
 =?us-ascii?Q?KYO1BKZYecDnYIpN6eaB4RBnimj9JFlBmw7lcsq3e3/DfvdkVuuH3t9n9aX8?=
 =?us-ascii?Q?oy/YGPtniAautokI+MeKsI7Cmfa/HiHuJPLx5q5X3I1WnTvRn2mwuUHmApSn?=
 =?us-ascii?Q?G9OLF4jxsM/QxVmsw3WLyHyOIp9krMyRdIO8ULqthHxW8LZyNMCl++q5qKyC?=
 =?us-ascii?Q?czAMwKEcxZRZ3SAcy1Y4kFN0UzcnfvYk37NcdFhc+WTnj2t1BKGJ2zncRZRY?=
 =?us-ascii?Q?t9P4meWXHSqLvzHLkN48Cz9SN/bvMVEuvYAiHHlAS/oy/l5asOD/nRVuMe4q?=
 =?us-ascii?Q?7RcYZnhq6zCUgqGEqIhEFfLRAlmcvj8sgeoyyk+E2UGQsu2SuVxhukSZEzFS?=
 =?us-ascii?Q?d/na6qyQ2v8RCKZNKlDnLxbWxMJylib0S8PRlJMlkoAY86AuUWH6Hhe2oY1e?=
 =?us-ascii?Q?EZUzxGAQAkKslcNQ5lhYgA=3D?=
X-Microsoft-Antispam-Message-Info: YX6Y28rQgqlO07iR+0p2K9so4W73yVGkzkeIm2InfffebrdVSMoa9U4F9vPSIp0xZiRdy7KzgxtgcBouBWjtUUprNdusJ+dZyGlwHdETOaFueEempqKGlqe/Fgt1fKZpgyaWcfKhMyuoFIXdATp175l1GEJhLGbPrfxxETzqEHg6/PzR+o22cxBQvqwYu2cf3ADLvy+3JYRw5jiwqlTeke5Omn5jrASSMkjM8J9XBPCB7UZyTGnN9/NSTLgSXqcuzcmBVDSCJbovAnD9OOj9NvQtUdMEeb+5JXzEqNPF8MsFyGmG1x/mDbYiAtbG2wzEebh7EY4ZOvW+gIPlPwHZOATwihXxo/SMtn813KrdqRE=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4930;6:Yur/lyDYftGHGAPWyFSHQ74qgFrVW83RhfxhHmsSF0nI5NAxfUU2T6OwyXDlKELEAiwI3Ngq3AeCFZGPIPANMpQxlx3IPw9gHI2FKCLV83/R+30cn4rAKs0SfGycvhVOarSpZs289QTawT9EB5Tf9JA0lG5q9GtsofJ3at48TXiWPNyMdLPdfVeVCssG40rmfXFsU0ouDDJ9Pv8GlnwOJB4uZfB5yof8rPmmS2oT4Xxq8NESyya5p7BignQkGzzaOKFALOOuJPgakVwz0FBBTh4IJVUF6+gZ2xQocy7BIazmGMqhTblV9TFJsS5sHlryogf3MHCujOY8Z48vom+brRYxB/Ag4S3FhnOzqF+GKWyBhG4aiV1ecIXyrpGSJ0v6Yx0eFZWsNL9vq4mkeSOjwtV/MbwMRoFbzfx5aWmzqZ4t/tvilIxqZEnb50YQTjtef210VDKQ1+ted6oWl/q2ZA==;5:QssN3hkttohPZTO14pwd3455llu4Rl3dtwm1VG8Juij5ZAcUz6txA2GpLGW90z/jEel9CuzHMV90N1ZQ2an5ewA8v3S/XSFH6KbAkZD60NxRQIqBtfiXjexMzT1ugOCaZD0ipkbbuKaI8TsCzGEXvvP62akww+GuW/JAye2hrtE=;7:X7G6LWoszwe9mi8Z27p1+EM3gImGJf6sGH0LBNQ6pWTWUm6DQWXqOr4oDQFn+MaY5OGMb7IxP79UNNvtG/dYsyf5y+UscnWTTMHs0kvLXsjmMvFcQrcKpRN6RuF2CMH1WS4jK4qG+7+/KP+KtUBIFhJBBWTNQowWqviuQbmMRocVnjgZFiEg6/j3fcHZNfUILdCaJpcAKj4gPLWUjsdoDXY600mKpLUD0VPOHZ9BqNqOfzF5OOE3sMXqao3Lre8O
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2018 17:55:55.4221 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c0819e4-a558-4c3b-2e94-08d60921acc4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4930
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65724
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


--knq5u2lkkg7y2qpq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Here are a few MIPS fixes for 4.19 - please pull.

There are a couple of conflicts with master, currently at 815f0ddb346c
("include/linux/compiler*.h: make compiler-*.h mutually exclusive"), but
nothing complex:

  - arch/Kconfig should just keep the additions of both
    HAVE_ARCH_PREL32_RELOCATIONS & HAVE_ARCH_COMPILER_H.

  - include/linux/compiler_types.h should keep the #ifdef
    CONFIG_HAVE_ARCH_COMPILER_H & associated comment, placing it after
    the linux/compiler-*.h inclusions.

Here's a sample resolution:

diff --cc arch/Kconfig
index 4426e9687d89,5c7c48e7b727..af0283ad1534
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@@ -841,18 -971,12 +841,26 @@@ config REFCOUNT_FUL
          against various use-after-free conditions that can be used in
          security flaw exploits.

 +config HAVE_ARCH_PREL32_RELOCATIONS
 +      bool
 +      help
 +        May be selected by an architecture if it supports place-relative
 +        32-bit relocations, both in the toolchain and in the module loade=
r,
 +        in which case relative references can be used in special sections
 +        for PCI fixup, initcalls etc which are only half the size on 64 b=
it
 +        architectures, and don't require runtime relocation on relocatable
 +        kernels.
 +
+ config HAVE_ARCH_COMPILER_H
+       bool
+       help
+         An architecture can select this if it provides an
+         asm/compiler.h header that should be included after
+         linux/compiler-*.h in order to override macro definitions that th=
ose
+         headers generally provide.
+
  source "kernel/gcov/Kconfig"
 +
 +source "scripts/gcc-plugins/Kconfig"
 +
 +endmenu
diff --cc include/linux/compiler_types.h
index 90479a0f3986,4be464a07612..3525c179698c
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@@ -54,20 -54,44 +54,32 @@@ extern void __chk_io_ptr(const volatil
 =20
  #ifdef __KERNEL__
 =20
 -#ifdef __GNUC__
 -#include <linux/compiler-gcc.h>
 -#endif
 -
 -#if defined(CC_USING_HOTPATCH) && !defined(__CHECKER__)
 -#define notrace __attribute__((hotpatch(0,0)))
 -#else
 -#define notrace __attribute__((no_instrument_function))
 -#endif
 -
 -/* Intel compiler defines __GNUC__. So we will overwrite implementations
 - * coming from above header files here
 - */
 -#ifdef __INTEL_COMPILER
 -# include <linux/compiler-intel.h>
 -#endif
 -
 -/* Clang compiler defines __GNUC__. So we will overwrite implementations
 - * coming from above header files here
 - */
 +/* Compiler specific macros. */
  #ifdef __clang__
  #include <linux/compiler-clang.h>
 +#elif defined(__INTEL_COMPILER)
 +#include <linux/compiler-intel.h>
 +#elif defined(__GNUC__)
 +/* The above compilers also define __GNUC__, so order is important here. =
*/
 +#include <linux/compiler-gcc.h>
 +#else
 +#error "Unknown compiler"
  #endif
 =20
+ /*
+  * Some architectures need to provide custom definitions of macros provid=
ed
+  * by linux/compiler-*.h, and can do so using asm/compiler.h. We include =
that
+  * conditionally rather than using an asm-generic wrapper in order to avo=
id
+  * build failures if any C compilation, which will include this file via =
an
+  * -include argument in c_flags, occurs prior to the asm-generic wrappers=
 being
+  * generated.
+  */
+ #ifdef CONFIG_HAVE_ARCH_COMPILER_H
+ #include <asm/compiler.h>
+ #endif
+
  /*
 - * Generic compiler-dependent macros required for kernel
 + * Generic compiler-independent macros required for kernel
   * build go below this comment. Actual compiler/compiler version
   * specific implementations come from the above header files
   */

Thanks,
    Paul


The following changes since commit 22f20a110321efb7cde3e87ae99862e1036ca285:

  MIPS: Remove remnants of UASM_ISA (2018-08-09 14:45:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_4.=
19_2

for you to fetch changes up to 690d9163bf4b8563a2682e619f938e6a0443947f:

  MIPS: lib: Provide MIPS64r6 __multi3() for GCC < 7 (2018-08-21 12:14:11 -=
0700)

----------------------------------------------------------------
A few MIPS fixes for 4.19:

  - Fix microMIPS build failures by adding a .insn directive to the
    barrier_before_unreachable() asm statement in order to convince the
    toolchain that the asm statement is a valid branch target rather
    than a bogus attempt to switch ISA.

  - Clean up our declarations of TLB functions that we overwrite with
    generated code in order to prevent the compiler making assumptions
    about alignment that cause microMIPS kernels built with GCC 7 &
    above to die early during boot.

  - Fix up a regression for MIPS32 kernels which slipped into the main
    MIPS pull for 4.19, causing CONFIG_32BIT=3Dy kernels to contain
    inappropriate MIPS64 instructions.

  - Extend our existing workaround for MIPSr6 builds that end up using
    the __multi3 intrinsic to GCC 7 & below, rather than just GCC 7.

----------------------------------------------------------------
Paul Burton (6):
      MIPS: Export tlbmiss_handler_setup_pgd near its definition
      MIPS: Consistently declare TLB functions
      MIPS: Avoid move psuedo-instruction whilst using MIPS_ISA_LEVEL
      compiler.h: Allow arch-specific asm/compiler.h
      MIPS: Workaround GCC __builtin_unreachable reordering bug
      MIPS: lib: Provide MIPS64r6 __multi3() for GCC < 7

 arch/Kconfig                           |   8 +++
 arch/mips/Kconfig                      |   1 +
 arch/mips/include/asm/asm-prototypes.h |   1 +
 arch/mips/include/asm/atomic.h         |   4 +-
 arch/mips/include/asm/compiler.h       |  35 ++++++++++++
 arch/mips/include/asm/mmu_context.h    |   1 +
 arch/mips/include/asm/tlbex.h          |   9 +++
 arch/mips/kernel/traps.c               |   4 +-
 arch/mips/lib/multi3.c                 |   6 +-
 arch/mips/mm/tlb-funcs.S               |   3 +-
 arch/mips/mm/tlbex.c                   | 101 +++++++++++++----------------=
----
 include/linux/compiler_types.h         |  12 ++++
 12 files changed, 116 insertions(+), 69 deletions(-)

--knq5u2lkkg7y2qpq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRgLjeFAZEXQzy86/s+p5+stXUA3QUCW371KAAKCRA+p5+stXUA
3WjyAQDSLNawb+awSS2HzMgmO3rT+rn1CxkUeO1NOGXGy6csfgD+JdihN+GwiTo3
9lKyzHl/R3w0c1vDFComfIl0on5xcw4=
=h9DG
-----END PGP SIGNATURE-----

--knq5u2lkkg7y2qpq--
