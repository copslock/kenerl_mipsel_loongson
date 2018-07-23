Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jul 2018 16:49:22 +0200 (CEST)
Received: from mail-eopbgr700104.outbound.protection.outlook.com ([40.107.70.104]:55469
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993006AbeGWOso6LP-n (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 23 Jul 2018 16:48:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0J72qbLdukilcKdU7Z1icZVPXM+kTBzHuoaXmBN7wY=;
 b=axNSEy1xYcIGNokklk4OoNoiZPD1hXlFLMHZmSDFFp3d7RYOEns1z3W6hkYyIojSO3NIZnkaSNLU2CFSxPsGTDMg/q4af7dAEYQJQdCZJat+U6dkab3twIiNAf8aFpax/4GYSfNA1AOezQ0QCZnLjOjWcd3TfAfVKJMV3qU5+w8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
Received: from box.mipstec.com (4.16.204.77) by
 CY1PR0801MB2155.namprd08.prod.outlook.com (2a01:111:e400:c611::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Mon, 23 Jul
 2018 14:48:34 +0000
From:   Dengcheng Zhu <dzhu@wavecomp.com>
To:     pburton@wavecomp.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, rachel.mozes@intel.com,
        Dengcheng Zhu <dzhu@wavecomp.com>
Subject: [PATCH v3 4/6] MIPS: kexec: Do not flush system wide caches in machine_kexec()
Date:   Mon, 23 Jul 2018 07:48:17 -0700
Message-Id: <1532357299-8063-5-git-send-email-dzhu@wavecomp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532357299-8063-1-git-send-email-dzhu@wavecomp.com>
References: <1532357299-8063-1-git-send-email-dzhu@wavecomp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BYAPR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::34) To CY1PR0801MB2155.namprd08.prod.outlook.com
 (2a01:111:e400:c611::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edfd55fb-0884-42ea-2f59-08d5f0ab5d98
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR0801MB2155;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2155;3:6dI9TaEG+DGpPHqf/rh87syovweoX9RQWmzoHpzysmZL6zC+UvXXKd2heqOAhCVkYQVm0PgR47oI5JR1jjCYrap01eXESmynpQ9V+Gu/hkzzZXwSEQ19nya6a6OU5hThM0nHdazhyyjOIX8lpoOn4Ik4gAzlr+Ew+hSUGEGnlFXxO/axo/COJNvqPoXnfmXuQmXUe/EUoSgBI6W6ngiX6j1BJDx9qhgaT/UGeMk9L3rQDRisjmk64W7CKQtjw8uC;25:xTYQrJtJnrwB8sZSwl2hgIdP+j3y8R7hXJfk9zIdaLHxOGcpPEW+T1cXi9NWm/UBse+4/2kKweWely76/wiD2d3AQIr/1BWkI8SpBRDw8UsQTVXGVqQU7i7Vp7Sne+CmRN2Wh7Wh/uZpVIUF0WlUboGJLfph84SBCBgndZxmd67sgPmJiKAV8tdqL4Guh6IlUpDR93QJQemvH7Fm4T0U79ypVyNVtzDG5LAVuV8YL1sD/iERx5Y/Mpl3r3WXBu6vBsCIQoq//Om1/ArNQhvzCa3HsCLHQv6EVoD+LC4eGyoIFb1cP6pFJaozxxVrxGqhqb3Tq2PqQbVCPVMpqGhkmg==;31:z6ftnCMZ+CwR/OC2ENKNezRfj2YdHBXYg3QPfDcZe37DPpa0wW2VkDCTqvMb57cONoexwHmCCPf2os5lQnJNNHcPvbUfZgY6vHH2z/6635pQssd/5Q18V+xoZGqjd8UuAX9yPtl+2vVS9rJJ9XDKKpzGMa0p+rtDKN8NzvwFScfJ6YBSEl/EsR26KKeev8eGPZyvA1YLMgKumezW9M3G1jxFua1cCyvJX6JZ/PJn4j0=
X-MS-TrafficTypeDiagnostic: CY1PR0801MB2155:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2155;20:9oI6wVtE/yu4U5T4v+DUpgLi80X/DWak21LGXqioWd8NlwgcUUzoyxzwto4+e7krETZGLr5Mu13AlsRMfRdPaa0C0yzaRBfYgwFaz3ZuWEWndEmXpcqa6MSxqGBGZMHgCDGYAWoByx89DtUHUj+uJD0NkxbODXY6xfAsqmDofW/VWFv9BEz4F5hLpoqzOzT64wMufYhOzj2L7r7f1EWUkBTINMTWHknAQvGPS0YLiUZduCrKJrbaXRhHb7HiOQvV;4:LSwTqDwhJm7ePcT1pO/T2z5L2Y5rUP2R6hBbxYbiKHuRtJzQOuZd1+qCUaz+Q89etm34Gb9cZ0L9zi2wAvpsNk/Ofd5rQGoMC1rIwuZRbMHSRuO3oGQhFbVM+LKJQ593jdZCoEWCvZjNGqtVLlsp4fLVplc0EduDHiFa3KjwXS700/TUiFSNXfPs5Q+jRNEgN9dzIdimrZMjVzy0gWaPGqlJrSs1UleJl2J1P1z0gkgRMqtn8yRZa6RocPjsvPkslR8/3I66sD87zHyCgcvvs1wTMnPeUR9ByIddNZegkw0RlttngZKWzxCVed+7cAnZ
X-Microsoft-Antispam-PRVS: <CY1PR0801MB2155D0198C78D38727E149F2A2560@CY1PR0801MB2155.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(2016111802025)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(6043046)(201708071742011)(7699016);SRVR:CY1PR0801MB2155;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0801MB2155;
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39840400004)(396003)(366004)(376002)(189003)(199004)(66066001)(86362001)(97736004)(8676002)(105586002)(81156014)(8936002)(47776003)(3846002)(6116002)(316002)(16586007)(106356001)(81166006)(14444005)(478600001)(5660300001)(6512007)(36756003)(6666003)(51416003)(305945005)(37156001)(69596002)(48376002)(68736007)(52116002)(50466002)(7736002)(25786009)(76176011)(107886003)(4326008)(446003)(11346002)(386003)(53936002)(16526019)(53416004)(2906002)(476003)(2616005)(50226002)(956004)(6486002)(486006)(6506007)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR0801MB2155;H:box.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0801MB2155;23:WJ81uYBdHsTOdgnkYus2d6CT5GrcZGuoJegse0Z?=
 =?us-ascii?Q?/pRz4Kfp7SLdhTCvddEwCHD9vaNVacTikNFe8Xdwt8Dga/Uoh4USgQOl/Kl4?=
 =?us-ascii?Q?9qqWYtkom/0t09WIpCsIOKpqh6JXeAg6yF4NxOQd3MJ5WLGVeTG8cVq8ga7i?=
 =?us-ascii?Q?IvwsFtXJddiRJAdsRUitvtVfoDtKbgInLiv3yMa2vt2YedIOYh5E7H3/LERx?=
 =?us-ascii?Q?/CTod3AdfNrusWFiTgYmrgtSQIApLiVahT47b1UDmDoG6LujHGrJhJAHvZSG?=
 =?us-ascii?Q?cKL+FucoUFFBOk6cAYGpO5vd/lXTFEKYD8Gc78N90TU+o0u3V8ocFIu31m/g?=
 =?us-ascii?Q?MPNpvQV4JD1zu2bQUKDQxwf33D9CC6TV595KshDiMhVNx9qCFdR6xp2+5ECa?=
 =?us-ascii?Q?+SzwvDvUuw5tYxqktz3l2vWr6t9WQYquszbX7OQT3H911W756v1kGsYz/OoI?=
 =?us-ascii?Q?wsFCY0R2ecSYxOB5OaS/g/NtzuJvYHTnPHkb8UbzJuYAuwgabdzgflgfoCSa?=
 =?us-ascii?Q?uHmUcZK9avgjtJUElSMalEcdRokGj1jmCOM1upu7MIpDv/vInpxHhw2d0now?=
 =?us-ascii?Q?7xyN08ScdQmjax/Mu8LGItb2eaLruOkRiF2uBMqc7AVdBg8skTTuiLNAwKhb?=
 =?us-ascii?Q?mfp8jupKYXIR9iBKj5UATmsdgff+XYFhahN7rrKqfH6B+RTqEp38mcfUATjl?=
 =?us-ascii?Q?t+/Dms2i4VhPt6gqRowfiupPjApKNo0xjHPPjFmc87VDdcCTnBT9QhPybGqm?=
 =?us-ascii?Q?sv8Moxr/KlVgkTouHUSB9ngrLik5NtttY/ebIZrV8r1k1vfQgVsucE6NeIYK?=
 =?us-ascii?Q?1fc2xqHCFo6XiaZUvjTzO5JRtY9dw0iZ7+tNk/69dmEOgHvGXn8UMXffpPS9?=
 =?us-ascii?Q?hhp1rarrXYfFbFAM1PXAfzdgp6H1ylPoC3tUgt7/h0DlwQmjbapO/rcuZrsb?=
 =?us-ascii?Q?eSDlG8A4wSQ8smAuWLTJYdA5X2O2z9KhTlOU3G1d57klvoaKRag5Xw2yHUss?=
 =?us-ascii?Q?r2uKPR51cmD5ujVLWyJHfATXZzXaQ8zv3g8x5NwyJx3qaBltvKP+zWCGTef+?=
 =?us-ascii?Q?RP9hqwDjPqj9D+UU1UGfTohniqYQJ8xhbTZFM5C5kZ1A5XmUGUcoljhsVoDo?=
 =?us-ascii?Q?laRbjmXjP6sND9XRE/M6MhU/H1TZ8+USglWxFC4daR/CKfgz6NZKAJOL1iA8?=
 =?us-ascii?Q?XsUe/b25N2hK24wG7mWVjZs2rj/8DATad84BsljJH4pZhWsRH9yZ+XwUOig?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: 6c+m9qmW6e5XEQ9F9U+HHSpkdvq092FZTve1L0RZT52uovrbCKKYuredt1ic1AVVFHV2BBRdaAfuP6m2yDI3VNsP1t6Akl962MYWubQWa11VDPIyWCdeGLNzdaBD8pCtIhbOpS7ojXDSMveTouzBTnL798yICxmlBttE/ube/9GBPwl6WAyl4IM0CXpRvX5HTMb5bqfO44WAUOAwm5MPK1+HCYZ54Lvoi2De0KDfE32uxs/ONyfRSeAZ05QH9QkPwvB9Vq+gvwjJZ34dRquGbDyF0kbHQeLnkzByF4vOZqGwqlknPSCvV8iW4jCl7oCqwefkm4ji5SEqVwCp0WM4wnf5ea0jJbgk/kJ0GT7fZYc=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2155;6:zXw9IOZG/XzzRMoNwMNTQTuqkv3RhrcuKJHuwT9mvT+u8gL+F+Hb5w0SXCRbS3oKXvILM+QvBnAPOPtN6V9MFS34e737+Osb+22zypOLpR5YOz3HjpJ008FxQVh1IYfjQdcZfBWE6qKFSrLyfevXQr/sVqNGUKistnVzzQm3JVKpoXAT5LN9dttMTb5iu1x6EsD8FMTkyYTzlxDlfrKJ965wmyzf6GW5rCxPKwAEbz06QEZJd2DPWManckt69mSN5RlZWRXXYwMDVkOx/S6YM/rIhD9X4WIHSDpcPePrVyBnIh0Tq9fh/64DZ432ldgVmYIKHZz6tjyg2BIboS04fDMezyOTB9/Jfikt+rBNOIhuNpnHpWn0/wGzpuFO7eHcO2a/p7XwkEbNOFarfv0SA8dWKKlqFJRcOBh47TVu5HAUnlapfX0ReqXttQwXzUM8IPNPWb+SJjOe2vUXFzXPeA==;5:0caNXvn2jBB1Gx0jHd4D2yj8HhHmJVtafTtHOy3ElruzlzB4Yc+eTkZ+WWteZO99AS8/U7c1209lbZOwJPI8xvI4g+oMVl+XxHgEavjTb863znCGuOJzd0Z5RojOu71fVoOOoQBUKfGeROWy4iZ/CysSHQce5cm0UAC/rFWXmWA=;7:DRJfi0AJGl1O8x8bhfU3Sx+NxaQ5t/rtygOd8kGbH3joqdBk2fnqdcQw7AQU7L8ojd2ta8bqngbMv1dc4P2Nwa5bASDy2s8+AwgCBQLxvZzpKvims0sfQC2JTudD5ZcRZa5VxSiyMFxs7hZfo4wpmOUNwqL13wl3T6Tnz1/DGKiEjXtORzxeN/Ul3SN+aY8iLmeBYoZWA78srPH0iwlxN4H+fyaR4/HTuaHtQ+rAT4T89bgsdYfGl7J7nVxZl1Uc
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 14:48:34.0621 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edfd55fb-0884-42ea-2f59-08d5f0ab5d98
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0801MB2155
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65053
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

Tested-by: Rachel Mozes <rachel.mozes@intel.com>
Reported-by: Rachel Mozes <rachel.mozes@intel.com>
Signed-off-by: Dengcheng Zhu <dzhu@wavecomp.com>
---
Changes:

* Code style adjustments.

 arch/mips/kernel/machine_kexec.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/machine_kexec.c b/arch/mips/kernel/machine_kexec.c
index 1679408..6e3f7c8 100644
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
+				 reboot_code_buffer + relocate_new_kernel_size);
 #ifdef CONFIG_SMP
 	atomic_set(&kexec_ready_to_reboot, 1);
 
-- 
2.7.4
