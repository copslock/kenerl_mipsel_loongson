Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2017 17:48:23 +0200 (CEST)
Received: from mail-cys01nam02on0058.outbound.protection.outlook.com ([104.47.37.58]:30302
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23995047AbdH2PnSNcvO1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Aug 2017 17:43:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=rtDyLnURFOjiCnEQ28/NIA0QMuYZVvHKmWfDAI9FHhA=;
 b=joR9hWXNviCFE+SA0//v6Ng+P0COWAKp+m8SWknWsZCYKEbbUoDVLhxeYcWKNQGd3z8Io2vhqyPY86WODrKYKrA3woqzRibQi/4xA/Q0yeK+QiD2Gil+9M+zkyE1VV/TFtDdMYZO9WcAp3iselmqna9vJsIIfHLLKnwFUMupKQ8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 MWHPR0701MB3803.namprd07.prod.outlook.com (2603:10b6:301:7f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1385.9; Tue, 29
 Aug 2017 15:43:02 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
        ralf@linux-mips.org
Subject: [PATCH 8/8] watchdog: octeon-wdt: Add support for 78XX SOCs.
Date:   Tue, 29 Aug 2017 10:40:38 -0500
Message-Id: <1504021238-3184-9-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1504021238-3184-1-git-send-email-steven.hill@cavium.com>
References: <1504021238-3184-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: BY2PR07CA0031.namprd07.prod.outlook.com
 (2a01:111:e400:7bff::26) To MWHPR0701MB3803.namprd07.prod.outlook.com
 (2603:10b6:301:7f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c526877c-6082-4680-b594-08d4eef4a29e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:MWHPR0701MB3803;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;3:UR7/qT5UsDxdHtrL+9UNeim2ExzExS0mq7I4+EW0mqO7K3eRnLeRP/AxB0oD+PIODIKpKh/5dUN761326a7CbVD/y2ozBA82r1NZoRYceWS/9Xwwpo8ROaC7BiVJ6n3TXMGF12ZPASHhq1ifRzMHodQTRHr6bk8Ak/Dyh/qlM5csUcuPyxU4EfPWxEvRoSF0GAxN3PUmyHd+uvdK8GtCdlJzZI19/JgYyFrFcjIHFxOd7U/hqY0/bhUDfTe7jbc3;25:Dz6gtbJ/9ahAMp9juhbHJuDjeDC7DC4ItOaKvIjMUQzRms/DSv+dRpS6iTBDPUalM4YK4pu1jwEgGOwDDszF7Br/4LLDaCCFJfpvAkptphmZKCeUadUFwax/0G+clL3wDENMpNRWtGkNYWTjnJhWd/5r5u+0IGmMRxSnR67QiVS7yD8syH7MdYjGXJojIuITDnO6q7nBlmqSpHQ00KN7q5tSk/+ibo94Zq8ixoL8ZXChbRKRIktK4+Yhu5q7shNhYqu7X6Y0VHtF1oq1mZaQkSIMa0ET1/erA/RaQovaLpPm9w9YXbAZglWVFKEJ0Pxt3f4iecCYnI9BISAKMEAvhQ==;31:HZlh3195o2eXrWCwYmqwDUJk8xbMYdiNfhgijWF0Jd/KrWMrUJhX+MEMkBkO0+PtJfGyXgUPiokacYmsfzRBEyo0MTRnY16aO1AGfuzugisTktYDKJ4wnSBVyhW/AQOoeWt0L5EIWalWPJHVRpCMsAzGkaqFWlmTmXp9koUhoQTC6Ycl37hG+nKfQS4sMThr/tV6KJqsbD0QnIT5Uj2FQ6fG+KWsz/dhYbNGtSUKRaw=
X-MS-TrafficTypeDiagnostic: MWHPR0701MB3803:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;20:1sJoK91kSUh20yk4Vi0KTnJTHpDlpbT09JWxvk0Tq40k9lvGb8BgtjJDs8yLiuEkyowUTVCx7QXBmI+554p2dNZOBH11SjOydJGziEGgKFnlNJC3qb0Zf/JkJTORhjh2FOC5WrSHlBTTtV+UPI5aZyDdgq8nLMhapoaINAi/+6F6Pit5wQG19cl6ee3PrgngqojxRNg6Qvgr+IHKjZAmzVlgX8ml/wYMWXexFIXCbWjN9bFoS4FOUlo3n1+IJS4/I/zJWW0dT/W7GM2L7G1YcGJgS5ek7CDG36iFVdCwnwwtO7REa+7+T402yoKyMV6r9K+yksWr3wcBVhQYYvKrIssCRCp5NOLnUrI1SLKN+AIno5KssS2Vsv4W/kuyVuPZhySYQKUeFb5N1cl50oPjs6RCN1w4S0RHUYslqkZQha+Tj8QtQM/jai1O8BJnUW4WhV3ILdleshy3BbSIo5cDOd8nRzPTpofAdpqBpUixE54nBeInLJCURjVd5Bxh+Hqs;4:J/kw8GkwK/nOQWDHa8bzQHH16IG0iTrnn+DSDbQyuOA1MxXgjCj8osYFkGcd4KN5k/9Pk4SMR/XdvWg9lUi8Nh73e06dS4ewEy3gRvAF1lFsQl/DKu+OvHRcvu0JHEna+fl0gLS1obUryOhp/a0tbiSnRp6+wFDNTn+m7jcnBydCAfEYUPKG9TdEd9v2QCdReMJmubW3ReH5KfLxgPo+5HnaKhbROdGyLLDs52jkvyjApoG48Srt9Ww/c7gsqH6g
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <MWHPR0701MB380384F424965487C56B2F69809F0@MWHPR0701MB3803.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(100000703101)(100105400095)(6041248)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123562025)(20161123555025)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR0701MB3803;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR0701MB3803;
X-Forefront-PRVS: 0414DF926F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(7370300001)(4630300001)(6009001)(189002)(199003)(189998001)(7736002)(72206003)(97736004)(36756003)(305945005)(5003940100001)(69596002)(33646002)(50226002)(8676002)(81166006)(7350300001)(50466002)(81156014)(68736007)(3846002)(6116002)(48376002)(6506006)(66066001)(86362001)(47776003)(53936002)(110136004)(50986999)(76176999)(5660300001)(6666003)(6486002)(2906002)(2950100002)(25786009)(42186005)(53416004)(6512007)(106356001)(101416001)(478600001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0701MB3803;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0701MB3803;23:UuDFMkb0RafRZbwIfxwKOcYwYVwBLn9obT1ciWT?=
 =?us-ascii?Q?o7Ck8iRvPuzeVHKpWQZvYSYyEA9LMAE86zYMTXS27+CD6ZZy5srH/687zIaz?=
 =?us-ascii?Q?0q0GskBBCCPlfxavT+6g1lH12QXD1KyucrkEnM+i0DzEElvyrnctIInhcA+S?=
 =?us-ascii?Q?YQejBkWVsjLOluiBOuaHLdjkSq4+Gy/EGFY2w+Cf08ISv42FBR+qsB1UBAoA?=
 =?us-ascii?Q?TCTUYQ2VEJhtUZcINAo2WEeegNGNI5cQOx5tlhjwvjn61v94GiOy4cjhKwZU?=
 =?us-ascii?Q?fPZpckMaSG/tCIg3CzdR6A5pKDXzmNy8xZqoxvAtdIyfIrLmmMI4XMDidmW1?=
 =?us-ascii?Q?+I/VH5xa1a9pd9Gkm9mwLoQ33wEMPcjuKFAU1cat/QMqkCbuyd/MK9AoW53L?=
 =?us-ascii?Q?hS5ApOY4dDiE0J0wplg8jngBZqool9DsZxQd7Db+5HsKiGg9n3B87H+SUgaq?=
 =?us-ascii?Q?8QzA7uq1O6R3GsoRAxfuJzvmHiPgUBW++egdwkr2FVwrGmHeisUPCMwhZmKI?=
 =?us-ascii?Q?FUiGdYoCKr1hOtNnwLnn8s/MEW4LjE2iG7A3urvIqkP3EH9bNlnsWLJedU7L?=
 =?us-ascii?Q?AmVInbqInLV8qY7Xi0ybKrbb1RQxFzEk+u7K9WLuZcoIUVpMV2i01nMzGzT8?=
 =?us-ascii?Q?SVHhB3Y82hUiw2rF41EC6f0fZtM8k6sjl3lGlfUnCFMu4sNqkZ+yEURqUI9L?=
 =?us-ascii?Q?8TdzFON2Bxv7DY/3Ij4Asa9XsEWGlVsJbG7/My9WhmvaaOcDrI9xoARQZE7e?=
 =?us-ascii?Q?frNYJMMlJNae8YDOGetblNI5j+6nHWZtzA163Wit6Q+oAaa5BHnfNemw+TpZ?=
 =?us-ascii?Q?C1WOEaQZIkU3IlQMUhmSFqaoMNCyci/WFQGw7CANF0uUsvPOWbxm4tGbWsTm?=
 =?us-ascii?Q?HKniCMSUG1QMDLJmbDcAYAfhr5eYhO4m3WSocFTz00XisIYU7IuFa1VJA9hW?=
 =?us-ascii?Q?fY5obk0p8e4T8+jnKf7dsbn8NzUPWVxkHew6M5PiQqr03pa6fT7kb1ZyWKaF?=
 =?us-ascii?Q?gkpipY9sTEbHVi7e/bkV5G8Y9ZozURIUc4NUlPgt75pANa3CHulrMvSNCYKP?=
 =?us-ascii?Q?YAEA8AfFzu/U1g6W0Fs86f3tIhMIYVSiizhbtr2tQeo51ubrFBA=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;6:xtJNDSl5T1dOBJpbvZTfX+0V/gHS6D9QYCZRfXopY65Li1CFxfnKPU1hDUdRMofxvDtQAz/tytzU8puA+WWThcusHJ/1dTZLeSNo/71xaLZ6c3jI6OwxBWqOcQ9GmRwL1DBgVATNN/SqVhLzjddhAa9gMfiIprsztsZiRsQv8vDSK5bkTyHo+2wWdlXmFIjfT5bDnmu0p97MLBw0Ajs3Wu5Y8cXQffIfok1Sk0XEJzCXo8BY8WV1Rlfk6Qua72FvrwE88XFrK30nvA73ET0kNm+OkhH538aHfgjAONN5+ul5zJtq+xTDKeBiqN5IrYhwz0EwLuIDfJOSK76iqAlMkw==;5:SZnjAIFmtv8IRyDTzvCe/aXW99HJfGnQHhzqRlGrPm9kH23O+aTD17uroKxqbaXYptMlEditDI7Yfs3gNfh+SlGv3OW233WezgbQKp2NkGembTnQV0hZ0yM/8Qwg/VTIy3E4jUuUd2+Q5Yx5PL7Yqg==;24:jd0KMMxfrbE5MH7s1Lvn0Gp1WWbj7abeAQV+jZH8GLa4TEXTo0/3kB9A00p/kAoh/5SKzD1l4/++fFzgPcVKur8XV29qOAH0qmx4I6rXmyo=;7:iemVNuGNneTUPn1OghKiTVHtijv+A4Pr3B3TMrzLOTagJFQx6+9IQUHWQ1KW6z3eWx929qsHemPaMX4Q2nHjk862Xj9MK1tElX77FCYKwu/Sbjb7spcMZv4IDCMGo1wa6PA7Bg2ccF+8V/utzWRMikVrYeQbdBrZ0MB4Ee10344y3OxfLdf1dmcGoHML99E3HtLLvxWnrScK/Iwf1FZ0zlD19xz1LMsSJ5/XVgLIhO0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2017 15:43:02.8042 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0701MB3803
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59876
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

From: Carlos Munoz <carlos.munoz@caviumnetworks.com>

Signed-off-by: Carlos Munoz <carlos.munoz@caviumnetworks.com>
Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 drivers/watchdog/octeon-wdt-main.c | 133 ++++++++++++++++++++++++++++---------
 1 file changed, 103 insertions(+), 30 deletions(-)

diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-wdt-main.c
index 410800f..0ec419a 100644
--- a/drivers/watchdog/octeon-wdt-main.c
+++ b/drivers/watchdog/octeon-wdt-main.c
@@ -70,6 +70,10 @@
 #include <asm/octeon/octeon.h>
 #include <asm/octeon/cvmx-boot-vector.h>
 #include <asm/octeon/cvmx-ciu2-defs.h>
+#include <asm/octeon/cvmx-rst-defs.h>
+
+/* Watchdog interrupt major block number (8 MSBs of intsn) */
+#define WD_BLOCK_NUMBER		0x01
 
 static int divisor;
 
@@ -91,6 +95,8 @@ static cpumask_t irq_enabled_cpus;
 
 #define WD_TIMO 60			/* Default heartbeat = 60 seconds */
 
+#define CVMX_GSERX_SCRATCH(offset) (CVMX_ADD_IO_SEG(0x0001180090000020ull) + ((offset) & 15) * 0x1000000ull)
+
 static int heartbeat = WD_TIMO;
 module_param(heartbeat, int, 0444);
 MODULE_PARM_DESC(heartbeat,
@@ -115,21 +121,12 @@ void octeon_wdt_nmi_stage2(void);
 static int cpu2core(int cpu)
 {
 #ifdef CONFIG_SMP
-	return cpu_logical_map(cpu);
+	return cpu_logical_map(cpu) & 0x3f;
 #else
 	return cvmx_get_core_num();
 #endif
 }
 
-static int core2cpu(int coreid)
-{
-#ifdef CONFIG_SMP
-	return cpu_number_map(coreid);
-#else
-	return 0;
-#endif
-}
-
 /**
  * Poke the watchdog when an interrupt is received
  *
@@ -140,13 +137,14 @@ static int core2cpu(int coreid)
  */
 static irqreturn_t octeon_wdt_poke_irq(int cpl, void *dev_id)
 {
-	unsigned int core = cvmx_get_core_num();
-	int cpu = core2cpu(core);
+	int cpu = raw_smp_processor_id();
+	unsigned int core = cpu2core(cpu);
+	int node = cpu_to_node(cpu);
 
 	if (do_countdown) {
 		if (per_cpu_countdown[cpu] > 0) {
 			/* We're alive, poke the watchdog */
-			cvmx_write_csr(CVMX_CIU_PP_POKEX(core), 1);
+			cvmx_write_csr_node(node, CVMX_CIU_PP_POKEX(core), 1);
 			per_cpu_countdown[cpu]--;
 		} else {
 			/* Bad news, you are about to reboot. */
@@ -155,7 +153,7 @@ static irqreturn_t octeon_wdt_poke_irq(int cpl, void *dev_id)
 		}
 	} else {
 		/* Not open, just ping away... */
-		cvmx_write_csr(CVMX_CIU_PP_POKEX(core), 1);
+		cvmx_write_csr_node(node, CVMX_CIU_PP_POKEX(core), 1);
 	}
 	return IRQ_HANDLED;
 }
@@ -280,26 +278,74 @@ void octeon_wdt_nmi_stage3(u64 reg[32])
 	}
 
 	octeon_wdt_write_string("*** Chip soft reset soon ***\r\n");
+
+	/*
+	 * G-30204: We must trigger a soft reset before watchdog
+	 * does an incomplete job of doing it.
+	 */
+	if (OCTEON_IS_OCTEON3() && !OCTEON_IS_MODEL(OCTEON_CN70XX)) {
+		u64 scr;
+		unsigned int node = cvmx_get_node_num();
+		unsigned int lcore = cvmx_get_local_core_num();
+		union cvmx_ciu_wdogx ciu_wdog;
+
+		/*
+		 * Wait for other cores to print out information, but
+		 * not too long.  Do the soft reset before watchdog
+		 * can trigger it.
+		 */
+		do {
+			ciu_wdog.u64 = cvmx_read_csr_node(node, CVMX_CIU_WDOGX(lcore));
+		} while (ciu_wdog.s.cnt > 0x10000);
+
+		scr = cvmx_read_csr_node(0, CVMX_GSERX_SCRATCH(0));
+		scr |= 1 << 11; /* Indicate watchdog in bit 11 */
+		cvmx_write_csr_node(0, CVMX_GSERX_SCRATCH(0), scr);
+		cvmx_write_csr_node(0, CVMX_RST_SOFT_RST, 1);
+	}
+}
+
+static int octeon_wdt_cpu_to_irq(int cpu)
+{
+	unsigned int coreid;
+	int node;
+	int irq;
+
+	coreid = cpu2core(cpu);
+	node = cpu_to_node(cpu);
+
+	if (octeon_has_feature(OCTEON_FEATURE_CIU3)) {
+		struct irq_domain *domain;
+		int hwirq;
+
+		domain = octeon_irq_get_block_domain(node,
+						     WD_BLOCK_NUMBER);
+		hwirq = WD_BLOCK_NUMBER << 12 | 0x200 | coreid;
+		irq = irq_find_mapping(domain, hwirq);
+	} else {
+		irq = OCTEON_IRQ_WDOG0 + coreid;
+	}
+	return irq;
 }
 
 static int octeon_wdt_cpu_pre_down(unsigned int cpu)
 {
 	unsigned int core;
-	unsigned int irq;
+	int node;
 	union cvmx_ciu_wdogx ciu_wdog;
 
 	core = cpu2core(cpu);
 
-	irq = OCTEON_IRQ_WDOG0 + core;
+	node = cpu_to_node(cpu);
 
 	/* Poke the watchdog to clear out its state */
-	cvmx_write_csr(CVMX_CIU_PP_POKEX(core), 1);
+	cvmx_write_csr_node(node, CVMX_CIU_PP_POKEX(core), 1);
 
 	/* Disable the hardware. */
 	ciu_wdog.u64 = 0;
-	cvmx_write_csr(CVMX_CIU_WDOGX(core), ciu_wdog.u64);
+	cvmx_write_csr_node(node, CVMX_CIU_WDOGX(core), ciu_wdog.u64);
 
-	free_irq(irq, octeon_wdt_poke_irq);
+	free_irq(octeon_wdt_cpu_to_irq(cpu), octeon_wdt_poke_irq);
 	return 0;
 }
 
@@ -308,33 +354,56 @@ static int octeon_wdt_cpu_online(unsigned int cpu)
 	unsigned int core;
 	unsigned int irq;
 	union cvmx_ciu_wdogx ciu_wdog;
+	int node;
+	struct irq_domain *domain;
+	int hwirq;
 
 	core = cpu2core(cpu);
+	node = cpu_to_node(cpu);
 
 	octeon_wdt_bootvector[core].target_ptr = (u64)octeon_wdt_nmi_stage2;
 
 	/* Disable it before doing anything with the interrupts. */
 	ciu_wdog.u64 = 0;
-	cvmx_write_csr(CVMX_CIU_WDOGX(core), ciu_wdog.u64);
+	cvmx_write_csr_node(node, CVMX_CIU_WDOGX(core), ciu_wdog.u64);
 
 	per_cpu_countdown[cpu] = countdown_reset;
 
-	irq = OCTEON_IRQ_WDOG0 + core;
+	if (octeon_has_feature(OCTEON_FEATURE_CIU3)) {
+		/* Must get the domain for the watchdog block */
+		domain = octeon_irq_get_block_domain(node, WD_BLOCK_NUMBER);
+
+		/* Get a irq for the wd intsn (hardware interrupt) */
+		hwirq = WD_BLOCK_NUMBER << 12 | 0x200 | core;
+		irq = irq_create_mapping(domain, hwirq);
+		irqd_set_trigger_type(irq_get_irq_data(irq),
+				      IRQ_TYPE_EDGE_RISING);
+	} else
+		irq = OCTEON_IRQ_WDOG0 + core;
 
 	if (request_irq(irq, octeon_wdt_poke_irq,
 			IRQF_NO_THREAD, "octeon_wdt", octeon_wdt_poke_irq))
 		panic("octeon_wdt: Couldn't obtain irq %d", irq);
 
+	/* Must set the irq affinity here */
+	if (octeon_has_feature(OCTEON_FEATURE_CIU3)) {
+		cpumask_t mask;
+
+		cpumask_clear(&mask);
+		cpumask_set_cpu(cpu, &mask);
+		irq_set_affinity(irq, &mask);
+	}
+
 	cpumask_set_cpu(cpu, &irq_enabled_cpus);
 
 	/* Poke the watchdog to clear out its state */
-	cvmx_write_csr(CVMX_CIU_PP_POKEX(core), 1);
+	cvmx_write_csr_node(node, CVMX_CIU_PP_POKEX(core), 1);
 
 	/* Finally enable the watchdog now that all handlers are installed */
 	ciu_wdog.u64 = 0;
 	ciu_wdog.s.len = timeout_cnt;
 	ciu_wdog.s.mode = 3;	/* 3 = Interrupt + NMI + Soft-Reset */
-	cvmx_write_csr(CVMX_CIU_WDOGX(core), ciu_wdog.u64);
+	cvmx_write_csr_node(node, CVMX_CIU_WDOGX(core), ciu_wdog.u64);
 
 	return 0;
 }
@@ -343,20 +412,20 @@ static int octeon_wdt_ping(struct watchdog_device __always_unused *wdog)
 {
 	int cpu;
 	int coreid;
+	int node;
 
 	if (disable)
 		return 0;
 
 	for_each_online_cpu(cpu) {
 		coreid = cpu2core(cpu);
-		cvmx_write_csr(CVMX_CIU_PP_POKEX(coreid), 1);
+		node = cpu_to_node(cpu);
+		cvmx_write_csr_node(node, CVMX_CIU_PP_POKEX(coreid), 1);
 		per_cpu_countdown[cpu] = countdown_reset;
 		if ((countdown_reset || !do_countdown) &&
 		    !cpumask_test_cpu(cpu, &irq_enabled_cpus)) {
 			/* We have to enable the irq */
-			int irq = OCTEON_IRQ_WDOG0 + coreid;
-
-			enable_irq(irq);
+			enable_irq(octeon_wdt_cpu_to_irq(cpu));
 			cpumask_set_cpu(cpu, &irq_enabled_cpus);
 		}
 	}
@@ -395,6 +464,7 @@ static int octeon_wdt_set_timeout(struct watchdog_device *wdog,
 	int cpu;
 	int coreid;
 	union cvmx_ciu_wdogx ciu_wdog;
+	int node;
 
 	if (t <= 0)
 		return -1;
@@ -406,12 +476,13 @@ static int octeon_wdt_set_timeout(struct watchdog_device *wdog,
 
 	for_each_online_cpu(cpu) {
 		coreid = cpu2core(cpu);
-		cvmx_write_csr(CVMX_CIU_PP_POKEX(coreid), 1);
+		node = cpu_to_node(cpu);
+		cvmx_write_csr_node(node, CVMX_CIU_PP_POKEX(coreid), 1);
 		ciu_wdog.u64 = 0;
 		ciu_wdog.s.len = timeout_cnt;
 		ciu_wdog.s.mode = 3;	/* 3 = Interrupt + NMI + Soft-Reset */
-		cvmx_write_csr(CVMX_CIU_WDOGX(coreid), ciu_wdog.u64);
-		cvmx_write_csr(CVMX_CIU_PP_POKEX(coreid), 1);
+		cvmx_write_csr_node(node, CVMX_CIU_WDOGX(coreid), ciu_wdog.u64);
+		cvmx_write_csr_node(node, CVMX_CIU_PP_POKEX(coreid), 1);
 	}
 	octeon_wdt_ping(wdog); /* Get the irqs back on. */
 	return 0;
@@ -467,6 +538,8 @@ static int __init octeon_wdt_init(void)
 
 	if (OCTEON_IS_MODEL(OCTEON_CN68XX))
 		divisor = 0x200;
+	else if (OCTEON_IS_MODEL(OCTEON_CN78XX))
+		divisor = 0x400;
 	else
 		divisor = 0x100;
 
-- 
2.1.4
