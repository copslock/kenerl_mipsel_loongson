Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jul 2018 16:48:56 +0200 (CEST)
Received: from mail-eopbgr700104.outbound.protection.outlook.com ([40.107.70.104]:55469
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993928AbeGWOsm1mH-n (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 23 Jul 2018 16:48:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBrmEN8uiMc9WndaE/aVzrKWB6JVeNM0NvukN0ODOGI=;
 b=jnwyiS8OmqP9cdIqSxcNv1uarzo1Bdtg+wB9pEhVRGYHL58ZddY7mdXstXFqgMdcCsOiWkWtPrArzf16nv7q5UcwbSqIgnKAIojZrm5GXJ36WIk1GKM4mfii1ikHHDGf/YHkivRb74xb4WCI+aqoHKhz7AhI+nJTK8nYkE2zZGg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
Received: from box.mipstec.com (4.16.204.77) by
 CY1PR0801MB2155.namprd08.prod.outlook.com (2a01:111:e400:c611::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Mon, 23 Jul
 2018 14:48:33 +0000
From:   Dengcheng Zhu <dzhu@wavecomp.com>
To:     pburton@wavecomp.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, rachel.mozes@intel.com,
        Dengcheng Zhu <dzhu@wavecomp.com>
Subject: [PATCH v3 2/6] MIPS: kexec: Let the new kernel handle all CPUs
Date:   Mon, 23 Jul 2018 07:48:15 -0700
Message-Id: <1532357299-8063-3-git-send-email-dzhu@wavecomp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 696bb30f-da60-482a-fab1-08d5f0ab5d01
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR0801MB2155;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2155;3:x9KYh9+SV5E+ldWd9rvgqXX+1iE08KNvXL845a+jflTbz6aQFcK8NbZlzi7BN/BV0WN5UCBtzcpfm72pwlCqlSAzrOFWQU8VbAWAFW3B2KwgmfIT5vBLWUp0UUqdzqF5OqsW4xzBoOl2m5gzUCpLGjw51w3tolWUovViL55mbdPmSO809Pdj0u27MaF1pGiTCBIFuit3KilASRKkj2VkUEQWQY1P1agoSacyyyNvxeB9/iYly/+Nv2CG0sU2WwML;25:UEXn6muZJz8/oTdt8wUI8vOJ7P2gvi7uIDYu8xc9SPrloqFiPlK2a1Jc3VqCibh4otT40vDBc3l7LwnkHDkK/lfDDMhB/Qhjx3nQICGHpWbF6D5vN+Ta92AwQkRIPoWifjhj1EtuUtxj9Vvkz4Am9PXmOc2PFZr8roSNt3ON/G/WRJucXJzeBxjpM53FLpPtvBgj1DsyNhClmMV9Ans3sUBJqeq1F1aBa+y87jfDFCHK2m1Dv+em2cZCZgNSdwBmeVPsKDNFUb1ioM5NX+LzfnuQLJ1/Ehdnqd5RQuB91hzTz8yffrX2T+oS3HeGhib8uJjAbH2Q5iLmaNEeWnma6w==;31:MhTdB09ojjYP/28lz1kCll1BQRcTV82ge5Kfnao4ogHjc+fZRsiBr/lBkYikt4cBIDkiUFZOEl8BocoVZf3He1FLt1nkGoP6gs11fcna3g4XPndF4izGpNiCT1gKPFRluMPOdIJ5y76AszzfS00tal20c9LCOgG+OIUosy/pmqT6Zv9Lqsl9dFuDeyGYI2T1hzfZcheg9CBMAStXzaSL+Flw0B4uHxA6S2OJyccJ8+g=
X-MS-TrafficTypeDiagnostic: CY1PR0801MB2155:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2155;20:tgv8Ndm9am9HLpqO2M6KcVakHPHJDXT1zqgkqaHaBmrpribCtKvsvpKO/cm1KPiSDh//eDnbdMQA3FURvapfbUfdcdpbWOZJjApsoN/mVDwBQTqyJRSrYmjteH/6ycTvzIGuxAKq4nTc1G7r/DgsbfG4k0j+bsqZhpOZoEg2xjzVvx0oEU+QSyZyVxU66IvMAOpkxn7StfC1acW3aIKBcJqzyfBvwxmtGqnommsNJonH49PgNfycdzZsdaNz0c9u;4:pFLcQl8kf0nwl8HUfZTk+o8ygdkmoMwglv8DwuwcyiZUIuVsRrQGFyadoImGMDTuIGwe+2sH9g+5SreMV3v6ULOnON5zAVKZqV6bEqrBtz1LvRE+aROBA+luYVSxu9RdypOtdDZAXaJCGiWdMVK0Hdrdh1xTKLafR6rrLo73pUGtFPbtetrKKnKi1KFMxNEF646pRBzGnNziQxvB22tDMQFtJH2fuEMEFdguxV98WUXBCht/YbBULCgkVp/RZir6Tkeaekw4KiIbdC/33QmCzHyMeAjpQp+TbnV6+0q5OHiz0JYUXKO5DoWi3qh00Z3h
X-Microsoft-Antispam-PRVS: <CY1PR0801MB21555C66CA69E5FC0B2A8591A2560@CY1PR0801MB2155.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(2016111802025)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(6043046)(201708071742011)(7699016);SRVR:CY1PR0801MB2155;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0801MB2155;
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39840400004)(396003)(366004)(376002)(189003)(199004)(66066001)(86362001)(97736004)(575784001)(8676002)(105586002)(81156014)(8936002)(47776003)(3846002)(6116002)(316002)(16586007)(106356001)(81166006)(478600001)(5660300001)(6512007)(36756003)(6666003)(51416003)(305945005)(37156001)(69596002)(48376002)(68736007)(52116002)(50466002)(7736002)(25786009)(76176011)(107886003)(4326008)(446003)(11346002)(386003)(53936002)(16526019)(53416004)(2906002)(476003)(2616005)(50226002)(956004)(6486002)(486006)(6506007)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR0801MB2155;H:box.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0801MB2155;23:QgYLdD+WS+1o9cB+92O69HWx7O1knRiAKjZVSzQ?=
 =?us-ascii?Q?YsrU/qTnWgAUCyOFTx8zIArpjfTHT8LjwpxlmFotq1or79TBoqTy+8IeoTxO?=
 =?us-ascii?Q?fKtZCgnyevv12P2uxIH8DSonAuL9qNsLyO+JcRiOqr0JbzBCiZqeQww0eQp4?=
 =?us-ascii?Q?1fGGo1DH5EKkI9wtaKZPLR/ddXLW/VQgMy3DlXbDcYMCtsJqsrwTSRYI+qHr?=
 =?us-ascii?Q?26bmbdq9+e/VWenIsPdgTRdTuzg+QgRydpzujIjACNRfbaO2xaqAlEx+fSre?=
 =?us-ascii?Q?998tL7Iy9TfIJ2tRn8fCIy3yC52mBX4MFX06ZK0Gh2e3y+o1Im4x0cgCHFXW?=
 =?us-ascii?Q?7MkWYCRmqaMLq/20ERXdOF8RW6g+NaeuS9XD8zbldKRQjLblynok8CVK67Nq?=
 =?us-ascii?Q?4M0Ny3G3yVcH8AIurqDev2lT2gkCoO9vpYNbG2xhs07bCmzxhYrOQXpgT+eU?=
 =?us-ascii?Q?jFDsQIckulHkOdrqnrvyysVZqdkLwTt4ydJfuphATSd6ptXPkxhjo/iJUb6B?=
 =?us-ascii?Q?kQL/Gqkgv73w3VXc+c/oqmoPJuVTuA/HLm+ER9TTjk1k4dDQCAxQXFXo4d3w?=
 =?us-ascii?Q?4XqQhqvlzIPhl3WzHoIXDtvZ2Mv30jhiZ4tnZdYMW4A5udfOJ6jFYLpOxHot?=
 =?us-ascii?Q?zBgN+1mVvnN58ZJMJCIomnRGUCHWRVxEO0c2KNT+mprOEleISSHy96ypK4aV?=
 =?us-ascii?Q?tXYK+OxYf+SD+oQWHZgbwMPBdCXWP+HsTuIqpuKCuCJVDOP7K4rHUO3OvO7O?=
 =?us-ascii?Q?PHXkyy3eREiza6XdBgn77LuNOqyDzmBuPFIWFbqR9+ZOD/jqoAE7lmQAF/Rb?=
 =?us-ascii?Q?jjXEYENRh6Uwu+Fjfnkbp9iGKfGeeJKx3OE7GyewX9ufdREiGSVo5CYHEa1P?=
 =?us-ascii?Q?xkhcrqUV5hb4Un70u/C9j79yhqYcRG3eQkKj62DLVOgAYZpw3WwmKwcOusqG?=
 =?us-ascii?Q?UkqKVTr9rlIoxP9rZq9v1SEpN9s7EcEVswlPtq87jc0lk7CAYTqJFWFm00xh?=
 =?us-ascii?Q?WUNZo1r0FBxyW2KDQ0ydSngx36YnPV/rHD0gu27xPwXrH8I9KmM85JZuH4VM?=
 =?us-ascii?Q?9PyuTAY48hBIsW3SHPA2lFR3gUgMXbNeL4H1FZ8pscLtUXRuZssQtZ9xEUZy?=
 =?us-ascii?Q?Q8oHQnibkObLo5Nljz6YQMLGmaz4fdNADx4I5Rr8tixVfv4BHZEOnlg/vo5u?=
 =?us-ascii?Q?hGFhQfsT7qtvPR6P7yMuoErzG79w5AkeZ+tdsoNRtvvNieXNClAn8JU2Fqgl?=
 =?us-ascii?Q?XxBRc0PdP5L+aheYIzu0=3D?=
X-Microsoft-Antispam-Message-Info: 3cAnyfhmm+vxRU0rOf/lyWOhjJrZBNd3jzsNn6BpRlejH3gIzO3mP6uvcw896/te47gZIux4A7Y5waUm+4j7GzyQtb+2RljVqb70mL/o10KI2C7sR+m45wQd3VxsT43V6/LCt/wN2F4CSX43/ykAZ8LKlf1/Z6IP6jWOkVPqRxVOSc39lG5GkC9VAyxnWGVaCzaNqZsLMkkv8EMguLuBYhPlMq3AsVZYmf2wigf/dt983nRqqUZv+vfLLD1iUsMVzDM8ol0ffidKHE6oIIwnnitZtGzVUtowFVF8FexPuHZuvbWHwSXGWkGS/GA3J3pT27Wps5GI7z5e1guxUAw+n/txYWP/M+1cHQHfONCLMW4=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2155;6:i+ZwLvNWSLLuyN17mUIhNEqETyebLafHVx7JfjSR8fpz2uKHMyR2oLg4VTyd1yEfk96e9oVkSjNBpVjfvF+WUHJfMfO6veRZyVDv0IJ3Zvv7F4LhIvEMb10FR8iUXef5Dk2fbBfmKixjtAh6C9sP/SxZtAgBKRf/ANNFLGO5GFB1uJnxq8GO91Bej9o/a1tnColjcyzJKQ1cc7vZrtgBMRJx8zmgrzKXBoeXv5q3/ku0lTXUW6d5oE4RQCODIaNN2lQByZ2iZTVm4IIHbhJJqKeQFqrN3keVk/NCMHT7dFlrtxPiw6CBSIq4a1brZjwqnTMVLEkG0/6OBZCSPPkFGx0zqcmuLwNB+UrxIWRFmaqJ/2eL8ZO5AneCt66MLoQupjE+5vSXPz2ZM6w55apH0PlMJJuBMxP/rBEtVGOWbKasGJxKMszwAbV9WNhOSmDeaBjDm0eFpabVJRCUv1kEzQ==;5:itXiTopRz4bsgFmEBnGe7Iz8XnjQZjcrtQfY18SyNG0BLRBcFdKIxrOfq1wYZE9a+gYn14JUyYQinAH3FT7TcG67rBLdc6xbo0my/hnZCLW9aBGnD8oB6Wlz6fRR+JZm+4gJS0H6DiWFCaJDM6te8H2v/ydkRcve4mujOCb5lzc=;7:q6m2G9nQHGJB1Q7P5xP5ZI114SjFV66tSzB+SgAvQ3mP+LNXkAreWKBhrjpZu7rCE83GZk83P2/9Kr560nv00CTCIicmXmRVC+iW7jwGkSs3khZCKBarCxKkNdS+InXp4TAotkbqS2o/L2pSRZOZZlaGLcmKwrVzOZEmQfLzmFT2ffY4xl/gXmF/EBExAQgQk66CisloH28aImje01ilMUuuoQ2Mz4r1fPHuLAQoI1Yjb994FLklRDUuMUWPycYY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 14:48:33.0777 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 696bb30f-da60-482a-fab1-08d5f0ab5d01
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0801MB2155
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65051
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

Use the new play_dead() interface to prepare an environment for the new
kernel. Do not rely on non-crashing CPUs jumping to kexec_start_address.

Tested-by: Rachel Mozes <rachel.mozes@intel.com>
Reported-by: Rachel Mozes <rachel.mozes@intel.com>
Signed-off-by: Dengcheng Zhu <dzhu@wavecomp.com>
---
Changes:

* Code style adjustments.

 arch/mips/cavium-octeon/setup.c  |  2 +-
 arch/mips/include/asm/kexec.h    |  3 ++-
 arch/mips/kernel/crash.c         |  4 +++-
 arch/mips/kernel/machine_kexec.c | 28 ++++++++++++++++++++++++----
 4 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index a8034d0..3a1f7fa 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -95,7 +95,7 @@ static void octeon_kexec_smp_down(void *ignored)
 	"	sync						\n"
 	"	synci	($0)					\n");
 
-	relocated_kexec_smp_wait(NULL);
+	kexec_smp_reboot();
 }
 #endif
 
diff --git a/arch/mips/include/asm/kexec.h b/arch/mips/include/asm/kexec.h
index 493a3cc..a8e0bfc 100644
--- a/arch/mips/include/asm/kexec.h
+++ b/arch/mips/include/asm/kexec.h
@@ -39,12 +39,13 @@ extern unsigned long kexec_args[4];
 extern int (*_machine_kexec_prepare)(struct kimage *);
 extern void (*_machine_kexec_shutdown)(void);
 extern void (*_machine_crash_shutdown)(struct pt_regs *regs);
-extern void default_machine_crash_shutdown(struct pt_regs *regs);
+void default_machine_crash_shutdown(struct pt_regs *regs);
 #ifdef CONFIG_SMP
 extern const unsigned char kexec_smp_wait[];
 extern unsigned long secondary_kexec_args[4];
 extern void (*relocated_kexec_smp_wait) (void *);
 extern atomic_t kexec_ready_to_reboot;
+void kexec_smp_reboot(void);
 extern void (*_crash_smp_send_stop)(void);
 #endif
 #endif
diff --git a/arch/mips/kernel/crash.c b/arch/mips/kernel/crash.c
index d455363..6d43200 100644
--- a/arch/mips/kernel/crash.c
+++ b/arch/mips/kernel/crash.c
@@ -43,7 +43,9 @@ static void crash_shutdown_secondary(void *passed_regs)
 
 	while (!atomic_read(&kexec_ready_to_reboot))
 		cpu_relax();
-	relocated_kexec_smp_wait(NULL);
+
+	kexec_smp_reboot();
+
 	/* NOTREACHED */
 }
 
diff --git a/arch/mips/kernel/machine_kexec.c b/arch/mips/kernel/machine_kexec.c
index 8b574bc..b3674f7 100644
--- a/arch/mips/kernel/machine_kexec.c
+++ b/arch/mips/kernel/machine_kexec.c
@@ -19,6 +19,10 @@ extern const size_t relocate_new_kernel_size;
 extern unsigned long kexec_start_address;
 extern unsigned long kexec_indirection_page;
 
+static unsigned long reboot_code_buffer;
+
+typedef void (*noretfun_t)(void) __noreturn;
+
 int (*_machine_kexec_prepare)(struct kimage *) = NULL;
 void (*_machine_kexec_shutdown)(void) = NULL;
 void (*_machine_crash_shutdown)(struct pt_regs *regs) = NULL;
@@ -26,6 +30,20 @@ void (*_machine_crash_shutdown)(struct pt_regs *regs) = NULL;
 void (*relocated_kexec_smp_wait) (void *);
 atomic_t kexec_ready_to_reboot = ATOMIC_INIT(0);
 void (*_crash_smp_send_stop)(void) = NULL;
+
+void kexec_smp_reboot(void)
+{
+	if (smp_processor_id() > 0) {
+		/*
+		 * Instead of cpu_relax() or wait, this is needed for kexec
+		 * smp reboot. Kdump usually doesn't require an smp new
+		 * kernel, but kexec may do.
+		 */
+		play_dead(true);
+	} else {
+		((noretfun_t)reboot_code_buffer)();
+	}
+}
 #endif
 
 static void kexec_image_info(const struct kimage *kimage)
@@ -79,12 +97,9 @@ machine_crash_shutdown(struct pt_regs *regs)
 		default_machine_crash_shutdown(regs);
 }
 
-typedef void (*noretfun_t)(void) __noreturn;
-
 void
 machine_kexec(struct kimage *image)
 {
-	unsigned long reboot_code_buffer;
 	unsigned long entry;
 	unsigned long *ptr;
 
@@ -132,6 +147,11 @@ machine_kexec(struct kimage *image)
 		(void *)(kexec_smp_wait - relocate_new_kernel);
 	smp_wmb();
 	atomic_set(&kexec_ready_to_reboot, 1);
-#endif
+
+	kexec_smp_reboot();
+
+	/* NOT REACHED */
+#else
 	((noretfun_t) reboot_code_buffer)();
+#endif
 }
-- 
2.7.4
