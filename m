Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Oct 2018 21:08:12 +0200 (CEST)
Received: from mail-co1nam03on0137.outbound.protection.outlook.com ([104.47.40.137]:36160
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993070AbeJZTIIySBXc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 26 Oct 2018 21:08:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiO0CVYjNgmYlsUYd61O7Ymo3gdMxcLmLC15iMtfNFI=;
 b=NlQ9e18IGwaSyHfwTzesLPlYBFwElk15Gvr1zNm+2F9alpR+sEde3w7R82Vz1jR/hpigqMumrCH/nj5oOviyFSXDdfFnE71Ad4ShMVDGlkB7f3pSXjdiSbB32UE2vQasYUWK7CF43krxnSrS3KCcVKUqAWt1ohzu8fL9k91h1+Y=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1119.namprd22.prod.outlook.com (10.174.169.157) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.25; Fri, 26 Oct 2018 19:07:58 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1273.025; Fri, 26 Oct 2018
 19:07:58 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: [GIT PULL] MIPS changes for 4.20
Thread-Topic: [GIT PULL] MIPS changes for 4.20
Thread-Index: AQHUbV803RDl80Tco0CdIK4M7ce+iw==
Date:   Fri, 26 Oct 2018 19:07:57 +0000
Message-ID: <20181026190756.fqk2ozm2ruhmwwex@pburton-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1301CA0025.namprd13.prod.outlook.com
 (2603:10b6:301:29::38) To MWHSPR00MB117.namprd22.prod.outlook.com
 (2603:10b6:300:10c::23)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1119;6:mKK9B66JEHupf3dJjRi0RCluz3WbkqAWvp856tjKXkJA4enRHibtSR33YbYOdfwd9skuGba36woVIDBa6I960MFqVwIE/ryu86CwvEo2YF5Qv1DFHQj14yLxfvArokWO+ZqZUoCYbgpxw6djA0KBwagKDbVRr/NjYirsyn3pYy1BWSFLW5I/CcTPOSwl85evUNAKp+WbqtwIL4BfWsOfQR0iRPugvTzck2faNOBvA/nUO+8TwoV/ohPechzLqcezAe0/4mP4xQZ1wkRjgIGOxDOh/v3shQSLZYlBrjQdsGTYL+4IVhLvm2+iIy1KpUFnozNF4/87fyYnUwTge1ofTJ8yWMfHtGY4Ee13GL0FCDFBHv5BQHzbv0oEVVBS7wDPmIl8iGBo20fzu0Kf6OD2bN021IGcCs8E+3UE/1FH3M7IwVyE3GYYc/eS4H19xFaUUMRv3+Z32EP7+ZUOKx9GLQ==;5:JyCuaX35/Y5/Ye7VBLiptuwNgxPVSo08LZHnadio5csfwMvrlLAc/6WXbpRTOWYOutVDrobHfeUHaSW+z1c5Ku2gflKYVDI5GhJRQv6XXayYj18FTdb4iWjPsqNtvXrQeiyhqZk9+vOoe210pJlEeLQxGgI0UTnPr146W1bfA84=;7:w8spR3IA1YKLiw3s4MFIPo8mQ5bs2eWsFqF7kQS8SV4ixrXa9DFbFbgi0dd5MgiqzTJIGfY8djspdINLOtQUWonU8irgbHkHQgH+pf5n3BJpFm8Ye+h84yVPUq2qPK9Ve00F3fvRGp/9RJtUowSVUA==
x-ms-office365-filtering-correlation-id: eeaba772-7284-4e52-84bf-08d63b765712
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(49563074)(7193020);SRVR:MWHPR2201MB1119;
x-ms-traffictypediagnostic: MWHPR2201MB1119:
x-microsoft-antispam-prvs: <MWHPR2201MB11195EB428E7EE2097F610A1C1F00@MWHPR2201MB1119.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150)(209352067349851);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(102415395)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(4983020)(52105095)(3002001)(93006095)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(20161123560045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1119;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1119;
x-forefront-prvs: 083751FCA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(346002)(396003)(39840400004)(376002)(136003)(199004)(189003)(2900100001)(5250100002)(81166006)(81156014)(58126008)(97736004)(71190400001)(316002)(54906003)(14454004)(8936002)(508600001)(71200400001)(4001150100001)(476003)(25786009)(486006)(44832011)(6916009)(99936001)(106356001)(33716001)(575784001)(105586002)(8676002)(42882007)(4326008)(66066001)(6486002)(5660300001)(186003)(6436002)(305945005)(102836004)(7736002)(68736007)(33896004)(6506007)(386003)(256004)(6512007)(14444005)(9686003)(26005)(53936002)(52116002)(1076002)(99286004)(3846002)(2906002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1119;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: koxs2gQokf2Go5uVhzXc40zmzrIN/H6BHxOPTjoCq/MVzfVl2d1qL0V4AnHXfP3x8ONHvKlvDo0ZqqDW+iE8cy4uQe+tAm4Ki155Cm18eCB6TDliS806YqypUPt/i62OmEXkkjdUuQKXpzueZFva8E9bsDxkx/7L4Jc8wrfRdVoUoVG+wmDzzyo2+TyofV5l3h3IBM+M6QMLK7JPcB3TNl0JeJjLAueBF7M4mnjGsbmCebzE1SKYyRICWoDZA+0pWcDhizIU/bwZPHQ3QBoI/uxT5IAgzyvSwFipOpl5uTVCGKENr1g6suGnOxHbi+EncDv/RxqIM8g/zlXt5iHDsgVcX1WjGModHzxvnsNm3x0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3aqyq7yq5vhk3w2o"
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeaba772-7284-4e52-84bf-08d63b765712
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2018 19:07:57.9570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1119
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66959
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

--3aqyq7yq5vhk3w2o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Here are the main MIPS changes for 4.20. Please pull.

A merge into master as of commit 18d0eae30e6a ("Merge tag
'char-misc-4.20-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc") results
in one minor conflict in arch/mips/lib/memset.S. Both the .set reorder &
.set noreorder directives following the .Lsmall_fixup label should be
removed, leaving the file matching its version as of the mips_4.20 tag.

Thanks,
    Paul

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_4.20

for you to fetch changes up to edbb4233e7efc37dbebb10f7774b38c64080dd66:

  MIPS: Cleanup DSP ASE detection (2018-10-16 15:30:21 -0700)

----------------------------------------------------------------
Here are the main MIPS updates for 4.20:

  - kexec support for the generic MIPS platform when running on a CPU
    including the MIPS Coherence Manager & related hardware.

  - Improvements to the definition of memory barriers used around MMIO
    accesses, and fixes in their use.

  - Switch to CONFIG_NO_BOOTMEM from Mike Rapoport, finally dropping
    reliance on the old bootmem code.

  - A number of fixes & improvements for Loongson 3 systems.

  - DT & config updates for the Microsemi Ocelot platform.

  - Workaround to enable USB power on the Netgear WNDR3400v3.

  - Various cleanups & fixes.

----------------------------------------------------------------
Alexandre Belloni (4):
      MIPS: dts: mscc: Add i2c on ocelot
      MIPS: dts: mscc: enable i2c on ocelot_pcb123
      MIPS: stop using _PTRS_PER_PGD
      MIPS: generic: Add Network, SPI and I2C to ocelot_defconfig

Dengcheng Zhu (6):
      MIPS: kexec: Mark CPU offline before disabling local IRQ
      MIPS: kexec: Make a framework for both jumping and halting on nonboot CPUs
      MIPS: kexec: CPS systems to halt nonboot CPUs
      MIPS: kexec: Relax memory restriction
      MIPS: kexec: Use prepare method from Generic for UHI platforms
      MIPS: kdump: Mark cpu back online before rebooting

Ding Xiang (1):
      mips: txx9: fix iounmap related issue

Huacai Chen (6):
      MIPS: Loongon64: DMA functions cleanup
      MIPS/PCI: Call pcie_bus_configure_settings() to set MPS/MRRS
      MIPS: Loongson-3: Enable Store Fill Buffer at runtime
      MIPS/PCI: Let Loongson-3 pci_ops access extended config space
      MIPS: Loongson-3: Fix CPU UART irq delivery problem
      MIPS: Loongson-3: Fix BRIDGE irq delivery problem

Maciej W. Rozycki (6):
      MIPS: memset: Fix CPU_DADDI_WORKAROUNDS `small_fixup' regression
      MIPS: memset: Limit excessive `noreorder' assembly mode use
      MIPS: Define MMIO ordering barriers
      MIPS: Correct `mmiowb' barrier for `wbflush' platforms
      MIPS: Enforce strong ordering for MMIO accessors
      MIPS: Provide actually relaxed MMIO accessors

Mathias Kresin (1):
      MIPS: ralink: Add rt3352 SPI_CS1 pinmux

Mike Rapoport (1):
      mips: switch to NO_BOOTMEM

Paul Burton (15):
      MIPS: Use a custom elf-entry program to find kernel entry point
      MIPS: Use GENERIC_IOMAP
      MIPS: Remove SLOW_DOWN_IO
      MIPS: Remove no-op/identity casts
      MIPS: Move arch_mem_init() comment near definition
      MIPS: MT: Remove unused MT single-threaded cache flush code
      MIPS: MT: Remove obsolete cache flush repeat code
      MIPS: Remove unused MOVN & MOVZ macros
      MIPS: Remove unused PIC macros
      MIPS: Remove unused TTABLE macro
      MIPS: Add kernel_pref & user_pref helpers
      MIPS: Remove unused CAT macro
      MIPS: lib: Use kernel_pref & user_pref in memcpy()
      MIPS: Remove unused PREF, PREFE & PREFX macros
      MIPS: Cleanup DSP ASE detection

Quentin Schulz (2):
      MIPS: mscc: add DT for Ocelot PCB120
      MIPS: mscc: add PCB120 to the ocelot fitImage

Rob Herring (1):
      MIPS: Convert to using %pOFn instead of device_node.name

Songjun Wu (1):
      MIPS: dts: Change upper case to lower case

Tobias Wolf (1):
      MIPS: pci-rt2880: set pci controller of_node

Tuomas Tynkkynen (1):
      MIPS: BCM47XX: Enable USB power on Netgear WNDR3400v3

Yasha Cherikovsky (5):
      MIPS/head: Add comments after #endif and #else
      MIPS/head: Store ELF appended dtb in a global variable too
      MIPS: BMIPS: Remove special handling of CONFIG_MIPS_ELF_APPENDED_DTB=y
      MIPS: Octeon: Remove special handling of CONFIG_MIPS_ELF_APPENDED_DTB=y
      MIPS: Add Kconfig variable for CPUs with unaligned load/store instructions

 arch/mips/Kconfig                                  |  42 +++-
 arch/mips/Makefile                                 |  11 +-
 arch/mips/bcm47xx/workarounds.c                    |   8 +-
 arch/mips/bmips/setup.c                            |   9 +-
 arch/mips/boot/dts/lantiq/danube.dtsi              |  42 ++--
 arch/mips/boot/dts/lantiq/easy50712.dts            |  14 +-
 arch/mips/boot/dts/mscc/Makefile                   |   2 +-
 arch/mips/boot/dts/mscc/ocelot.dtsi                |  19 ++
 arch/mips/boot/dts/mscc/ocelot_pcb120.dts          | 107 ++++++++++
 arch/mips/boot/dts/mscc/ocelot_pcb123.dts          |   6 +
 arch/mips/cavium-octeon/octeon-irq.c               |  16 +-
 arch/mips/cavium-octeon/setup.c                    |   9 +-
 arch/mips/cavium-octeon/smp.c                      |   7 +
 arch/mips/configs/generic/board-ocelot.config      |  10 +-
 arch/mips/generic/Kconfig                          |   6 +-
 arch/mips/generic/Makefile                         |   1 -
 arch/mips/generic/Platform                         |   2 +-
 ...oard-ocelot_pcb123.its.S => board-ocelot.its.S} |  17 ++
 arch/mips/generic/kexec.c                          |  44 ----
 arch/mips/include/asm/asm-eva.h                    |   6 +
 arch/mips/include/asm/asm.h                        | 116 -----------
 arch/mips/include/asm/io.h                         | 129 ++++++------
 arch/mips/include/asm/kexec.h                      |  11 +-
 arch/mips/include/asm/mach-loongson64/irq.h        |   2 +-
 .../asm/mach-loongson64/kernel-entry-init.h        |  16 +-
 arch/mips/include/asm/mipsregs.h                   |  20 +-
 arch/mips/include/asm/r4kcache.h                   |  73 -------
 arch/mips/include/asm/smp-ops.h                    |   3 +
 arch/mips/include/asm/smp.h                        |  16 ++
 arch/mips/kernel/Makefile                          |  18 --
 arch/mips/kernel/crash.c                           |   7 +-
 arch/mips/kernel/head.S                            |  18 +-
 arch/mips/kernel/machine_kexec.c                   | 143 ++++++++++++-
 arch/mips/kernel/mips-mt.c                         |  59 ------
 arch/mips/kernel/relocate.c                        |   2 +-
 arch/mips/kernel/setup.c                           | 144 ++++---------
 arch/mips/kernel/smp-bmips.c                       |   7 +
 arch/mips/kernel/smp-cps.c                         |  80 +++++---
 arch/mips/kernel/traps.c                           |   5 +-
 arch/mips/kernel/unaligned.c                       |  47 +++--
 arch/mips/lib/Makefile                             |   2 +-
 arch/mips/lib/iomap-pci.c                          |   7 -
 arch/mips/lib/iomap.c                              | 227 ---------------------
 arch/mips/lib/memcpy.S                             |  22 +-
 arch/mips/lib/memset.S                             |  60 +++---
 arch/mips/loongson64/common/Makefile               |   1 -
 arch/mips/loongson64/fuloong-2e/Makefile           |   2 +-
 arch/mips/loongson64/fuloong-2e/dma.c              |  12 ++
 arch/mips/loongson64/lemote-2f/Makefile            |   2 +-
 arch/mips/loongson64/{common => lemote-2f}/dma.c   |   4 -
 arch/mips/loongson64/loongson-3/irq.c              |  56 +----
 arch/mips/loongson64/loongson-3/numa.c             |  34 ++-
 arch/mips/loongson64/loongson-3/smp.c              |  14 +-
 arch/mips/mm/init.c                                |   7 +-
 arch/mips/netlogic/common/irq.c                    |  14 +-
 arch/mips/pci/ops-loongson3.c                      |  34 ++-
 arch/mips/pci/pci-legacy.c                         |   4 +
 arch/mips/pci/pci-rt2880.c                         |   2 +
 arch/mips/pmcs-msp71xx/msp_usb.c                   |   4 +-
 arch/mips/ralink/cevt-rt3352.c                     |   6 +-
 arch/mips/ralink/ill_acc.c                         |   2 +-
 arch/mips/ralink/rt305x.c                          |   5 +
 arch/mips/sgi-ip22/ip28-berr.c                     |   2 +-
 arch/mips/sgi-ip27/ip27-memory.c                   |  11 +-
 arch/mips/tools/.gitignore                         |   1 +
 arch/mips/tools/Makefile                           |   5 +
 arch/mips/tools/elf-entry.c                        |  96 +++++++++
 arch/mips/txx9/generic/setup.c                     |   5 +-
 68 files changed, 919 insertions(+), 1016 deletions(-)
 create mode 100644 arch/mips/boot/dts/mscc/ocelot_pcb120.dts
 rename arch/mips/generic/{board-ocelot_pcb123.its.S => board-ocelot.its.S} (55%)
 delete mode 100644 arch/mips/generic/kexec.c
 delete mode 100644 arch/mips/lib/iomap.c
 create mode 100644 arch/mips/loongson64/fuloong-2e/dma.c
 rename arch/mips/loongson64/{common => lemote-2f}/dma.c (75%)
 create mode 100644 arch/mips/tools/.gitignore
 create mode 100644 arch/mips/tools/Makefile
 create mode 100644 arch/mips/tools/elf-entry.c

--3aqyq7yq5vhk3w2o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRgLjeFAZEXQzy86/s+p5+stXUA3QUCW9NmDAAKCRA+p5+stXUA
3ec0AP4m5wnKIDSf3mUaVNwTE1yRvrgRogWyk92uLJxn2ZY+wQD/X+EN9GcHrJkY
kcoXTLttoCJJx30El+TAbDc00KVEWgM=
=cZio
-----END PGP SIGNATURE-----

--3aqyq7yq5vhk3w2o--
