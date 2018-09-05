Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2018 18:00:45 +0200 (CEST)
Received: from mail-eopbgr680114.outbound.protection.outlook.com ([40.107.68.114]:38103
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994635AbeIEQAJ0Gn1O (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 5 Sep 2018 18:00:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdm7dFI2Y0qIitFQOwssHXG/bNSRsI1ocP+/8KEqHFI=;
 b=caLPdnAi3+jxCrM/s8GAsNd7KzyrHa7EEf08Z2hkCXq5zBqXd0KHNhUsDNQrN2uG5meI7Bz7s/cqPvoNp5hBrb5664z2CJiJZDVn6o5VMUkQxto7J+nI1dAQUwmQEHmAzpqqD9kImvctp8TlmcpJLlIAjulI5dl2FZFvljvSt7o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
Received: from box.mipstec.com (4.16.204.77) by
 BN3PR0801MB2145.namprd08.prod.outlook.com (2a01:111:e400:7bb5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.18; Wed, 5 Sep
 2018 15:59:58 +0000
From:   Dengcheng Zhu <dzhu@wavecomp.com>
To:     pburton@wavecomp.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, rachel.mozes@intel.com,
        Dengcheng Zhu <dzhu@wavecomp.com>
Subject: [PATCH v4 0/6] MIPS: kexec/kdump: Fix smp reboot and other issues
Date:   Wed,  5 Sep 2018 08:59:03 -0700
Message-Id: <20180905155909.30454-1-dzhu@wavecomp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR2001CA0003.namprd20.prod.outlook.com
 (2603:10b6:4:16::13) To BN3PR0801MB2145.namprd08.prod.outlook.com
 (2a01:111:e400:7bb5::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8ab8b2a-7f0a-47ac-8614-08d61348a169
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN3PR0801MB2145;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;3:lHYl1/LzBCdHcyq9XhQHPVN6P58dAUfLg1nN0QhXkJm3zf15ZphfVbTXksw97ax/J82HH08juqa6cnpq1AwOGr76KV2uiKxGIueInaMyVhiBwZIS3jb1niSppGhjTtl4BCKHg9yxKuvlABrlfCi3s43StNfP5zWdaWSBSOeBfnbu1h4rnjKVr8/a2Vo24XMdj0rUnbfIKkEz//9tS8la5wSqm02LSB8H5l92Y5FaNQGDQoVDh4btK3lMNEJ6Ap3x;25:B+hej2G4kQi6atuOA32mHCctzUtdQrJpSeMySQVTEVv/brG+n/4i3iVmiue5Eh8AjJkXlV8Wf24s/3GaXrsGd2UEGhbWx21a9mOh8g9VTHwlqDtnpP4w3751iA6kiMWT+x4I1X69DQXDh3+CKHcV0bUuMJRflgckqM2xqV1hOWmXbe2gHdMnlOJFmRSVfiMqvR0nUu41D+sazEOz/CujbyTal6/nOYjTGeYFWEEXIcNiBPDx2Uaqr/jiPtS4xNHGEHeexxys2gQj+5/6t3oY4m+/WuWz5/WLI4jvolhTGG1LaZe9QJDPZCgXjYbUMjx/4lBpOEmuLUKwdWWMX8SMfA==;31:Mufkqirqga087stmTdjwzO6eakNs66keEY237D8YbJd3IPIJdXq8W1band5vibY7CgAy7PzY0/WE4ons7BnzhhsLE065PGJah1jbRcKoXwT9ZT0cfxl7Qr0xk+eTUEb+gcw97AbOg3qjHGS26zFgD60TTXhuzd4FbxDImZXlLmSFLN7AX/Nw/Oo05l9VYdqqK9Kl4VJIGmJgOH8BAaucNQMkSpbmK+leOSyPPmRpz6U=
X-MS-TrafficTypeDiagnostic: BN3PR0801MB2145:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;20:Q3zp7xwc9xyeEsKUGcGXpRUsYPYalVi/bk9/WZiosTkoEpuhx6OZP7RdM7Z7YsJGbXG/G5uRS8na/vTwB0iVMDyk3cbOvZlQ2AN78rBuhqiguS2amoreaUCnQpp1hPm8d0LUcw1GZbRu8+8lV4v++uDaLw87CBdvjv6bH9sa8aZfhf0DyqZ0LnIM9ViLIiZ3uTO6HhCNTPnHNRPB40RIaXeklI67U0qpVPfqihQOV15MEH8WJLEQ/nN/NL/6JntJ;4:wQ6VdTBsqUzcDLC2tOCmLN7dRoVNSLiT+vbsUiwsDuxUhZq0VM7zJyt7LMdCropFukg1L1i8dtC/J1KQ4N5PkjQaBSqs/x2JZHn8gsNNqlHjzjanOakaWdB9FHYVA08SNuw0TGtIW/YiG0Y7NwUv21YnCtsGt2EPXKOGlYSE06oi/BCKuo5BoOJKY15Sua47JvJ3XBhp6mMedevagKxdgKNKaLWi+gfAu6LaF8NdMxU5Z4frN0LC4ITIIiG+0TXHvS1a2s2rnRfTSddJIC6+JA==
X-Microsoft-Antispam-PRVS: <BN3PR0801MB21456F27230123977EABD45AA2020@BN3PR0801MB2145.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:BN3PR0801MB2145;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0801MB2145;
X-Forefront-PRVS: 078693968A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(346002)(39840400004)(376002)(199004)(189003)(956004)(476003)(486006)(16526019)(26005)(53936002)(6506007)(386003)(81156014)(81166006)(5660300001)(53416004)(14444005)(6666003)(8676002)(2906002)(8936002)(25786009)(48376002)(106356001)(4326008)(51416003)(105586002)(50226002)(66066001)(47776003)(68736007)(107886003)(50466002)(305945005)(2616005)(52116002)(7736002)(316002)(37156001)(86362001)(97736004)(69596002)(16586007)(1076002)(6512007)(6486002)(6116002)(36756003)(478600001)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR0801MB2145;H:box.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR0801MB2145;23:EidPP1zbrX4XJPAxM8WR0b1qPtMbwUuyh0+7tnK?=
 =?us-ascii?Q?QHFeXux76SAqTV+wANTWlIUIU/Mi6Oq775L+TVENr1I5i49UfpEruP9tsbhR?=
 =?us-ascii?Q?BGkwK7J9Qm2OJXsFWhDNtnwpEBrE1I7JhLz5BMAMQUAeyECB8IZnNDxgQTbp?=
 =?us-ascii?Q?QGwTGgYJeuEwyyS1Lg9Qk4SQLQQEoytpeNpNTm+JFd7mmCo/i1ZGKuKszk4k?=
 =?us-ascii?Q?3tpnbG2MZDWf30SuKm7P2sQDfuPtdWw8xfrrHdEaffa9RvRj1rpD1WB4fWOG?=
 =?us-ascii?Q?NqztIScIquvqBlUuFR6cuQ0CEOt9uH/Ud1ADQi306bII47iF3v4vq6l7Ey0Z?=
 =?us-ascii?Q?jSXGIRtHHppI+/mk/ezrTnL/6E5jD8afRDo2LGfpVTe0p0FMEg4t/h6f0eaR?=
 =?us-ascii?Q?yz1J1I1AX0EF2GYEZdKowRMvngKBNaHq1hGYkH5zoM8B7yyLPxXBOCMXAR2S?=
 =?us-ascii?Q?p7um3FpK3gBOIFVhXpF0meGQiyrATWUfEATVJYD7ZvcArcFlUlZJsnFrn+sD?=
 =?us-ascii?Q?D5YFEBrjMgMAzxHONPlJ94lLBYkQ72UvQmD6oe8InodfdY22EOWczlVJ9ony?=
 =?us-ascii?Q?zTd44eJmKsIIE3D4X3NIZ7fIgwMLxC6NQ1WzdV96fkReg68AY5Yr8djTL0Rc?=
 =?us-ascii?Q?MuRZU5PAwHsvYVi2k+YOQ+sdr8CdDJzBjZPJNyxG2/3elaYh4ss86oZQsqxT?=
 =?us-ascii?Q?Ok4Rp/Rljlet17rOckZGzpVrXCqBvF0RzFa6PyBR72X7wdSetZnj5SP4jBR+?=
 =?us-ascii?Q?eaYo8PJTWCGfnpLN1bAXBwxL6/k16lDMONpPJT3gCvuJUvt42hFirMQ5GywV?=
 =?us-ascii?Q?NfUBqTcA5xIBrfYmDc1vgVQ2M9U9tykgAGKvp9+HCrYPzvYcgu+BSUO6svC4?=
 =?us-ascii?Q?rjpAZnr3+gGStCBgEK4ETxZiYdlYt07SFE6/mQZAj7sbrI6iQnoF+NQi4gS+?=
 =?us-ascii?Q?a1OS1YRAPz2LNaVdm9/QiViOk4ehsOfS0UrtbaWhMQUNsCKSKTeAdZRa9NBt?=
 =?us-ascii?Q?/YHWeR4b2BOFXE6lQvMueFZ1MBwFV3gIiPaP20Vs2ofAlfLGB5XRMX0nwcO9?=
 =?us-ascii?Q?1ss/S0TWMpR2wamGlosRJCZGS/tSepPmpOJRMhXmCf9cUA2W/ZyJ9z0CJnw1?=
 =?us-ascii?Q?Dk2yZhxxX4Ds0RHxqACTGKqXf6u0ZiVsuay19yQJCjQl3mMwE3fKnLwB0o3r?=
 =?us-ascii?Q?jjFWmfv+hxfdYxJYlmitsW5SxO0E3ROAerkCa?=
X-Microsoft-Antispam-Message-Info: bbWpUafO6mg6PzE9FDp4hlt//DwXwmzTxL17YbVYLUP+ul74beI3c8JuJChF/TEaEiLMmLNPQvsQRWu1L4UMBE4MIoqWIYRNQbAFsm8U7Qw+MBV0lJPm7WRpOdkiTN4qzmmrNzNgG/Lut6UMI1b+vx6TfaUmOJHaar90IzN5yMT4Lxu9aEeUDhaYzn20OLMVDbLlBzUPW1/JDZhQvwMTu1fIpikmlBRbvwh/FMmiLjMduQHZgu6jvAU5CHuTCWfwawSWbYQ2MDInlcE+i1SNXXwQKq9u611NnGNcsWjcqUZENnMQYtKl+QP7taR8Fmh03eQLIIA4lO+kMBbU41P1Q2XuQPgXzIcfJJGg0hIhJPo=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;6:xpoyGB9sTk3yS50tnFenIrrjdjQHtQ461uBtMIO+NjoGjLNpuU19sDEla1u1eSs5sWTfriJNp/SLHWPXzP+KmytuLqur9EH3LvpdNenTJoWcqcjnGoHlqXbT5RG6xkY7JVbmwu9q2dIRcnl/zcEA5aicw42I04PyHQsBB0WaB9WRRm4N55teiiaoP91ncEhDii4+IazO6EftT9wCrFjgwmXcx4PMJLgtz/8DT9MckEbYFumoTX+nUf81NwQNftBZEk3sZy3RdFJ3FAky1DnHv/tPWh18/oTKkBZvO97ts+5/C6hoZ2ISt4h0G/52QitySblSSnjHkep4/qMixD0DeM396EeGxSXvUQJ4K2514vwVjJC7IycNxCZTcXrd8SgYMDPtS+Agcm6Z52NZGiy7RKfSL2ukYj3vkxygc11gsW33/qaMtWjJ8GlUPDcS8XH3/W9MpiZH2IECnerJyzCUjg==;5:CMAExkmxWwC4fgGmQlXkwe4aeJ98p/x6LaU25zy/cnLQxsH0NDHUBF1u2rg8TOvr5tBo6GElM9xFYjGI1nCwuO2sR7dwYgnp8smb4ic+dAcmVRKhO3Mc5L1Nurd3UvdZlw3SmbrnNjtGqKrPilpwpKLsYWcg7rliFX47Ai3SH8M=;7:7fV6TQ+gbpxLYCGfYduYNM+gu0ku1YGL6/IoS4Yvg3LV317y04cesjtlSXW0ECdl08zQZ9qyXpdSnv7O/+WHuNEH4A2R6nMIl/mmaR42ZQSjkxWSDcLd/ZoG3NV8929duq8BLeeeP2Nsw2gs19ZbWrN5+csCP6Siq+0tkqwydqaRYjC75iuoeptJfSInAiRCk+WCyF2tvohkdhw8ZoO5Y054pIL84Yuw31nUkVMQDpgzBBchLoX1muSKMx7O78Yy
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 15:59:58.0186 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ab8b2a-7f0a-47ac-8614-08d61348a169
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0801MB2145
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65956
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

v4 - v3:
* In patch #1, idle_task_exit() is moved out from play_dead() to its sole
  caller arch_cpu_idle_dead(). So no interface change of play_dead().
* In patch #6, the kexec_prepare method for the Generic platform is defined
  as uhi_machine_kexec_prepare() for all platforms using UHI boot protocol.

v3 - v2:
* Code style changes according to `scripts/checkpatch.pl --strict`.
  Patch #6, like before, still has a warning message reminding if
  MAINTAINERS needs updating. But it does NOT involve a maintainer change.
* Add LIBFDT to CPU_LOONGSON3 for default_machine_kexec_prepare().

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
  MIPS: kexec: Use prepare method from Generic for UHI platforms

 arch/mips/Kconfig                     |  4 ++
 arch/mips/cavium-octeon/setup.c       |  2 +-
 arch/mips/cavium-octeon/smp.c         | 34 ++++++-----
 arch/mips/generic/Makefile            |  1 -
 arch/mips/generic/kexec.c             | 44 --------------
 arch/mips/include/asm/kexec.h         | 11 ++--
 arch/mips/include/asm/smp.h           |  4 +-
 arch/mips/kernel/crash.c              |  4 +-
 arch/mips/kernel/machine_kexec.c      | 82 +++++++++++++++++++++++----
 arch/mips/kernel/process.c            |  2 +
 arch/mips/kernel/relocate_kernel.S    | 39 -------------
 arch/mips/kernel/smp-bmips.c          |  8 ++-
 arch/mips/kernel/smp-cps.c            | 49 +++++++++-------
 arch/mips/loongson64/loongson-3/smp.c | 82 ++++++++++++++-------------
 14 files changed, 183 insertions(+), 183 deletions(-)
 delete mode 100644 arch/mips/generic/kexec.c

-- 
2.17.1
