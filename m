Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jul 2018 21:23:36 +0200 (CEST)
Received: from mail-eopbgr680122.outbound.protection.outlook.com ([40.107.68.122]:5440
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994608AbeGCTW2O2bJf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Jul 2018 21:22:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clgXEaTRDRRUjCdv9qgY9qElexQm5+q7dwcVLUDuYIY=;
 b=SupUS8UpiRUGhFuDicV3xTNEaP1hgMi7c8F0MW2WTgEqOD2opN0rS/v0lDu3aiSSB1RyRHasok+KmgR39nn8fbwVizjk3At8DoEwf1lDtSZjP4QKIPLGPTB9Smgi8DVSsaqczWBfXbbDVJMF8BqHMPJNomnHoOqTH6/LXXY5OK0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
Received: from box.mipstec.com (4.16.204.77) by
 CY1PR0801MB2154.namprd08.prod.outlook.com (2a01:111:e400:c611::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.24; Tue, 3 Jul
 2018 19:22:10 +0000
From:   Dengcheng Zhu <dzhu@wavecomp.com>
To:     pburton@wavecomp.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Dengcheng Zhu <dzhu@wavecomp.com>
Subject: [PATCH 4/4] MIPS: kexec: Do not flush system wide caches in machine_kexec()
Date:   Tue,  3 Jul 2018 12:21:47 -0700
Message-Id: <1530645707-30259-5-git-send-email-dzhu@wavecomp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530645707-30259-1-git-send-email-dzhu@wavecomp.com>
References: <1530645707-30259-1-git-send-email-dzhu@wavecomp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR06CA0100.namprd06.prod.outlook.com
 (2603:10b6:4:3a::41) To CY1PR0801MB2154.namprd08.prod.outlook.com
 (2a01:111:e400:c611::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bca5210-53e8-4bac-2be0-08d5e11a4670
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR0801MB2154;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2154;3:RniBbPTUfYfaaS8BN00iOvg3xPi3jbefrjXTnSGZfGjZrK/2XQYh3exgPiwysLyabvRC10yskqh7VnXU22f9QWTdVeVJilWwXuRW0RnO82Q0C2a3oWxtg0mBLu91EIQN1YAlUUYVnuz1YD31PrX/EDcV41+GDRbkXXbiHZDDF2x45Z5qasfJ/L/+tBZWDhbt8/kCckO/2g5xmdarBJNTd+zrxW+rAJf0LOS229scHxz8z0H0rqtIRGMbG17AK8rX;25:OgFpBDTWf9/n+MB0dqV607prv4a5wa1LO7SDYkFN8oy1CaaneZzd1vdn378IuSS1VJefiS57dC6LkSSUNCpLwzjzm2/65h5wx/LtgGw83ltAd/ksDU/BbSqRaM1mtzdT+FyAsgPRAFdNC5zSJ42axuy2uGTrZunqe9js5GKff+ySwo9faiZEcjJJXAl4iomt2qRSxc5iL6pib+zivAUhoRDaAf+ToWJxAiKEMBuTo130k2TzU9bAmb+zVK30JxPaX7fJbPl0w6U0p4Unf8Gl0stBjS35KBXqygP2albmdwS86bHKwGJA37XoR/MNWCnb111jin35f73WEDS2T8/Hhw==;31:7ciVqWQuUa6kIjlPG1m12UIKcKWJKUNAcm+LllQEerVNsWspBwI78yPu8PNep2o5SuS1iw3BeqxUp86WUlCk82B99/mWM5+39hwiq0g+2vmthOkEyFKndbJMAXQWkligdvf35xhflGJkxtjNY7ovF+srwkUN8RyR+md/FPDDViMZSht7j0A8SxG4283IcbloLGqsj16YVkY7Xbjf1vZrNDpMMN+EPVNy0zUGfqu8HOI=
X-MS-TrafficTypeDiagnostic: CY1PR0801MB2154:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2154;20:zzkL4eMpvhfDyW7KY14RxtPUU5zoyvYMRpob41ffS2XFh4pgpo8KcgKkAxo4d6XPs3LDo3XQ3nHEA7rXhAVJMw6+YOpoJ1NrRHSFDeQytqwz5rj3AZz0niAsohZBNAcczHtupdfIniyT6t6X5MfHcJTaU+yuDYE3upeSQjWbqCIDL9euFxv/6P3XucRwDrkED23VyebsERGejP2FCBUvoqDXvKkl8r7ZjMF/7huUFu0XsrfRyihJdaZcjf8I8s9y;4:+79L27RMqI7njbENFxmh9MDRM21KyGj2lbPtmesqNUZ9+hL22jHA2kuSPe+cz+KVrpaoYdMMprE3q/iPMJNrf+iXJcDzXCoFofdjlH7wSySXIsLskftPoGmYHr7+jjMwORgb5nwPRu6u5iVDdlWTuuB9lbj+GNLwRDN0jm9KmmQ3kkz+ah+GAmdoAsh5n2NQ/AkOwDFUzqonS4uyMoSW9AG6u5jlzb5bhgGUSHLuuKM/Smc+IGl3wdutAP2KyMZkWY8kT3q0gFVNzdtkjSgZ6Q==
X-Microsoft-Antispam-PRVS: <CY1PR0801MB2154916C92F8622CC5F1CA00A2420@CY1PR0801MB2154.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(2016111802025)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6043046)(6072148)(201708071742011)(7699016);SRVR:CY1PR0801MB2154;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0801MB2154;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39840400004)(346002)(376002)(366004)(199004)(189003)(476003)(68736007)(478600001)(81156014)(81166006)(8676002)(97736004)(305945005)(486006)(11346002)(6116002)(3846002)(446003)(956004)(8936002)(69596002)(6512007)(2906002)(14444005)(86362001)(2616005)(316002)(16586007)(6486002)(25786009)(6506007)(66066001)(50226002)(4326008)(53936002)(47776003)(107886003)(450100002)(53416004)(5660300001)(51416003)(52116002)(105586002)(7736002)(37156001)(386003)(16526019)(26005)(36756003)(106356001)(50466002)(6666003)(76176011)(48376002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR0801MB2154;H:box.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0801MB2154;23:qSWeKkEMwCJDYpLB66C0aRrrac8wXXuQEvTuDC8?=
 =?us-ascii?Q?KATscSqcvBq6moVtcBQ9xSrabMF46igSBG0pMNamwKQIhhVGVw0uijWCr9Gd?=
 =?us-ascii?Q?Q/IRf5GAeK6P5Uhkpx8KWlSLPdDKJxQCyi/zkZaPHz0T6kGdYDnevH1XrMCk?=
 =?us-ascii?Q?YlZZVf4vN0vTVI5qeg4e98TFIpbGHlzaN+kSoSgDAln5eIBBGvrVlBbboG+2?=
 =?us-ascii?Q?ILTXCeitwi/Y+PkY9a2FRoZfRKhipj1AOvK8nN6RUHgvvWNwCsBwmz0VV8YZ?=
 =?us-ascii?Q?8cvkNP2f5rd2yQ5EWrwN+gixKrh8Fip8p9T1ChiRuqOISZ/HIcdwonFwUOgM?=
 =?us-ascii?Q?WfFODjLGZaVwr06xPBrY/Shu6/1rsuFWYkku0XEzBW3fuizDQcFaYtM0Zach?=
 =?us-ascii?Q?yTHdLEv6DK9LRoEcvDD2RM8UyectTnPBDEAWMxltkmQhM/qnIZkY5K5uTpnX?=
 =?us-ascii?Q?QKt98nRiL1c6EtPrGflSsdrS75uUoyZAk1V3a73+Oa60paoAyWfe1NidlVlQ?=
 =?us-ascii?Q?BQObmKgKcDA6g4ejANIlvyY0cPUQ6+ofVU5uHr7H5IBaEwZNBlNvtOjGvTFA?=
 =?us-ascii?Q?px0gCekzahNDElX98hRHhSch/4uubJIxwX+V9zawH+5Gku3dGKdhHMXdHQ9E?=
 =?us-ascii?Q?iKRkGhwWUhnzHRZfQnHoZB0/IqSvHsr6jlO20K6NnpV3NAq6Z3OY6NLJD9+O?=
 =?us-ascii?Q?zgnAsP1niwzybLe311fc/qoQa0aQDetAiE8tWOtohKX53MHvsLbZlliw9ho7?=
 =?us-ascii?Q?ecOlZhCyEClTUD42swNqZrsjgG+8N4d+ReYd7h6SSvC10Mvf2Do8MRT8ESM6?=
 =?us-ascii?Q?/sbeO3MmxsHLzymTriyDEWdNaTopTKXJwQgGV7+JwjlNNMc6Dt6n3JNad0ch?=
 =?us-ascii?Q?yQ0phZZbJrRcD6ClMhRJr+ALc6WmD+cLCiXNbaiAPcgJZPksIYWfmCPVxuEQ?=
 =?us-ascii?Q?szjUwHAVv10AtSOdsoCcszQoKqSYcQOJXU/8kcpN0/JgfNiDQ7KEh5tT4Ujy?=
 =?us-ascii?Q?ZIIp30+0ZY7x55SbzmGmoBSg718YKNg0hbpsrm+1Ccm7Sy15nglE9oji5y2r?=
 =?us-ascii?Q?D/bAGHCvFvoZfqbxiq/IsVL6y2+IN6BpYX18FFgXBxNpb6oowiUQIUG9hWOw?=
 =?us-ascii?Q?c72d+q4JcWUp0pGjPZoISpqyWcKbJM0m9yc6WODkCEQTFXaXBLjTJZ1dMFiL?=
 =?us-ascii?Q?1MxBhxDe+cVfeAGfx9HGuMdB7T5V1PsG99NdUtt/M5pCc518dnQWP5a6hiyV?=
 =?us-ascii?Q?VLSHO65Gc5bnFPvqP7Jsfp1HIgub+mBMkcsTlg+sb?=
X-Microsoft-Antispam-Message-Info: UVZpamLrVM+2IvhJN/3u9ekAO+EohPMiFZ3sGpemlwopHp9QFEcF5gnp4pfs8UnNbfKGeOZsn7iB89y02cZ+JZzUOT1NdbdEezuXT8qmaaaV6HEvujzF2Y6uEqA02E/MhYwaSl/W9K4RB7nNItOQbPQQ6bUB2SxlpNce89xJLQhL3sw3ZSGgYph2j6ADj7BEtm1GdV8+5bVzqaKLAXlPmBhZDSmKJGdI7LT0ChMkrMBA3W/tBLGyqsJvzqjKadBf1OVD8ajUtzc64nv1m9f8ENIAsRreFlHM1jYNnRhKisYgGqJnRKW3CmH9deCaOACcrOzaKfrtBmLWtPwLOKv9ulLPVmw4fQKNAgLvgswQG74=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2154;6:MeJFlpFAoPexfklvqDOxCoIaggTzdUFyUY6/kYnw4xaozkPWAwq/kDE8H+WfMU5mVFL74t+yDw/o+nlFGAn3ZawwQAQEJOTR76ta4/kzVzT1LjQSa1t5UIvvMbb8CFoGY3LURB5LZr5aPzFAqAGg+vKkPZ6gUt8h969HKVzR1bBo45ChTp6QsJFq+JfpGtTjw2+ozkpielIDeZKxOjidtGkNQwRiC8n2/ZzYA8RvEQ1iC/EtIsoSTgHg8fyaSST6gTTvNX0wWOl/K39jzCbfcbx7Ag6C7Vc1xrsc8tyfDD2S1l55uMoLI6bx1z7952Fz28gtQLThe8ZRFnpf2rLK6wr/fGVcBrXn42l7xJ9M04M/CW6A4o5WoJeEKop04vfH2dQSikDGoOrH0/q62nOYwiazkq6rI5pHyVZiKrGqZ4/MC9+7tu29eX1aCYLMKpMM1rWDpGOLaordrlK8xUf4ZQ==;5:hBQ3TPbHWB7fg+Xh+GU7JE1GcG34sCOT0EREt9aKhAIYpsyzJy4s12+XLrgPL7rQgjFarrCbfHd9RIWp/KEsyPvqXC4uYwa0FqZfW47EcA2PkhlwuZryE3AXJCCSAKb+M17XYvy8P+fqPoTBp+KMrJgdkfuc6z+IzxSITRUktbk=;24:Nn4FuYBr4Q0QdnGXwk6/fBBH8gWGMPHw8rNUWvKUTpiqv9vtWr7w6O/67tCmZ4GVSJN4fa68UQx6XJgt1rtGa4Y26wml5DqMD/DBsXblB2U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2154;7:0HvbeoY/rmOjSaDxlv53E2rJCuP3Vc7VHZpXF2FzyRAz+tzR+oIC4WRhhPddk38+NJzwwTq5esmYicRYg59bW+glmAmyJH2oF7leNoj/y6WH+P/VlDHi3rTSDt5h7XU/LIq8J6XphEWYF8b5yDsJ7wx4T0gZdxxDRWJoEof7mMc7ItrdDtfyD5SXrzwwBUUo5zY0hxLMbgVZvyC5AtlGinTL2Jp9K95Ke1oVfUuIg16cc3LcnESoFuiMwAGBT0aw
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 19:22:10.6265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bca5210-53e8-4bac-2be0-08d5e11a4670
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0801MB2154
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64588
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

Instead of __flush_cache_all(), simply flush local icache range. In systems
without IOCU, flushing system wide caches require sending IPIs. But other
CPUs have disabled local IRQs waiting for the reboot signal. It will then
cause system hang.

This patch fixes this problem.

Signed-off-by: Dengcheng Zhu <dzhu@wavecomp.com>
---
 arch/mips/kernel/machine_kexec.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/machine_kexec.c b/arch/mips/kernel/machine_kexec.c
index 48c06c2..294fae167 100644
--- a/arch/mips/kernel/machine_kexec.c
+++ b/arch/mips/kernel/machine_kexec.c
@@ -139,7 +139,16 @@ machine_kexec(struct kimage *image)
 
 	printk("Will call new kernel at %08lx\n", image->start);
 	printk("Bye ...\n");
-	__flush_cache_all();
+	/*
+	 * __flush_cache_all() is expensive but unnecessary. More
+	 * importantly, it could freeze the system as it may need to send
+	 * IPIs, whereas other CPUs have been waiting for the reboot signal
+	 * (kexec_ready_to_reboot) with local irqs disabled, because
+	 * machine_crash_shutdown() has been called prior to entering
+	 * this function - machine_kexec().
+	 */
+	local_flush_icache_range(reboot_code_buffer,
+		reboot_code_buffer + relocate_new_kernel_size);
 #ifdef CONFIG_SMP
 	atomic_set(&kexec_ready_to_reboot, 1);
 
-- 
2.7.4
