Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Nov 2017 07:16:18 +0100 (CET)
Received: from mail-sn1nam02on0067.outbound.protection.outlook.com ([104.47.36.67]:20544
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990492AbdK3GQL0wjNy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 30 Nov 2017 07:16:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=FcvinxCjp5UtHJJnn93ri0ohc3xTQNoQ0nbY+mq4zYU=;
 b=ZG46HCKVAuL1q1MfBEQp1u4iQ6kHIrf1lUcyellRGRLJ88TMvwimD9IKno6DhI60iJ5mnIQLJ/uxJrbZ7MwP4JnubS7K7P54pe+YCpZphCMzDbtCfiIq8sF7TnPTn39fR9UI84PrTuecnNeeEFEHP4fDySWVwROfkFOMEC312lg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 MWHPR0701MB3803.namprd07.prod.outlook.com (2603:10b6:301:7f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.260.4; Thu, 30
 Nov 2017 06:16:00 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH v4 0/7] Add Octeon Hotplug CPU Support.
Date:   Thu, 30 Nov 2017 00:06:14 -0600
Message-Id: <1512021981-15560-1-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: CO2PR07CA0074.namprd07.prod.outlook.com (2603:10b6:100::42)
 To MWHPR0701MB3803.namprd07.prod.outlook.com (2603:10b6:301:7f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f90eb26d-6107-4cdf-7b6f-08d537b9d412
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603199);SRVR:MWHPR0701MB3803;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;3:hI+EhGE9+TFHqO6Rn/3gzJkRsqonRjqzCbPSSrzb4mVL34lDC3O5IE4wd646Jj8/KB5WiqOHMxRBtoSxEUc/GM0urYq6lpFLQ2e1sGUrgIabOeGZhVQ0br0LgON442arTanrusGFg63AEcTfHq2o9/cSc3i5Zadxi3MjQ+tHy2niwFCDEuMUg1bsA9TKs20lPMveggRHNkgUOTSiRt8S4Mg2eRSbqGqHLDbgER5ThZTIrinGqTZ54LiGMt/nQkhU;25:PyFdNJIyTd9EXh85ZUdHo/U6Ww4JvAhDkj8TCiqynZ6d7G77Ijbj/9+NryFQ2OFpgl6EiDmDXyD+5TPegRfJ7aUXslB/2ksn27LmOo28/0YCqgt5xj7g4rfBKQ3hWBeEdCgaIdI4P5RXXb1ljypv1ClCieBKQys5b+5QEC5xoLjNcwaqMT+KFIIU/Onr10zFlhTRu4xZPtLN1vBMWZNf+9QYyGdyDLEYwD128CikmIklM4Pkfl9QxO+5y8uuhDeReX0baCNQCMaIH8BqXERcoVB6FyJww8LEazNCHzeobU1GwphjWLZQJ+QboAXZpvcDf+aYtvKNB+Vzvl856eeVpQ==;31:/Jyv4nV9myjFG5cXUVChIrFe0Vp9yN2FKZQaCA0oYIkLjxuK5KAUL6fEBgrUky7Mhw6R5roU8CplH8+LOQ7qVfBkgqgoawPfxQE33bmPOJ3baJDnHnI41l2zPouLNwkIykfGKhktrTHNc0vBWIdYj/oOlyi2jcWcisPKCPo4apcKhgYWuWiSRImuDObEHHK9S23FovE1PHF/6J/wBqJWxFNLb09uvrU1rgAHidbPxrc=
X-MS-TrafficTypeDiagnostic: MWHPR0701MB3803:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;20:MhZZh4I90t5arhKo9fPgiZ16Y1qYShFLj4h76YPOUl1fTEi0FG00CjzxH0hgin5+zGwuiifUcX4EFyHYaYYTzoXKeBpJ5j4qAUm/SSLCHGS7udA8AMBGzhPz7k4QpIhp6Xr4qptBtSjENHHvXpuE4IFH58du4H6iiSJwqt7DJgG8Mpey//9UtjM0XiaTT77w3kVtAxSo8yCJtVMc3kTQnYpJq3QT+M1DN3oHVOCo6spmiNtuMzzEB4iTJrqGfBGjpH2UZROBLxchtxrpmDyqMYjtF23Q+jO0Cd9REa7GEEfhBVPe5Wvoy5W3sUITZeoilIFKKq3xEf2FCC7HGlMJg3d2aWicvix2296q5WoML/65ktrb8zN7AvVZmstAjgEO3YODwp1RPoHYWK8bzcSIrNwE+0AtYIwbNswET/Fz+ezLRwKRmK4cEvxrf0yPNzMK0dHM10t6TEChY+RZV/NW4tH20QMAPm1TVND7q8Dl4yeTvedm5HzY+6UFTL1ASDlJ;4:FpQGJa+tUP81cBCyfmZqrWqcSh/HMMKt2gt4ClDHyuSUZUQPTJizUm/a9f+B6pcE3D3mITx1beTUbVTh57oVMW9uFV0fC00a3TQ3GVHY6sY7APLzq+/wMOJ/2+UGvmOaAXJ5/2aG8GsfrFBDz7+Hutbrwv+gO2BZuEgKHxVi4HWUv4w/HFiOaenXUgPB+fdvIJebJWF1Jl8CZ0dxG9B8ffAtZRNgDa6fn0dCq7OmQcRdhXh9dlYNbdExlLbVopUq984ruBNDRMdeg7QefwztgQ==
X-Microsoft-Antispam-PRVS: <MWHPR0701MB38034D4D34073D58F6EC65DD80380@MWHPR0701MB3803.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(5005006)(8121501046)(3231022)(93006095)(93001095)(10201501046)(3002001)(6041248)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123558100)(20161123555025)(20161123564025)(6072148)(201708071742011);SRVR:MWHPR0701MB3803;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:MWHPR0701MB3803;
X-Forefront-PRVS: 05079D8470
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(376002)(346002)(366004)(199003)(189002)(101416001)(2361001)(53936002)(72206003)(189998001)(53416004)(51416003)(6512007)(33646002)(2906002)(47776003)(50986010)(36756003)(16586007)(50226002)(316002)(6116002)(106356001)(68736007)(6666003)(81166006)(3846002)(5660300001)(48376002)(8676002)(25786009)(86362001)(305945005)(450100002)(2351001)(7736002)(8936002)(50466002)(81156014)(105586002)(52116002)(69596002)(4326008)(6916009)(16526018)(6486002)(6506006)(66066001)(97736004)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0701MB3803;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0701MB3803;23:TwpcdEEBGRjamnQpge9cnkwwSSpQp2Hls8pwZWl?=
 =?us-ascii?Q?g/WWBWBEarl0tXuhwJjyRlVjSL1OFwc3nklPx4ME8MG8Ybs4SgWWJnB7i1rq?=
 =?us-ascii?Q?oCPBm47bWAZfvaz7x/eCoqbOV2zyNVwl74hvyC2yUNmdzQeobuSWV1tvEc1Q?=
 =?us-ascii?Q?cBsguJHwZVveQ8nkfE5w3TsU4KFj1AB6L32kfg5eVBHkDxhpaPBR3r3pxI8z?=
 =?us-ascii?Q?4+kOk96sq7fW1xtxIVIQcSSXy8ZqJrDqhOleFBmRQRvnnWTW+PBDRWy0eZF1?=
 =?us-ascii?Q?3lkfDDI8ltRVL6+a/0N7GjCa3sFKkZ83Ctep2SUp0jwHrikgc/n/7WsoCoLS?=
 =?us-ascii?Q?c1RgVK09o0Ms/pcySXo3BU3x1uCVHIVEbBkfzJk2vz93oXaPJm8jgct5GIKf?=
 =?us-ascii?Q?Zy4K3jTvv0oo0vT9Xg5SpKCKGXa+TkjJc41VBWx21pWutzgeaqdbKhgkMYSU?=
 =?us-ascii?Q?+4QlN03GXg1wwUXP7bQSVYbIwx5r1lG2lrVRW/L9T/4d4NyWuPNMa/25LxQk?=
 =?us-ascii?Q?foGSoWk4j68mRtN5YIPVhZ3llUzvC1zu+tyujMOONg1I0a1e8cBz87Lww9MT?=
 =?us-ascii?Q?MShMYVwDjO9VS2uzVFXhYA59ezZDRNAl2bnXIYQ6h8saLLUXgeSbteS4Zpgm?=
 =?us-ascii?Q?g7WLlvb/FhetHEF6jrxUqg2W6xOERNIBn3yJZRSPItI53HA+0sFqeWe/7Nqf?=
 =?us-ascii?Q?eG1DR0bsRiPBgRiG2QDSAaFFZVVOkV+lrQs4us3OEBZ2+xWHcceg3kl54Egm?=
 =?us-ascii?Q?/ZSsb8WP0z+P61wFY02D9VMOPLqe1SjzKSfm7fSZy3U5H2Orq1Lcekl8PnnO?=
 =?us-ascii?Q?VnqDD3TT/ZhgqINYxI2+UhpppWNifuj2ZHexIkUl8u0kURcklVva+61f0bb3?=
 =?us-ascii?Q?9h90mIevqlK/gTugBTcXVc7V4SXRnn+C7HZW9/9TCs7eR+5oWXW8LDFaP7gX?=
 =?us-ascii?Q?fnFCQZu9puvKclQ1EWsA7C9BwHzSjfaw2o7y1+w259neFF7QzUu0iLFbwfHD?=
 =?us-ascii?Q?S/FI6TGNovF5wE6mb3kEBCtq+PKY6mSUWDHcSCmQE5djqVWWqPTKebzzO+d2?=
 =?us-ascii?Q?nfLmbrF4zw24Go3YHQt2oyOAFQTxBSSaJP7t5HKNgVpHrXh+8JqUNSh2lnEd?=
 =?us-ascii?Q?pG+Ehz7csRkVwsOU7VzJRfUzuEHJ5W6aPVVVXThz9usyjwmQHF4Jepg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;6:9FL33K2j1cdjkmA/FJ5grtcLYYL0Xy0ffQ6hshMk4SlyVXfRuXlzphq+uJVHR2sJFRSVOZuI1HCB4mc2YAsO3LQ45Tl8XRfdEntP3eOAYiRoYEmLZ9H3+6JZXQhAvfb4q/VIQ+C1VB3TGhnIQ8VtNpXpTfLMPDdiPUVKaSaPPoBx+UiRqAuU4J9o/RlAm8Hl8OkQcUVeMssEZJh3cIkb2hNTL8dfuh7lFUyidMZH7/EVpvds5dJxA/hjgDsg3/fm+Rqah0+25j6ygWOiXXyPWdVPOZZ0LJAUn9KctwHXgbR9TuUOe9XS0OTh7nPvKrj6BUph+KGtBYZyjULMNEzVKyli89f6bX+wZ+5Xo1rZa1o=;5:m28Ixi5I/SGHhllCLP4ZCz8kPSPIRd3mIi+qbz+25kUUpRzq5Yzesdlo7ZdqcQnaSCjEPK2JcNOuvsd3h50t+p2lxMs3dJW0ae2pbQMxsQyzQ0JJA531juWisiCnMhJhqHkjb5th7wz0qGJ+xMYo4QIEeb+K5kOxHaVbugNfZhU=;24:t1geGaF3PR2454/eWj0B7GLCOJjN6260sFnHuSMzAt6xRwiTe3kLUmGcGo1BVB3DzQHHPN7BzjhQdWCZjiSitLYivnrZjoRVqQukwU8Kyro=;7:ckOKGVDh8pQIngNy+X6EDo7Z8STY0ZqC9xWfCrZsTXnP1TwBYKTiTw7IfPIVVIT+aXYbC4tieItXrk5B0wTeyC29c0wd2riVUhLk59SFCpLpE8Rl5P8LKjCguzDvT7g7RYANGMuW0K7D1ydlJ9b0TBfKL88ASwQ4873MK0Z2+nj8uqOFVtuc2x4CVnSb0boGdBMqquwBS2gRZBXwb7TuR6NyqU97adlOtC0IKkQ9sdj8nckvqUQEgATciRMVK337
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2017 06:16:00.6126 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f90eb26d-6107-4cdf-7b6f-08d537b9d412
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0701MB3803
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61232
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
- Rebased against v4.15-rc1 kernel.
- Smaller patchset due to some previous patches going upstream.


David Daney (3):
  MIPS: Octeon: Populate kernel memory from cvmx_bootmem named blocks.
  MIPS: Add the concept of BOOT_MEM_KERNEL to boot_mem_map.
  MIPS: Octeon: Add working hotplug CPU support.

Steven J. Hill (4):
  MIPS: Octeon: Header and file cleaning.
  MIPS: Octeon: Update values for CVMX_CIU_FUSE register.
  MIPS: Octeon: Add Octeon III platforms for console output.
  MIPS: Octeon: Remove crufty KEXEC and CRASH_DUMP code.

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
 arch/mips/cavium-octeon/smp.c                      | 234 +++++++-------------
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
 26 files changed, 427 insertions(+), 551 deletions(-)
 delete mode 100644 arch/mips/cavium-octeon/octeon_boot.h

-- 
2.1.4
