Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2018 02:21:16 +0200 (CEST)
Received: from mail-sn1nam01on0126.outbound.protection.outlook.com ([104.47.32.126]:1088
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991172AbeDIAUfmsdbG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2018 02:20:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=D8Q5W03mgNZuzBZTpOGSmyjkp8KsscGI7ISYH3ffmko=;
 b=GA/bzgqzZdr/fQ3LfwMvutXIvFso/9dWqTRcDkVzRAi9bKSoNTb0l8tgY0mVS2DKAVcRIR+n+vXNh7D4WgGNVyEnVT3fBvLjBFUWh47fOKRxlrgGf7WYSew/jc9yYaYzpuOdusWd1HC0Dx0QHFe4sNdjuqmoOquzJ2IRnZfarkU=
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com (52.132.128.13) by
 DM5PR2101MB0920.namprd21.prod.outlook.com (52.132.132.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Mon, 9 Apr 2018 00:20:26 +0000
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059]) by DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059%2]) with mapi id 15.20.0696.003; Mon, 9 Apr 2018
 00:20:26 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Matt Redfearn <matt.redfearn@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 150/189] MIPS: Generic: Support GIC in EIC
 mode
Thread-Topic: [PATCH AUTOSEL for 4.15 150/189] MIPS: Generic: Support GIC in
 EIC mode
Thread-Index: AQHTz5hUwC6tf/p33kSe6T2vklBYLA==
Date:   Mon, 9 Apr 2018 00:18:49 +0000
Message-ID: <20180409001637.162453-150-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:jFjNDB5vyvd8I6SANA7eD/Q02GiBixoJJc/3EGFj9IyHh4wOwNYgtOSTy8GmaAEd/0H0syeavU+JbMVztmU29BUEdEpiH4JuXMguC+qcK59O52DdRiyHeNNYPWFsK/o5u9Z7I8xWfvypbIuxHQOEo2EzGZzuabsPKjF6zzq85G/aJbODcHD9Ab8dL69qJSO070BnFiOhEISzQW+bC1wd+yYMgyy/kzutggE6n+y/UGV8RRyRGg2E72FFjsurpEv5;20:Eawla2eZlvuASHh4XVtpf4EDqtN1+3LqOKgVB1orK7zAhZOVfuJZijhXnaQ+SOpZgSjpQqYV7NjEzzX4th2kncSmhHT0iuuo+4psG8VqcdO6oJ2s0WGPDWYq6tyBN23eHpyBvhIThW0RZ6/HO70bLsbXqAYBJkDFAOsqu2w/h7A=
X-MS-Office365-Filtering-Correlation-Id: b3338b6b-23ba-4db7-7aa1-08d59dafb151
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB09200844CB1D8C9C8041854CFBBF0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(346002)(376002)(199004)(189003)(66066001)(86362001)(3660700001)(3280700002)(25786009)(76176011)(2900100001)(36756003)(6506007)(2906002)(99286004)(86612001)(6486002)(102836004)(305945005)(1076002)(7736002)(97736004)(2616005)(446003)(11346002)(476003)(486006)(26005)(6666003)(6512007)(4326008)(107886003)(6306002)(5660300001)(478600001)(6436002)(105586002)(10290500003)(966005)(5250100002)(22452003)(316002)(186003)(8676002)(110136005)(81166006)(54906003)(6116002)(8936002)(72206003)(53936002)(2501003)(3846002)(68736007)(14454004)(81156014)(10090500001)(106356001)(22906009)(41533002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ntIDHqERxAIBmO9bSJUDUQORkPILXQo0fT7SAkImzBRwv4bTVMTLJJkdskQcpUegam7poe1yjz3td+7q2wTLMeSDXQgKWGIrp/+QAVabPF54ZJkL1eqrgeveanj3gI/nZj+cRdfoCFVetpJjhMd8JLF2FePu8nmJ0Ak8QGCLuiWQQz1kcZFWcuuatYqMqwgu0n0wFiyg+A2ZsY9wWpTtik0S3YMtBU8DKXrraCIUUGkgZzXqy6KgcF4MuQ6yIAg7NxEMa+/KwpbJC5EyPFjzt5AmPSJPTCqsc7y7AXLdsHXw4AFfLLrdry0OBDMONJ6LOMvtq+QS9xgXaFlntLMmM38V1qlxzlIFZcyM7xTmeYlhR1fW6vu2+WLvabXYJL+tdSZoqZE1OPMzvR+rBjDpQfw5x6jVqNtDwr0Lg9uOCkE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3338b6b-23ba-4db7-7aa1-08d59dafb151
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:49.2216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63437
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Alexander.Levin@microsoft.com
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

From: Matt Redfearn <matt.redfearn@mips.com>

[ Upstream commit 7bf8b16d1b60419c865e423b907a05f413745b3e ]

The GIC supports running in External Interrupt Controller (EIC) mode,
and will signal this via cpu_has_veic if enabled in hardware. Currently
the generic kernel will panic if cpu_has_veic is set - but the GIC can
legitimately set this flag if either configured to boot in EIC mode, or
if the GIC driver enables this mode. Make the kernel not panic in this
case, and instead just check if the GIC is present. If so, use it's CPU
local interrupt routing functions. If an EIC is present, but it is not
the GIC, then the kernel does not know how to get the VIRQ for the CPU
local interrupts and should panic. Support for alternative EICs being
present is needed here for the generic kernel to support them.

Suggested-by: Paul Burton <paul.burton@mips.com>
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/18191/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/generic/irq.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/mips/generic/irq.c b/arch/mips/generic/irq.c
index 394f8161e462..cb7fdaeef426 100644
--- a/arch/mips/generic/irq.c
+++ b/arch/mips/generic/irq.c
@@ -22,10 +22,10 @@ int get_c0_fdc_int(void)
 {
 	int mips_cpu_fdc_irq;
 
-	if (cpu_has_veic)
-		panic("Unimplemented!");
-	else if (mips_gic_present())
+	if (mips_gic_present())
 		mips_cpu_fdc_irq = gic_get_c0_fdc_int();
+	else if (cpu_has_veic)
+		panic("Unimplemented!");
 	else if (cp0_fdc_irq >= 0)
 		mips_cpu_fdc_irq = MIPS_CPU_IRQ_BASE + cp0_fdc_irq;
 	else
@@ -38,10 +38,10 @@ int get_c0_perfcount_int(void)
 {
 	int mips_cpu_perf_irq;
 
-	if (cpu_has_veic)
-		panic("Unimplemented!");
-	else if (mips_gic_present())
+	if (mips_gic_present())
 		mips_cpu_perf_irq = gic_get_c0_perfcount_int();
+	else if (cpu_has_veic)
+		panic("Unimplemented!");
 	else if (cp0_perfcount_irq >= 0)
 		mips_cpu_perf_irq = MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
 	else
@@ -54,10 +54,10 @@ unsigned int get_c0_compare_int(void)
 {
 	int mips_cpu_timer_irq;
 
-	if (cpu_has_veic)
-		panic("Unimplemented!");
-	else if (mips_gic_present())
+	if (mips_gic_present())
 		mips_cpu_timer_irq = gic_get_c0_compare_int();
+	else if (cpu_has_veic)
+		panic("Unimplemented!");
 	else
 		mips_cpu_timer_irq = MIPS_CPU_IRQ_BASE + cp0_compare_irq;
 
-- 
2.15.1
