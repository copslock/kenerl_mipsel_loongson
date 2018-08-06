Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Aug 2018 00:25:21 +0200 (CEST)
Received: from mail-eopbgr730108.outbound.protection.outlook.com ([40.107.73.108]:30880
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994672AbeHFWY6NRhyu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Aug 2018 00:24:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iw9EBiIhH2zEhQ27nYjjNaWn8Mum4+DBwjB3esWN+g=;
 b=o8lOH6odksHFK5zSNSu/kAlaPxtimTUvK0uf1M4imm+h0V/VbNVUqVGP2EW2IYA/eYfn9pzc1L6n/J51y260s5yuc2U72isE6GMPwoP4OlhtP++g9VRsyewnlU5lszUJwWUSrhXaXTdD8AGzMzcEK7eCoVxEdVCfsXktNzGKHOA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 BN7PR08MB4932.namprd08.prod.outlook.com (2603:10b6:408:28::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 22:24:48 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     linux-mips@linux-mips.org
Cc:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 2/3] MIPS: Fix __write_64bit_c0_split() constraints for clang
Date:   Mon,  6 Aug 2018 15:24:26 -0700
Message-Id: <20180806222427.2834-3-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180806222427.2834-1-paul.burton@mips.com>
References: <20180806222427.2834-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BN6PR2001CA0045.namprd20.prod.outlook.com
 (2603:10b6:405:16::31) To BN7PR08MB4932.namprd08.prod.outlook.com
 (2603:10b6:408:28::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87e7532f-babd-40cb-f3b9-08d5fbeb6baf
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4932;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;3:Yx/NvlzZel19oVorYsFDHM2v5cE49utwmESMnwYaCcAm84DOxO3Mqzom7EHhrIc4WnTekBf2iDt/KDXHdPD4JIUXBWSF+1xb7miRBWA+j/dIcIrWncQFHni7zhg5D/42ZmiM8uHswBd1kzOgWiUyVVPaYQgNUkoThKlcr7N0KK70j+ERGm+2Lxh72WjDDzpi/srAOb/BTkQhDcJx6NEbqvZxZL6A3tuphUknT1wU6rGU4iLdbeSoVwpMxubT3/pr;25:jJns9HQwkl7BL6egV9J8t62mwB9TzMrcx5PJbuQCXPSOkwXrk9E+SAEPtTrFd7gty6SUN5Bo58HA7Mj+lgXQa0iin3O+KWGwJACYwrft+6/9gc893Z9FGcVsJiWOnuP6Ny72lFxmFgue3gJIzT6gWTVES56vSa4nVNCDj+Z4u5oMmRwBmhjX4Qylo9hksrcCDeKzo2KeG6Vyzmr6V+bG1V4AdRmgbZBbDkIv0iuNp3HFW5CVeJJrLXaRPMRYdaQDv+lhcXIheB0IyIaib3mi63vYesvo1NhUFxd0lU7LbDU6YMT+INqTxW4L99bfhjN4XKZpWaSEEqMd2q33/X6T8g==;31:+6LLGbdLkCsgaLK875kt7zPUn/cslvws8jIqv71PvLtsBlHHtxf8FhybYl6dY7ijjFOs6jUC5kJmtldrCjikXaigdN+PP9LMsGb6iROn/O+xk72lY9bNJsUW/NGTP/5QtFyWsSEiLgdbvXA4UtKhQwrNtp7csgJsZGFg39jsT0Zxm4e2r93uLLpwl+YGRvPGXoUknj0VjTJ5VlEd0Y7iIJcxQaIA1jO0KnYzwmBgM/c=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4932:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;20:swjePBU8yN8FdXbVFP4MG5an0PHhwEs3fUFalOX+jQnHZqtf3ypvnHNlbEybP5KnhaLa+gB49yprRbYpbqxGUaVsoixWXmuRZu3xvhKD5SdyPtAnDTBQ5W4Sv1knAO86ofe8SD+ff2H42xp7r4OomQVH3DW7FxF1/WqUHs3PaphiPKeAvHKVpayHa4fS74RvsBoZXZfyBgbkoNgS9CwecIMlsQrxvhSrQkaPKtLjtKUbY2vcxOkGxNDGTaovu4wF;4:dZL5iQUwFe16mZXmpAi4zqVAy9yaIygzLl1peju72wp6xUMfAVOlkkzbnbBDfC1FfMMN6nArfnZDU0IH81xMHpp8d5ato3GDTspgYyLaceNTfp4Telaesssa5+X8GRG+PO73zgRdr0C8hrem4oavDIGEbZkvnKQ8lEJRypbb1scIVM9WXiV/duy6/hyHAuBP8Fhw3Cf/Ez2cHHVsqfIIO35cLnN+crIguNWwyH+svv/Tvg3udAoFsQqLph9PLXvAQy8njyr/3BilECfX4oSBhg==
X-Microsoft-Antispam-PRVS: <BN7PR08MB4932F22EA36C63745702A689C1200@BN7PR08MB4932.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BN7PR08MB4932;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4932;
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(136003)(376002)(39840400004)(189003)(199004)(97736004)(47776003)(66066001)(42882007)(7736002)(476003)(446003)(11346002)(25786009)(3846002)(1076002)(81156014)(81166006)(4326008)(486006)(76176011)(956004)(2616005)(305945005)(8676002)(2361001)(478600001)(68736007)(50466002)(6116002)(48376002)(69596002)(5660300001)(6916009)(6666003)(2906002)(16526019)(36756003)(26005)(186003)(6506007)(2351001)(386003)(44832011)(6486002)(316002)(6512007)(16586007)(50226002)(106356001)(8936002)(105586002)(54906003)(53416004)(51416003)(52116002)(14444005)(15760500003)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4932;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4932;23:W1Dhy35T2jjL+5GfYbIcHUyDXuplQGr5w9o3e9KX6?=
 =?us-ascii?Q?q6s2aH0wn5UCQI8ImxJiOHPcbvWhbEvlU+zCVqafX0Dwg+qa4pVu1D6/xPOj?=
 =?us-ascii?Q?wS7bD0cGrAQ6090iKzTSknQV3iaU7Q9Mt955IsZN2Fc5u+sGSxR4obyt9rtu?=
 =?us-ascii?Q?E/BWtZj7ARQZpnfiqvJjvBSsZfB7p7dV6500EkGJUYWSaQNWPPwYi2V6z8XJ?=
 =?us-ascii?Q?Yk/hii/mMokP/rVnWPr5idy/JmDQ7H7aVEq15evTkCSmOdfvZX5hrmnWu5fl?=
 =?us-ascii?Q?kCKp3z3HAr0Amu7Mpq9NAQkvpcp5AYN78ZO+t6RMA4uz1ZusMXVAC/2k3tr8?=
 =?us-ascii?Q?jqwe/T63MAoer5drDe+WgsH9SmznUVgD4djNl1rsvluz+cNigBK+BG/r+uLB?=
 =?us-ascii?Q?g3Vj5Ky34BoRm5GSJLasIRtwzs+AER5RxYjDmPagphoGduQtK4HDGqiM+n/F?=
 =?us-ascii?Q?6q1sJrVZyYYwjt0sE/BcfoQW01hXErlv+0zNxpdWToCyfvRGrNkUq8Zeb/CE?=
 =?us-ascii?Q?t0lTDz05TUiTEZSEqsExzlRaVyO9o0vu+PP55JuMGEqTM0NYcwt1h/HG+FaZ?=
 =?us-ascii?Q?k2J/TuGqHYuRrpT9CaE1AzkYezQuvlnDTkZZp6Dqx/wDkUK3Q9C9A3A9Fc+5?=
 =?us-ascii?Q?l+p6rLYfwP6LVBD+zVOTmLS25W3i45PpBhgafDNCP7Wwtyu61Ge2khfhJP/S?=
 =?us-ascii?Q?DgriTlkiGzf9wbm169oav2IhyEE3+nFUM2HPQRpZsmW16zjqcxUx6jVfDWyh?=
 =?us-ascii?Q?fi7bN1Ua7YaF3t4BDIRa5YHohekc1twkvBCKs5NaXqnIZkNqEIWJefY2pAxJ?=
 =?us-ascii?Q?TYwUWkjJwB5bTZipggKhpDFSPuV4ATpgkfBbmx++Y0FYFu6TgR8JKBBaA6NX?=
 =?us-ascii?Q?QkZePYAI+faH4AuMGnfgu0HECsIR+mAxD0UuVxpiiJR7Ar3BG2LyPwKPEG/0?=
 =?us-ascii?Q?E5mSyexe1+qLFDRiWiZMmWTrPTiBcqc6yMCPDkQ3iq7yJJx+gMyQsD2ev+ms?=
 =?us-ascii?Q?ojGnBTlhY61pZxqUq3M2hzXc0cQri6AJgxkES/C5jjhZxQkNu/TMQlz5FBXr?=
 =?us-ascii?Q?jrUZQpfPFnbCp/ydPq4su98rKTJkNCLBNdtbJmp3GiuHsBvbTR/lBuLgIzfv?=
 =?us-ascii?Q?orGEH9WxTo1xWXDXBfG+cK4q182LbgUtGPB74rXCacwWm0zkoz+j3ctFudk5?=
 =?us-ascii?Q?cD80R0oXqQ+9YXuE1yLHEhjcsurGmp1r+RWImNj6Vdv+nmWlryTrm7HUvJTf?=
 =?us-ascii?Q?pb0x7yNmRuLTwzLWJ3oTeNM8Sa66rh36SN+us0ipHv01mBh2fuegHo9/5O0a?=
 =?us-ascii?Q?ZFNzfrodQyoySg6wZ8k+xFFj7kybq5+nRzOhacHz15IQSjERex3/H06PiPL6?=
 =?us-ascii?Q?B7LGg=3D=3D?=
X-Microsoft-Antispam-Message-Info: xCkoXOw5IJfdBu09pVwiByjMNSaDl39cfbalu3T795yC+2CE62luNKfkr0aUBhvlfhLVcyo3Z8IEJhxAPLIlhZ+EHWAtWev98O7JqZYFD0Y4UfkO7FuNPwyxyrhxPDdUJFwWDqzu0mc1KKb/ktS0xmizndVrzVQbb5d4o91GabAHOlMEnlOJMtF0X77h2O7gyEkr2P4gWh5F/igiwAqpBMWqza6Nc8hCM1ABvByeIceXMRK/6c2XrxjkN0acljZwdYDM8PQSl+mJ4AxkWiIPa+iK+21tVxL0ywJbUsdUBTkLUYtSY9T0vmGQ7iirz8BBGdL07hY/6GyhXMBkHiKrxnuLNJ6S5ioFDlrBUw3ftmk=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;6:t2XpRKlZvmc9adCxX5P9V3QmZpeeFiUh9hv0fi9rtwtiV5c2aSn7Rir963Kv35+CNdmGaurEKgUuhKSfKJR6U6J72DEGaVQpmaRysDEyGG+3cFJdLUkjjMqBieN2jaj3doGv6s+0nMS65g2aX+ck9v5e7MxYiIovI2qHl+DFVZOIQc9yI+A83RWInS6jk5ySkJvPUgFWOpZNLyZ5Td8fWjaqsk/jBomNB/8guyREUdpwbUYebbAdQz0P5lj6etZoa9kYoi9lp2kaPm5aC0QpSHE70P42i3qy6aJMz+CQGzR1zXkBdBGre6svZJH+EM4qunaNEOo3MVju63vS+2y1b22pt9UdUHJenDhI25oOdkLoWHeweVSa7EVDNk7FCkLuE/660ASJxfvNONOqZPA9rFwywvlMKB0chdB+Hpjxkbxv+9ayrHvWtnnwAj8tk+IdTc8gWAUEn8/TAq+zJy8qXQ==;5:/1++2EnrHUEhAM8biTxJOKfYtb2rvbfqUIA0KKXmdW1EfCdG7Oz92vHMdrSQo8m0IckE8aHVfDsH5wUKBNUXc4XEtIDKuSXAQWuFEavRDdiQM670pyiVcTOPMjQYGi9euDhSnWvi50fa5TbsZl1UGM+tmhSDYABRJ7hv3km+SuM=;7:mPN2uxW2MpTVs3TsEK2YRAo44MB6nO6v29bkKIaaBLsKUre0F4KWN3XC+gJj+hd0vxLnroXNind8n9/PzDf2HtIYEI4U0U+hSJ3NcvyMNE38e/dbutXYrQwSzq9WaOkBGybzRVGixzGp6TwvGlo+IjpwzbCleYHzH1CNJ63ey9ebg/PfOC8KVjX4JuWV6lc2MMLPCoav502hXcOjM1jY+L3ts+GoJYMrii/mgdeDGFGY7eL+qHxV2jtfe+okfovo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 22:24:48.0779 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e7532f-babd-40cb-f3b9-08d5fbeb6baf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4932
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65440
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

When building using clang, the constraints for unreachable inline
assembly seem to be checked. A result of this is that a CONFIG_32BIT=y
build using clang will result in the constraints for inline assembly in
__write_64bit_c0_split() being checked even when the caller ultimately
used __write_ulong_c0_register() & the 64-bit path will never be taken.

This results in build failures like the following:

  In file included from kernel/fork.c:98:
  ./arch/mips/include/asm/mmu_context.h:149:19: error: unsupported
    inline asm: input with type 'unsigned long' matching output with
    type 'unsigned long long'
          write_c0_entryhi(cpu_asid(cpu, next));
          ~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
  ./arch/mips/include/asm/mmu_context.h:93:2: note: expanded from macro
    'cpu_asid'
          (cpu_context((cpu), (mm)) & cpu_asid_mask(&cpu_data[cpu]))
          ^
  ./arch/mips/include/asm/mipsregs.h:1617:65: note: expanded from macro
    'write_c0_entryhi'
  #define write_c0_entryhi(val)   __write_ulong_c0_register($10, 0, val)
                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
  ./arch/mips/include/asm/mipsregs.h:1430:39: note: expanded from macro
    '__write_ulong_c0_register'
                  __write_64bit_c0_register(reg, sel, val);               \
                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
  ./arch/mips/include/asm/mipsregs.h:1400:41: note: expanded from macro
    '__write_64bit_c0_register'
                  __write_64bit_c0_split(register, sel, value);           \
                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
  ./arch/mips/include/asm/mipsregs.h:1498:13: note: expanded from macro
    '__write_64bit_c0_split'
                          : "r,0" (val));                                 \
                                   ^~~

This occurs because __write_64bit_c0_split() declares an unsigned long
long (ie. 64-bit) __tmp variable for use as an output from the inline
assembly, and then attempts to constrain its input to make use of the
same registers without caring whether the input is actually of the same
width.

Avoid the build failure by simply casting the input value to the same
unsigned long long type as the output which we want to use the same
registers as.

On a CONFIG_32BIT=y build this means that for users of
__write_ulong_c0_register() we would zero-extend the input value from
32-bit to 64-bit if the path were ever taken, but we know it never will
be. For a CONFIG_64BIT=y build the caller should be providing a 64-bit
value already causing our cast to be a no-op.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/include/asm/mipsregs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index ae461d91cd1f..d8213dca2ab4 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1495,7 +1495,7 @@ do {									\
 			"dmtc0\t%L0, " #source "\n\t"			\
 			".set\tmips0"					\
 			: "=&r,r" (__tmp)				\
-			: "r,0" (val));					\
+			: "r,0" ((unsigned long long)val));		\
 	else								\
 		__asm__ __volatile__(					\
 			".set\tmips64\n\t"				\
@@ -1506,7 +1506,7 @@ do {									\
 			"dmtc0\t%L0, " #source ", " #sel "\n\t"		\
 			".set\tmips0"					\
 			: "=&r,r" (__tmp)				\
-			: "r,0" (val));					\
+			: "r,0" ((unsigned long long)val));		\
 	local_irq_restore(__flags);					\
 } while (0)
 
-- 
2.18.0
