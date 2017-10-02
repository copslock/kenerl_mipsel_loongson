Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Oct 2017 19:45:10 +0200 (CEST)
Received: from mail-cys01nam02on0059.outbound.protection.outlook.com ([104.47.37.59]:16645
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990408AbdJBRpC6yiE4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 2 Oct 2017 19:45:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0TcKeYje5VrYY4chB68ubG10zHBBaGwQAQ7MSZAksCo=;
 b=ZweRz/wvWQMsxb1V7puoMCNGAhtkeEC2OLulP00vpVv3sEZ3EooN40/jrdHxeziJoCyJCi2aGPUEfQ/eMU+amrRJ43oFcR8iE/ZFfYiWxFIxwPMtOUm9MQJ5N2hndVbLSi8i3cDHqAfUiP9MSv81jApghoSYAac7+NhuQqyq9XA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 DM5PR0701MB3800.namprd07.prod.outlook.com (2603:10b6:4:7f::22) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.77.7; Mon, 2 Oct
 2017 17:44:51 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH] MIPS: Fix sparse CPU id space build error.
Date:   Mon,  2 Oct 2017 12:39:49 -0500
Message-Id: <1506965989-5043-1-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: SN1PR0701CA0008.namprd07.prod.outlook.com
 (2a01:111:e400:5173::18) To DM5PR0701MB3800.namprd07.prod.outlook.com
 (2603:10b6:4:7f::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d9b205f-00d8-4a27-8482-08d509bd48fc
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:DM5PR0701MB3800;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3800;3:qPsd+geyE3+DG6Q6CeF45LHYKmAR6mRDDGG+ZhgPIJW+lewSeRDkBC/EKTIeB0rXRCoB2qWvo7fDGzxLSk5SHz6uYOxzdsz/gc06TWOVlaena1N0TiCw9Wmsj0790uuEjJubPlpXPDoht8+1NGX9tBrZLAZV00j41s9OHoGyWg+kK5wn2VhyZjCujUslehuTwgXBaW8CFu7894kRHUJz69GFCNmZJTXvC29bILiWCWBLxFDh183byFXhhZo7QdaI;25:FxvWNzaRfZxjpdyAVofYtc/Av3x6Sjtfb5QjrFC5fw+LTKo3hNUAF732fu6ke9n1g7M1SytKpfboHcfR81NhqMePFblLpySysw6PQWSNPlbs1NwGaGiBFdFViIpFqiSOSGUQk+oCKsNVJIrUwuf8Tgi+UhCMbggrI9i9s3QtH/nlO7OhQH6ikaRJxaNvwnjJfckkZqyIYF9vBc4Vou1v9okYGbgZTQy6z6NE3rY0dt6sn2nIBEnkcAAds53/GjBEiIFG2tbHniR27vDKIJY9pGsRQDOPyxG23s1nBmkFyNrxYf0DvGgTIs1CY/e15uz2U3EXz5pvsETJ11YwY9m0SA==;31:3RrORQ+7X9yEa9GkCYXtAWojmc7ydBAinH4IueZ2D/yxTb3BAqW5iBm1FKgQEefvbAMh2VVdqODJIaNbA3VDWSVTBMimB0NTe0SIG+z698MvB2S6DTtbs9MOPHxZ1SjSPWS9yI6yRVTiKu8XUK4KTEcBm/XjNt7LVlfEnLSjzmAks58d1isMnjbxBOZJ08R5aie9o+0XgaBejLuoI29tThinMM7A2UVeyhgWQ8vNfnQ=
X-MS-TrafficTypeDiagnostic: DM5PR0701MB3800:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3800;20:1ge09kM9O7pWmmBR9YsNDAGkdsFfxeAEOsRxOGE35r6QexYPH+AzFBEK6JfPy8V+u6tqwprqORe/euKMKWqFrAPukMyERlVyhTA8dnFbr0WKm6RFlJEUPEXZtSJhyzJLe2TQRtGEFxomi2tmur3H9Kcv+70BBhyk6VOol+fsGBPPf3F4wp3P7C9iWcSbXFdXo9jW4+8zCe2QpMnfAsFgKP1PDf2NYN4YBfas0BgbMZ2PcQfm7L/APL9hDJc9bYihqgY9oyuFObRK8I1LSKXJiVl7m99N7Mg+FTq691HMPOw1c+k9nVpNnWM90L56JxIYmamxcCiE9u/vHvZxCiKvsmgQ7lJcZED3HZB8mAVLreJaLvr34TA7Rbad/7XkeU4Y/qFqdSmq2iQLmwysfQcmefglENhjumQ84u5GrDZfBFx/UikQWpLWF9d98IjRIc1FUYWqw0I5jnTJNIAfi3iMqZKvIyTzC5Z4bt5mhFtgNIRe0ke6nupPxmx4oOAKm0Mj;4:9yrwWh2JnFACHXahspWkEIXRWSPnOaMHAVie5NCVeIPyP/QW0/pHv/Bw7P08QpKb5K9RPjbveP6a//31UTrvU9XIsSHyQmOSwxNCFvfa/kMR/8thABTQeYRaTGcBNgpDX0s6SBhyxK8kvPJA/MgLUS+4frlffXNBZltJG106xY8UZ90Y+fKcNyRDjBsqZj7aL0FVr45xk3ifaVW3S8mQcYYbAfzuMc5q/atN4DJJv01MITs2gOoHq/+CC2inBqkX
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <DM5PR0701MB3800A07C4709553D5FA64326807D0@DM5PR0701MB3800.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(3002001)(6041248)(20161123562025)(20161123560025)(20161123558100)(20161123564025)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DM5PR0701MB3800;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DM5PR0701MB3800;
X-Forefront-PRVS: 0448A97BF2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(376002)(346002)(189002)(199003)(105586002)(33646002)(53416004)(106356001)(2351001)(72206003)(2906002)(5003940100001)(7736002)(305945005)(66066001)(47776003)(2361001)(189998001)(86362001)(575784001)(50466002)(48376002)(97736004)(6506006)(478600001)(36756003)(25786009)(6916009)(5660300001)(69596002)(316002)(3846002)(16586007)(6116002)(16526017)(50226002)(6512007)(68736007)(101416001)(8676002)(81156014)(81166006)(8936002)(53936002)(450100002)(6486002)(50986999)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0701MB3800;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0701MB3800;23:d8Qq5ZvLt6eHB93DhrgtL4WPnkjKYf28861bOex?=
 =?us-ascii?Q?sVW30NbGmdfg39O5HOZ1Z3kaHTThfRjjoR24uuTW/351+hTYGoVULAb3WCBI?=
 =?us-ascii?Q?Jv5R1iGSip+6/5ZrhrsNvnsGR+JRJIHEUnZEFTH5fswYI17wY8zh+VlO3hVP?=
 =?us-ascii?Q?igk0JRC5syr3RfoAHFEJkW/omv3W88E75m2gOj6pwv5LcJDtBQuNh9e+Qu4Z?=
 =?us-ascii?Q?8fpdu55wx2O6PcjkZeC4mAvdVvUs3bxNfB3ydjOLAJixnie2BqKRdyTM16ni?=
 =?us-ascii?Q?yOBab9695+ZE90PkGa7HR0fOJhz0RZNBpCo0p5mtcaPeQn/pAU6ZGt8pHgYn?=
 =?us-ascii?Q?L9pdo5onhmbAvdyy0O2INUNv/d4RKxvRGGfzLDbW+2EhIyiVOiXUDXxLeUcQ?=
 =?us-ascii?Q?LcYo5l3W5JFfKlvaYgmZfdS5kiAWkPXQzf9dmf4Q9HHiUHm34kDJHVTMZMd9?=
 =?us-ascii?Q?6fr6jUF2+3tmAxKPsJ63JzKcH8c+RmehuvvINzPag5y+JJWe7NsVyyYib/QZ?=
 =?us-ascii?Q?a7BmKMi2GqPvu9tf1wrsdXKDatxJf/9eR4rIGby4Jy/hi1up8Frt7km19bUb?=
 =?us-ascii?Q?xoxp/0hg86+hPDRzoB14cmX87VOZVLAlmm94s1SkH4751+0crHKqUNSvfG9K?=
 =?us-ascii?Q?uUgGQe5hsiMuIyf3wedy+208E1YrCCS+mymTHZQ7cQawTrfzR64e7wiwEbST?=
 =?us-ascii?Q?BSCXQiuQatpwrR5R3o32aMGuGPym6rlaXenaIY/9PU8b4jNileTH3agG6qcS?=
 =?us-ascii?Q?u0blS6vjb/+EUV6i+uSQ358C8WyveXARogoJZINv+CiKcdNxZ6Kmdmyglp7C?=
 =?us-ascii?Q?Yonnd4UMXrdsJ1V7ntUSq6yOvUvIISkm3VNmMMJtrRK7LgrHad+oaV3cFsKc?=
 =?us-ascii?Q?uCRnQH32vRUXSjZBVurVbnJwEbwccyg/t07VrPsoAAZHPPcFHAujNc0ypKed?=
 =?us-ascii?Q?yQ0KaGQ+9dgHu9Gq5Fdhq9s4xLKwzsyfavd+qmdaImWmq9LIvNKmdCDORy/L?=
 =?us-ascii?Q?dreF1eZ7KrhCwXfBcyd/nNlYN2NNShgP0kbXHdhYpIeg0BwYp4TCo9aFN4H3?=
 =?us-ascii?Q?ADQ4tXicCtwqHeVkhq7s05sEe1X/7PQ4vNR1vuJLSpg3IJn94Z4B5SCvSEtU?=
 =?us-ascii?Q?k+1BcB6PibhUlis/Nt+EOKyqVffK4iQVF?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3800;6:yGxQD51jmJhTvQ9dVNWSiLPm6AdTsONa+98MUA2z/1mjIV6QO8mCd1qFi9w++UCdYxPNfa5OVDxDRJp8VRPDMm2ybP5jsurEH6P+Jpcqes0ZeivvvCC3LcfuYPzYFWTlbrv3vTzQElGPj1o8ddgxZG8ZQ9v5zu2QS11TLSTASWzZJUwqJ4eIqPJ4d9tijHSM+wK/0tvoVootPy5Hg9hWj1HOhxdVVjPef3tygzAuVzyty7onE4Gu3ypCk4ESgJQOP8SzargmvBcdrvbqHkxSXhd94eApU9P93mp97yM0L9+UTt6uJoR50RoidzMYsY3H+92UaGMgf4jSDmJCz4ktGg==;5:EGmDFEEIwOTLfpsBBv9ZFgTsDGmMveOrVzOtPcrkgGEYWfORBHlOCIGKTl3FfST11UJr3au0Gk5EWuKnU3IjdxGCqJbeff5ZuIVQ7OP6DJbH2vHT6JbPC5s/pL7nIZEmX5ZiJ8/SA7hOiiTG9AZO5A==;24:LYqfqEpQ92O4KhrVRSj4ltmh2AbWG4FFkiO2ikoRbFHnJqCpAcPXzH+tCbgvGUX+GRCbkXzWHGxzSks9kzUwxK9gR52Bfyna3sx2BpwR8HI=;7:wp3n6+3owpnNTc69c63amZT5kRbhhk9qzKRlR1UgFi7OvrM/fXJkY6XV8RweVwwJGmPBCyK/4Q+cmSglh1wXkvsU/gjwW60xuAgFDAxe3oRRkNemv37/u18hK87xD4QXwcTi4jME6VrscHcfVFxz4Yf+WufvvNjO/aRYk7Oynzs7M+1Gebnuusyv3XFKxrMTJogl7m+YQKj3xXtVa9MHcSp3GIzJAcpilxwFihLPFpw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2017 17:44:51.7458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0701MB3800
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60218
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

Patch "MIPS: Allow __cpu_number_map to be larger than NR_CPUS" was
incomplete, thus breaking all MIPS builds.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
---
 arch/mips/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 87ed0ff..da74db1 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2726,6 +2726,14 @@ config NR_CPUS
 config MIPS_PERF_SHARED_TC_COUNTERS
 	bool
 
+config MIPS_NR_CPU_NR_MAP_1024
+	bool
+
+config MIPS_NR_CPU_NR_MAP
+	int
+	default 1024 if MIPS_NR_CPU_NR_MAP_1024
+	default NR_CPUS if !MIPS_NR_CPU_NR_MAP_1024
+
 #
 # Timer Interrupt Frequency Configuration
 #
-- 
2.1.4
