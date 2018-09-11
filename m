Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2018 23:50:52 +0200 (CEST)
Received: from mail-by2nam05on070e.outbound.protection.outlook.com ([IPv6:2a01:111:f400:fe52::70e]:27336
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992759AbeIKVulFl6ob (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Sep 2018 23:50:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdM45lrFOGVaIs/1aZF+8xhGUpz9vQQb30iuhsWihhI=;
 b=B3/uODT1oroQ22gDsamqgyhiv14/HuZLZLD0tVcso9CB2cLLxZQdr8p1dT0Xy8sQysvCvzT2Fr5siOKZGGTu2ORZzYNBwDZXsOzYcHMmpIGVD2R0TQl9FD+7SeJWzgqFO/ByE+6mTFB9/JIwKOJWFKtYZUDm/M+auMan/QsO+RI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
Received: from box.mipstec.com (4.16.204.77) by
 BN3PR0801MB2145.namprd08.prod.outlook.com (2a01:111:e400:7bb5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.18; Tue, 11 Sep
 2018 21:49:56 +0000
From:   Dengcheng Zhu <dzhu@wavecomp.com>
To:     pburton@wavecomp.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, rachel.mozes@intel.com,
        Dengcheng Zhu <dzhu@wavecomp.com>
Subject: [PATCH v5 3/5] MIPS: kexec: CPS systems to halt nonboot CPUs
Date:   Tue, 11 Sep 2018 14:49:22 -0700
Message-Id: <20180911214924.21993-4-dzhu@wavecomp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180911214924.21993-1-dzhu@wavecomp.com>
References: <20180911214924.21993-1-dzhu@wavecomp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR21CA0055.namprd21.prod.outlook.com
 (2603:10b6:3:129::17) To BN3PR0801MB2145.namprd08.prod.outlook.com
 (2a01:111:e400:7bb5::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f59987a-7a23-4642-09df-08d6183083df
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN3PR0801MB2145;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;3:Chbgu9NJGroz7ic66n+uL+FxMnAREQXD48Y7OVL87mTj4jRMi6D8tHggIKN2GPZagU4TFxNEipQROAKmTl0/zAqkHpu02EGlyD7kf9mUhWX938cOni8boxoEvFECH2MFj3N0CHZTF7/30Qzg+NqXRGnbrf5aSzYQi7MyrPsMJL2VNhinSC/CkKyjupS0pkUpXi3fXB6NuyLG++twVnzBeK6ghdUkyWzxJgdTI0240f+iMXkVB9c9MfcKH75R24LZ;25:SXbpU23up+wWmGETL+hPrw6UP7bRN311eism9ADzJfrVAEzTdehFqOpwW7W6ZhXVrk3XF2LuKE8e8WVPjJc+t5WbjHlvc9ze4Zy03/MFWujnyt7iAQouh7vR+r4WSQsYlsubazzrqXRAKH7nmOyorLlyCHOL1V9lzM4GDTr6/RSuaTnAo8dSqhRgvO3zxgTkgNZONOxYr+ANwpupHl2tYdvPBWQp5PPB2rlDR2O+5goIl/7I9Wd8bsG9jN53vlehP0+WpBooHHJ30sCdZC98wfa/A7qeZpVrTPgpXaxLCwMvhBzGmDWXqcgVfJME0J2l5XKWlY85cJePEyClJGcFPQ==;31:CztOM1GGM4NQzjiQgsTTNfDW7W4r+abmCMPgzXCTIk8RPAZPlGoBQulmqyhJyIra/2JYcNHDA+Qq8yAH1IlwkxSwNm6VGqYhKcT37lBTy3gAcbtilz60UP9j/zUSstrTHknZ25Fu54cZLS2GZsRA3aal+me7S9mFjXxsHwhq2U6/29LJBQnC2UXPfkYloj/L+GP9Wnw/+ZI7Cu2C/LxH0Ch8C4sA13ABk+3cidPXDpE=
X-MS-TrafficTypeDiagnostic: BN3PR0801MB2145:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;20:aABpNlFO3yWOJLLP3dydaUIDiGYudzzbix9lJPVPnB8LVHIzAJFL2857cgVgKcuDQjS4Le1l8lmAuW5aCGnKbLbN4bVxsSKwR+QGHkEW3VU9t3RHSHRV+pnzpYqXNMB2UisQly/oA1CjP6cjuVcwnXDv+fdfLBgtMbHNgugdSYjT/L6HcOzp3FnDXfj+ka2nd7KJJpg3V98gX5dHpbzdiAxz/dLosyqc2IcZxh1UhcylOjlJEvfDpl/AfK2i2iWj;4:NYT/cJaVhOejhaoF/L68pl418DC61DhZEKZdl/HSG4Z35L7j80BnYKd5++nsoX4X5tGyD5yu2yfZyFGc0hHpEl+Y1kQxqkpZX5T1Sc6Y+Ifh8GffroBcez8hizenFzCOb7M8Op7bRG9GrseERKFnA3Ads3MfrnTrdQil5cGCdkKpCQgTWdtUGOyohh64uNTWo2IX4XxKglNxoEp0nAZw64O5k0VkJKwj9gzUSrM4/gDyTPDmU+yDMTIf2Mj7ORSl0iw4LsVeoEknOfUc2RFAhA==
X-Microsoft-Antispam-PRVS: <BN3PR0801MB21451CADC410282577952AF3A2040@BN3PR0801MB2145.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699050);SRVR:BN3PR0801MB2145;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0801MB2145;
X-Forefront-PRVS: 0792DBEAD0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(39840400004)(136003)(366004)(199004)(189003)(6486002)(4326008)(316002)(2906002)(68736007)(8676002)(36756003)(16586007)(8936002)(53416004)(105586002)(37156001)(86362001)(48376002)(106356001)(25786009)(50226002)(50466002)(6666003)(66066001)(47776003)(305945005)(53936002)(5660300001)(76176011)(81156014)(52116002)(69596002)(16526019)(51416003)(6512007)(97736004)(3846002)(6116002)(6506007)(7736002)(386003)(26005)(81166006)(1076002)(2616005)(11346002)(446003)(478600001)(107886003)(486006)(956004)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR0801MB2145;H:box.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR0801MB2145;23:cNKJo5jVcU9FBNvbJ75zrnQLkxeUOzHkxxmB2wz?=
 =?us-ascii?Q?WLd1PFAwAgdfYGlN8cm32zr4nC11DHNCl/MHB1WaT9S6yQ3Ufqa74BWFkNmi?=
 =?us-ascii?Q?awAEFk4iQ5tEw5MWwGaVXAE3NVVNQYCEl9trEna+5SipnrtXoQbD/4XHgHIH?=
 =?us-ascii?Q?UW7oQ9gwWzv4CmgpK+erI0f0cLG2xhXRzXg1qgXYsn/dBHMcEWLpudYy1tba?=
 =?us-ascii?Q?MBkjOLR9iEo8zFA/7GFk6h5JmzPqEq3eGAowP1LKppZ44TsixkxOlSpZqBGL?=
 =?us-ascii?Q?jobEunzTh7jQvllJGwdM6jJbwb6KcoRXcsA9lnAPCxeWYBp64TU3YsH+dneL?=
 =?us-ascii?Q?65WUirnofcP2rAEse1nvJpH2ePB1UC+zrubt04h0tUDELxoiIPWKu7zZ/KNN?=
 =?us-ascii?Q?ecjiX3XDFGHPDSLiBuLKKK5bmLRzZ7uI6ucWlSyWjszRoXCBTWnTcxdfIRVn?=
 =?us-ascii?Q?SdP2S3tywTvQqiVMKJRaKPWv1XRUk4wmvdY/bhPPQ0xFlnYN1XPsL10S20DD?=
 =?us-ascii?Q?jNCyFbyQaD/RLgFl4oEVH9wHrn5WCEOUqhofyWHVI+ubpFXoYNtQ6DByo1/p?=
 =?us-ascii?Q?lCe1cv+diH64i10ijB7udlI9Z0kQgUXIyVkXBmFt23BBxnjLe3gtPgtoxKOo?=
 =?us-ascii?Q?96Hra8kJf8eP8TifB1ivSmHtAPabqX1kfXSX+qi7glSlonaIfOyziW6n2Bax?=
 =?us-ascii?Q?MNQvPfmc0XG8ZQq6yH6aP5Iwv0tCa6ZJcA16SbRwNs6XXIiPzkLB0q30NbLF?=
 =?us-ascii?Q?Du3HMdXJQYlbDE3ay0C2EQ1ek7OzCbFyqqMuIsDS1ZrdxllThmlkh9qmuC0H?=
 =?us-ascii?Q?EKLEGsq5wILRXm7cAJNhXyRjs8kuo2UUZqxcZkP+MoocMSWrAMsb0LTbkhM+?=
 =?us-ascii?Q?OJag+0xwBnntFSQda8t6ogxYqQ/ZBnMh0e5oEts5jV7OGkdQeqR4igAthOaA?=
 =?us-ascii?Q?r0jY7lpWZUf0Pu/3hrqLI4/HgExGgaMyOfvsDzcjxWieL3Ln2f81zs537Wnh?=
 =?us-ascii?Q?f0REZBGJMQA8TmkzpTGb/i4Ai/3lNxlobQZn/6EI+Hv49EYCkrj6Qp7c25rW?=
 =?us-ascii?Q?Ynlw5HVtM9JD4jrRaNityfkD6FvwErNBt+65j7XoP8UOvq07E++xXJar0cPH?=
 =?us-ascii?Q?xzKhh8DOf/CkuvkcDkLJAMGPZvKn2GPvUZu32yltliLGoxKHuvQ6BLCpJhjy?=
 =?us-ascii?Q?b/FSQ1cKbJfSJBROvD3sKFVYsagtsnPTCLR5guPgHCHEKjBbGuhuclUY6sg?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: YQv+bLU0aDncjpnDqaoW+vu6enfrYxbhV9aZZxX+bS20iu7sX4ThPE6PTV6855JQUZbQPrIKsfgEtgVjPy993iOd7+0EbkJPE9y2lMnrbsQR7PBgX3aBCsiipjreuPsnarso7Y7AV3SLdhYrnAq4XBEqagigY8D3SSX+3KbVZHDU34hWgSh2fnBdLFXjGlsUHiV4/I3U/0EI0sN+rYUuQC4bnHOjndYmYl3uOHhxfgnFtjrlhwhvAyOoWC9dFviH1TygLOcchdnOs4we+j3Fvtq47xBFJHb0cHS1YU+otMewsFKdc4PClj4vupwHFNsK6vaOBCWcO7CNGLyXkHKvsW3TO7O3oUj3uLMMgsUuOeQ=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;6:UtcVxeq8Ri+klXpCcLzuLP3VYKri3buNGUeAKuRYchbVaswCJh5hY9HSCWgDDn3XFNyESkQsvPH9AoG4iJsIrA7RBUuWLeToaq90wHR/j57YOhWxuBUIYmenmMyN9YbsbPuJ0zj51/KVVnm3w8O+tv/QMsBJQHqHwr8v+SamFNzJZGZebcXiw6d8oT3jGFjmKa/skN7w7/dDLl8xdbhjHBWcK6tGpmBl0UIJBYxNjjqhdb2Wy3Bx6gRGdRCyMGtcAZ3JIjtFM5DU13mleFxweSmWigL3JukKg0Xuk5ZHzdMHm6iBuDoase/5bHEaG9Y2wWoKDJ75qq4fHxbxzZ09gYm4BWprK7C/esA1XWdPwoUZZihqM/j2P+LtXY7py5Pgo7rW4JnQxlDqcVqqm03gokMbofnEOSkRVvGylqqwYS15/bBvs3lxfWS5eMAQyWlFLpumnnP955E3CpiKF4C0jQ==;5:j6hx+v3gwncOcwpqpTo2GOxF3L1k7QHHuiPzcDbNI5E+BKsmckyKKhNB/CHnpxVD2m7pBDU+16Cgs6hoXMqam7MMzCBzOfQnhqubYzBU/jLinYWzAkx8yLuppmInJqyF6hOjMpy5Gr2K5CM5DAsxPqlEr6485qarMc/NX6J5P5Q=;7:L1Oxh3h4wO3K0wtLP/4RKwe/H1h5Yq8Rl4PGxva0DpgvRnH6HxInHqZmi0PQ3MBBN/qj9nXpSHQBpxq70sI/rY91afCxiZljCMMNBUml0yBjpFHCSMk39iI23sMRaB+tLFYEComnQUABzBEuQxmeQZb6+RSyuvtnGV7eHYeT4T8oeQOkB6Eto8fKIG1TLWU6Q1bi/3fe+I2fVv00PehoTwH1tmTCNg29WVEtqOBW9YxWXLc/InqioF/o5m1AXAb5
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2018 21:49:56.3648 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f59987a-7a23-4642-09df-08d6183083df
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0801MB2145
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66208
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

Share code between play_dead() and cps_kexec_nonboot_cpu(). Register the
latter to mp_ops for kexec.

Signed-off-by: Dengcheng Zhu <dzhu@wavecomp.com>
---
 arch/mips/kernel/smp-cps.c | 80 ++++++++++++++++++++++++++------------
 1 file changed, 55 insertions(+), 25 deletions(-)

diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 03f1026ad148..faccfa4b280b 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -398,6 +398,55 @@ static void cps_smp_finish(void)
 	local_irq_enable();
 }
 
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_KEXEC)
+
+enum cpu_death {
+	CPU_DEATH_HALT,
+	CPU_DEATH_POWER,
+};
+
+static void cps_shutdown_this_cpu(enum cpu_death death)
+{
+	unsigned int cpu, core, vpe_id;
+
+	cpu = smp_processor_id();
+	core = cpu_core(&cpu_data[cpu]);
+
+	if (death == CPU_DEATH_HALT) {
+		vpe_id = cpu_vpe_id(&cpu_data[cpu]);
+
+		pr_debug("Halting core %d VP%d\n", core, vpe_id);
+		if (cpu_has_mipsmt) {
+			/* Halt this TC */
+			write_c0_tchalt(TCHALT_H);
+			instruction_hazard();
+		} else if (cpu_has_vp) {
+			write_cpc_cl_vp_stop(1 << vpe_id);
+
+			/* Ensure that the VP_STOP register is written */
+			wmb();
+		}
+	} else {
+		pr_debug("Gating power to core %d\n", core);
+		/* Power down the core */
+		cps_pm_enter_state(CPS_PM_POWER_GATED);
+	}
+}
+
+#ifdef CONFIG_KEXEC
+
+static void cps_kexec_nonboot_cpu(void)
+{
+	if (cpu_has_mipsmt || cpu_has_vp)
+		cps_shutdown_this_cpu(CPU_DEATH_HALT);
+	else
+		cps_shutdown_this_cpu(CPU_DEATH_POWER);
+}
+
+#endif /* CONFIG_KEXEC */
+
+#endif /* CONFIG_HOTPLUG_CPU || CONFIG_KEXEC */
+
 #ifdef CONFIG_HOTPLUG_CPU
 
 static int cps_cpu_disable(void)
@@ -421,19 +470,15 @@ static int cps_cpu_disable(void)
 }
 
 static unsigned cpu_death_sibling;
-static enum {
-	CPU_DEATH_HALT,
-	CPU_DEATH_POWER,
-} cpu_death;
+static enum cpu_death cpu_death;
 
 void play_dead(void)
 {
-	unsigned int cpu, core, vpe_id;
+	unsigned int cpu;
 
 	local_irq_disable();
 	idle_task_exit();
 	cpu = smp_processor_id();
-	core = cpu_core(&cpu_data[cpu]);
 	cpu_death = CPU_DEATH_POWER;
 
 	pr_debug("CPU%d going offline\n", cpu);
@@ -456,25 +501,7 @@ void play_dead(void)
 	/* This CPU has chosen its way out */
 	(void)cpu_report_death();
 
-	if (cpu_death == CPU_DEATH_HALT) {
-		vpe_id = cpu_vpe_id(&cpu_data[cpu]);
-
-		pr_debug("Halting core %d VP%d\n", core, vpe_id);
-		if (cpu_has_mipsmt) {
-			/* Halt this TC */
-			write_c0_tchalt(TCHALT_H);
-			instruction_hazard();
-		} else if (cpu_has_vp) {
-			write_cpc_cl_vp_stop(1 << vpe_id);
-
-			/* Ensure that the VP_STOP register is written */
-			wmb();
-		}
-	} else {
-		pr_debug("Gating power to core %d\n", core);
-		/* Power down the core */
-		cps_pm_enter_state(CPS_PM_POWER_GATED);
-	}
+	cps_shutdown_this_cpu(cpu_death);
 
 	/* This should never be reached */
 	panic("Failed to offline CPU %u", cpu);
@@ -593,6 +620,9 @@ static const struct plat_smp_ops cps_smp_ops = {
 	.cpu_disable		= cps_cpu_disable,
 	.cpu_die		= cps_cpu_die,
 #endif
+#ifdef CONFIG_KEXEC
+	.kexec_nonboot_cpu	= cps_kexec_nonboot_cpu,
+#endif
 };
 
 bool mips_cps_smp_in_use(void)
-- 
2.17.1
