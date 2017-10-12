Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Oct 2017 23:04:20 +0200 (CEST)
Received: from mail-by2nam01on0081.outbound.protection.outlook.com ([104.47.34.81]:34528
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993070AbdJLVCryGDcj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Oct 2017 23:02:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=nLybC1ehKhbOHetB+vAREpSDTeIjHfMx/YG1FjgNqo0=;
 b=M4AdT4p8yLIioOQTaPznRjl1aY6iAzOxSvdp1/EqIuCrtQR2751Ut/RsbR2T26M7joHVnh1pY2dnjo0sD8qsR7wV3o4TkNjGRccrUy85iW6o389KIzwfaEv5f+7awIdtzgfRresPQ6U50TBFxJ4VZJrQMiLuT1ua5dqWrRLcUD0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 MWHPR07MB3503.namprd07.prod.outlook.com (10.164.192.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.77.7; Thu, 12 Oct 2017 21:02:38 +0000
From:   David Daney <david.daney@cavium.com>
To:     kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>
Cc:     linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 4/4] kexec-tools: mips: Try to include bss in kernel vmcore file.
Date:   Thu, 12 Oct 2017 14:02:28 -0700
Message-Id: <20171012210228.7353-5-david.daney@cavium.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20171012210228.7353-1-david.daney@cavium.com>
References: <20171012210228.7353-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR0701CA0012.namprd07.prod.outlook.com (10.162.96.22) To
 MWHPR07MB3503.namprd07.prod.outlook.com (10.164.192.30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16434109-9e40-47a1-1a78-08d511b49235
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:MWHPR07MB3503;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3503;3:rWPV2FSf8dDyqQUCx7z2ILnchoWp75hqBHLPucbR3tULXbIDbIJFtJwGyRjPSy9/EbXskhP7oI+qPx4evFIkdZpVFUY9+Vw9kN10mZxdhAmq6KvAgS7ovvr6e981vEUvzAFCp2u+kYARfkzry861kDnfyD5BofBgF3NRgqVt4Lz7tJ0cjeSMBaYzjlHrjDXdV1IomJsfTar3D782tYiv0jzjZJyoRH5tmH0nv/yVc7ZhzKirL3cLAPqE+pTkX39T;25:DQ2EQSZ+W7UQN4blxUX7b7ae6M7TnJ4ROteAswQm1Wd0UkGRuaeKtxmT2rtczVbWVflWGji6aYF+s2nFkOMrAZMhTmvLTzjkfLTBjGt0z1VirK1S3ILEaiwH0xPldykv6fxrhL34MSz0IUCDBACW0t0CcZTRuzPjLqRcVm5g9HyoPWaE7L9n2WFv9Jyz8vl6iJvii+gLMHLCmHj6xbAH6M48Vatv8EiicqBTiM9DvX6SzT8gAZEmZQsOE1kBwtAZfElXTUNCMQUfzdaQ83yaxgRYejQ5G+ZD7lGHoASFVgqXlw5hv4C7HnYoWrv2RqzBBzEuqHF692kPYxGbx8w74A==;31:M+3jysf4mQ/P+MUg9PXT/6QrlT8YlCcHL3UBywfovIvcGvje0e+k+bbGCKIOxhVB4HQEWDCmwMumXaB57tDtA0FQkLgD8ow5wneWtxmhNqYTfac7yUSQRPG/M+EQlNPHvOLC9n+Fr18uERPHXVUlNkP5V+K0QgwndAJsZpf2rcLiV1gq2CBYLSGg536seUtU9D4duMbfENlvwKQNjXCK6/YC5vTwp5WdFeDlxiB4k0U=
X-MS-TrafficTypeDiagnostic: MWHPR07MB3503:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3503;20:mpuBc5Cd4m1jslG96+6fn8m411bCZMp/3INvpFzNj1+T8uUJG1VErB2Coy0qFpyUUpgEMp3Ek6kbVo8ASOcOQmpHSBKacmGXN0Zowr5CVYLZOk3D2CIENriFb0Gb3P9Swq68x+svWhQzJSMj9LY/0pJRUWkWvTRT3VNyWb8FdMzcc26yuy48gYJMG1hmE1Qco9cCtTGm/a0A9W4uq6keD1i8bDVchyOQJFg+T4eZlBcY+OYa5ALUr6CXX5tpYQ8VXE9Ywu3CKm6NE7vmCrEnMFvI0Bq7lhh0ZlcgFUN7Oze+dp1PuccBaFdabdBdjvnY2fZEF2buTM6QRZBWE0QEZuBA7qvCu9FoQ+z+XMY0R0ea+XGhiEIVxBjcXA5iRzyYY/nv7QT0rcxGGHKSlCCDroyJLvCq8S1G2pwl9jiU01L6lBkTvX+yT+B43pntUJkZKZ5QWCRIuVytZy7+nzpHgBu+BUfLzBoIymyAAC7sGadL7DR7X01d1xpG4oTvzLsa;4:VNX44iDlZlXS57ZHCaxGByiBzp1O+uq890UuY2Cl0+cDKL4Qa4Dqvo3TyulXNzE4yyauywgf+QOmSKORhah4RskPDEywQEwGggD2hqtGLv7PKC2qFaog9E6+wCBgNDCGj9gvPPBS54yVqiTmSRtbN+hMnkCaixsD6EN3iDRRNW2fqmoozMzjEapY+ljgalVLGzjsN6v+7wuhkib7fyH0EpgFkYYL0remYA3+CBcioQoGm4PXXqmauwWcg4itS6oA
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <MWHPR07MB3503C21D38443D7A28B02FBC974B0@MWHPR07MB3503.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(100000703101)(100105400095)(3002001)(6041248)(20161123558100)(20161123564025)(20161123562025)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR07MB3503;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR07MB3503;
X-Forefront-PRVS: 04583CED1A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(376002)(346002)(199003)(189002)(16526018)(68736007)(53416004)(76176999)(25786009)(50986999)(69596002)(47776003)(5660300001)(2950100002)(50466002)(48376002)(6666003)(66066001)(101416001)(86362001)(6512007)(478600001)(316002)(6916009)(6506006)(7736002)(8676002)(81156014)(81166006)(305945005)(2906002)(16586007)(36756003)(72206003)(6486002)(6116002)(1076002)(53936002)(107886003)(3846002)(106356001)(97736004)(4326008)(33646002)(50226002)(5003940100001)(189998001)(8936002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3503;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB3503;23:JCjpHuURrHFFUny+VIbRY8TclBQxTHkQqcE7B9xpt?=
 =?us-ascii?Q?NnnFvHbeUUasMix90aQi/nYKeqHucC/lWGBNQXKjrgAP/eAm363ohGjLDdQq?=
 =?us-ascii?Q?7rId/MwwhGFeKhXPZyWZXHEIHfsRzOcqxXuuZcuZBa3qG58O2xs1vpcfBt3p?=
 =?us-ascii?Q?oB+HtZUb+UGReqNJYq3TWOEZ1PW521XlTANuEU5ikDfGoaPzefRcoc50NHyM?=
 =?us-ascii?Q?kwGGr0mqM/66VE5w31xxSqxJg4x4wzrTy+vND+K/gBjd2dM3mTfXVGBopyn+?=
 =?us-ascii?Q?ChZb0jP5kaAMNZzNbDAbbed7GNg7t1+H/lwq6PTUVmnUSOph3J/ydy5xwK8j?=
 =?us-ascii?Q?6gUjTZLAUM2F5evQOR3FRgaeAvlx9b1uRCm84eSgKaTh6/0/jZQO+MpNECSY?=
 =?us-ascii?Q?X+3MZLX3/DuW8ifj2ksKL5La+/dTK9oP/G56EwMWVvW4wW8qObRSjXQm98m8?=
 =?us-ascii?Q?jHVwe1vCso44WO204lh4tk7R6i3/3LvE2rrphPioG7nSsGCvOtmHxbPIPNw8?=
 =?us-ascii?Q?RldM+qU/EIpafUCOlJ8bYWoW1/GftO1Rx4mFHtxC5OSLtzl+NTl0cpUVUAeW?=
 =?us-ascii?Q?p/2Gyeok23s1yVNR2ITHslFmHaEaxgF9xe+djn3OxHvPWHcukqtJXXKqDex5?=
 =?us-ascii?Q?Vr3zJ62TUGDmcocaAlW1FBcVbjR8v7ZFdGRCxafN4bzrzxcPP9eL/ztyc1M3?=
 =?us-ascii?Q?0ocq2vtFCH2h+Ix9MfcS/8slBtzm0hsxtQE6/ocv4/4Pa3TFXx5eu3K4maFD?=
 =?us-ascii?Q?0NCJ6qAhxX+lG6rFOnlzL6NI9fv+OyS9Qi6BUmBOess6dejPIe9fhLYYefX8?=
 =?us-ascii?Q?ux1UmgYgp4GHRkau7RYmmHuxP9C/g4c1mchiYliK0DiUYFDsKZEcD02qAFzd?=
 =?us-ascii?Q?sIvP2mVVKROP8xRT1rzHisvIe9X2/IOQjU9dUjyXr6Mm/qL+ggw/qeEFYvlf?=
 =?us-ascii?Q?LALmttIU3E7zSslvYRGtst2JP7sSSLu1LzT+zyGithUrk/I6U4jVyLL/on4v?=
 =?us-ascii?Q?i9DWAMt2huWRTrgHeCl0BvlNtoUiC4vUpYcsvODIyLMPgyGY+XThUoNfLHWs?=
 =?us-ascii?Q?yQO9IpGOCmbduE7ObcMlW3Mmp2+cxZ5Ko8lGZF4/noatWG8wS5WzeCunE0fB?=
 =?us-ascii?Q?uGcim1yYeIomRzEFfpb5HRYwASlnU5ADBgfVxNQ6UM9Gwaq8Fpp8Q=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3503;6:E6zkjdijtt012LwlFzHc3GdbgFv/l+LNcrXnlflhknn9z31iY/pdaaNmBHvl+iCJWAV0Wb62rj56f38HoA9F4PCNr9/9+cx3bN/Oky/DrStKUhGRpBY/2zkXxu83edvWIyB+T+J1ycBhgd8ZpM2qUmsZpnlQ/T0OB/I6dsymi6h5YHSHzr3HeFMPyBPlz+Fa1B8nNDIByvVjqnJiwJ0ZK0WiXSHQCsGRFOkAvdRV5osF4RtcbvCP0zs1auQrBei6jJxGoDTB/BgrYqPwuhFXhcc3ruOOh95/C4Y2p3vDN7arUvumkyGTze1wUxO46ZLEyg7J/QUA9KkUrINa7/rjGQ==;5:02foxxBWUaRMM0eB/tGIu3tYQ2MbYreF+tWt2JRACfL4MaGvdIY2eGYZp46yK8t81v8CifeXPJ7JQ3GmizX4VIn/hzKw/r72BcnCf5sQYjNaT3SGFUrloZT9nIcs0K1JdWrMNzIf0DXcSNm0OYeBZQ==;24:yKhpah++w+gOFZWulp1w9VUwBH8Q2gMYNwQ5lYtdJGeI74hzV8O6tz1+ihj0RCNzbZAlUKQpWUNOx6izpEzYUSIl1bzsOa+Y3X/R2T2frBQ=;7:36Ici7ULB2nCka1hrTp562SYYs1ZnKfd1MzxM+7X6giFWQMoBFm/BZlHrSpSt/GBNgPb+si42moKjtLFjDiINN6l712WTdyu0njz0Vc5ZNLxsKgRD+KklMuL6LwLxXqyELY4nqg55iEFniqZFZFnEEps7Ss1BTM3PxsMQCUN3q5/QSrGdvasWu/sZe6gC0R+nKXXT3qCSpYN7MtuvXoO4i0ApYdjGVP2udJlLlE1t9A=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2017 21:02:38.1751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3503
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60397
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

The kernel message buffers, as well as a lot of other useful data
reside in the bss section.  Without this vmcore-dmesg cannot work, and
debugging with a core dump is much more difficult.

Try to add the /proc/iomem "Kernel bss" section to vmcore.  If it is
not found, just do what we used to do and use "Kernel data" instead.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 kexec/arch/mips/crashdump-mips.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/mips/crashdump-mips.c b/kexec/arch/mips/crashdump-mips.c
index e98badf..fc92e64 100644
--- a/kexec/arch/mips/crashdump-mips.c
+++ b/kexec/arch/mips/crashdump-mips.c
@@ -74,7 +74,10 @@ static int get_kernel_vaddr_and_size(struct crash_elf_info *elf_info,
 
 	elf_info->kern_vaddr_start = elf_info->kern_paddr_start |
 					start_offset;
-	if (parse_iomem_single("Kernel data\n", NULL, &end) == 0) {
+	/* If "Kernel bss" exists, the kernel ends there, else fall
+	 *  through and say that it ends at "Kernel data" */
+	if (parse_iomem_single("Kernel bss\n", NULL, &end) == 0 ||
+	    parse_iomem_single("Kernel data\n", NULL, &end) == 0) {
 		elf_info->kern_size = end - elf_info->kern_paddr_start;
 		dbgprintf("kernel_vaddr= 0x%llx paddr %llx\n",
 				elf_info->kern_vaddr_start,
-- 
2.9.5
