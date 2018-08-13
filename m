Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Aug 2018 19:26:31 +0200 (CEST)
Received: from mail-cys01nam02on0092.outbound.protection.outlook.com ([104.47.37.92]:14742
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990398AbeHMR01AFOVt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 13 Aug 2018 19:26:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgaG/WjbBeaIa2YxIR7zvqAlb7bEh5+2bF5KJumcTvc=;
 b=H6ixEm0BC7DLp8uGLeNkl82Kr/R6sO0T4W3vzfuoCi02iQ4bu44GgA8kbik/JJ+MOyZ0lSemyljevHRhr2tQ481eJMzqOr2GV99hXoo1balnpGrN/q+/n/7dHl2xyBK+oGtkX7oSiMg98zCQ9iSCUtBevX+tRuQjNhtCYjm9jPo=
Received: from localhost (4.16.204.77) by
 SN6PR08MB4944.namprd08.prod.outlook.com (2603:10b6:805:6e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.23; Mon, 13 Aug 2018 17:26:16 +0000
Date:   Mon, 13 Aug 2018 10:26:13 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [GIT PULL] Main MIPS changes for 4.19
Message-ID: <20180813172613.74i55xmne26ad7dk@pburton-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v7hrmez6dkvzjers"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR21CA0029.namprd21.prod.outlook.com
 (2603:10b6:3:ed::15) To SN6PR08MB4944.namprd08.prod.outlook.com
 (2603:10b6:805:6e::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7529b3b6-6ea8-464a-f9bb-08d60141e01f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR08MB4944;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4944;3:royL8pQd0duI8PI+bemDU4mlRIAb6+bwpjNvzf8C/Gl44JWjWAWqCtx1P9ak1CU9d3D5qWG2z4yenTdO0fD8c3B5heeydUL0X7mtdAVj07Q6eMq1C48nFl9Gqz8KIYKoybot4Ih6DePU9uRXUs6RIcV5TuY7U1aVVRpGI3DDr4dnHZa2CJqwHBVHkPSV5QK1yMCsRfs6egqhhahxfxYyqWe8oci1AUD5fwPUl1qyDdD2NomOvirdAlmvLEdA22mZ;25:Tv6UJlOJjAaUNKDqqwq/CXa2sJfiTiaSZVcMG+NT2nadR/eW/ljChChoLIoxXCGl6C5nlXfwW8nlf4LGzb6ESNimJBmcnN35lzgmgF6QN3tfSrlmlmCdu9WPuuClUS1iM1IJlwxCRP8GVvl0UAADGrg8cGzvabeLf/jtUSrhD+/4xDzom5XH4e3dgeB0uLFYnI5pIZB9HdA8TY6VlbRfRuyoK8IooeaM780MQeXPszWU0yzcyOMQC5R20ak3qmuEF19rqnNlwg6L/APFY3d7TzC6ZV5MemaunGQQ4sQrsn8QxPgOaISqHn/cOwZag1xEdnr/2GSBevtP9cmOPLKFIQ==;31:jqM1aUPs/6QDAxB4eHbeRIEAN5kLSEc04KT19uLYiKP4xClC+gegRjI7j3FZWDtrz5PKvBkFu4PCOw1K9nysQY2MaSXlFpz65x7Q9HRISVWWqzvxJRjglXGke42AmGAlm2xWKo2OO3bqqd5hlMj1LdrTeV6CCuyietjnRzayA9svqYqfNtBwQs2wGH6q00v2ZUMMFp3aEOvEjHmlWoHrJnGBuQ3yZNW7oz1nqDi9oVY=
X-MS-TrafficTypeDiagnostic: SN6PR08MB4944:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4944;20:AJ/T+Ftl1cwlXJqIK0jKAcxUeICOCGbjhVfRgvQ6vqlxuKF5mFTQHSrGg/o+aEk949HiF8Q8G8vp0TUJrtUVtUdD3USnpoa51fv/cTCyJXMjPdeAjZKgEmOEauciX/8AoRdId3LoWWgmX7bHSeBin/OADeqjGQejxrUbfdIOdy06ajxPMySoFev8VZILGCUIAGSQKeoAZRKmOKt47vMvUnMPtet1w/MducVRX3RcaCAsCteujZPGxg2fOiIoBbUk;4:lA4m6IDLSCVNEPbZId/oT3dS9FXLIHUyB+xvoxK6NSR12Zwn9jjzU6RmGPk6rbD0fCBV1NaJQWWHsYX9foN2U4r0gvX/onrdZ6UmhPGAAbCTnt82WQ0DMHNp93auKSnQ6NhyCsvQ1G4Dbw9DdDSlf259mRtRn9NHX0knagaCGSTzYY367kMv3isFCaVWdAx8QNcOakEOxvoKuH0lu2wCUVA2I53TjtagdSMVUwodXfqegfiZ8rZiDjTuxbEMokO3H9Jq/lzBNDDDqV64QPscBvR5BRPYrRFMNIDjPtCWVHDLFkHjmOM3itN1yQ1LTtAF
X-Microsoft-Antispam-PRVS: <SN6PR08MB4944B619634F06F0AA15403BC1390@SN6PR08MB4944.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN6PR08MB4944;BCL:0;PCL:0;RULEID:;SRVR:SN6PR08MB4944;
X-Forefront-PRVS: 07630F72AD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(136003)(366004)(39840400004)(396003)(376002)(346002)(199004)(189003)(14444005)(16586007)(44832011)(486006)(33716001)(956004)(4326008)(66066001)(476003)(84326002)(53936002)(316002)(8936002)(58126008)(21480400003)(68736007)(9686003)(5660300001)(52116002)(26005)(1076002)(25786009)(105586002)(6496006)(106356001)(54906003)(33896004)(16526019)(6486002)(386003)(6116002)(3846002)(81156014)(81166006)(8676002)(186003)(478600001)(42882007)(76506005)(305945005)(7736002)(6916009)(6666003)(97736004)(33964004)(2906002)(44144004)(2700100001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR08MB4944;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR08MB4944;23:niXzDqXO1RgvK+54TfXRKkM/5Igt8Xeo15xkl7Xy/?=
 =?us-ascii?Q?flsXgGVy2FptyYkNyOvDZHj+ZcJcMJ2ZXtM5FI+wpVH/0dMzz+fpEoF+bbE2?=
 =?us-ascii?Q?dhMKv+jKhRoGlwzdaw31NBD1aen9aIho2C3mOik09iyJEd7/f1aGCYMWh8se?=
 =?us-ascii?Q?MmvmsKycDX9uefGIacZ1bEvDht29rSagzVMCXWleCFDxSSRRE6rq+0sKbV5/?=
 =?us-ascii?Q?4W+fJJeRD++wXq8s8R3t9YVdhqAiozNopk4/wki41i6ysASDVfZcp1leImpy?=
 =?us-ascii?Q?fciBmH9Q9ZgGlKOc0axJk7VdeQBhIySn7McVAilQMoV7DTwjvRmxqYX2reLm?=
 =?us-ascii?Q?kXyTtUkhdPbNUmSkLZDa71//fBGGZUyGCQRe7e6fsiVpS5ehOFYmghHOJdoW?=
 =?us-ascii?Q?lmt48wiMJpHfMojz5vhH0DXa9ljD44yA/LYFPvG3OlSkDKmTvbiryEi+mCn6?=
 =?us-ascii?Q?v6Rc2LGMyHI8NqjBkHwQkFg6DBdXdeOYWCFvQ8HMNkT01B2mdZrhe6xVVng1?=
 =?us-ascii?Q?mjPlv60RFWWf8bNqfDy8OLtUPKWLriNCCEDR05NPHg1Eiib9d8gihfX4lLOl?=
 =?us-ascii?Q?g1Ty7oG2f44iU5XDsRV37qBiFRhla4mNocBslb64jLR/8xGkg+mO1V4U79T0?=
 =?us-ascii?Q?JC4f7Z5WMmmgGrtEyv/CEuQfP86+hWR4qNzekojdN9ea/LLnkAfsgGe7obbG?=
 =?us-ascii?Q?Ns/XX6K2Sy2JqJ3tdDEqG2YEcmRB54B8x2cAi6rwiwh72ZmSJpdwQGmhfW2p?=
 =?us-ascii?Q?OvfWyllWOzIZSZsjcvZYuPlWcNdiHbI50sZnv/JOreJetPOKxoW9cWjZqzft?=
 =?us-ascii?Q?GlviRWFmAxk6ThFKISCsK5FbSbOXb/bg3nL2eLYx81gQECiB9Xk1h0nC+g2j?=
 =?us-ascii?Q?h4BFaGSdS05hDyYrwi8vMnuHJhnDF9+bBd8oMoYz/jsyHswoxGEwFZlipbWy?=
 =?us-ascii?Q?UKQdYJ65hbaH3GdtPqudAmOrrTgqzX+LyLxE7/kVocexwtsZqx1G7NLNZ405?=
 =?us-ascii?Q?S6GDmvt+QNr0GH75lkCd59JusTAoY1qAQRpn1DL10HF6GQbl6523kovJNhDJ?=
 =?us-ascii?Q?00T8rzhkWbozrX7HXHZQFKsVYtrCoNWkKER8yvWWIf9QW+Cr06DwAZLssQFD?=
 =?us-ascii?Q?xA8UHYwR8YwtCKUA+1STIRi7pXwYuaDIiltgJfIGN7sLKdd4OG0/wiUIeFaT?=
 =?us-ascii?Q?N54zB9jgrNx9qnHKoWpt1BBmWtugAvCUpSocOYhzKfpZMMT72KXsgv/EZ4xI?=
 =?us-ascii?Q?M2msYRL+0yhuFidM5OFV+K4UUp1Pi9pGsiQd5sBY3Hiwv3rs2n4Yw0QoDCnk?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: jhEEyhQC2bmLg1DBmxLwjQ5SlKOj0bXwO+m/9c9zkd4Dec4if7h2D3GYBRdYFjEbPi8+7FZuTf9ORTKIB2/n9v6kpV/9bCTDDstjUEQbgJwx7zg0cmdGFliey+Rn9YvE8c6C1ylQ9b8ysemId13CC/Il6ZsR243YKx7B2ukjO4kfrBoB5dmW+rwfYN/3K5wC07fYi577QqQ+OJfGRjPrOLUcGunh4WgSlv8NBIL6nWj/XZ15uZvVVGblSXEN3Dpz8sqnNiC75d+aC5L3FvcWXXC2sr+A/I9/6eokVD2F0LVnhwlfUmXzqU8M9j4yEDxynnqKG2qvL63/nfxbLyU3QfD5uhMC0y5WLyNjPH7m8Ao=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4944;6:tt3TSIZ6G7lupEg78CGZWje7NRrdGiAyMhMwSbEUqsxu72pWA6nuVI4cTWjZL6eaxUO0YDTilFtRGR94FTkLbHX2atnaII2TGNb/UNxOkBWf6tMZ0mPLhFNAjLmNMRIlQKd6cKhEedMvbI5TcJIQPhkmiZ98gEdP+Ph8VU28IHO28F6J2W+CDeRjM8uV4l9yTez3Cy8avilvAwNSapWtYHsyl6s4eHw/s3P4eVhH2x66nBFr6uiSGmdhd6JS6802d5lYqyUeiccxagUJWVgJy3W6D6y4SVjhlV7fFD8BdrLG12i4+IZQe7rla95EPF/f1jMJrK0vGLKx3gg111fl8BxVHAfG84Kpv55BJUMkQEyaCZWMzWs2U6s2MPvi6ZO4/Eo+g75tXxt40+dosvCMEGWaaDAmADq01DN5VYTEtQNkHf4bARVTrJu0hkIaDsrP+KiFcaam9J2Xv1Y28bGquA==;5:D7PNCKwvK+Ylj7aWmP2xqw23KoP3enPkcyQmsKU5oCuygbi4jBMO8+sx20gruBcF3mZrtsCbDPqe9JyQQfkHbmegdNSP5JR//zt7GPka723DxEMBvZqX63S7t2Hl8dfG0SgcMqpNIZ7eUwct4qD5EsU1f0ebnfWJcvEF8el71/0=;7:4taKfisMUCMbDrtUtUGWssnCFfLdHN9kfp/H6MtQSaozn8YQZh7pgb1PJwM2rUjBMkP6M0BUgLZj5cmVCLEHq3ZDxl1Gn/cS42keaTSUOpT6uZ0xd6Zt1UFKWoUgCFpngL9bwBpeqvCJQAIpq68yPtGH5KyJlYrqiE1kPP4EBBlDNpC1AXkE3GOD2hLP00kj+opAnBKemSISF9SdXBuF3oXtd+ca+JRXI223CMkxlxhHTCbQhPdRH3RZ3IcN9px3
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2018 17:26:16.2106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7529b3b6-6ea8-464a-f9bb-08d60141e01f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4944
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65573
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


--v7hrmez6dkvzjers
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Here are the main MIPS changes for 4.19.

We still have build failures when targeting the microMIPS ISA, but
that's been true since v4.16-rc3 & the fix caused an ia64 build failure
in -next, so it's not included here. Hopefully I'll be sending that your
way sometime soon.

A trial merge of this into v4.18 results in one minor conflict due to
the addition of 2 different header inclusions in
arch/mips/kernel/process.c. The correct resolution is simply to keep
both:

diff --cc arch/mips/kernel/process.c
index 9670e70139fd,fe6001d748cf..b3d3b397fb12
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@@ -29,7 -29,7 +29,8 @@@
  #include <linux/kallsyms.h>
  #include <linux/random.h>
  #include <linux/prctl.h>
+ #include <linux/cpu.h>
 +#include <linux/nmi.h>

  #include <asm/asm.h>
  #include <asm/bootinfo.h>

Please pull.

Thanks,
    Paul

The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_4.=
19

for you to fetch changes up to 22f20a110321efb7cde3e87ae99862e1036ca285:

  MIPS: Remove remnants of UASM_ISA (2018-08-09 14:45:00 -0700)

----------------------------------------------------------------
Here are the main MIPS changes for 4.19.

An overview of the general architecture changes:

  - Massive DMA ops refactoring from Christoph Hellwig (huzzah for
    deleting crufty code!).

  - We introduce NT_MIPS_DSP & NT_MIPS_FP_MODE ELF notes & corresponding
    regsets to expose DSP ASE & floating point mode state respectively,
    both for live debugging & core dumps.

  - We better optimize our code by hard-coding cpu_has_* macros at
    compile time where their values are known due to the ISA revision
    that the kernel build is targeting.

  - The EJTAG exception handler now better handles SMP systems, where it
    was previously possible for CPUs to clobber a register value saved
    by another CPU.

  - Our implementation of memset() gained a couple of fixes for MIPSr6
    systems to return correct values in some cases where stores fault.

  - We now implement ioremap_wc() using the uncached-accelerated cache
    coherency attribute where supported, which is detected during boot,
    and fall back to plain uncached access where necessary. The
    MIPS-specific (and unused in tree) ioremap_uncached_accelerated() &
    ioremap_cacheable_cow() are removed.

  - The prctl(PR_SET_FP_MODE, ...) syscall is better supported for SMP
    systems by reworking the way we ensure remote CPUs that may be
    running threads within the affected process switch mode.

  - Systems using the MIPS Coherence Manager will now set the
    MIPS_IC_SNOOPS_REMOTE flag to avoid some unnecessary cache
    maintenance overhead when flushing the icache.

  - A few fixes were made for building with clang/LLVM, which
    now sucessfully builds kernels for many of our platforms.

  - Miscellaneous cleanups all over.

And some platform-specific changes:

  - ar7 gained stubs for a few clock API functions to fix build failures
    for some drivers.

  - ath79 gained support for a few new SoCs, a few fixes & better
    gpio-keys support.

  - Ci20 now exposes its SPI bus using the spi-gpio driver.

  - The generic platform can now auto-detect a suitable value for
    PHYS_OFFSET based upon the memory map described by the device tree,
    allowing us to avoid wasting memory on page book-keeping for systems
    where RAM starts at a non-zero physical address.

  - Ingenic systems using the jz4740 platform code now link their
    vmlinuz higher to allow for kernels of a realistic size.

  - Loongson32 now builds the kernel targeting MIPSr1 rather than MIPSr2
    to avoid CPU errata.

  - Loongson64 gains a couple of fixes, a workaround for a write
    buffering issue & support for the Loongson 3A R3.1 CPU.

  - Malta now uses the piix4-poweroff driver to handle powering down.

  - Microsemi Ocelot gained support for its SPI bus & NOR flash, its
    second MDIO bus and can now be supported by a FIT/.itb image.

  - Octeon saw a bunch of header cleanups which remove a lot of
    duplicate or unused code.

----------------------------------------------------------------
Alban Bedel (2):
      MIPS: ath79: Fix the USB PHY reset names
      MIPS: ath79: Use the IRQ based GPIO key driver for the buttons

Alexander Sverdlin (3):
      mips: unify prom_putchar() declarations
      MIPS: Introduce HAS_RAPIDIO Kconfig option
      MIPS: Octeon: Select HAS_RAPIDIO

Alexandre Belloni (4):
      mips: mscc: build FIT image for Ocelot
      MIPS: TXx9: remove useless RTC definitions
      mips: dts: mscc: Add spi on Ocelot
      mips: dts: mscc: enable spi and NOR flash support on ocelot PCB123

Christoph Hellwig (26):
      MIPS: remove a dead ifdef from mach-ath25/dma-coherence.h
      MIPS: simplify CONFIG_DMA_NONCOHERENT ifdefs
      MIPS: remove CONFIG_DMA_COHERENT
      MIPS: Octeon: unexport __phys_to_dma and __dma_to_phys
      MIPS: Octeon: refactor swiotlb code
      MIPS: loongson: remove loongson_dma_supported
      MIPS: consolidate the swiotlb implementations
      MIPS: remove the mips_dma_map_ops indirection
      MIPS: make the default mips dma implementation optional
      MIPS: Octeon: remove mips dma-default stubs
      MIPS: Octeon: move swiotlb declarations out of dma-coherence.h
      MIPS: loongson: untangle dma implementations
      MIPS: loongson: remove loongson-3 handling from dma-coherence.h
      MIPS: use dma_direct_ops for coherent I/O
      MIPS: IP27: use dma_direct_ops
      MIPS: move coherentio setup to setup.c
      MIPS: use generic dma noncoherent ops for simple noncoherent platforms
      MIPS: loongson64: use generic dma noncoherent ops
      MIPS: IP32: use generic dma noncoherent ops
      MIPS: ath25: use generic dma noncoherent ops
      MIPS: jazz: split dma mapping operations from dma-default
      dma-noncoherent: add a arch_sync_dma_for_cpu_all hook
      MIPS: bmips: use generic dma noncoherent ops
      MIPS: remove the old dma-default implementation
      MIPS: remove unneeded includes from dma-mapping.h
      MIPS: remove mips_swiotlb_ops

Felix Fietkau (2):
      MIPS: ath79: fix system restart
      MIPS: ath79: finetune cpu-overrides

Gabor Juhos (2):
      MIPS: ath79: add lots of missing registers
      MIPS: ath79: enable uart during early_prink

Geert Uytterhoeven (1):
      MIPS: AR7: Normalize clk API

Hauke Mehrtens (1):
      MIPS: lantiq: Use dma_zalloc_coherent() in dma code

Heiher (1):
      MIPS: Fix ejtag handler on SMP

Huacai Chen (3):
      MIPS: Change definition of cpu_relax() for Loongson-3
      MIPS: Loongson: Add Loongson-3A R3.1 basic support
      MIPS: Loongson64: Define and use some CP0 registers

Joe Perches (1):
      MIPS: ath25: Convert random_ether_addr to eth_random_addr

John Crispin (1):
      MIPS: ath79: select the PINCTRL subsystem

Joshua Kinard (3):
      MIPS: Use !pci_is_root_bus(bus) in ops-bridge.c
      MIPS: Fix delay slot bug in `atomic*_sub_if_positive' for R10000_LLSC=
_WAR
      MIPS: Cleanup R10000_LLSC_WAR logic in atomic.h

Maciej W. Rozycki (4):
      binfmt_elf: Respect error return from `regset->active'
      MIPS: Correct the 64-bit DSP accumulator register size
      MIPS: Add DSP ASE regset support
      MIPS: Add FP_MODE regset support

Masahiro Yamada (5):
      Revert "MIPS: boot: Define __ASSEMBLY__ for its.S build"
      MIPS: boot: do not include $(cpp_flags) for preprocessing ITS
      MIPS: boot: fix build rule of vmlinux.its.S
      MIPS: boot: add missing targets for vmlinux.*.its
      MIPS: boot: merge build rules of vmlinux.*.itb by using pattern rule

Mathias Kresin (1):
      MIPS: ath79: get PCIe controller out of reset

Mathieu Malaterre (2):
      MIPS: Ci20: Enable SPI/GPIO driver
      MIPS: jz4780: DTS: Probe the spi-gpio driver from devicetree

Matt Redfearn (2):
      MIPS: memset.S: Fix byte_fixup for MIPSr6
      MIPS: memset.S: Add comments to fault fixup handlers

Matthias Schiffer (1):
      MIPS: ath79: add support for QCA953x QCA956x TP9343

Nicholas Mc Guire (3):
      MIPS: Octeon: assign bool true/false not 1/0
      MIPS: Octeon: add missing of_node_put()
      MIPS: generic: fix missing of_node_put()

Paul Burton (27):
      MIPS: Schedule on CPUs we need to lose FPU for a mode switch
      MIPS: Set MIPS_IC_SNOOPS_REMOTE for systems with CM
      MIPS: Malta: Cleanup DMA coherence #ifdefs
      MIPS: Malta: Use PIIX4 poweroff driver to power down
      MIPS: Annotate cpu_wait implementations with __cpuidle
      MIPS: Always use -march=3D<arch>, not -<arch> shortcuts
      MIPS: loongson64: cs5536: Fix PCI_OHCI_INT_REG reads
      MIPS: Hardcode cpu_has_* where known at compile time due to ISA
      MIPS: WARN_ON invalid DMA cache maintenance, not BUG_ON
      MIPS: VDSO: Prevent use of smp_processor_id()
      MIPS: Make (UN)CAC_ADDR() PHYS_OFFSET-agnostic
      MIPS: Fix ISA virt/bus conversion for non-zero PHYS_OFFSET
      MIPS: Allow auto-dection of ARCH_PFN_OFFSET & PHYS_OFFSET
      MIPS: generic: Select MIPS_AUTO_PFN_OFFSET
      MIPS: Remove nabi_no_regargs
      MIPS: Remove unused sys_32_mmap2
      MIPS: Delete unused code in linux32.c
      MIPS: generic: Remove input symbols from defconfig
      MIPS: genvdso: Remove GOT checks
      MIPS: vdso: Allow clang's --target flag in VDSO cflags
      MIPS: Avoid using array as parameter to write_c0_kpgd()
      MIPS: Use read-write output operand in __write_64bit_c0_split()
      MIPS: Use dins to simplify __write_64bit_c0_split()
      MIPS: Always specify -EB or -EL when using clang
      MIPS: VDSO: Force link endianness
      MIPS: netlogic: xlr: Remove erroneous check in nlm_fmn_send()
      MIPS: Remove remnants of UASM_ISA

Paul Cercueil (1):
      MIPS: jz4740: Bump zload address

Quentin Schulz (3):
      MIPS: mscc: ocelot: fix length of memory address space for MIIM
      MIPS: mscc: ocelot: add MIIM1 bus
      MIPS: mscc: ocelot: add interrupt controller properties to GPIO contr=
oller

Rickard Strandqvist (2):
      arch: mips: pci: pci-ip27.c: Remove unused function
      arch: mips: mm: page: Remove unused function

Rob Herring (5):
      MIPS: octeon: use of_platform_populate to probe devices
      MIPS: netlogic: remove unnecessary of_platform_bus_probe call
      MIPS: bmips: remove unnecessary call to register "simple-bus"
      MIPS: generic: remove unnecessary of_platform_populate call
      MIPS: lantiq: remove unnecessary of_platform_default_populate call

Robert P. J. Day (1):
      MIPS: Remove obsolete MIPS checks for DST node "chosen@0"

Serge Semin (3):
      mips: mm: Create UCA-based ioremap_wc() method
      mips: mm: Discard ioremap_uncached_accelerated() method
      mips: mm: Discard ioremap_cacheable_cow() method

Steven J. Hill (7):
      MIPS: Octeon: Remove unused CIU types.
      MIPS: Octeon: Unify QLM data types in CIU header.
      MIPS: Octeon: Convert CIU types to use bitfields.
      MIPS: Octeon: Remove all unused CIU macros.
      MIPS: Octeon: Create simple macro for CIU registers.
      MIPS: Octeon: Simplify CIU register functions.
      MIPS: Octeon: Remove extern declarations.

Thomas Bogendoerfer (2):
      MIPS: Make elf2ecoff work on 64bit host machines
      mips/jazz: provide missing dma_mask/coherent_dma_mask

Thomas Petazzoni (1):
      mips: use asm-generic version of msi.h

Yegor Yefremov (1):
      MIPS: kexec: fix typos

=E8=B0=A2=E8=87=B4=E9=82=A6 (XIE Zhibang) (2):
      MIPS: Loongson: Set Loongson32 to MIPS32R1
      MIPS: Loongson: Merge load addresses

 .../devicetree/bindings/phy/phy-ath79-usb.txt      |     4 +-
 arch/mips/Kconfig                                  |    56 +-
 arch/mips/Makefile                                 |    22 +-
 arch/mips/alchemy/board-gpr.c                      |     3 +-
 arch/mips/alchemy/board-mtx1.c                     |     3 +-
 arch/mips/alchemy/board-xxs1500.c                  |     3 +-
 arch/mips/alchemy/devboards/platform.c             |     3 +-
 arch/mips/ar7/clock.c                              |    29 +
 arch/mips/ar7/prom.c                               |     4 +-
 arch/mips/ath25/Kconfig                            |     1 +
 arch/mips/ath25/board.c                            |     6 +-
 arch/mips/ath25/early_printk.c                     |     5 +-
 arch/mips/ath79/clock.c                            |   193 +
 arch/mips/ath79/common.c                           |     8 +
 arch/mips/ath79/early_printk.c                     |    64 +-
 arch/mips/ath79/setup.c                            |    35 +-
 arch/mips/bcm63xx/early_printk.c                   |     1 +
 arch/mips/bmips/dma.c                              |    32 +-
 arch/mips/bmips/setup.c                            |     7 -
 arch/mips/boot/Makefile                            |    52 +-
 arch/mips/boot/compressed/uart-prom.c              |     3 +-
 arch/mips/boot/dts/ingenic/jz4780.dtsi             |    19 +
 arch/mips/boot/dts/mscc/Makefile                   |     2 +-
 arch/mips/boot/dts/mscc/ocelot.dtsi                |    32 +-
 arch/mips/boot/dts/mscc/ocelot_pcb123.dts          |    10 +
 arch/mips/boot/dts/qca/ar9132.dtsi                 |     2 +-
 arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts   |     3 +-
 arch/mips/boot/dts/qca/ar9331.dtsi                 |     2 +-
 arch/mips/boot/dts/qca/ar9331_dpt_module.dts       |     5 +-
 arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts     |     5 +-
 arch/mips/boot/dts/qca/ar9331_omega.dts            |     5 +-
 arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts        |     5 +-
 arch/mips/boot/ecoff.h                             |    61 +-
 arch/mips/boot/elf2ecoff.c                         |    31 +-
 arch/mips/cavium-octeon/dma-octeon.c               |   191 +-
 .../cavium-octeon/executive/cvmx-helper-rgmii.c    |     5 +-
 .../cavium-octeon/executive/cvmx-helper-sgmii.c    |     7 +-
 .../mips/cavium-octeon/executive/cvmx-helper-spi.c |     8 +-
 .../cavium-octeon/executive/cvmx-helper-xaui.c     |     7 +-
 arch/mips/cavium-octeon/octeon-irq.c               |     2 +-
 arch/mips/cavium-octeon/octeon-platform.c          |     4 +-
 arch/mips/cavium-octeon/setup.c                    |     8 +-
 arch/mips/configs/ci20_defconfig                   |     2 +
 arch/mips/configs/generic_defconfig                |     3 -
 arch/mips/configs/malta_defconfig                  |     1 +
 arch/mips/configs/malta_kvm_defconfig              |     1 +
 arch/mips/configs/malta_kvm_guest_defconfig        |     1 +
 arch/mips/configs/malta_qemu_32r6_defconfig        |     1 +
 arch/mips/configs/maltaaprp_defconfig              |     1 +
 arch/mips/configs/maltasmvp_defconfig              |     1 +
 arch/mips/configs/maltasmvp_eva_defconfig          |     1 +
 arch/mips/configs/maltaup_defconfig                |     1 +
 arch/mips/configs/maltaup_xpa_defconfig            |     1 +
 arch/mips/fw/arc/arc_con.c                         |     1 +
 arch/mips/fw/arc/promlib.c                         |     1 +
 arch/mips/fw/sni/sniprom.c                         |     1 +
 arch/mips/generic/Kconfig                          |    12 +-
 arch/mips/generic/Platform                         |     1 +
 arch/mips/generic/board-ocelot_pcb123.its.S        |    23 +
 arch/mips/generic/init.c                           |    14 +-
 arch/mips/generic/yamon-dt.c                       |     4 -
 arch/mips/include/asm/Kbuild                       |     1 +
 arch/mips/include/asm/atomic.h                     |   195 +-
 arch/mips/include/asm/bmips.h                      |    16 -
 arch/mips/include/asm/cpu-features.h               |   176 +-
 arch/mips/include/asm/cpu.h                        |    51 +-
 arch/mips/include/asm/dma-coherence.h              |     6 +-
 arch/mips/include/asm/dma-direct.h                 |    17 +-
 arch/mips/include/asm/dma-mapping.h                |    20 +-
 arch/mips/include/asm/io.h                         |    40 +-
 arch/mips/include/asm/mach-ar7/spaces.h            |     3 -
 arch/mips/include/asm/mach-ath25/dma-coherence.h   |    76 -
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h     |   771 +-
 arch/mips/include/asm/mach-ath79/ath79.h           |    34 +
 .../include/asm/mach-ath79/cpu-feature-overrides.h |     6 +
 arch/mips/include/asm/mach-bmips/dma-coherence.h   |    54 -
 .../include/asm/mach-cavium-octeon/dma-coherence.h |    79 -
 arch/mips/include/asm/mach-generic/dma-coherence.h |    73 -
 arch/mips/include/asm/mach-generic/kmalloc.h       |     3 +-
 arch/mips/include/asm/mach-generic/spaces.h        |    10 +-
 arch/mips/include/asm/mach-ip27/dma-coherence.h    |    70 -
 arch/mips/include/asm/mach-ip32/dma-coherence.h    |    92 -
 arch/mips/include/asm/mach-jazz/dma-coherence.h    |    60 -
 .../include/asm/mach-loongson64/dma-coherence.h    |    93 -
 .../asm/mach-loongson64/kernel-entry-init.h        |    24 +-
 arch/mips/include/asm/mach-pic32/spaces.h          |     1 -
 arch/mips/include/asm/mipsregs.h                   |    29 +-
 arch/mips/include/asm/mmu_context.h                |     2 -
 arch/mips/include/asm/netlogic/xlr/fmn.h           |     2 -
 arch/mips/include/asm/octeon/cvmx-asxx-defs.h      |     4 +-
 arch/mips/include/asm/octeon/cvmx-ciu-defs.h       | 10062 +--------------=
----
 arch/mips/include/asm/octeon/cvmx-gmxx-defs.h      |     4 +-
 arch/mips/include/asm/octeon/cvmx-pcsx-defs.h      |     4 +-
 arch/mips/include/asm/octeon/cvmx-pcsxx-defs.h     |     4 +-
 arch/mips/include/asm/octeon/cvmx-spxx-defs.h      |     4 +-
 arch/mips/include/asm/octeon/cvmx-stxx-defs.h      |     4 +-
 arch/mips/include/asm/octeon/octeon.h              |     9 +-
 arch/mips/include/asm/octeon/pci-octeon.h          |     3 +
 arch/mips/include/asm/page.h                       |    11 +-
 arch/mips/include/asm/processor.h                  |    15 +-
 arch/mips/include/asm/setup.h                      |     2 +
 arch/mips/include/asm/sgialib.h                    |     1 -
 arch/mips/include/asm/sim.h                        |    12 -
 arch/mips/include/asm/smp.h                        |    12 +-
 arch/mips/include/asm/txx9/generic.h               |     1 -
 arch/mips/include/asm/txx9/tx4939.h                |    29 -
 arch/mips/jazz/jazzdma.c                           |   141 +-
 arch/mips/jazz/setup.c                             |    17 +-
 arch/mips/jz4740/Platform                          |     2 +-
 arch/mips/kernel/cpu-probe.c                       |     3 +-
 arch/mips/kernel/early_printk.c                    |     2 -
 arch/mips/kernel/early_printk_8250.c               |     1 +
 arch/mips/kernel/genex.S                           |    46 +
 arch/mips/kernel/idle.c                            |    12 +-
 arch/mips/kernel/linux32.c                         |    29 -
 arch/mips/kernel/process.c                         |    80 +-
 arch/mips/kernel/ptrace.c                          |   254 +-
 arch/mips/kernel/ptrace32.c                        |     2 +-
 arch/mips/kernel/relocate_kernel.S                 |     4 +-
 arch/mips/kernel/setup.c                           |    38 +-
 arch/mips/kernel/signal.c                          |    24 +-
 arch/mips/kernel/signal_n32.c                      |    12 +-
 arch/mips/kernel/signal_o32.c                      |    24 +-
 arch/mips/kernel/traps.c                           |     7 -
 arch/mips/lantiq/early_printk.c                    |     1 +
 arch/mips/lantiq/prom.c                            |     8 -
 arch/mips/lantiq/xway/dma.c                        |     3 +-
 arch/mips/lasat/prom.c                             |     1 +
 arch/mips/lib/memset.S                             |    21 +-
 arch/mips/loongson32/Platform                      |     8 +-
 arch/mips/loongson64/Kconfig                       |     5 -
 arch/mips/loongson64/common/Makefile               |     6 +-
 arch/mips/loongson64/common/cs5536/cs5536_ohci.c   |     2 +-
 arch/mips/loongson64/common/dma-swiotlb.c          |   109 -
 arch/mips/loongson64/common/dma.c                  |    18 +
 arch/mips/loongson64/common/early_printk.c         |     1 +
 arch/mips/loongson64/common/env.c                  |     3 +-
 arch/mips/loongson64/loongson-3/Makefile           |     2 +-
 arch/mips/loongson64/loongson-3/dma.c              |    25 +
 arch/mips/loongson64/loongson-3/smp.c              |     3 +-
 arch/mips/mm/Makefile                              |     3 +-
 arch/mips/mm/c-r4k.c                               |    18 +-
 arch/mips/mm/cache.c                               |     4 +-
 arch/mips/mm/dma-default.c                         |   404 -
 arch/mips/mm/dma-noncoherent.c                     |   208 +
 arch/mips/mm/page.c                                |    15 -
 arch/mips/mm/tlbex.c                               |     2 +-
 arch/mips/mm/uasm-micromips.c                      |     1 -
 arch/mips/mm/uasm-mips.c                           |     1 -
 arch/mips/mti-malta/Makefile                       |     2 -
 arch/mips/mti-malta/malta-pm.c                     |    96 -
 arch/mips/mti-malta/malta-reset.c                  |    30 -
 arch/mips/mti-malta/malta-setup.c                  |    39 +-
 arch/mips/netlogic/common/earlycons.c              |     1 +
 arch/mips/netlogic/xlp/dt.c                        |    14 -
 arch/mips/paravirt/serial.c                        |     5 +-
 arch/mips/pci/ops-bridge.c                         |     4 +-
 arch/mips/pci/pci-ar2315.c                         |    24 +
 arch/mips/pci/pci-ar724x.c                         |    42 +
 arch/mips/pci/pci-ip27.c                           |    25 +-
 arch/mips/pci/pci-octeon.c                         |     4 -
 arch/mips/pci/pcie-octeon.c                        |     6 +-
 arch/mips/pic32/pic32mzda/early_console.c          |     5 +-
 arch/mips/ralink/early_printk.c                    |     7 +-
 arch/mips/sgi-ip27/ip27-console.c                  |     1 +
 arch/mips/sgi-ip32/Makefile                        |     2 +-
 arch/mips/sgi-ip32/ip32-dma.c                      |    37 +
 arch/mips/sibyte/Kconfig                           |     1 -
 arch/mips/sibyte/common/cfe.c                      |     1 +
 arch/mips/txx9/generic/setup.c                     |     1 +
 arch/mips/vdso/Makefile                            |     9 +-
 arch/mips/vdso/genvdso.h                           |    51 -
 arch/mips/vr41xx/common/pmu.c                      |     3 +-
 drivers/platform/mips/cpu_hwmon.c                  |     3 +-
 fs/binfmt_elf.c                                    |     2 +-
 include/linux/dma-noncoherent.h                    |     8 +
 include/uapi/linux/elf.h                           |     2 +
 kernel/dma/noncoherent.c                           |     8 +-
 178 files changed, 2956 insertions(+), 12251 deletions(-)
 create mode 100644 arch/mips/generic/board-ocelot_pcb123.its.S
 delete mode 100644 arch/mips/include/asm/mach-ath25/dma-coherence.h
 delete mode 100644 arch/mips/include/asm/mach-bmips/dma-coherence.h
 delete mode 100644 arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
 delete mode 100644 arch/mips/include/asm/mach-generic/dma-coherence.h
 delete mode 100644 arch/mips/include/asm/mach-ip27/dma-coherence.h
 delete mode 100644 arch/mips/include/asm/mach-ip32/dma-coherence.h
 delete mode 100644 arch/mips/include/asm/mach-jazz/dma-coherence.h
 delete mode 100644 arch/mips/include/asm/mach-loongson64/dma-coherence.h
 delete mode 100644 arch/mips/loongson64/common/dma-swiotlb.c
 create mode 100644 arch/mips/loongson64/common/dma.c
 create mode 100644 arch/mips/loongson64/loongson-3/dma.c
 delete mode 100644 arch/mips/mm/dma-default.c
 create mode 100644 arch/mips/mm/dma-noncoherent.c
 delete mode 100644 arch/mips/mti-malta/malta-pm.c
 delete mode 100644 arch/mips/mti-malta/malta-reset.c
 create mode 100644 arch/mips/sgi-ip32/ip32-dma.c

--v7hrmez6dkvzjers
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRgLjeFAZEXQzy86/s+p5+stXUA3QUCW3G/NQAKCRA+p5+stXUA
3Z/OAP4pIV/g2u+N/1/0gilnyg5cLYuV46M4ZNTJL84DSLIzTgD+P+kDLyrZlQRg
LDn3lt/gBs1FkD6X5DE6m1IxJ0sOQAg=
=v92i
-----END PGP SIGNATURE-----

--v7hrmez6dkvzjers--
