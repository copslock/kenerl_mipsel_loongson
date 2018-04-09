Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2018 02:32:30 +0200 (CEST)
Received: from mail-by2nam03on0724.outbound.protection.outlook.com ([IPv6:2a01:111:f400:fe4a::724]:10945
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994664AbeDIAbYUK8-V convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2018 02:31:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fFUbUC0RUvzUN5P/5ET8l8KSrRp4ootgu8yrJB0iYGQ=;
 b=YOjNGP0zPrIJMbI0gCa1ThdSJtz8mctLAog09MgJaSRe4HNv4pCLwVhROSi8WPcYPhsdopr8/4grlZC37ukhI5W9oUNsBp+rgn85yfyLKxdDHk9ZTEW5Q40z2Er4Gutm4umCtT4IgmKzff4EEzdCG/EIdM+9lQn9am2wpjUDaUY=
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com (52.132.128.13) by
 DM5PR2101MB0917.namprd21.prod.outlook.com (52.132.132.162) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Mon, 9 Apr 2018 00:31:18 +0000
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059]) by DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059%2]) with mapi id 15.20.0696.003; Mon, 9 Apr 2018
 00:31:18 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 171/293] MIPS: CPS: Handle spurious VP starts
 more gracefully
Thread-Topic: [PATCH AUTOSEL for 4.9 171/293] MIPS: CPS: Handle spurious VP
 starts more gracefully
Thread-Index: AQHTz5k2XxVssYY/NEKhyOL9pt1Zbw==
Date:   Mon, 9 Apr 2018 00:25:08 +0000
Message-ID: <20180409002239.163177-171-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;7:u7Y+4lOFnBLRwxnDJF5Vv/cB0jhF2zVGCoePqOm8EjiKK/1z6zPyJBKF+8bmBwUh0/iPFOq95bUyapG0THotYXFlGt2ORx/FYnLQJ6gbQ+K3xG1Qcmx4AWLLcjkGQxvLUAX95sqXTwuOJW671eZaEfsGOSRZCOOl6oa7+UXaURnR6zc+pKA+w0IMsGceCQZ1CAFxOnmaNHbOhZ3yJ9AD+tt45IMUeHUn19GzcN5RhaMHmt2yXKMGwqFeQNtPThq9;20:r09pQJy6ll4cNInjbef9PIEwibH6ExBOfoDXs6urXa8Ee/74XhQiekdoMg3+nJq+IhxqyT1mR1B37J1VS7gZNt8kWfU9icbmZkpC47YRtwXfMd8pgEAljLALqQ4/gMoCk3k0QHvjC3M/ClFE2jcj0l/I74wgi3Hdd0HypOFewBY=
X-MS-Office365-Filtering-Correlation-Id: 8b1ed94f-c1de-4847-4d42-08d59db13623
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB0917B7AFFB97BBCE880AA4E4FBBF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(189003)(199004)(99286004)(22452003)(106356001)(26005)(110136005)(478600001)(54906003)(10290500003)(316002)(1076002)(72206003)(186003)(4326008)(97736004)(66066001)(11346002)(25786009)(86362001)(575784001)(476003)(446003)(2906002)(6666003)(6486002)(105586002)(86612001)(3280700002)(3660700001)(6512007)(3846002)(6306002)(6116002)(6436002)(2616005)(486006)(53936002)(7736002)(8676002)(81166006)(81156014)(8936002)(68736007)(305945005)(10090500001)(76176011)(6506007)(102836004)(36756003)(107886003)(59450400001)(2900100001)(2501003)(14454004)(966005)(5660300001)(5250100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: G/856DcZFXkDvtzlR1XX8+XBbLVde0wxlTvYskO0Ax2UctFY+FM6pgfUR1I3526/ShZ9PN0yKJW+ViygTwZAR/b1UsVzNfGqQGe9LkBLfy5v/8n9ShdXqrjfFVuuw8LGbO8MuLHtXevqaFVigl8L4PzX7tqdxKZMlQXv2BWpAwYmykCC0I3jNssXH3iDxclMobYZdHtFE4U3zNWlaQPwtMVVkpf80ymmg7c9OquHTiSXKnnTDBFmzjBHo8e6E98uQJAtC93+LGsKJWF7Z7ok+jPTkCBzhVbAqwejX5Y380Uk7C6D79siFg2n0V9u7TEHTCg1eSMv3YFQiVbMG3PyeMQtoNPK3shcGQpbK5nKjwGf93KWa/vRnInxHJAs8iamxv501SqiJDTUvRSFJ0Jeb9kyLg6BJQmTvY5HwhD+D+w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1ed94f-c1de-4847-4d42-08d59db13623
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:08.4251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63450
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

[ Upstream commit fa7a3b4a7217b40bf58c4f38e5ee573b43a8aa2f ]

On pre-r6 systems with the MT ASE the CPS SMP code included checks to
halt the VPE running mips_cps_boot_vpes() if its bit in the struct
core_boot_config vpe_mask field is clear. This was largely done in order
to allow us to start arbitrary VPEs within a core despite the fact that
hardware is typically configured to run only VPE0 after powering up a
core. VPE0 would start the desired other VPEs, halt itself, and the fact
that VPE0 started would be largely hidden & irrelevant.

In MIPSr6 multithreading we have control over which VPs start executing
when a core powers up via the cores CPC registers accessed remotely
through the redirect block. For this reason the MIPSr6 multithreading
path in mips_cps_boot_vpes() hasn't bothered up until now to handle
halting the VP running it.

However it is possible to power up cores entirely in hardware by using a
pwr_up pin associated with the core. Unfortunately some systems wire
this pin to a logic 1, which means that it is possible for a core to
power up at a point that software doesn't expect. The result is that we
generally go execute the kernel on a CPU that ought not to be running &
the results can be unpredictable.

Handle this case by stopping VPs that we don't expect to be running in
mips_cps_boot_vpes() - with this change even if a core powers up it will
do nothing useful & all VPs within it will stop running before they
proceed to run general kernel code & do any damage. Ideally we would
produce some sort of warning here, but given the stage of core bringup
this happens at that would be non-trivial. We also will only hit this if
a core starts up after being offlined via hotplug, and when that happens
we will already produce a warning that the CPU didn't power down in
cps_cpu_die() which seems sufficient.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/16198/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/kernel/cps-vec.S | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index a00e87b0256d..b849fe6aad94 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -22,6 +22,7 @@
 #define GCR_CL_COHERENCE_OFS	0x2008
 #define GCR_CL_ID_OFS		0x2028
 
+#define CPC_CL_VC_STOP_OFS	0x2020
 #define CPC_CL_VC_RUN_OFS	0x2028
 
 .extern mips_cm_base
@@ -376,8 +377,12 @@ LEAF(mips_cps_boot_vpes)
 	PTR_LI	t2, UNCAC_BASE
 	PTR_ADD	t1, t1, t2
 
-	/* Set VC_RUN to the VPE mask */
+	/* Start any other VPs that ought to be running */
 	PTR_S	ta2, CPC_CL_VC_RUN_OFS(t1)
+
+	/* Ensure this VP stops running if it shouldn't be */
+	not	ta2
+	PTR_S	ta2, CPC_CL_VC_STOP_OFS(t1)
 	ehb
 
 #elif defined(CONFIG_MIPS_MT)
-- 
2.15.1
