Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2018 03:28:28 +0200 (CEST)
Received: from mail-bn3nam01on0130.outbound.protection.outlook.com ([104.47.33.130]:48896
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993888AbeGLB2Vi-ngt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Jul 2018 03:28:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biV4DwKzsFkrjJ02D/XMVI+v3CXYTQiC/Rqb2RCzfDI=;
 b=XsI12W6nsaI1g4nUVm884bs6yoyPZOHcfpnNQA08FGl5G0sJz824liETiqtU5U9zz0yFRO1e0gPceTKKKX5FP+m1uIV1WEJu6qRT+ztFRJuNLcKHT6slsHT6+2+T67ERS6W/vIKNJGL4Oe84ywiJ3lNzI9flPYp9FHFq2DjzBW8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
Received: from localhost.localdomain (73.162.151.67) by
 CO2PR0801MB2151.namprd08.prod.outlook.com (2603:10b6:102:17::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.17; Thu, 12 Jul
 2018 01:28:10 +0000
From:   Dengcheng Zhu <dzhu@wavecomp.com>
To:     pburton@wavecomp.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Dengcheng Zhu <dzhu@wavecomp.com>
Subject: [PATCH v2 0/6] MIPS: kexec/kdump: Fix smp reboot and other issues
Date:   Wed, 11 Jul 2018 18:27:42 -0700
Message-Id: <1531358868-10101-1-git-send-email-dzhu@wavecomp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [73.162.151.67]
X-ClientProxiedBy: BYAPR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::33) To CO2PR0801MB2151.namprd08.prod.outlook.com
 (2603:10b6:102:17::6)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f062b8a1-5299-4961-6724-08d5e796baa1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR0801MB2151;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0801MB2151;3:otK5zU9z+dMsm/Pf1VcgIOUbwb7qiEYCNwK65XzZwQmvtITfGn7klRu7qcOM/bGQNJ7ZwZzvLz2tyLoYA1ZDR70jeZVqRbWiGp41vjjktW8d3OcIy3OcR5x+64T4H7pbTe0BNfPfUyqX1lYPsOP5jRLMPUHKCObMjO5dnr9ERFYb8E0H4NAvjVvOQ6XqfvO3ibyYeS82jeojNFsOPdipWK3MEL1Hqb8lbqmnivwvli+0Q4uxW/xJUUUY9QorY1JV;25:+IrsARNFk9dSvmvfIgndd/Ud3CgQAG+P+eqnJ25D6dDxACbNixR2x4p6RwiFFSimIdXqYb7QoSTZZOrdAsEeX67QxowJr7r8KgacUFympmjFvtGM51ftlThGrK55CH/+hp0oEcnf7w9Gg1OPZ+AXg6C2aMpcK99xRVWJzZxjEMttlvoQVkzeeJ6cGcZHP4Y5awHfqNmRtw08VbqiVxI/he/2JEfOpVY9orpgskjAag3x3eA7friiGJswlMG7GBcJs+I7EyboSbQBV+Y/UguwKLd5zpJmcY+hJiwUfEl3Gk6hGufY0BAeTNJWtXvUCMeYpaHx1rYeZNys29xAyy5Uqw==;31:VOnNX9iFwZfYEWpjQOytBHD+Rk/0x3u4byRRl22Qu/TAH4AOPBFXcCD0472qQa0qQaqtKX7D5dgaTOoaeaGu8OEY+LlOxDJXaHtFv6RxAXIwe6WEdS2tubO8XppSZUvkBC7QQ2QrBSspHXqIKMZGDaUQ0C2adRSM2bEWdBo0eyDAFv0BKqZP416zPF4WLDxxbDH5V8n6pRb66ngZ9GOrH9y5z06LMImnnJtqm8JgL60=
X-MS-TrafficTypeDiagnostic: CO2PR0801MB2151:
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0801MB2151;20:OuY3zR5yrqiVeH2HzXcCT2Y8kmgyxVlgAPkckzgZjmFWyJBzs5h4LZMewHW1ZXc1DHILm+Z7UBBXihr3WA2t4g+ZCn3dqXs+M1jHnYA2hy4EXCl2BZar/yJ1VvDHwY0hil6tUZTsdMTBkmOAKgzmUm+q7yGt3HBMTXLeN2B+CxCyBnoxgKS16OUJat0wuaK9bpG6PF7gVLuUr2taE7JmXf9NehkwOhKWPy4ZRieP9C1dyTCi4OaT9b0puuG3lwzI;4:7DgVX0YhuzqRgjyU6Mmaf4p8ozrnvDCw67HXdJqIilzLN+tAmleVAqn425JVeplMgRbzE5bnPkd7h45f24fRxGhmRa0O8oRvWfe5my31/ZGgE3GVAORUzK7/bIDJpgnqzmQQvjeqJJH9Rinonx1tFy2uwtX2zGw3oZanlvDsbOMsK/6X64NetKfxgn03IHy1OOXGmjQb7VsGnvw4nfYQjGTAnKwb8RF6cP6paGyrhe/yy0adQN3LHImC0pvuu90alXsZ4Z8knBg6aC3Zlq3NVQ==
X-Microsoft-Antispam-PRVS: <CO2PR0801MB215197BA084A57B3073AEF9AA2590@CO2PR0801MB2151.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(2016111802025)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6043046)(6072148)(201708071742011)(7699016);SRVR:CO2PR0801MB2151;BCL:0;PCL:0;RULEID:;SRVR:CO2PR0801MB2151;
X-Forefront-PRVS: 0731AA2DE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39840400004)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(386003)(6506007)(26005)(16526019)(86362001)(486006)(476003)(2616005)(956004)(36756003)(106356001)(6666003)(2906002)(6116002)(3846002)(305945005)(5660300001)(68736007)(7736002)(478600001)(6512007)(14444005)(97736004)(50466002)(8936002)(8676002)(25786009)(4326008)(6486002)(107886003)(450100002)(81166006)(48376002)(81156014)(16586007)(105586002)(51416003)(52116002)(66066001)(316002)(50226002)(53936002)(47776003);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR0801MB2151;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO2PR0801MB2151;23:hrSlNGNa3B2XW7DqZzFAcUK8QV2bd6C7p8sm2+t?=
 =?us-ascii?Q?6mL7zYK5p7gBy/ahh7bZ2Bh529Z+EL13JB0VuJrillyp7prCUC0DqT4DnTl6?=
 =?us-ascii?Q?JPCq/uecVzvJmIdNyOMyhSI7O5hk8oFgqDliZX0y8iWZH2HqiL519flrtJ59?=
 =?us-ascii?Q?pseyTPjmh2+tOLs7uHhJD/vWRaeBRSLkaA5slXlk4X5OwJ13gjgGb3DjZ+hD?=
 =?us-ascii?Q?fW4nisUzVgJT5M1oKJB0HM9pVdGJNySOfcl1EtGlEYHi/tqOCcSC6C6DmeRv?=
 =?us-ascii?Q?9POgScJEaXlzWS9UxaF9CcBU2wyHd9vRInlS95W4tOL0JXzkIsoXk3Ih5p63?=
 =?us-ascii?Q?lGpBP4eTx8HrRFIRAPAa9fu+skLeNf6XCAwGQH+4DWPWF4HoA0Mt4ibY7v7M?=
 =?us-ascii?Q?XnIsVmMWVjPqE/sjXaQuoK6BvgAhADWzO4i/jnkuSFmH+LgxVS0HoG+GVOrh?=
 =?us-ascii?Q?3yQ6QQ2jXXc+kyUGYuQxO/1nIb5HgerMMzywPsfXQLS9oFH9JknByTIs4Nxz?=
 =?us-ascii?Q?HhdVBOdQFJayrOwi9cqJOnrJxrdaXGcSXi8HOcdFT1yNns6GbENXZBAouCGl?=
 =?us-ascii?Q?GMR6mMx6ubAvYQlQLVSUk4j6QSFf+vLnoLrRLJRcF/l4D2PcuL0S3/JopqEy?=
 =?us-ascii?Q?NvtjWPHDOm5ZSuB/xSXCuRxZi3BDu85epLLTv/7ck+Yp+VWgbyqYBjaUkW1r?=
 =?us-ascii?Q?9FqoL9EbfnGuMcbiq6+D63GCqaUuUvyR3d0LuwOPf7z33k1UEbW0BR1KBXDl?=
 =?us-ascii?Q?WHzuOMeLjwF48U86xWSoAYnB4yx9jIJwjZUV3NDTi/QGBL+zkp85wDajrwMq?=
 =?us-ascii?Q?BuYVjnqK4HsSZgsJsZsCVqPqX0hbijk7rCQVSEozJ1lFRas5q3+GezSXuTj7?=
 =?us-ascii?Q?cZSnV/mqLQpb+XdLRtpHC9Vapa7XsiU0EV0KztuvQ+TyDFjvOI+m4dxXEKao?=
 =?us-ascii?Q?hlU6VLmqQi5jtssAVWBST9VOyzpU4Ovz/4G/3DY1EdFAZ65RAC/SucgYdIoG?=
 =?us-ascii?Q?1tb3EBMQ7VNjz9+rR8DtVOkimsegjKoGcUSmPqAJKJOzBWCXJUm5Cwbkiezv?=
 =?us-ascii?Q?K5V9hLaXXm+Upwwk6ViM17nospiyWFr1LWte+91w96BD0pzf3wEWA1Hl56LS?=
 =?us-ascii?Q?mv7FwSo6v/mmmuB7y00Xpzh4/oAwaSS2LXivppRT1CawGmAIhs8en8Q=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: o0igJKpE4BkmeBDFHoUc2ZbJOKgj/KZHq5rbsgME3LC58XtotP5fl/AdbVfygs8xBiBUMwv3Na0zZXSvGy06QH82JYfYFga3b31x93kSoJskVAgeJkiPN+4UxmQiMMOd7eVMjCdIivp57UlbAJLA4QTB8xkyd3xzrDL2FmbHzOOfKBNfnPixtCsW1roKKIuQsCaFlnsEgWiMqHjWf/awm2qy/g/MB7T5MckKlsqM28XSf8WGGyHtOFppFybIumSemNp5Q73QF3i47sheOIYn17PqvjEhhWBjjba7aeyvPmm189cNub0z/js3F/1KS/atglCOZDEJfRoGjMg0oi4CL7In5xEw0lyEOEFfu5tsBAQ=
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0801MB2151;6:xejZaP4m6RrKccgCJ/6qQfgZ2es3Jco0IyCZ5RxjIE+L0NENV0mrgtB1rQ6UA36O9YPBKzreZXSJ5VQ4kNvWKviTxEqaChfmK1oOzyLoWyWxX5QOwkpeO9o+f7ZKnGBg9vmU9uIoekCxsgFvvYLWRNMK2L8LFlH//5kHC851rwOpgA7VmrWuVh7+SF8LFnucXUZnwRuwDWXuo1YMYfM+zElnOkSBpf+JOi44EVv0Ov5taD/Zq1NZd2J9F9azRDpUSvJpFue7sqxFXHbkZsnCLmGdm6hzK78pnrQAQzDx2yWZgplBp1Ma9fEPrl8hCjGK3MVcqqdSQ8Rux+Yr4fwA184pt/hxUeKk6oV3OvFko7TFonjDtlVpzZXGkvLREX1smvBy6C4HtuE4L8oeyvuB37wgblVXBvorfnzolYeG6nqb/4ghTTnO7Op2RA2NzcltFcISwHdzVc8X2p8jQtnXJA==;5:NSKbSgLFPi0AtJZlqsIf1V2YwtlE0VWOuPGPcYvi2lk6S/eeD+rGW3C5RIGfK1K/LwkMziVmxomzMpU0ak2GbSvFATstIkJrRiEZZru00KubhKd0D66iQjkor12RZcno5ZGuVq8oDhxNUKtjRfhfZzp81RW9LALLHZp9cN7bDKM=;24:2zWK08hmL3SNknYURno4g/vA3c+VkH2KZzf19msk4AB6mcLB483HgOCG7BKdHMNM8gZ4xIlCAfB9KHOi4urbvZx4yWm8azHaO+n9wLzl5Qw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0801MB2151;7:AOXOrS6Kx6c05NvfFhOFIr0be1ZolcPIT3pI8GvaMY+HhoJifVmmd6Qi38r+ES4IaK6spuHM2SpdBZtuVlVq8f72PhW/uQj/1SJ3J66dzwryTBOIY8EdBvpv9euwxmjslsTjoLEyy/oplp6fbGLDjEeONMbQWgsOj4/mo3F+pVEhgsbgDkwxy0KB6+OdM4hYPKU/pVsQNiQzrVBTIJe99dPoz5ufXpvhmRDv2zScLF7DvFBQ/EFzOx4A+HEqjn7+
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 01:28:10.2661 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f062b8a1-5299-4961-6724-08d5e796baa1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR0801MB2151
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64809
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dzhu@wavecomp.com
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

The issues are mentioned in patches 1/4/5/6. I will update kdump
documentation for MIPS if the series gets accepted. Testing has been done 
on single core i6500/Boston with IOCU, dual core i6500 without IOCU, and
dual core interAptiv without IOCU.

Changes:

v2 - v1:
* Tested on MIPS32R2 platform in addition to MIPS64R6.
* Added patches #5 and #6.
* In patch #2, removed the unnecessary inclusion of asm/mipsmtregs.h

Dengcheng Zhu (6):
  MIPS: Make play_dead() work for kexec
  MIPS: kexec: Let the new kernel handle all CPUs
  MIPS: kexec: Deprecate (relocated_)kexec_smp_wait
  MIPS: kexec: Do not flush system wide caches in machine_kexec()
  MIPS: kexec: Relax memory restriction
  MIPS: kexec: Use prepare method from generic platform as default
    option

 arch/mips/cavium-octeon/setup.c       |  2 +-
 arch/mips/cavium-octeon/smp.c         | 35 ++++++++-------
 arch/mips/generic/Makefile            |  1 -
 arch/mips/generic/kexec.c             | 44 ------------------
 arch/mips/include/asm/kexec.h         |  9 ++--
 arch/mips/include/asm/smp.h           |  4 +-
 arch/mips/kernel/crash.c              |  4 +-
 arch/mips/kernel/machine_kexec.c      | 77 ++++++++++++++++++++++++++-----
 arch/mips/kernel/process.c            |  2 +-
 arch/mips/kernel/relocate_kernel.S    | 39 ----------------
 arch/mips/kernel/smp-bmips.c          | 11 +++--
 arch/mips/kernel/smp-cps.c            | 59 ++++++++++++++----------
 arch/mips/loongson64/loongson-3/smp.c | 85 ++++++++++++++++++-----------------
 13 files changed, 186 insertions(+), 186 deletions(-)
 delete mode 100644 arch/mips/generic/kexec.c

-- 
2.7.4
