Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2018 23:42:13 +0100 (CET)
Received: from mail-bl2nam02on0058.outbound.protection.outlook.com ([104.47.38.58]:61227
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992212AbeCNWmGpjTJJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Mar 2018 23:42:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=qgJsHbhEsAJ6/LiWz13XkYu55GUO/qMI84sWRV4+SYk=;
 b=a13ezh6907cyb6WbeEDHfsy9HHPEqJw8BfAy3arPj3qK3H7nre1lJvycNIzDgq95Ny3IYA1urP+4mbj87EALy7mMFCnk8lW9zIhO1lGBrlGbZg0KzXjUBGA0iDXUWB+HhnXarCDeW19y8XHiZpfsZqDP7aprb8HCbM9lmjRPVFM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (50.83.62.27) by
 DM5PR07MB3610.namprd07.prod.outlook.com (2603:10b6:4:68::32) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.13; Wed, 14
 Mar 2018 22:41:57 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Subject: [PATCH v5 0/7] Add Octeon Hotplug CPU Support.
Date:   Wed, 14 Mar 2018 17:24:11 -0500
Message-Id: <1521066258-11376-1-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.83.62.27]
X-ClientProxiedBy: DM5PR07CA0082.namprd07.prod.outlook.com
 (2603:10b6:4:ad::47) To DM5PR07MB3610.namprd07.prod.outlook.com
 (2603:10b6:4:68::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2b7ec12-db65-4aa9-1d92-08d589fccb39
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR07MB3610;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;3:2x0Z2LOVx5NZnkavVPAt5Tg3pVl0TD0798V6dqW0orXjJaOeRLoIoLfJx0FDTeYdGJ72yWSCKd1CCEUGPvpAVZLQo1gfnpAIHVvWfxK9RNzkxhrLPDxhRuLZtMistvUYVYsBlXHN1cf89gUTKPRLwFUqTtry0CCMJglzkXtQ5xl1i/m/crlLG0Eyx3rU2thRUVv/XnWJSsronM1+3J/xdGz5o8rBRuCy8wRXc5CsZZbE4HONNVVEIOA9vckkYruh;25:JptVm1Y9MLvZOPbC0qlvgEhBu4UfIJx1xiAadFqcGFx2pmleb52b44q698DGDq2NlXzUThNWaW+LyqJK4zEy86wwbtjIAFDnSsXiE2zZveyaVqaWR8vj/3mfn8LlRTG2r65zpr8+GM9RWxYcotrHru0dLs//LaEHk32Uja0sbEe/rIqok2pZeRbBKfycKIS4+Tu62mP5rWT25XP6GHhaVXoISdFVoIXBwgpnMEGuyE2qasfnx9Y8rA2iAcVtEwJ7usuAIR7QW/46rgUjeGGp5xoAiUQlxZQrIqgujs9GNvVxSjkBmFl0i8vzRIjRR9n6hrHI+WbToBR00D3DuplBnw==;31:NuGlPgmcvO/DVNC7WqMn4/d0D7+itjCMOFlsGiRw+Eh+boHGq7AI6vxHUDldyRikvTumWxXgx/wF64P2asCl3itUSXdCRM2cUs8RDh0oSUviTMf0RJb+sDX2GpngNj+KKalzfy+qFmpQnc7bPXK92rX7Iod+jzrdxINMXHxqUasJDKIgaRYe94OJ9tGRXmPdj3Jw+OLm9AE3ACtL3phjRUv22+YP5uPlmrmMcLInjLM=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3610:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;20:aFo2UihXwO4tb5fkCe3PpUkaWhjED429sEUfX9SKRNIpvojicq33oxBIIKfMHaWUQE38yx9ghDQmoAAx9UId8/X7g4p19zVlBv1ivj2jkQkYY/4MTET49DwqEFsuNhKDuJ/oNB1Yk2l/VIuNlqgCSlrznmPpsHTm2NzDTI+xPd+1VLXtn9Az4rBMXoaeV6Ra62o/Nj7Z1wPhTX46W8onqYvG2aCIVb/BRDjlybKdKQEUBlhVqFqwJI9oRweeNGWo2KDVK0WHYdx48gC98UMrsHsfFZZatGB/DnXaQdjOaCTKgVpXW3Vx3Q5XXnoacvdEZhJOEIX76JYqqobRbLUXc5GZGkp4YZWvmNuuKmRd8/oZV54a22GAR9OVfwcHQDtcXAUAY3JUyAotuyZcGINGFICigb600B+O4vXdg1CONUaZkaCYo5egBTR15dl8Ymf455O9zhLW/xVawdugXNxDil+kE9Nep1L1+7u7uVFKNZxFWZGzJ8KHEmNAL07j53FW;4:dO92M0UgO6JNTOjAoT7akuVjCOEXMteG/o5hU+HfyJlzSfE8Xr+ZJxn6S2FGyFNPZDjguM3huDXSur4n39UXb+RWmq7UKrkialqH1SEtsicOoh4JxoylhbJ6XHheI1N/mPHbRGw13EbjartwYUMnhgx/NXrKnq+y2TObmGOH302YRKqXCIwSnDD0NoyikReQFPBpJ+DrL3gOE0gjbyUEWobfM1Wfo8vEw27BnwoHZe3Z285b52+RyyTAZyxloT97hpAHXjUzWq+Fn3JHjSTMPw==
X-Microsoft-Antispam-PRVS: <DM5PR07MB361042A3FB38D745A0255AEB80D10@DM5PR07MB3610.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR07MB3610;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3610;
X-Forefront-PRVS: 0611A21987
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(39380400002)(396003)(376002)(199004)(189003)(59450400001)(8936002)(305945005)(5660300001)(53936002)(69596002)(53416004)(51416003)(52116002)(50466002)(26005)(7736002)(81166006)(16526019)(186003)(86362001)(8676002)(81156014)(386003)(316002)(68736007)(50226002)(48376002)(16586007)(105586002)(6506007)(72206003)(36756003)(3846002)(6916009)(97736004)(478600001)(66066001)(2906002)(6486002)(47776003)(106356001)(2361001)(2351001)(25786009)(6666003)(6116002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3610;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3610;23:hKhDmNORK6xST68EfORWBXOpesywKihTm/Ydmq0S7?=
 =?us-ascii?Q?Y48JcHW50C92IKaajsY1V8zTb2xgkzdDbHMUX5YsQHLDuzyca0QVCdessrkG?=
 =?us-ascii?Q?ln9u7Y82n8X4cokOwg/AetOq04oZ5uQ6pX3Pim7JzWHPTaVRrKWc1Uhg2L3X?=
 =?us-ascii?Q?e2fgUvyqJnMc4gZtJ36Jsdmg5HEg1EihoYXf1omRa/36BmpF+ldMpoanwXk7?=
 =?us-ascii?Q?Qfq5tEKNxPcphFjV6OyuOy/TmnntLUCnWiSfAmjem1hvRBPREvhls6V0+rYM?=
 =?us-ascii?Q?Zpt4CowSD6vgEtfDx/SmVmpM8ex+Vq0y177G4zSzrldlS7GkPu+uPRkMvFI5?=
 =?us-ascii?Q?WO/1cXG+PtAp2BlnZmM+7KlddbXHDR+3xvWfdc1FuxwUrKS3hhil3C24NzJh?=
 =?us-ascii?Q?11PjUrLVpOTr7iRjE697e4a7jqN7MV3FbratzuOJWjVVfVHojyWDNo69rb6z?=
 =?us-ascii?Q?VGS+UHsLJj1hpWIL1ZyPFlGV176XTMYUofShiIqFLTTKkwH5m4Uu6CXrSQwz?=
 =?us-ascii?Q?gPamJFQ+yLGnqeAXXm7bwL68+aHaMmCZwlu7PMFbMDNuCrIyV84ggHyEtdAP?=
 =?us-ascii?Q?3K9bCMrBFTpafqt80pXOWGpPat9s4y/1QZdEHwoSskH7xCApzO6nkxZQ9wVy?=
 =?us-ascii?Q?31x/9xfuLwy/Li3VxKqHH7afTmh8fAAcC6NCSjNK5w7EGYogKmzu+DX/rCNb?=
 =?us-ascii?Q?Wd9i5S2B3y9me3VF2TztTC0TSCdv24VBBBHRoC5MzZ7vAT3WRBMMfGYfMS8E?=
 =?us-ascii?Q?K1UgIwYw/8HmYWdEPd9GaeNc7YtqCqneI8scNbjvo9oDUhShL802Xcdz3Ord?=
 =?us-ascii?Q?M8EP4v9s+CQVoJj3RUdA4IX75AsJ5j1nWKspnhojHi/CCzQnKBaimjuiTgWL?=
 =?us-ascii?Q?KMP8Xed9CbPv5ifuv5kKnPV83y7anPBn9h2DZAnHPumzZdekzIS0KFyUsymZ?=
 =?us-ascii?Q?VrCfngeFccydL6Nn3NF0aBqBOPiRCWYh3BKhPcqOuoQb8wzYeQ0PyeHsdpG+?=
 =?us-ascii?Q?xc2RDdVRfZmHxMS+1bY7ZVL81+MsE1ZrOL4sJecjwGEfhbKKBIjl0KKHh93f?=
 =?us-ascii?Q?65Q3TK/N3S+mDCNrU7jAp1UjzrqHRc7uFI8MpRwz0NB/fGNTP99sWpdTFPIf?=
 =?us-ascii?Q?316Y1vzvCmt2sYKpNPWJbEvSzCADyKpVKGSzCa8vxJWEeZzcLTHJg=3D=3D?=
X-Microsoft-Antispam-Message-Info: t3gLasuQ6QbKHS7M0Rl4VjRRuT98pcholVNjSAdcn5Z0l3OAWTNP8dZ4hJKLU3OsfKxNvKn+HCp47gXitpyXAXvYF6jsfHq/emzY47F9pYhs/lfxNSIFcHK/bMkxdLO7mVDahk50mauWr1nBBmfSDxfVkoXEePV6LD3sR5Ty9G/lMlruiAlPtz0dNfR4mLUJ
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;6:3YoP5DbdDYilUecfaurTgsIrYZGM/N2S+KAiFv3QwXaFMjEQ93AT1ByC9aQoZs6Jeo4xrGPrqU2zNGedGP6LZykvylm0YWWYcJdIyUJQ1egYtkJfAEY3X929CPvZPklhGxAT2QpAEEbVVJRt2VoXUG76Dfr27opKQOuvfNTsos4UluUaRvsIWSF+7hL3nQ1DqnosRUguVwkEzAuhKBqkwWwWu2kBkzQT2fQ6oJYvEx8RtI8/VcjnAqpyk73yZaA5sJsBTzHt15XrMemkUnBwvOq5pQF8n9KviJnM8oSxy2UCZzi3zQIsorlw3YTzrzge9DNPUgill/nNdd2+GpfnM8W7bSVKKpoT8jMkHprtsmw=;5:yglCQnVD9/9xzaGreibsX73kj9n3sLHQcnZBz91kDYUkcvdNm8imFzSYdnr6TYVqHqzIgXR46WmZNyjpY1FtquKiRQjXBQepOtpJtg8T08vOPjsw3zY5MC+K5C5TVg59o9sfDIQ0YbC8wIr1dQU21WNW4PXanuIRGBRR/sraSAI=;24:dfqCteYi9tFVtQSAmm07YN5CfVOxyY2uIIW5ZOAnnU/ehOSxUk3+huifKTjx7suyzq31Mn/7N0E3hItW1gFDGGRx8+h0TEINjI3K4YktYFY=;7:HCbyMrV9pwISWDm7b4s2WrH+dLGicRSwyTZO4wsyk4Gn4CnRzjsukI6ViLzWlunCYD55v4H68oqYQUM08v8eOzzdT8PxoRyEr/JgAwk4VJxj3Mf6rLnhuFX+CIHJYJA/yf58WhfdDK8fRtBAxCXodb22Z7EjnT5XtnDcInGdIyxnTIwElgG7dbYnZtPFIxCOmUvXuI3sbm/OaeOQrOmbS52OWN5BxiUzEzBI0v03G+ZfKOeKkqaP38Z1GF5rNPZ4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 22:41:57.5200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b7ec12-db65-4aa9-1d92-08d589fccb39
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3610
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62979
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

This patchset adds working Octeon Hotplug CPU. It has been tested
on our 70xx and 78xx develpoment boards. The 70xx has 4 cores and
the 78xx has 48 cores. This was also tested on an EdgerouterPRO,
which has 2 cores.

Changes in v4:
- Rebased against v4.16-rc5 kernel.
- Smaller patchset due to some previous patches going upstream.


David Daney (2):
  MIPS: Octeon: Populate kernel memory from cvmx_bootmem named blocks.
  MIPS: Octeon: Add working hotplug CPU support.

Steven J. Hill (5):
  MIPS: Octeon: Header and file cleaning.
  MIPS: Octeon: Update values for CVMX_CIU_FUSE register.
  MIPS: Octeon: Add Octeon III platforms for console output.
  MIPS: Octeon: Remove crufty KEXEC and CRASH_DUMP code.
  MIPS: Add the concept of BOOT_MEM_KERNEL to boot_mem_map.

 arch/mips/Kconfig                                  |   2 +-
 .../cavium-octeon/executive/cvmx-helper-board.c    |   2 +-
 .../cavium-octeon/executive/cvmx-helper-jtag.c     |   1 +
 .../cavium-octeon/executive/cvmx-helper-rgmii.c    |   1 +
 .../cavium-octeon/executive/cvmx-helper-sgmii.c    |   1 +
 .../mips/cavium-octeon/executive/cvmx-helper-spi.c |   1 +
 .../cavium-octeon/executive/cvmx-helper-xaui.c     |   1 +
 arch/mips/cavium-octeon/executive/cvmx-helper.c    |   1 +
 arch/mips/cavium-octeon/executive/cvmx-pko.c       |   1 +
 arch/mips/cavium-octeon/executive/cvmx-spi.c       |   1 +
 arch/mips/cavium-octeon/executive/octeon-model.c   |  53 ++++-
 arch/mips/cavium-octeon/octeon-platform.c          |   1 +
 arch/mips/cavium-octeon/octeon_boot.h              |  95 --------
 arch/mips/cavium-octeon/setup.c                    | 246 +++++++--------------
 arch/mips/cavium-octeon/smp.c                      | 236 ++++++--------------
 arch/mips/include/asm/bootinfo.h                   |   1 +
 arch/mips/include/asm/mach-cavium-octeon/irq.h     |   8 +
 .../asm/mach-cavium-octeon/kernel-entry-init.h     |  58 ++++-
 arch/mips/include/asm/mipsregs.h                   |   1 +
 arch/mips/include/asm/octeon/cvmx-asm.h            |   6 +-
 arch/mips/include/asm/octeon/cvmx-ciu-defs.h       | 169 ++++++--------
 arch/mips/include/asm/octeon/cvmx-coremask.h       |  26 ++-
 arch/mips/include/asm/octeon/cvmx-sysinfo.h        |   4 +-
 arch/mips/include/asm/octeon/cvmx.h                |  32 +--
 arch/mips/include/asm/octeon/octeon.h              |   2 +
 arch/mips/kernel/setup.c                           |  30 ++-
 26 files changed, 419 insertions(+), 561 deletions(-)
 delete mode 100644 arch/mips/cavium-octeon/octeon_boot.h

-- 
2.1.4
