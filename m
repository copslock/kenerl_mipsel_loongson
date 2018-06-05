Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jun 2018 07:49:32 +0200 (CEST)
Received: from mail-co1nam03on0040.outbound.protection.outlook.com ([104.47.40.40]:11990
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993016AbeFEFtVSz2FB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Jun 2018 07:49:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FG0EKOXyskkOM9W+YdYSCNyt0xsV6XW66f17Zn333Iw=;
 b=EfD+Z0oYAGS95x12BAPAC06Gf8p7KJ9TSGW3bIxSA8m8gfa3RxvKJuCv8i3qqA5yJZp8VvvFg/aIxrejkRmudqKRDBbyWUcidIhON5H7cb8FMDzMpOEg3tJzYjItagFjpQ4yAFTn6shnuS9BjFjugWDk/MHFF0J9O74sGlJji9M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.caveonetworks.com (12.108.191.226) by
 SN1PR07MB3966.namprd07.prod.outlook.com (2603:10b6:802:26::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.14; Tue, 5 Jun 2018 05:49:09 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Subject: [PATCH v7 0/8] Add Octeon Hotplug CPU Support.
Date:   Tue,  5 Jun 2018 00:24:49 -0500
Message-Id: <1528176297-21697-1-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [12.108.191.226]
X-ClientProxiedBy: SN1PR0701CA0012.namprd07.prod.outlook.com
 (2a01:111:e400:5173::22) To SN1PR07MB3966.namprd07.prod.outlook.com
 (2603:10b6:802:26::14)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR07MB3966;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3966;3:1rStL7lReJFzOTwi/qeYod9Df287pFJBlDiAkkuryix7lKYir9BKyLmifbZSJG8sZR5enSwYFYcIn48JQMydQA5e20UejotAt0OpW62OYdEn8Sf54SUOhSapSeOMV3+02RMIo2z3lQq40TVB8F/oUaQQZS69sTkxBw1A5RcIysEStR8rnZ4Bl24yeF1J08YkXz1hgz+V5kQ+k6BMVLYKY7gqdo6/38rSy9tuEdYNtqNjp9+W9WZc6EnOL2V90hw/;25:5Tn/g0PBCM9BaPzZFKfUiSKD3Xf1IVjnofhGL+Q2wQU4cn10wiCGG1BKJMl2/BGVN+zjWvxwSaxlH38xRDNXidPx5yenCWwSVgc5pvz7eZpnZOVuI9e4S2EjYtiQzTswR+Ls40yulAA+P4BdZfRg0Nh3GJF7Ap7/1785AM3qfQryEnGOtKf/sVbpsK2ZBqkgI2OoZMmUU1FAVTfoKIFmrbT8L3zXUkcDFugMfIy8HGxaa/r5IXLUVwJnRmsBiAmno+zBMrEDwF/N+5hr3yoxCisrej7i335EiuRuQHHfgG+sGbSyzAD99+P2EhxRf14LQziaL6klT+Cd1wgEGJVZ0g==;31:nyfpmtkulMfdw3GQxdw/raeX/a2r2kQpG5t7M7bzqHeWhVBaqXWWdOrPsZb0ONo0B6twDXrOBXxkpV9eL+OZ2L969u7ViM6cN5VE8GyfcTELSXmV0JCucurgdsKjiM9N/jOKmUBfXYnTb9rBvoswRVZgGIrY9gKedhgYxTbuG3khp73+DHJTbqmwf4+R4CtvUoQG2tPrFdwZJFE7ATCxKjbeYUGMq76kdE0tI+LJZ9A=
X-MS-TrafficTypeDiagnostic: SN1PR07MB3966:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3966;20:ojjIPepSlQWnJPeXttGaKoeWXDrK8HOQXSWieiTz1Nd463pmjE8S7kCuLqk7oLKVQmU2w5i2uOCWJqDXmiWuyo4NzjguPr/BDO8Bj6IixJou8YTlL86enVFG36seU2LkQ6GpOPdlBSEFjxqwS84ilRI7YNvbEPQzkdVOSmVmxOUOmi2cwmvQLuZw+en4cTnognlHbOOpLH5KrgEoT9+xMdOz9bWa49ZaURTOG6q2C/X5oq28MlZFd7tAo6cxeCN0T4PBUyB8Fs4TEEXHFiGyy4rQYRHr7qErtvcvbUJ8+Tz2s1aiES+tJCJ156jlhEb1BUBWFLgrMLtlTzVZYH5iw+hD9Lvo3dC1Bwf3PV6lxpeBa1IBzG20jsQvgkeevi/Z7vhKsuQfFRMTzicHsKBXx2hP5i5wcwy6x4ArK+vGdLw7f2dC06OrsSKQ1oGXSfTSj6STt8JtcoBvPy8LCljwLe8K+hbCBM1a7yl82r3auFdxcJgupsrWZowGXLjv6B5s;4:gfbJyDinNBMl2LDoldXTvkbVDjVXF/dBL/EAu5oHdtd5TrLXcepCwMPCTmoc8HFvZlzKN8QLUdygqf35YzN6EDZ/NhYWBZoMHvnKSa/Rr4D0Dp1bXoeCct24ih3SXfDZtlm0Sv9qMJIgzIAk8PsfB0hD0BzCc59fnXzzCyCuljCB6szjCPXCS05Kkg3btkHZPKIXHo+qAivdqCknZgu40kJJL5ysmy4NGh2n3386NLSWcckaq7zjRw71+7rFPmYncwFH5EjnPhxtFJ3N20mQZQ==
X-Microsoft-Antispam-PRVS: <SN1PR07MB39662FD29601B006858889A280660@SN1PR07MB3966.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR07MB3966;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB3966;
X-Forefront-PRVS: 0694C54398
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39380400002)(376002)(39860400002)(346002)(199004)(189003)(316002)(8936002)(956004)(16526019)(53936002)(478600001)(476003)(50226002)(2616005)(53416004)(186003)(386003)(25786009)(72206003)(3846002)(6506007)(26005)(6116002)(5660300001)(66066001)(305945005)(48376002)(6916009)(7736002)(59450400001)(50466002)(486006)(6666003)(47776003)(97736004)(52116002)(2351001)(6512007)(105586002)(86362001)(2906002)(8676002)(106356001)(69596002)(81166006)(81156014)(2361001)(6486002)(36756003)(51416003)(68736007)(16586007);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB3966;H:black.caveonetworks.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR07MB3966;23:T7Yc1g5NAbIXmUSl3eWZJ/Y3OFkZOtVl5wd41yYFA?=
 =?us-ascii?Q?I9W2/xmEJH6DB/cUKRwFNhQIYqDX1E4EQitsEn/sPNb84S6Hsef27R9Dg3CU?=
 =?us-ascii?Q?j6p86HjPj04xse02uBARBylxJ7IY4y7zN21+kE+/ZfCqPw3/gdEDrePVwsxd?=
 =?us-ascii?Q?QAeBDfPEwwUhMepxju2IHt+uRZO1aHnfx0N6vOR0UgDeZ292rcOoR4DY13Wl?=
 =?us-ascii?Q?5lx21P0fYjtfxX+GqpCFoHKP8n6YABlP6+S6AFeHfnMiWQHhtqTIxcyoXt24?=
 =?us-ascii?Q?/k9AD+NEmKjm2yYtoREAIBWbnnOGFnCLHzEaQ1Eu6rA/F1UPW1NRmuzbeJQM?=
 =?us-ascii?Q?toM8m+9T7kHxHBeRAy2UJ4v6H+zWCpYN5G+b01GTaPULFMiiXIcUyURexLAk?=
 =?us-ascii?Q?YxRHZ5MKKFOsivn+mhqqDFHS+dp8S2Ngpaxhi8FpWk7BerBDKq+NRHQkbE0o?=
 =?us-ascii?Q?aKYQ2efyVggA38nT1O2a2AAcKMvlq0B79NYXZ17be3dICtErhIKbgh7krRms?=
 =?us-ascii?Q?wzMNHO4I9zFvsxbuyVXGUUktgYBl35E1YZUsAZ9XerwwH5iicvKxr218uT3K?=
 =?us-ascii?Q?boQFGPwUdXNFBzwfmd2l2lonGiF0QtaN3McBmWNhj8NWAcvP8QDur4wtLNZK?=
 =?us-ascii?Q?3575kgr/SMzghQ+U36EB01kVViVaKyH5m+UKB4hlfVi+LHOhudtXUUfsvCw+?=
 =?us-ascii?Q?8BJr7UG6cF4Tf4IY7exslNztqqA6n8vRFm0Vh0l1mPZ+tCw4CTx1ULYxJKcF?=
 =?us-ascii?Q?cPMsASLv6ysOf2ytwJ7MpUZRCiR6BX0QTqI0hTR19XxBpb5C4SSExnX2cw1D?=
 =?us-ascii?Q?MT3v7O/nR1RCEVK96MOTI0zKDrugKD9fOjkrMiAW5l1NlPrISfEGqasKKfZa?=
 =?us-ascii?Q?6zCgKk4pSf3EHGvxgPoWmGkHRAhRJaEKOrdvnYu+8BRYseyRh5esSwrHXDhL?=
 =?us-ascii?Q?Cr/VuLTWDptJvwt3XCoGKw3pCyckvv8NEm14yYexV1yRKdEMFlTu38LcPWhm?=
 =?us-ascii?Q?TALAnSzLZ2X3zv68qRw3ZhoF5ovs3pphfcNQ6GiDsn7IPwmEZstZs+RFoy7J?=
 =?us-ascii?Q?Nwksjrzge8lkkM4ez2LMEQdNqte68VzD+b7ZCKYe3WkJ8MWqfsrforz8fVv7?=
 =?us-ascii?Q?LirqCaYJQdyxWdtckNqZLgx5ndrL0fzZXSYk3AaLkd7oLFGke/kUXafwp48Z?=
 =?us-ascii?Q?GmkIGdJSERwGMpKoUz6MP8C+jwvtif5RSOqbqKAIzNdNySZq7MUI3dQKw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: 6zLId4HFDzaK+ZhnDrj1vSPj9/QeO1Oi6LrKY7NV2O+VntMy1KoTVrTGp3BO68E+bqkuAgRWTS5pA9PgRpX3iYU2O3NaNlrfkvvmIXL7gW2fdfduwKS2qK3faZP6nF9y7px+KbR8+HhrYXAwEX9SjBTDd3MqHsbDvauyg3ajlm4E5ty7uarjH21NSTuM1Ae4
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3966;6:UcE7rk90T/cx78mq8fT73qsxuB7oIKoRHfn2wwkpdXAL6i0WJsDvpuSZJmgtCZ1MVGQCD6do31OTbZFvSKCtgSXhcWXCTPr8C98NfFdoyi0NIf+QVa3BtDqMZDUAyH0PGntEDdAUTw+fBSklvFgi8qwqz/51APikxetCRCakWsZpsw0nBM2RMLDscnoR5pME0uUU5Okl5qTs2wQdaEMeTs6iu2LSMfs+sXpk5kSO8ZzksTZYwKTW1QeBJFSF83okStZGbDV2BGz6Q6kM6WVBlYYI7wcmyKAQ4Qv4y2hw3AvE1aT3hPXO+Jy4m4Y1eX6oC/+6Xba/17p4n9EqoXkwR01n5wkTaIewyLA6B5BlC6ppKHrnduKSc2zOs1Ki1DJNiRiEMjHEfjcsx9TwdPiRInJqFSJw8+kMwHu2pIY6O+mz6ZczDVZsVS26DIPK0i7OltmzS+2XfghcYt99hfgKdw==;5:zQ488mzPtwkBBRByEe3VvSl+ZIT5RMpTtQFdN+urkNBeiscw951rUh1bjBxEda5SwkfZUV80XBONBtUo9E2xxKSZkCbgcAvrAExqyjwNhq9NKXA6bPg4264/JoDmpQq4XJNK4JZaAiStTk/4iOBHrIBggU1XkP/IjFZnVJaPYsQ=;24:XLAUbVper+Oa5Ae8fkBy5qw0fEx/3BhhoaaaNQNPrzjU1YSJOg/Q/j1HwUNvg5FQ8lLhdD1xXJ9Rh9Ec9f8/JlUnqA4vOAsXAFG5pmVkDY8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3966;7:7Wrz/AjMsGm6uf+Vq4JCkZrq1Tbis+A2nz1r++KM0DS4afU34biGWix+v6sUl5C+8FUz20ZF4S8tg7i3qaVUv95/cSt/9+TEZO/5RMXvpWVo23JBcx6sInVI/u5kV9ThgRD4MyqmhaeMBA95fE8k0sF7v63hod7VwdIAU+HHCW+ZeSvn+iq053+O/jHuDvDGZUecgMw7HeyKsFhUkhi9EKAFTEzqKmvx2wR5CKgyERtXMjmEHmCRT5nF4hOTI64n
X-MS-Office365-Filtering-Correlation-Id: 017247c1-2d3e-4498-e0ec-08d5caa80f58
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2018 05:49:09.9842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 017247c1-2d3e-4498-e0ec-08d5caa80f58
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB3966
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64181
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: steven.hill@cavium.com
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

Changes in v7:
- Rebased against v4.17 kernel.
- Minor clean-ups, no functional changes.

David Daney (2):
  MIPS: Octeon: Populate kernel memory from cvmx_bootmem named blocks.
  MIPS: Octeon: Add working hotplug CPU support.

Steven J. Hill (6):
  MIPS: Octeon: Remove unused CIU types and macros.
  MIPS: Octeon: Remove extern declarations.
  MIPS: Octeon: Properly use sysinfo header file.
  MIPS: Octeon: Whitespace and formatting clean-ups.
  MIPS: Octeon: Remove crufty KEXEC and CRASH_DUMP code.
  MIPS: Add the concept of BOOT_MEM_KERNEL to boot_mem_map.

 arch/mips/Kconfig                                  |     2 +-
 .../cavium-octeon/executive/cvmx-helper-board.c    |    29 +-
 .../cavium-octeon/executive/cvmx-helper-jtag.c     |     6 +-
 .../cavium-octeon/executive/cvmx-helper-rgmii.c    |    65 +-
 .../cavium-octeon/executive/cvmx-helper-sgmii.c    |    25 +-
 .../mips/cavium-octeon/executive/cvmx-helper-spi.c |    32 +-
 .../cavium-octeon/executive/cvmx-helper-xaui.c     |    14 +-
 arch/mips/cavium-octeon/executive/cvmx-helper.c    |    54 +-
 arch/mips/cavium-octeon/executive/cvmx-pko.c       |    62 +-
 arch/mips/cavium-octeon/executive/cvmx-spi.c       |   102 +-
 arch/mips/cavium-octeon/executive/octeon-model.c   |    29 +-
 arch/mips/cavium-octeon/octeon-platform.c          |    70 +-
 arch/mips/cavium-octeon/octeon_boot.h              |    95 -
 arch/mips/cavium-octeon/setup.c                    |   376 +-
 arch/mips/cavium-octeon/smp.c                      |   238 +-
 arch/mips/include/asm/bootinfo.h                   |     4 +-
 .../asm/mach-cavium-octeon/kernel-entry-init.h     |    56 +-
 arch/mips/include/asm/mipsregs.h                   |     1 +
 arch/mips/include/asm/octeon/cvmx-asm.h            |    93 +-
 arch/mips/include/asm/octeon/cvmx-asxx-defs.h      |     4 +-
 arch/mips/include/asm/octeon/cvmx-ciu-defs.h       | 10048 +------------------
 arch/mips/include/asm/octeon/cvmx-coremask.h       |    28 +-
 arch/mips/include/asm/octeon/cvmx-gmxx-defs.h      |     4 +-
 arch/mips/include/asm/octeon/cvmx-ipd.h            |     3 +-
 arch/mips/include/asm/octeon/cvmx-pcsx-defs.h      |     4 +-
 arch/mips/include/asm/octeon/cvmx-pcsxx-defs.h     |     4 +-
 arch/mips/include/asm/octeon/cvmx-spxx-defs.h      |     4 +-
 arch/mips/include/asm/octeon/cvmx-stxx-defs.h      |     4 +-
 arch/mips/include/asm/octeon/cvmx-sysinfo.h        |     4 +-
 arch/mips/include/asm/octeon/cvmx.h                |    96 +-
 arch/mips/include/asm/octeon/octeon.h              |   140 +-
 arch/mips/kernel/setup.c                           |    30 +-
 arch/mips/pci/pcie-octeon.c                        |     8 +-
 33 files changed, 959 insertions(+), 10775 deletions(-)
 delete mode 100644 arch/mips/cavium-octeon/octeon_boot.h

-- 
2.1.4
