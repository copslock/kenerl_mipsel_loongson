Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Jul 2018 03:23:53 +0200 (CEST)
Received: from mail-eopbgr700124.outbound.protection.outlook.com ([40.107.70.124]:62912
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992925AbeG1BXuSMxcE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 28 Jul 2018 03:23:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CyCyV51BNUkSeTRWWeuhhFNlevq87UBILWwA8frdcs=;
 b=O3kdgKromUvOvX8m4ljRLiQ4vccrKDtgd2A8sVNS7Gf2NsUnIt4FvBvzdolgoC6Np5GcDqwFKjTL8c47b0yUNU9jROUwXWqrjgdWuYlFjJTGp7uevihBubiMhitSjTzJvAqjYxpz258J0kSSHVgFMgveK1qciUTNufCdrag6eEM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 SN6PR08MB4942.namprd08.prod.outlook.com (2603:10b6:805:69::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.19; Sat, 28 Jul 2018 01:23:39 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     linux-mips@linux-mips.org
Cc:     Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Paul Burton <paul.burton@mips.com>
Subject: [PATCH 0/4] MIPS: Support auto-detecting ARCH_PFN_OFFSET / PHYS_OFFSET
Date:   Fri, 27 Jul 2018 18:23:17 -0700
Message-Id: <20180728012321.29654-1-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: CS1PR8401CA0042.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7503::28) To SN6PR08MB4942.namprd08.prod.outlook.com
 (2603:10b6:805:69::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8680b10-529f-4966-e634-08d5f428bffe
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN6PR08MB4942;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;3:+C3NDxRyb7qCdXH14axf6R+/xhdITKHLudxGNBHSWFWCQCouQ0zcrpI9rSITDIWUgvk9S2dnUxAfJw8txvrIyYp5Nc31i9gsARBRYGhoXR/6sTkYMRqm4wGiOfgPe8DDxKxWNzOw/zda56XLA82fZXN+6kzXInHwQKDbfWMf+TIKdSn8Cdp9Z+qmQM4bCjN5FF1KDim5ulDO06saNlfDcsta25e4bWLa0GIu75FFNcuuLcDnscCIGS7ekn8vYacc;25:w20jfN5laxkZuVTN8ZqykaPmucvUUs6e3LA8Y3kMS0qGY3roPxmDHjXUfK1kEkksPkPWn8MismkiMgk1LrXPII7oTNG/yf91Pxm8UT6wmV9KyfMMGDQnto+KAcNhrZ154g/9GEFS6oM/gyhmvQ28xJjKI0Ro89RoMnvydtMI1VxUQHcP/kvc37hlxDVMPMxHAZq5++ICAZoxCRQH42qGE0nSmvnWafPLxHw2AhoRNWpuCsdF1MbnX4KWgKCfPTwU+q/x/xfiuOCQ5VL36UNcmAbWjnk7mS6FmGPNLQA40ZYZ3JSglmpza1bHuuP8Sm69J6eS0xYiMPxOkEJflK5+6Q==;31:+besdf9JRBNs2p13prM27MblUWOEb6awD6aho5l9GBYFeN7aaeyZZ/shGNSdmC8Xq8vcN3JB8jkYXfqcr9459HpY3h7bUPJnWeDAJvbgLq6KhODr0SSqGccq9EXf9MQVmlPBhBqXzEEnCRAZfps2CnNy0WJ8t02CqD34e/4awbGmR3U/c+N9ltCrCSHNseNYkcM0AzsXoyAxthsfk8qd2hwFTOHpoM8JUf7DfIy2YoM=
X-MS-TrafficTypeDiagnostic: SN6PR08MB4942:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;20:yLfQzPphlz45vddXRqXTvd3vkbdLfIXcG9g4CZ0i8VCy9FRU3BrJDijI6XJjE/jwyUJppIqEKIN6iPc949bpnRNummrUPbU08HZ2h30hCR7qtACvc7bSeZyoEN9x+szKlEpw2qPt0eQtf3+ZxXn2HmuGTsckFnJtBcvFnyW1KRW2f7NutGlnolTXLDOUUoMQ0nFg6qqNGVy5TCIgBH10lGQlcpVFpaGA7wQ+BKwZ5nux7d2Sh++lKcdHb2NLgTGC;4:rDRlojsNg9WAQWssEU5eGVDbS4hAe4vnbLFwMu1Rxu/UcKlgfkx1sxCV4UlYprKcyjlbj0iSXXo/mnhIaRR3qBsUP5oujGnkw0C7/rH6rlQGfxOZRZCPNJeC0rJyI6vc9ODpOrBO6OWzm9u9RDbDZWug4tcNL8J6qALZoom9gfQ94Hq+FpE3bxoaTJI9NSTcTcOLMV7FfUOr5jNRsOf7vyV6rjtv4lkMgev6YSUsmIb5paMLpeZ8nCN0HNGlHV1GiovTczZ7kZh/byBQ1esF8Q==
X-Microsoft-Antispam-PRVS: <SN6PR08MB4942F32F96AE30465279FD7AC1290@SN6PR08MB4942.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN6PR08MB4942;BCL:0;PCL:0;RULEID:;SRVR:SN6PR08MB4942;
X-Forefront-PRVS: 07473990A5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39840400004)(376002)(136003)(366004)(189003)(199004)(51416003)(48376002)(50466002)(14444005)(47776003)(52116002)(956004)(42882007)(486006)(6486002)(6512007)(476003)(66066001)(53416004)(44832011)(2361001)(105586002)(106356001)(2351001)(97736004)(2616005)(69596002)(36756003)(6916009)(16586007)(81156014)(8676002)(81166006)(478600001)(3846002)(1076002)(316002)(6116002)(6666003)(68736007)(5660300001)(8936002)(25786009)(305945005)(4326008)(7736002)(26005)(53936002)(50226002)(16526019)(107886003)(2906002)(386003)(54906003)(6506007)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR08MB4942;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR08MB4942;23:myfCdgpk9ZMxq7IfPQrQD+bxd0ON6bXXSbm+WsgPZ?=
 =?us-ascii?Q?kd9j8RX5GCYxw+XZKeJTjMFDs3yiCBly+PW8ptAvEK749frxIxGX0F7n7++7?=
 =?us-ascii?Q?fVluCs5dkxAAAvPdxqH3xoVONS3rpB4EFov1D03dcGQdsIm79T+JOxRKFfOA?=
 =?us-ascii?Q?BU+9X1uPpWeOao4/rbE8RbWcrD+Ps1bET59A594yni+oUVpzj5iw+WZ7XHJj?=
 =?us-ascii?Q?1ZUnRZItYQt4AxhV/+4dUOsumB2U3jgw4sxnT/HBHakrajjkJsf1sUSP8EWi?=
 =?us-ascii?Q?qzqj27gTzH1mcR1rpQxv1zlhkM2O74RthqxuwKK9sIIobAClHY1t2uGKkAjq?=
 =?us-ascii?Q?DSPyMOOfxYh/xTvm/BcTF4O0ZudkswMcHUpXYbQ4o3qov6OxMYYGv4+1PwCO?=
 =?us-ascii?Q?DJMQAssBZe0J55pNuPtXgmMosa4aV4BRaqiHIFgWYQKjM1C0GIxlk5oqTyIy?=
 =?us-ascii?Q?GlqunZ+3ez/t1uhAnzAhybSm6fLMbFnAnGVBbMwYwQKiat6XEdOq3DCNzyHg?=
 =?us-ascii?Q?jCQ4AD+aQmCj4BGBGJ6A1qJob8+HnWGJxTCgBPMnQ49dK5W2atEdLqohxfZc?=
 =?us-ascii?Q?80WPPYmVNXKNCS4pl7h6XIYdrerzQ77wXb1LM6EbroEi2OC8J1HFEVQVxrS2?=
 =?us-ascii?Q?/yW0MSjPC3f2daWtK1EfriOB5jVdT6bkCscR2c+lK3eRnNAzCTeRLqpuyykd?=
 =?us-ascii?Q?AUR6Xb4ErlrXNGlXGUVPdfK2kfLaWSdgnDbmdJQCrLi3ngbkHQXySQR+WZkm?=
 =?us-ascii?Q?hPRzwHqgz1ZmK+l8jScWwZJfCuUedc3T2Ucft9Ii4YPw7Z3cXOed9GWzthJI?=
 =?us-ascii?Q?nN+AOfcQpJm8vbdVguwLAMzuZBDqrfmcblVYlkttajZVakdSZ7yJ/08rrK7f?=
 =?us-ascii?Q?iNFhK8BpeN0Uer/b2lwNxSUz8QNbuuUlMsAh7PoiN3BoS+3tXT2qEuoqzz/b?=
 =?us-ascii?Q?UJV1nbtfONAC/AfF0MtxZrwN02TNzSpaXfjyem4yeIhfa8+dNl8Bfjy8LAj9?=
 =?us-ascii?Q?Y3Zf3pGxsF0pZejpFWaq6bdzm/B8Z7898rJQ1qPUE6YRowTLYyC4Ha7xdei3?=
 =?us-ascii?Q?gE6CGE+J1FzLVM8GsEXoHTHb7YE6V4O9rk/glLAMDkN4EMPZDH45VPkvmTyM?=
 =?us-ascii?Q?aEu3ykZoxyraDfDFpKu/0dCGW5WtmvPezQNoCZX901K7unczU7xUbsisjTbU?=
 =?us-ascii?Q?CxQrwlkFN6OMXp2LU9kwkDtvKEgtoeJq/hzsUZC40GlYlz40clDK3NLL2WRP?=
 =?us-ascii?Q?4p/rqqXX0pV2kfYNU0/cI89MRJ5TfygJeNtK9E9Rj5Vp/8vRHaBDUosLLOT8?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: TLDC7MLAspgysDI9GLF6FxyMv4NK0qaz/AkPWlFjKezL4XeOwy8yd1GVIto6e0nFM8d0/CkxDxSnuSPpMs/eSvdAVPOll+6ggHFcvS/65XFsPDpNNx8U25vRUzDtm6gl8TSHJ7ImfqVKATGATHl1fPi+AEvWeCy2qnLrLqWzjuAUuPQFyfOeeAsx4ZuDXgKyGZvRjZGdbizrfvT5i1nrEJtGtTrAIi7cP9bpFJdKhj1HyT1VeiW1rI/NVhM8gYiAsil0TsYR2JzY6WV9LJzmsPZwUMELD+UyZpwIw4mVbBG8zDcABfVKXZNh+OyRxBEUrhdALsOFcbsf8vetITfYtg==
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;6:0WbBNh/rYqIgr+cJUwLYiSWwLxuac3TZ/cQkWO6jExIQU60Ih23TOvhQ5IV3V+gZOxy78ok/wsB1jegjKNEnDRpJ6BDTWxrN+yNSvvAzIZYYGZuM+kVIq4t0ZgR0ishjk06mhdMLOsysXNdUw69AGWM2p38psdTDHAdqjEnXl9+tbFNQFygzD723Umdcf8/20Jb003VunbpH92hvKQCcvZgVfl0oFwoiG/X4zG9LzYQx2u970RmtzwwRVDDT0EnhkiOfbDqfAo844X/CO9LrNB+uQTl9LJyMQEW9+U8jlhPFU1LIjuuBeb04Ham7lwE30vA0KV1IACJscvIi5kazrHeh/0DY7oliBY4mHINK54qDY5t475ZKDzmLpOzgzJmUoym4HSKupejQVkDQziCXME0EXrp4dTcM8xGO6ostC2XB3sEDK+aJwiBfwx1b7L3r8RmQupds49DlkHjKWm8Rkg==;5:ahUpo3ExxOEC69E8VlKqdTcDqF+uGCRu14J2XFOmfte1M5STgesalGHblIUoA+MDVNRJE0evxsVPFDKxuiYF1rTYn5fE7No4gkOp6uLyomDunr+rwO+z/kx//xypjo3aIWxe0CH4Y73UoC7hBJspI2lNTZgOSHtrkLIfFLABzGk=;7:hTV+XE0799i4tgVl/j82+6ynFIRx90YzPoeOCmc7dcp8BdOep6bKq7b8K0vk/99j80MHgKyXSYYiNn6DKb34rclLZqJZCwYJMOcB4t5o2MEwKdt+nsC1o9xlaEQlTPn04bCvwV7NvOi8tEl5yxB4hqO945gnxacJecZ+amuu5fs4HrjBpoDDN3IRudjyR3hnwImUEhhMq3HmexNJsY4YpjHkB6nIsKB1o15xyUUnFh9Gl6+KLvULfKEBiixbvU0D
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2018 01:23:39.7315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8680b10-529f-4966-e634-08d5f428bffe
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4942
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65217
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

This series fixes a couple of issues we currently have with use of
PHYS_OFFSET, introduces the ability to auto-detect a suitable value for
it from the boot memory map & enables that for the generic platform.
This allows generic kernels to run on systems where the base address of
physical memory is higher than zero without wasting memory on
book-keeping for the unused region between zero & that base address.

Applies cleanly atop mips-next as of commit a999933db9ed ("MIPS: remove
mips_swiotlb_ops").

Thanks,
    Paul

Paul Burton (4):
  MIPS: Make (UN)CAC_ADDR() PHYS_OFFSET-agnostic
  MIPS: Fix ISA virt/bus conversion for non-zero PHYS_OFFSET
  MIPS: Allow auto-dection of ARCH_PFN_OFFSET & PHYS_OFFSET
  MIPS: generic: Select MIPS_AUTO_PFN_OFFSET

 arch/mips/Kconfig                           |  4 ++++
 arch/mips/include/asm/io.h                  |  8 ++++----
 arch/mips/include/asm/mach-ar7/spaces.h     |  3 ---
 arch/mips/include/asm/mach-generic/spaces.h | 10 +++++++---
 arch/mips/include/asm/mach-pic32/spaces.h   |  1 -
 arch/mips/include/asm/page.h                | 11 ++++++++---
 arch/mips/jazz/jazzdma.c                    |  2 +-
 arch/mips/kernel/setup.c                    | 14 ++++++++++++--
 arch/mips/mm/dma-noncoherent.c              |  2 +-
 9 files changed, 37 insertions(+), 18 deletions(-)

-- 
2.18.0
