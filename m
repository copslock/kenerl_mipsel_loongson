Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Sep 2017 19:39:15 +0200 (CEST)
Received: from mail-sn1nam01on0042.outbound.protection.outlook.com ([104.47.32.42]:33276
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992329AbdI1RjGoO94F (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Sep 2017 19:39:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=SZF+wfEG1XKS239W8fCePMiFJs6z7LyjlG+hyi06+8I=;
 b=VxwrBDugiFXj77NXTq0sXPUOG237QtErg64UAB8hyqP4E/ngiF3IOoi6unlj4kumA+S5zsgcD5GyLkrJ/JtgQ2oWtUc1XPdd5lXovihxVUgxfVjlAVRh7cjs2WLCpOSkXWGFQE5EnrorQ5N89l4s1phQ88wdV3avzcWbbha3yx8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 SN4PR0701MB3807.namprd07.prod.outlook.com (2603:10b6:803:4e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.77.7; Thu, 28 Sep
 2017 17:38:56 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH v2 00/12] Add Octeon Hotplug CPU Support.
Date:   Thu, 28 Sep 2017 12:34:01 -0500
Message-Id: <1506620053-2557-1-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: CY1PR07CA0024.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::34) To SN4PR0701MB3807.namprd07.prod.outlook.com
 (2603:10b6:803:4e::30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd946f86-3e89-4960-416d-08d50697cb8a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:SN4PR0701MB3807;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3807;3:3Ji9DfOYSGEWdV5O6IkOb9FBUZgPzHTZqi/vDAVS2gtvfnoydcJyBy+nk0vf9Lvdm4E7LTxhBL6W6P1L6ibSW/1zFltH+Rg33N0WIuQ480U9o4kmg0QTe5uAGF2sYiXE2qRc3SooCOEYNYLdKe5s/H4QjRjYAgdfZmvt+6yy2BXFwJFKUlPtDfiuCmGZZ4SMxGi83So+teVBgJNHZkf3spFt1ViF9rHEKvl265AQ0+Jn/FVFUMpfynpk0zBBkF0y;25:c8oO8P48wMwUOVayskSyf0t5O8ky9jwA0+Dozgaa9M3Ey0sh5oLOjIGkJA3shxIE0bX8XfClA9ZsPrN6V6RGKCEvgdYZfRx6vAuTKNipsgwe+U7+h17BNjY7KeyUUQk8LUB0FWncsBH6VNPaGPIzLGmXC2MYCBF+vs/QTcuwWxIhwnCrVlzV1pnvY+EeYDahyjU6L/40sPKXVE0eG0Z8f453Ero9Q8GM58DdyqCtsZy/vSqEio7QsGBzYBJlEOZFE8Tfkc66LbP7QIIeWGmZQD667POUxLP+oTCsVsJKUetabA5hx4WLEACine1xD9bCMilD29e/bVChMJlsMcWSyw==;31:CE+CuYJ6eFjJ7EfsB3Cevoc3ZLSm9rxAx89ZWQ/2uhkX82Vd5A6cPbR7yo16HfnaTvUgTxbXEEf/3Su8KBHQF9qieG1dIsposVhGzMlPjYQ4t7Vp18pzBdrY+XCBfkSUo0cBbteUrRrd7lVtaNV3vy4qYp4RcmJGWAwI2iq0Al+Djc/HElPvl1zEy2nTi2WavADYmLCYQHi7AqsYM/JBow5h9Z6CbOnSuWXPoWcqghQ=
X-MS-TrafficTypeDiagnostic: SN4PR0701MB3807:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3807;20:x+XyoraMoBN7pY0om41g81tqIJ25ODdKm0MStDE0SCnnKDXnGw1YnboUYyM0j4nwciuaW/WQX4vhi4YlL2JwtX9PUGzeVF7dhz4wAw9LojyO5+olhCvpmWD87bGUyHPGVuxu2pRTJSdV+1hqhka/9fyHXalU27rUd4oAEDZVRV9rgZbtg057+Vcr9NVSQkgj3BcGe6wwmaBtKKJ6f6wqk1sWsP5VtS7gDJgOqItOBwDqtRO0cTz+Uo5BqynvFa8Z97GFIg10h/W8LLl+EyZuLcHn4L6K+OKr51AG3xIoiV77O9KaV6RwtgmV58FtCHDA767DbTyZGPiB5tVf9n5STnwYPBWMkV2L6Yj0nrPpzQtKAthPwIj13WZvTBVlFSxigTYS9xJCTQrDZJ1jXI74ce8HfQ01EPDggBcIdsDOQMFNrauKI7RiVDsEZiJZhluLB2GwxZ+CRzQzQbQfIKqdZAVzH3KCKl1EQ29bbzkH2rJEjHmZ/K5v58bimTQozVXB;4:IIQx6EnXnaAEdBKKzOHt7BaxvGqLKzaiTT0N4HSXkQLYarkt7NlB92IGTE+yq6G5l5igF81AMH1TMVsuhHLhsM7EFVTN76/eEWqywtCFPSlmilp2a9gamOChh1qD3fYFVXOlJhVYic65WSIW7WE6tm2KicJIHkNQLoxWyxDgbZ/mwupLiSVqkqsoZ1whn86++i2C+FjUEdq//dbexdlEfNX5/hG+DMBtLPsq2gYMOKyBo+6SNJYVpmhP4iLAyTpxbQDSfbT7/7Iz7FBGrYGoftIHz1mjraYTvgmQeuK45q0=
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851);
X-Microsoft-Antispam-PRVS: <SN4PR0701MB38077B93290393FF3E20B93C80790@SN4PR0701MB3807.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(100000703101)(100105400095)(93006095)(93001095)(3002001)(10201501046)(6041248)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123558100)(20161123555025)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN4PR0701MB3807;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN4PR0701MB3807;
X-Forefront-PRVS: 0444EB1997
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(6009001)(346002)(376002)(189002)(199003)(53416004)(6512007)(50986999)(189998001)(2361001)(68736007)(6116002)(5003940100001)(101416001)(3846002)(86362001)(2906002)(36756003)(53936002)(33646002)(106356001)(50226002)(2351001)(6506006)(105586002)(6666003)(50466002)(316002)(6916009)(16526017)(25786009)(16586007)(66066001)(47776003)(305945005)(6486002)(478600001)(97736004)(48376002)(7736002)(4326008)(81166006)(5660300001)(72206003)(69596002)(8936002)(8676002)(81156014)(450100002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0701MB3807;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0701MB3807;23:xz71ZJ/fcFsDBbIwP5EUSHzCIH68Nb9hk7bg/LU?=
 =?us-ascii?Q?bs5kCKxnPUCw9DXoxuU6O7FTARqumN9w+D0OLd1ExYiY0i08aX7wMdxBtcKq?=
 =?us-ascii?Q?E7jxm9UnxQ/l200YwwTjTCn6msv2y0rGFEOArftYr4Om2VesTQ+1oT9KbHdh?=
 =?us-ascii?Q?Rq7cnZzVNJI9iUw/DWP+eNYLnvQCXXkpLCSU9+tkMvjU3ZqbUHJnhX8Qch0e?=
 =?us-ascii?Q?iShs/Vd2K2T0T/0F5V3T6LyZ6/DZFNgjqhHqm60pCvbV9qFo3T2vA5T+dNSB?=
 =?us-ascii?Q?jrSvUMILrRFdBzRNnJU46L1QEJ+wbiWl13xG5Tg/vchY/mGyEIsYMdC1STbM?=
 =?us-ascii?Q?bqWyDArLK6xDS2x3fYcq0iwlSgZwFnxFH1uhlRvFrUoYSchFrI2huPqHy92s?=
 =?us-ascii?Q?2G9a/xZZj7PGHclpOVH4XNoswqLQGZWzwYuFoP45rZWJoQ0TmJeT+MwJ+d+I?=
 =?us-ascii?Q?oZBZGzOz81hlnb+b17qORCvR22bB5gyc21O55d4m4H6bJ03raUPKoprfjBFo?=
 =?us-ascii?Q?Mst1pkKf1xquh9MfkrngrnpOnecY6bx1wUxfZePZvoVJYy455WnBypM/2yNG?=
 =?us-ascii?Q?AIGfu0wrAG+66ZcKmdobF+yglBsAQV13BMVEIz+iFtGjK92iSeukbrDRta+5?=
 =?us-ascii?Q?JiOp6tujW39CHeuSnvvpKYwWF9XJ1vm6kkPEMjzB/H1+JwVN+tM2jTemLgWX?=
 =?us-ascii?Q?m4Xp2cbS6cBVjFa1Dbw9uibslirFUjwwyxMXbe0+pIrCP1kLlUeAnz8fJDs3?=
 =?us-ascii?Q?9WknNRr26Wxfm+fv07mbjnaFrmoIiFzW6mhg9/MMLJo5IU23X+9JrhQ/4fNg?=
 =?us-ascii?Q?cbpy162wOn2RvzRIQe/TlA7tiXrCZC8I0jzuMAoKXnxy4IUbeWewbEjKmzoT?=
 =?us-ascii?Q?m1aOwyq62B21gYU23Ijb8R072u/0mlKX0JXfuf8G5hCOFhAVHUxHZzMjZfZz?=
 =?us-ascii?Q?mUK3wRtNgv+Arv9Geg3apw2QSnBEvcXovI2fgApGoutgMxitqlaNLqLuQA6a?=
 =?us-ascii?Q?A0S7UKCL4KKqtwqNteiMrtV73NPY8NkHedNNqwEYS79mp/ztMVqUKfEe4lmx?=
 =?us-ascii?Q?4XfOpEECmXNFTjWTJVC8xT21sAkopWoIEBjq82hLJcG2gsk8ZzQfxplI0uWK?=
 =?us-ascii?Q?d1rCTJMkwIfJlm/mEW8y1PCwSNL7YxsZJPd+I4/Nn1e/+YhFdzpGaTJ9mCip?=
 =?us-ascii?Q?ZkwyPWWG9ZMC3vRpw2R3ggnDB0vOZ61wg44QtGonC4JGUsGwuQe7UuxnC0oX?=
 =?us-ascii?Q?el9SDiuH1+vgbTDYpCFc=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3807;6:fGbhFwwK/uvl75O1q4Sz4dXKQJUeX2lHa3Na4NfpdhQ9mGQM/WFS+WLyFnu20ieAbjcz0CPew+3r5RhIR26kWhWt2h+oxYH5PvRs9xN4uCT07Ag1lqLyeDUxl7PP10GxV6pDmw/8aAXUwjihYL6d3LaP97+k5+bOgeSTmIPM02Ga4prsA84aeh/rSBGEbym9eoMF3kQZ5QpV/6GGZI5NF1qp8bPihbqAYsWDXD/6ANmQSKcP0bIHscWTn3K9rvNlBzzNA7/UrHSTZjlHvXHRwZPrYfzSXf9IGNY86DfRi8P5OF7KJdAeJ4aCG1O44A/JOl9WiTE6U2NxjlzpL0Y/cg==;5:gzY383jzoUIfVCEa4Gt03UV9WKO2oaNhGSu8x0rXCeBHA+mQNrs0q4jEU34dgBaR3e1xscdczgV1swd3dglixTUZKAXXwBB01bwsrJW7opzFmU+c9IPuLaiT+je3ykvJvgPky7xofp+v/R5XeVQfEw==;24:b6DBaXMlK1UFXGpFDltAR4o0JWWqG6mjphZxk6lOb6fDnqJhHznrd4hdIvAoC0Y8p60zI2/m5nh4vS/Q5lrmaUeBkklxKZZRGB29UG9q6aI=;7:r9d7Cg13d3GfWzqCFUDu7VGpsOTHNi4wXuvJsJBGX+7gRFmRIxysbsATPpn+jCP3/fjcfZ/+D2mI6JOJsGDgOmx7reODgMr/jYOClQH9c5E0B8kleJTrPdPDrs19rjOj35jtuBOV+9k304RiR7isZao0NyFcQXJaVylFkyU8fWHxWahOYBr6whmmjQGTB1oHQgDyxLxECjSez3arnZkeNhX10jPXE48TTYVQXjkie4Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2017 17:38:56.4488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3807
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60185
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

From: "Steven J. Hill" <Steven.Hill@cavium.com>

This patchset adds working Octeon Hotplug CPU. It has been tested
on our 70xx and 78xx develpoment boards. The 70xx has 4 cores and
the 78xx has 48 cores. This was also tested on an EdgerouterPRO,
which is 2 cores (whoohoo).

Offlining CPUs causes the watchdog NMI to trigger. Our boards do
not reset, but when attempting to bring a CPU back online, the
booting of that CPU times out and eventually the kernel becomes
unstable. This patchset gets hotplug CPU on Octeon "right".

Changes in v2:
- Reorganized patches per reviewes on mailing list.
- Verified that the watchdog timer works for both endians and
  properly interacts with hotplugging CPUs. The first version
  disabled the watchdog when hotplug was enabled, but only for
  little endian. Never tracked down the history of why that
  was originally done in our internal code. *shrug*
- Removed many unneeded mb() in Octeon SMP code.
- Removed all usages of 'volatile' in SMP code.
- Added in assembly optimizations per ideas from Paul Burton.

Chad Reese (1):
  MIPS: Add nudges to writes for bit unlocks.

David Daney (4):
  MIPS: Allow __cpu_number_map to be larger than NR_CPUS
  MIPS: Octeon: Populate kernel memory from cvmx_bootmem named blocks.
  MIPS: Add the concept of BOOT_MEM_KERNEL to boot_mem_map.
  MIPS: Octeon: Add working hotplug CPU support.

Steven J. Hill (7):
  MIPS: Remove unused variable 'lastpfn'
  MIPS: Octeon: Remove usage of cvmx_wait() everywhere.
  MIPS: Octeon: Header and file cleaning.
  MIPS: Octeon: Update CIU_FUSE registers.
  MIPS: Octeon: Add Octeon III platforms for console output.
  MIPS: Octeon: Remove crufty KEXEC and CRASH_DUMP code.
  MIPS: Add define for number of bits in MMUSizeExt field.

 arch/mips/Kconfig                                  |  13 +-
 .../cavium-octeon/executive/cvmx-helper-board.c    |   2 +-
 .../cavium-octeon/executive/cvmx-helper-jtag.c     |   1 +
 .../cavium-octeon/executive/cvmx-helper-rgmii.c    |   1 +
 .../cavium-octeon/executive/cvmx-helper-sgmii.c    |   1 +
 .../mips/cavium-octeon/executive/cvmx-helper-spi.c |   1 +
 .../cavium-octeon/executive/cvmx-helper-xaui.c     |   1 +
 arch/mips/cavium-octeon/executive/cvmx-helper.c    |   3 +-
 arch/mips/cavium-octeon/executive/cvmx-pko.c       |   1 +
 arch/mips/cavium-octeon/executive/cvmx-spi.c       |  11 +-
 arch/mips/cavium-octeon/executive/octeon-model.c   |  53 ++++-
 arch/mips/cavium-octeon/octeon-platform.c          |   1 +
 arch/mips/cavium-octeon/octeon_boot.h              |  95 --------
 arch/mips/cavium-octeon/setup.c                    | 246 +++++++--------------
 arch/mips/cavium-octeon/smp.c                      | 224 +++++++------------
 arch/mips/include/asm/bitops.h                     |   1 +
 arch/mips/include/asm/bootinfo.h                   |   1 +
 arch/mips/include/asm/mach-cavium-octeon/irq.h     |   8 +
 .../asm/mach-cavium-octeon/kernel-entry-init.h     |  60 ++++-
 arch/mips/include/asm/mipsregs.h                   |   1 +
 arch/mips/include/asm/octeon/cvmx-asm.h            |   6 +-
 arch/mips/include/asm/octeon/cvmx-ciu-defs.h       | 166 ++++++--------
 arch/mips/include/asm/octeon/cvmx-coremask.h       |  26 ++-
 arch/mips/include/asm/octeon/cvmx-fpa.h            |   4 +-
 arch/mips/include/asm/octeon/cvmx-sysinfo.h        |   4 +-
 arch/mips/include/asm/octeon/cvmx.h                |  42 ++--
 arch/mips/include/asm/octeon/octeon.h              |   2 +
 arch/mips/include/asm/smp.h                        |   2 +-
 arch/mips/kernel/setup.c                           |  30 ++-
 arch/mips/kernel/smp.c                             |   2 +-
 arch/mips/mm/init.c                                |   4 -
 arch/mips/pci/pcie-octeon.c                        |  12 +-
 32 files changed, 447 insertions(+), 578 deletions(-)
 delete mode 100644 arch/mips/cavium-octeon/octeon_boot.h

-- 
2.1.4
