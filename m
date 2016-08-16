Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Aug 2016 08:23:44 +0200 (CEST)
Received: from mail-by2nam03on0085.outbound.protection.outlook.com ([104.47.42.85]:1314
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992886AbcHPGXLgIbQl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Aug 2016 08:23:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=P2GKfGbrguiMNPhq2F4trmBh0Gw+gUvRR5sqeA/CXuM=;
 b=HZZmI30PzZ+9LBpOxdGqDhBetxdJ8kWnttjS9kh8cnSrvH+bXULRZ4GaMO1qAeVTrpOb9UW9VoQBEnc1SX3HVkOCcD0jPyo/TaQ/XcTHAkrfWuOEZsQbQN1gTx2He9hzN8DMIhGoqCu8n2+lBgcQGSt/zYFnuNCyVcNIsNHpYvw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Belits@cavium.com; 
Received: from abelits-laptop1.caveonetworks.com (50.233.148.156) by
 CY1PR0701MB1693.namprd07.prod.outlook.com (10.163.20.27) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.1.557.21; Tue, 16 Aug 2016 06:23:02 +0000
From:   Alex Belits <alex.belits@cavium.com>
To:     <alex.belits@cavium.com>
CC:     David Saney <ddaney@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [PATCH 1/3] mips: 48bit: Port of commit 1e321fa917fb2d30d39ff1c6ea89d6f1cf4f34a5 to 3.10.
Date:   Mon, 15 Aug 2016 23:22:54 -0700
Message-ID: <1471328576-16758-2-git-send-email-alex.belits@cavium.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1471328576-16758-1-git-send-email-alex.belits@cavium.com>
References: <1471328576-16758-1-git-send-email-alex.belits@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BN3PR11CA0028.namprd11.prod.outlook.com (10.162.169.38) To
 CY1PR0701MB1693.namprd07.prod.outlook.com (10.163.20.27)
X-MS-Office365-Filtering-Correlation-Id: b6cf90fa-acec-4333-7d52-08d3c59dc75d
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1693;2:T89u6HU5jjuxMsqOte9xf4MkaP6laRfAf7FMJGwA7zDvOvLR4hM2QJllLz1rK91LypWopD30Omk38iUHZoGXBsXT4SDPSe5B7GB1B+4Ehm/RIXUxSG0F7TGkYoUKnwfVmf01ubOR4zKZpsjhtoTP5drQVN5aRh6IXWqz33mFfBAbA7ao/Ch43ySPD8ZpdmLv;3:YTTCE052LABjCtF8p0kU0yr9R/9i8BbjPuRT/DKboY59jVvSnn0M7qJxsX+OJRHN7V+KqYXdUpJSQwItbmgKqPJp3xvyellGq5M/NKncsJNO8sWJdV5qvCPUeDtLsO+Z
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1693;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1693;25:HDGzJYsHa9DjEBrkMY5xFVYaPCnAesmDD9HfcowU3k+bmSxOrogh5+E8fbZHWUvu0fOP2/QdNmySoh/bsrGwRVsGJN6EckpFiOZ0nqbaCD0RQcYIgg2oyW2kwt4IM9QWkgwItSH8U+2nXrEL3yhKx1jH9dbGlhZsLGZi1Dqq5VdjDC1QGSH1RrgWZCtc/h76BQ6gJURZirM3IepoYz3lQ9YUoCrpIGBO5JBbs8hD07zyw1HYC7yhCu3B8XX2mVVJqjXXDqe8s2XTSpWwetT7cakrkWVuZCoqOOEuex4CbediYrO0g29qP/NPzQ3TfpoGM5leHlfZhch+22X2SYF2sBNsTt4h46yL99GZJePc4d4tsHKFNq8dRI1XT6mXvVRQchF35osd2hTyjc/sw63J4XT0jY46eggo5dxAAZirMuvTRTIe45v+dKaGXbitwAaxn/T2rWXVQYZT/hgyBlntijBfj6bDt4RYJs5zdEYoGvsJlG6OIHt52Vl6d/T5umIVRApuAFsvHCyekc10TNyFXXi3nIBbSwzzE4i0Xg62Llv28w1n3z3sOz8MPsumiNYnc4QS6C7zQWPTCAeK6vS4lI96+9cbia1rLHPVjQBbPm5XrUaUqlz3o/GzmQZRX87fr4rK8bxvPKjLWeNIoS1PmiS4KBsetBC+Wfv9uXXjwlVDnAyXGVIX3AOQagJF1v17kqDUELPoy/m8AIJwxvtENQ==;31:qzxgF1UqzfeM9vHiEEEDN068yk1+6l0t5hbUikkLM1NEEN5nZ3nkZAPwq7Mcd8Q11o3ehaGBuAaSEZ1FM4SLMZkmRw2uQjlfqPGArzKH2YygcBjBUc5nMGTJdsU6CCfPUPxEhgx+C50e0KDKdrVdfzuhVZDrlG52PNvAaTItI4gAYxuiIFkMTiAPGLK0+ErGuz90a0auEr2RB8pahCejNXymnblOcq8qZxrEUCq4eqI=X-archive-position: 54561
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex.belits@cavium.com
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

X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1693;20:pj2u5U6JfaG+RFVJZpC0/Gmw2Rs7mMzqX1jpYK/AxAayeEVS3bbk838JejDi7t1KeUffT7tpaLz5+Lr/EX0HxX6/Jjl4K1u3PEkpYpfY2VolE9xfwKODWH9qTnX7cz5ob5LJERag3IFh7KLUn8Q0eltL5qQCpH665obEN4VictQMzEV0FvvqobNGMmrLy+ZXcSUwJ/a8JZCJB+EZ48reNNziLZh2O3EtJ3AonmQo8q7ov2cqSVyhi8lmlNFKqRaoF1jSoY0OTgni6ADmPWLjfJMf+W3f9jHWh/ayi+h6sARdKnY3C4XtKgCpg296fDvWv6Od8ijs+FOJsgPDHt6MmuykO2A5JT2e3hkeDcABOGb4EyxkPNPoGT5Mikf6Dj4coR3bGOBKw1+r48MUklk7f7WLAzm/xoGJDa/GQyGc37v50/Nfy2U8jWed37v8Gp5MwZq5EhxUr/6TIURV2B91ygr2Z0GWRqzJaqQUK/9O+SOevcWTAWIJlB4VlPe6EYyj;4:rD8i/a2Yh3I/BsdXRdx3X0WYKSbV0hQt/TLVCZX/povkQujguk7U1w1dOzcUW/lOYfDfzWAOKahkcMDANB7SmxQ50U8jJHm1yAPvVefMeWau9W7NKC8woDdGShsay8vYOYM/KCyLV4q1oP0ZmeGbQBCd8OSkmqVjNXD+e7w711bifqxRWE4WNtBM6I2wMeLrLT8hEfzgYETxptONknV9LLDjVKH4z8RRy+b/f3zh+vr945/qgtA74/xgHmoA2pP8qpmm8XyVgymDed2W9CWshQdFeb2EkJOxWqjWhjjLe4QMR5NneL8Uu88dL+csfbESeskrcLbU9eHwSo+J9qKf1BSUoP/0uKIYOPODhmA3942FzzXw6/+/6aeEAm9j32BvO5zOSV4rlKhR/3u8PjHhRQ==
X-Microsoft-Antispam-PRVS: <CY1PR0701MB16936AE92ABECCCA118BEB958B130@CY1PR0701MB1693.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001);SRVR:CY1PR0701MB1693;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1693;
X-Forefront-PRVS: 0036736630
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(189002)(199003)(97736004)(2950100001)(19580395003)(110136002)(189998001)(33646002)(450100001)(50466002)(8676002)(48376002)(66066001)(47776003)(2351001)(229853001)(92566002)(42186005)(86362001)(575784001)(105586002)(106356001)(4001450100002)(5003940100001)(77096005)(53416004)(19580405001)(69596002)(101416001)(76176999)(2906002)(6116002)(3846002)(586003)(7736002)(305945005)(7846002)(6200100001)(81156014)(4326007)(81166006)(50986999)(50226002)(68736007)(7049001)(36756003)(15760500001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB1693;H:abelits-laptop1.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0701MB1693;23:nHfZ6P+1QI/sC0t7G6vl6IJjVcytatx2n3K1B9L?=
 =?us-ascii?Q?ifbrX2nRw38vbfCHbDZfXT8CJOf9ADmGMW9Dv6M3nzhBBOlmO9lfg8tAzZbf?=
 =?us-ascii?Q?xUuuw4wUDBhmlP7rq6QEsxNHFKOrYaeE/F0o01Ee42Si7E0feVlaNh+x36s6?=
 =?us-ascii?Q?L4JwGNzrDhVJjPuNsV0E2MiGVerH9D1WBmeUACcI+P4IVqXo2auSi64eEtGD?=
 =?us-ascii?Q?SaSbXRi6fckEWponRjgAVEKXXI7UTuVUq/R9/JT6OLgmlX/OPzhVmybH2e1F?=
 =?us-ascii?Q?wwWm5mmTQHYAmLkFCi61QoDD0Pshfslc60pfRG6OctIMtS8HX/pOY/sqUzTg?=
 =?us-ascii?Q?vpX0f53vLbjf2O0uMqx/QIw1/FmCxnTnuidd3SY/hh6198M2BivYv6gS0Mkn?=
 =?us-ascii?Q?dQSN/GP6jEruqGB0ZWGBc4B02QkbaGCMcDCLx7KTKKp5LLPr8oZGpmwMlaBF?=
 =?us-ascii?Q?nhIgUXm5+naa9rTcdvsSxC9v371aauertuz56ptsyOWJK3+6PnrG+T6hjpwu?=
 =?us-ascii?Q?7qQLFFWLg1cJAZiJ6amR+soyyqMhjgXgmHUdFI8Zlf4Mb1SWDc9s79hGxEf1?=
 =?us-ascii?Q?twMz2iMlsZstPKIqDIWkyLoQzU/xIjbzAlpmQd/tjtPcbXPe8J9iLJDcwRUV?=
 =?us-ascii?Q?Nkx3Td/sKZKMj6eHeL7fsNOZZxq+EwGv9JtAnasA3Ksm/UyzYt46eH8WeC5W?=
 =?us-ascii?Q?am+XvlesMDfrVu82Fg7T4gdnK0d46GV9SGLbg/Zeq9z208p/PAMM3w5Wjakd?=
 =?us-ascii?Q?uL8h0Z4tSyPpFTJhE7lpzS6Y26O1xxUBipxo3OMR1n/nNKX1zPJ/5PDGUlXD?=
 =?us-ascii?Q?33QrrMaieOYmPKP0aKyTQfdZFkRrgYB29cqUrLTXDtfNQ/qJYlibCaohRejm?=
 =?us-ascii?Q?S8I+XivtA/xURjc38FMAOOrEKiZQ4WcffNug/Mph0MN413l0arCFpy0mz72j?=
 =?us-ascii?Q?JhJUoxmc+gsWwLBZxvExKPRHrXmqujVYYd+UhmRlgSXFOJVKs/b4go5iCKpY?=
 =?us-ascii?Q?kcT16G9bqsHe1diNkqeihk5T9ahD06XVbZs1G7VopVfp5qSfM6WNbdN0COsS?=
 =?us-ascii?Q?U7jWqX1XW8/YHgAw7Kn2CwEsMjRXC367iSWcYYSumlz7cWSc6k8XsZPhlbJF?=
 =?us-ascii?Q?9tKxXy0iEW0QGpC4OhrAfSFNPSBGZ7GTvQCTfqwS64LsHyNcCiWwDltdJJYW?=
 =?us-ascii?Q?0ceiTrgQ+dAD80rtRFT3Bgo0YNTSO7fvAE7+hgHsETLW3U23iv0UE+RjKk4h?=
 =?us-ascii?Q?wTo2b4Xu6f21rEIUJmu/bbsrHu398bSyTzd333a2i?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1693;6:CjkDwhvyEwjIPo7v90FiXPzowtP595GMETZDDXgRC4o4U0IM9nqVPXbIZLw6MO9zEMhZGWqb0619JKR1pM1SeKePdMxZiJGttGYX2ONQaTS8NYAfJ8g53p9HjpILTEgvd31XqOgi/VahHlxU7mKxutMrtNaxKpQBszULkrCJ7wf9g3cmhpc9Sc2lE2H1jgLtVBkpDxwMSbzuopI6+mKP1O8/nO0uGXMZP9v9aUeZHOuDYbmy5vvgfjeQhVvHMaOFV8TmRXtD1T7ajqQ5ROjErZ901x1SUEkxXH3jcPralnY=;5:Bq6jAuyl29CY4wkr0LcVobmoJbUp5Oa5oEE16sCeYkKMyss7x4W+jSLqieIrS4Sjxht4kbZN9FxuyI2UR5fNHs2Gw182n8Fsruh/dICRD8QCqeBhMOHBBbXQJHASTWPlmdfMztYT619LiJJ/qp1S1Q==;24:A3v1hvUtX8Y0if4AoDFKF6aiHmtBTznSOTii0JGSvp6kQP8xTTKq+hDqgUgUi6jcteowAKlC6lK0x+BUr/AZTZGecACE1ky5SJBOGbkhyUs=;7:qxiup/EHslO15cwBgm5wvfJYZC4XS3v4yDxLh8cZHNWSLXf+HHmYrTZvg8XZnsaeV7LfErtngINE72euot9fxCBBvx3Kd+u0hKsLJTHNLPR/PBulQs3O4+0oofQoUQNkbYi5EkDaXKMJESEVGlQ48H0wC3uGUTsaw2t1tuKj1DgpQL4kB1N471hKZCuNASd4WQx5DtlU40l4B9I2d3nABGCEtwGPSl75V+wfC2NeVEbiKKkLdgUHPTyn5d5gEhxp
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2016 06:23:02.7395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB1693
Return-Path: <Alex.Belits@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org

A part of 48 bit virtual address space support. This update adds support
it for 16k and 64k pages.

This is a set of patches to add 48-bit virtual address space support on 
MIPS to the kernel 3.10. It includes a port of existing patch for page 
size 16k and 64k, plus support for 4-level page table for the rest of 
the supported page sizes.

Cc: David Saney <ddaney@caviumnetworks.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org

Signed-off-by: Alex Belits <alex.belits@cavium.com>
---
 arch/mips/Kconfig                  | 13 +++++++++++++
 arch/mips/include/asm/pgtable-64.h | 18 +++++++++++-------
 arch/mips/include/asm/processor.h  |  6 +++++-
 3 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e53e2b4..2ee3067 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1756,6 +1756,7 @@ choice
 config PAGE_SIZE_4KB
 	bool "4kB"
 	depends on !CPU_LOONGSON2
+	depends on !MIPS_VA_BITS_48
 	help
 	 This option select the standard 4kB Linux page size.  On some
 	 R3000-family processors this is the only available page size.  Using
@@ -1765,6 +1766,7 @@ config PAGE_SIZE_4KB
 config PAGE_SIZE_8KB
 	bool "8kB"
 	depends on CPU_R8000 || CPU_CAVIUM_OCTEON
+	depends on !MIPS_VA_BITS_48
 	help
 	  Using 8kB page size will result in higher performance kernel at
 	  the price of higher memory consumption.  This option is available
@@ -1783,6 +1785,7 @@ config PAGE_SIZE_16KB
 config PAGE_SIZE_32KB
 	bool "32kB"
 	depends on CPU_CAVIUM_OCTEON
+	depends on !MIPS_VA_BITS_48
 	help
 	  Using 32kB page size will result in higher performance kernel at
 	  the price of higher memory consumption.  This option is available
@@ -2257,6 +2260,16 @@ config MIPS_PERF_SHARED_TC_COUNTERS
 # Timer Interrupt Frequency Configuration
 #
 
+config MIPS_VA_BITS_48
+	bool "48 bits virtual memory"
+	depends on 64BIT
+	help
+	  Support a maximum at least 48 bits of application virtual memory.
+	  Default is 40 bits or less, depending on the CPU.
+	  This option result in a small memory overhead for page tables.
+	  This option is only supported with 16k and 64k page sizes.
+	  If unsure, say N.
+
 choice
 	prompt "Timer frequency"
 	default HZ_250
diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index e1c49a9..a86bb73 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -17,7 +17,7 @@
 #include <asm/cachectl.h>
 #include <asm/fixmap.h>
 
-#ifdef CONFIG_PAGE_SIZE_64KB
+#if defined(CONFIG_PAGE_SIZE_64KB) && !defined(CONFIG_MIPS_VA_BITS_48)
 #include <asm-generic/pgtable-nopmd.h>
 #else
 #include <asm-generic/pgtable-nopud.h>
@@ -90,7 +90,11 @@
 #define PTE_ORDER		0
 #endif
 #ifdef CONFIG_PAGE_SIZE_16KB
-#define PGD_ORDER		0
+#ifdef CONFIG_MIPS_VA_BITS_48
+#define PGD_ORDER               1
+#else
+#define PGD_ORDER               0
+#endif
 #define PUD_ORDER		aieeee_attempt_to_allocate_pud
 #define PMD_ORDER		0
 #define PTE_ORDER		0
@@ -104,7 +108,11 @@
 #ifdef CONFIG_PAGE_SIZE_64KB
 #define PGD_ORDER		0
 #define PUD_ORDER		aieeee_attempt_to_allocate_pud
+#ifdef CONFIG_MIPS_VA_BITS_48
+#define PMD_ORDER		0
+#else
 #define PMD_ORDER		aieeee_attempt_to_allocate_pmd
+#endif
 #define PTE_ORDER		0
 #endif
 
@@ -114,11 +122,7 @@
 #endif
 #define PTRS_PER_PTE	((PAGE_SIZE << PTE_ORDER) / sizeof(pte_t))
 
-#if PGDIR_SIZE >= TASK_SIZE64
-#define USER_PTRS_PER_PGD	(1)
-#else
-#define USER_PTRS_PER_PGD	(TASK_SIZE64 / PGDIR_SIZE)
-#endif
+#define USER_PTRS_PER_PGD       ((TASK_SIZE64 / PGDIR_SIZE)?(TASK_SIZE64 / PGDIR_SIZE):1)
 #define FIRST_USER_ADDRESS	0UL
 
 /*
diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 1470b7b..fc1c0af 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -71,7 +71,11 @@ extern unsigned int vced_count, vcei_count;
  * 8192EB ...
  */
 #define TASK_SIZE32	0x7fff8000UL
-#define TASK_SIZE64	0x10000000000UL
+#ifdef CONFIG_MIPS_VA_BITS_48
+#define TASK_SIZE64     (0x1UL << ((cpu_data[0].vmbits>48)?48:cpu_data[0].vmbits))
+#else
+#define TASK_SIZE64     0x10000000000UL
+#endif
 #define TASK_SIZE (test_thread_flag(TIF_32BIT_ADDR) ? TASK_SIZE32 : TASK_SIZE64)
 
 #ifdef __KERNEL__
-- 
2.8.1
