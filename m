Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Mar 2018 06:01:03 +0100 (CET)
Received: from mail-co1nam03on0124.outbound.protection.outlook.com ([104.47.40.124]:56639
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991534AbeCHFA5GfVVD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Mar 2018 06:00:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=7af8KOME2cjogO1QVwe63oblOPj6Ek8f+lF7pghjlI4=;
 b=U72CC7WQmWmNqCeyiPNFtNmxBXfOp+tANpf5hR5/ryq46Hr/nfR/A2HG9c++DjSDDNcxEn+n0KaeBVs6Nt+TLzqAzFWyJpKqfcMng3MJxGdbyTf0fXxknBG5fh4/RomCmyDrpF1cPekqyEnDv9N8CDqeldrV5zqJvE1tjo2AaSw=
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com (52.132.128.13) by
 DM5PR2101MB1109.namprd21.prod.outlook.com (52.132.130.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.588.3; Thu, 8 Mar 2018 05:00:46 +0000
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8063:c68a:b210:7446]) by DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8063:c68a:b210:7446%2]) with mapi id 15.20.0588.008; Thu, 8 Mar 2018
 05:00:46 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 054/190] irqchip/mips-gic: Separate IPI
 reservation & usage tracking
Thread-Topic: [PATCH AUTOSEL for 4.9 054/190] irqchip/mips-gic: Separate IPI
 reservation & usage tracking
Thread-Index: AQHTtpo1c56ZN0UDBUqLv7kamsDmXA==
Date:   Thu, 8 Mar 2018 04:59:15 +0000
Message-ID: <20180308045810.8041-54-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:TuhL3/DaIyUoXvbytYUOl7Mms8biJjtSX2juhhcTzMR8275JKWThZt2AU9XaqC4edp2/y/ENUFmojvMQFDBpvlrwoleA4e76d6+EaZ5753ac2/4D6T7EnHjTGKXA0CCs55teiaGuj0b1m0WUG0lhQTPNawdevNg83ScTZ8hnQkURUyG7msGvTwFvwU8T2dgs6j2UHEJQgJ1mU48JuQ9C39X+inpOfGF7HDujRDibutjkROAU1WM3h4HG2+8a0V55;20:Sk0X8ftpMzxb64+oQn/DDDq1FwqlIKOvSZy1Ci4fXgiQnUTDY49YxGXPoG6OeVTO4uU4YvqKAGiQ2AhKD7pIU96dwzwc+Rhj67G4WcO6MwOulBfwNj5zAyfBg9lqRYvAw6Pqu5FXniTGjGZOQjtqXeTjZD7ZxW87P963dGRIBnA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 58f9ad5d-d709-46e0-1bfc-08d584b18dbf
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB11095AC853B5A21719F2DCA1FBDF0@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39380400002)(39860400002)(366004)(199004)(189003)(3660700001)(5250100002)(102836004)(6436002)(2501003)(81166006)(8936002)(6486002)(81156014)(53936002)(6306002)(6512007)(8676002)(6506007)(5660300001)(86612001)(76176011)(10290500003)(86362001)(575784001)(4326008)(105586002)(25786009)(10090500001)(26005)(2900100001)(316002)(106356001)(97736004)(54906003)(305945005)(7736002)(186003)(36756003)(22452003)(110136005)(14454004)(966005)(72206003)(6116002)(3846002)(68736007)(3280700002)(66066001)(2906002)(2950100002)(478600001)(6666003)(99286004)(1076002)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Hi1CsrBIfTIBbHFImJHJKFVp6TeXis/9GF5/EQlWdStVBbiLzcUx2uFrhkXR/6eB3gKFfWk/rbe7bjtc+/1ijfHD0CqfoA8CSN1AJX8TOKZhOLeKSos4TfF7Xs7vvesqonaDn9PNLI/6nLfl97VDwbq5BVqS3Nn1IKWFqZxTZ8NBUlQN/da6yhzqrKpSMKUaj8RXq8yK+QFDj2tsrs0Ik8CgyoHIcz9OOABENS/YsO0sVEhBsPoPF77tVlq1p95szPYeCteP9cKd6w9U8SaE0/vh3ReWOFAeN3KuObibUV0rZest6/o3FWUxI1P6DUyttWaSI+wtD8ppauGxo6LRLQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f9ad5d-d709-46e0-1bfc-08d584b18dbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:15.7951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62851
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

From: Paul Burton <paul.burton@imgtec.com>

[ Upstream commit f8dcd9e81797ae24acc44c84f0eb3b9e6cee9791 ]

Since commit 2af70a962070 ("irqchip/mips-gic: Add a IPI hierarchy
domain") introduced the GIC IPI IRQ domain we have tracked both
reservation of interrupts & their use with a single bitmap - ipi_resrv.
If an interrupt is reserved for use as an IPI but not actually in use
then the appropriate bit is set in ipi_resrv. If an interrupt is either
not reserved for use as an IPI or has been allocated as one then the
appropriate bit is clear in ipi_resrv.

Unfortunately this means that checking whether a bit is set in ipi_resrv
to prevent IPI interrupts being allocated for use with a device is
broken, because if the interrupt has been allocated as an IPI first then
its bit will be clear.

Fix this by separating the tracking of IPI reservation & usage,
introducing a separate ipi_available bitmap for the latter. This means
that ipi_resrv will now always have bits set corresponding to all
interrupts reserved for use as IPIs, whether or not they have been
allocated yet, and therefore that checking it when allocating device
interrupts works as expected.

Fixes: 2af70a962070 ("irqchip/mips-gic: Add a IPI hierarchy domain")
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Link: http://lkml.kernel.org/r/1492679256-14513-2-git-send-email-matt.redfearn@imgtec.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/irqchip/irq-mips-gic.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index d74374f25392..abf696b49dd7 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -55,6 +55,7 @@ static unsigned int gic_cpu_pin;
 static unsigned int timer_cpu_pin;
 static struct irq_chip gic_level_irq_controller, gic_edge_irq_controller;
 DECLARE_BITMAP(ipi_resrv, GIC_MAX_INTRS);
+DECLARE_BITMAP(ipi_available, GIC_MAX_INTRS);
 
 static void __gic_irq_dispatch(void);
 
@@ -746,17 +747,17 @@ static int gic_irq_domain_alloc(struct irq_domain *d, unsigned int virq,
 
 		return gic_setup_dev_chip(d, virq, spec->hwirq);
 	} else {
-		base_hwirq = find_first_bit(ipi_resrv, gic_shared_intrs);
+		base_hwirq = find_first_bit(ipi_available, gic_shared_intrs);
 		if (base_hwirq == gic_shared_intrs) {
 			return -ENOMEM;
 		}
 
 		/* check that we have enough space */
 		for (i = base_hwirq; i < nr_irqs; i++) {
-			if (!test_bit(i, ipi_resrv))
+			if (!test_bit(i, ipi_available))
 				return -EBUSY;
 		}
-		bitmap_clear(ipi_resrv, base_hwirq, nr_irqs);
+		bitmap_clear(ipi_available, base_hwirq, nr_irqs);
 
 		/* map the hwirq for each cpu consecutively */
 		i = 0;
@@ -787,7 +788,7 @@ static int gic_irq_domain_alloc(struct irq_domain *d, unsigned int virq,
 
 	return 0;
 error:
-	bitmap_set(ipi_resrv, base_hwirq, nr_irqs);
+	bitmap_set(ipi_available, base_hwirq, nr_irqs);
 	return ret;
 }
 
@@ -802,7 +803,7 @@ void gic_irq_domain_free(struct irq_domain *d, unsigned int virq,
 		return;
 
 	base_hwirq = GIC_HWIRQ_TO_SHARED(irqd_to_hwirq(data));
-	bitmap_set(ipi_resrv, base_hwirq, nr_irqs);
+	bitmap_set(ipi_available, base_hwirq, nr_irqs);
 }
 
 int gic_irq_domain_match(struct irq_domain *d, struct device_node *node,
@@ -1066,6 +1067,7 @@ static void __init __gic_init(unsigned long gic_base_addr,
 			   2 * gic_vpes);
 	}
 
+	bitmap_copy(ipi_available, ipi_resrv, GIC_MAX_INTRS);
 	gic_basic_init();
 }
 
-- 
2.14.1
