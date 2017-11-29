Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 01:57:19 +0100 (CET)
Received: from mail-by2nam01on0089.outbound.protection.outlook.com ([104.47.34.89]:64751
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990490AbdK2A5LuHVOi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Nov 2017 01:57:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=H0FRPb59UH8tl4RAmiaii229fTODc+QCaAmUGHEHQvE=;
 b=KNnAciCG+unuzhn9wx2tCiIdRg7qRLOS0CuUgA80eEF0T1rmNeW2GuNM6KUbZtAsXWTNyJVVIlLapdntJMh0ZTgC/E/1TNPJr7qdAh2TYOeKHD1aMnJQSvpUOhUsdjobaOCyiPuB0vnW+l1IjthY/zKXSyMSmG6EBgajSyA8Yg4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.282.5; Wed, 29 Nov 2017 00:56:59 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v4 0/8] Cavium OCTEON-III network driver.
Date:   Tue, 28 Nov 2017 16:55:32 -0800
Message-Id: <20171129005540.28829-1-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BY2PR07CA0096.namprd07.prod.outlook.com (10.166.107.49) To
 CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de7c18cc-37b5-417b-c7ec-08d536c418ee
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603199);SRVR:CY4PR07MB3495;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;3:BZfBJxnYG2FLilK0N7XdXOtPoKJth5PUfkH2pcKS2baoCju5fKn8+CMj1jFUqxGqKDJPzlMsZdhDu1oxaABKWsyIt2h77ijYBXU80D9vkX8wJX5C4cyHJrCSZ0soKo7QUmdw72J0ktDNjEdsMiDpFWv0PjF2agqgG/UQ+GC8FK5VFqxSpjyFbf3sDU9jIJYb3yaZfPw478rLr6Vm5Ce3GaFsVr/dIGm3PcfD4BBVHcKwSL2J3Yg6dk2GAp+ilj31;25:Ad/4fotG070wVXdr3VcJmv89ZERCZWlltHKjsorZls7424lpj8xLQCJwR7Q5hSmbmorulTdqTbUrZSwqwJs/auzC1QrYDPGoJbtrUbVQLFhZ71c3guKLBKQC6n7k32fuhfyQXGV8Gv3Mp3cxLrxuXyGsxAwZihIFqDi8vJk9ioLpsQP0JIr8qUBv9iMAwLbOIugxiKGE393oa1FcWCKoyl+qg95UHM0MDmjH+27CrSOV6EZA5nFaSpXLLUArRCeq47t0wa1vuqzPpklP9VNHmUEGuiwk5VaKsyFWulpniFiUCdT13VXyAqAvcTZ8WZhz+qaQTnnWgMK0ZJH9gA0pc+SSXoQV82dcPyWFXaiuxK8=;31:BfCvWRkK2mWf8/Z0Cs7q4czL+nhD5i8LI5CV2H2gqjpETQ5mOUwqYL3bHsXyyhgHnQGXx6lqnGGdTISVS0uYSi7fMfOUMHtkaww8ULl2Ceyyv/BCT3nhKk9pJxBs3ndpG9KGRov0oMYeBI4z4k/y+UZRlI+F+HIgNvtRJX9zpPr/Xo2uHa/Zl/mbRCp0Ec8jOwsdwcoNk9UoRDdpSwhb85+At3F8YmJolT54SAbqkho=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3495:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;20:VM0d46xFiLVsOryR/tS84Ks2PszZYKwYnFSbm5idSn7CTzjtwqkHVnwTfvOrFfBAROqMSxHUtVp0l03TXyYR8tJTLwJs/gpTDNnTWwzV0jl1Pr4uyc5zksrGy00Kb32o5v/Kt13v1JccXVp0dxKBBlsovZqaIKiNDpcLxa50AzQcab4jy2mI0gbckf82KSAe06vDS2WqPtAafDXMRsG33H2n3IEHQled0gQBv7VbonoNpCRiSbt9eWEci8EiQTce5Esov9Xwl/H1wQifvERk4vnEg0tLUTiuJDxbF6IZLuGLH6J/e36PAw1Kz0Eri+PILgUZjKJR9JaQEmlegdwyToGqv7Knu2EnT5VjOM5cmizFz8s+QAfIoCNbSH84Z3BazgSLUr+82BnAHlGJh7ysZ0u2G/+Ey8z5R8Y/Mp7y+St4hQfGD/Gv5rY6t6q9A0nuLFOOQUBPXytGvQ6mQSbz90EelUiO6NslTqFJSSKVOnjFHwSuQs3hbzTTK5wL0kr8;4:kYoa6CCo6fLsnjQb/ww2iIPg+WVCjLysofxNEPdzsARVIXhzl7vJ8YYRQSXAndBzemOi13mpoRzcqCnqQ11PpkcVlMm12PfsxwDsl0mzNfZrvFPIYuQYaASsmk8MSg6BXyFrK6g0fGbM7Fn9dtG5BGZzHW/JB/j+GF0gEQABeKunoPwMBTBOb9TadCrQttlHPMiiTMpqMVyVnxR3cbYbeVQ8qf3s0h+FZHwDplq3RuN4+z6jSXECIk2e6FJgBfyWby7Scl7znTC75+A3B6xB5w==
X-Microsoft-Antispam-PRVS: <CY4PR07MB3495F16A519BCA48E57858CD973B0@CY4PR07MB3495.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231022)(6041248)(20161123560025)(20161123558100)(20161123555025)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(6072148)(201708071742011);SRVR:CY4PR07MB3495;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:CY4PR07MB3495;
X-Forefront-PRVS: 05066DEDBB
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(376002)(39830400002)(346002)(366004)(199003)(189002)(50986999)(16586007)(8676002)(4326008)(305945005)(7736002)(101416001)(16526018)(86362001)(53936002)(39060400002)(107886003)(66066001)(25786009)(81166006)(81156014)(2906002)(50226002)(1076002)(106356001)(7416002)(8936002)(97736004)(105586002)(72206003)(5660300001)(68736007)(6666003)(33646002)(478600001)(3846002)(6116002)(47776003)(189998001)(36756003)(54906003)(110136005)(51416003)(53416004)(6506006)(316002)(6486002)(48376002)(50466002)(52116002)(6512007)(69596002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3495;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3495;23:Y6KJFh+5vKzupntZknqhXgZxnn1O91vkLc+YSzh4/?=
 =?us-ascii?Q?ESA24zBdgutMgpt+xZFBMG9/zlc7I5p/G57CBT0QUG5PhxMCgyLXlnQtbE7e?=
 =?us-ascii?Q?DZG8t1nZhPw3sQWFavZq3DRKByDMII7BcPxpmRLPtk1Y0IOoIB9xWIf0YRfD?=
 =?us-ascii?Q?r+MWaX4JRch/XoPCOC9sNjaK5dUkyHsvn6iPvdQWw9h+6ucI8YD8ikC9no/4?=
 =?us-ascii?Q?8Gyw6ZbujeDDAOnrgMt6/uGEl80weT7LW36zcyzLTfNr681CtTN5X7DPt1QK?=
 =?us-ascii?Q?2gzoDHbvOy+a3a/jXCFW53mYwBgXZxtsixeyM/6l1VONrPieDO3iTh0GxpxY?=
 =?us-ascii?Q?VuZ2FZGtPVjIx5bDVabm3CaxmxP8MtyUaoRd4OGkdAMaJLaXYrzbfjzZV3C2?=
 =?us-ascii?Q?5WrRJqQ2V9MVVLhrWy2qtysU1FDGm47efGVevT7NmdJhZQMmyQHNwIF6J+AC?=
 =?us-ascii?Q?xqTQtaJZ4Fn/GmQrmXbtrQIl+BFqdQeayNy1UezRAydyTlZH94DUetjV/3ls?=
 =?us-ascii?Q?w09yvK3oUDqjMlK7ESGr8BqLtBouYJ7aAyvOr9+pxkZQlO6/rq7O+zLuc6El?=
 =?us-ascii?Q?UMH2oeuUKI85JoYw1eCKkBw8gLgp7TcWoeFApmLBeN7SAkJrQLbZPSpVIOLa?=
 =?us-ascii?Q?cfMpLGg0lmrXVAdE7AKIIz0cQGvUQnEQ6cDUskRa7+erorX4SToIsCJNizU+?=
 =?us-ascii?Q?tOskpAj+m83jJtXoGBF5akytpVb7nLNAC/pKd+ZA6upZW8My52dVm7ofsSj8?=
 =?us-ascii?Q?si62CiQWCP+DG7nZfFIJgJC2hN0oW1B/6vYex9Qt/zjsisDf0n0pJ1EI2zp6?=
 =?us-ascii?Q?A0VCgZ29XEAkrI0E0gzwdjtkyHioCEn6Ub447srfZLfcL3nXfYpgeDmZklDE?=
 =?us-ascii?Q?a5Du9nknSmE8XDpkEuVZdRZ7+MWGR97dK3NUewFcfY/Ou4nb+JXo9B5zkzrN?=
 =?us-ascii?Q?ryT0E6I1JAgYmpbYRy9nlIbLQb5MLzs2U1IEq2jaujzNO95poroy1wc44Dtp?=
 =?us-ascii?Q?nEgsnituBc1bV3VG12bgoEw6Fl/FeB9tzsqcT8L/6wpUcQwh7tIHfS+SYm48?=
 =?us-ascii?Q?WkBPAJN+uzTR/asEwDLfYSQ3OTub7UDYPLOZOOk2q/7f4hMWpVz6M61+BfHS?=
 =?us-ascii?Q?KCjj3GevI9aUxJMtjS+PMJ/JSmF6fL5acOuIqxZ1kmwQCmI3gyFOt82PK/Wf?=
 =?us-ascii?Q?CJ2kBz+wuAE9K/HJua7pm4dcbDOHOVMKsy2ypC33Z0mw3UKkxhypn5b9uq5Y?=
 =?us-ascii?Q?Zd0fys0+CmlNL9emY4=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;6:ophgWn6gnBEeCh+tD5N1tfU58JeOIlpijI23ZjMS5jk5hIMirdgj2yLimBZz0mNu/gxgnui2oAMvwHmHZUefznQzUFsAWoB2XKI8pGyso2F+YNFG8wPR1OMS4JSshdHWYtzLwhgU1oRJJwoslXA8DeZHFa20e/4Hij9g+JqBf4RvaL4nU4mckmIffCYJT7Y5VlDgnG2UC6CsDtNBtA4qh8U0Wx++eJt/RuFGsJuN6BOSFclXXI4Xrp7b9d1D/f9jJLwC+N3SV0dx1IuN36xQPutqlfcRlLc6qZ8it+Xu+lF28E/qsE5lCrert5AhEaoO5dIiV//p8p3dc/TU9LMTtS2C8hrIZaGOfki+3M2o8fc=;5:VLWyqcB3ZUvA1t3OlSMfpNib/VrE/S9tBB6Sfr63yy+0SHYqddoMbv8eOa1H1wgu4Y57ELbmpMvA7Dn/uBNxTMKw3gL0gzqMZh8O/qtv80vLn3R4VzKrEf+L67une5cF6pOvb1Rvnhvbsj/3Dto3yIh2BMQv9bLU8/mGeAnxi34=;24:7/Tc3TRy3eWNg4Z/UYZLn7lv9jSyTdkjt4THzi44wc8ETDnxbLDBi9BeF1jOzg6ykdZWt9gOEJ+5D7toqYDfFjDo0UMmRNqyK+Alloek29A=;7:nmjmfUYEQiYneOPR/YvsE704pWJm0WP0HG+xGHHFMy38O3lJ4eq5hKzQ/6CvAKXj/S6PSH5qA/mqqxxXyygrseqT93EUG3Vj/AiDMC56WPg8r3XMVOm5awU4Hyp1vQJ9/TfDsUGE55qpjTp+nHhrzIF+fQLCWDsjTi3b4abvkc12E+aHyWbLgsco5nh+VB7NJAdra3SysNCoSGMDD0pRG2BKCvRxk9cdWEwGF4kmfkefqcESdAmfJknQdZ37irjZ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2017 00:56:59.6690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de7c18cc-37b5-417b-c7ec-08d536c418ee
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3495
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
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

We are adding the Cavium OCTEON-III network driver.  But since
interacting with the input and output queues is done via special CPU
local memory, we also need to add support to the MIPS/Octeon
architecture code.  Aren't SoCs nice in this way?

The first six patches add the SoC support needed by the driver, the
last two add the driver and an entry in MAINTAINERS.

Since these touch several subsystems (mips, staging, netdev), I would
propose merging via netdev, but defer to the maintainers if they think
something else would work better.

A separate pull request was recently done by Steven Hill for the
firmware required by the driver.

Changes from v3:

o Use phy_print_status() instead of open coding the equivalent.

o Print warning on phy mode mismatch.

o Improve dt-bindings and add Acked-by.

Changes from v2:

o Fix PKI (RX path) initialization to work with little endian kernel.

Changes from v1:

o Cleanup and use of standard bindings in the device tree bindings
  document.

o Added (hopefully) clarifying comments about several OCTEON
  architectural peculiarities.

o Removed unused testing code from the driver.

o Removed some module parameters that already default to the proper
  values.

o KConfig cleanup, including testing on x86_64, arm64 and mips.

o Fixed breakage to the driver for previous generation of OCTEON SoCs (in
  the staging directory still).

o Verified bisectability of the patch set.

Carlos Munoz (5):
  dt-bindings: Add Cavium Octeon Common Ethernet Interface.
  MIPS: Octeon: Enable LMTDMA/LMTST operations.
  MIPS: Octeon: Add a global resource manager.
  MIPS: Octeon: Add Free Pointer Unit (FPA) support.
  netdev: octeon-ethernet: Add Cavium Octeon III support.

David Daney (3):
  MIPS: Octeon: Automatically provision CVMSEG space.
  staging: octeon: Remove USE_ASYNC_IOBDMA macro.
  MAINTAINERS: Add entry for
    drivers/net/ethernet/cavium/octeon/octeon3-*

 .../devicetree/bindings/net/cavium-bgx.txt         |   61 +
 MAINTAINERS                                        |    6 +
 arch/mips/cavium-octeon/Kconfig                    |   35 +-
 arch/mips/cavium-octeon/Makefile                   |    4 +-
 arch/mips/cavium-octeon/octeon-fpa3.c              |  364 ++++
 arch/mips/cavium-octeon/resource-mgr.c             |  371 ++++
 arch/mips/cavium-octeon/setup.c                    |   22 +-
 .../asm/mach-cavium-octeon/kernel-entry-init.h     |   20 +-
 arch/mips/include/asm/mipsregs.h                   |    2 +
 arch/mips/include/asm/octeon/octeon.h              |   47 +-
 arch/mips/include/asm/processor.h                  |    2 +-
 arch/mips/kernel/octeon_switch.S                   |    2 -
 arch/mips/mm/tlbex.c                               |   29 +-
 drivers/net/ethernet/cavium/Kconfig                |   55 +-
 drivers/net/ethernet/cavium/octeon/Makefile        |    6 +
 .../net/ethernet/cavium/octeon/octeon3-bgx-nexus.c |  698 +++++++
 .../net/ethernet/cavium/octeon/octeon3-bgx-port.c  | 2033 +++++++++++++++++++
 drivers/net/ethernet/cavium/octeon/octeon3-core.c  | 2068 ++++++++++++++++++++
 drivers/net/ethernet/cavium/octeon/octeon3-pki.c   |  832 ++++++++
 drivers/net/ethernet/cavium/octeon/octeon3-pko.c   | 1719 ++++++++++++++++
 drivers/net/ethernet/cavium/octeon/octeon3-sso.c   |  309 +++
 drivers/net/ethernet/cavium/octeon/octeon3.h       |  411 ++++
 drivers/staging/octeon/ethernet-defines.h          |    6 -
 drivers/staging/octeon/ethernet-rx.c               |   25 +-
 drivers/staging/octeon/ethernet-tx.c               |   85 +-
 25 files changed, 9069 insertions(+), 143 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/cavium-bgx.txt
 create mode 100644 arch/mips/cavium-octeon/octeon-fpa3.c
 create mode 100644 arch/mips/cavium-octeon/resource-mgr.c
 create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3-bgx-nexus.c
 create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3-bgx-port.c
 create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3-core.c
 create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3-pki.c
 create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3-pko.c
 create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3-sso.c
 create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3.h

-- 
2.14.3
