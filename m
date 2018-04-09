Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2018 02:26:04 +0200 (CEST)
Received: from mail-bn3nam01on0097.outbound.protection.outlook.com ([104.47.33.97]:2944
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994661AbeDIAZkaep3V convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2018 02:25:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+/Dqa7FbR5j7K1LjP7egbAkmgRZyQcZi79+r1TCp51U=;
 b=BBDC9nYWsA3IoetD3KIH7Hd3h7s4QdhmO1aigrL61L4R6GzHDirb59OGR7jkGiWnilw7ZDBXyV1uQM3e5AsFlgnzQa15x5beBhyE9Ok4uroDytHTlwtj4AfofKwjBygq7jB0hExIqAoGfm0Z2zO7suEmEb0levNpqTToSzXycLY=
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com (52.132.128.13) by
 DM5PR2101MB1013.namprd21.prod.outlook.com (52.132.133.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Mon, 9 Apr 2018 00:25:30 +0000
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059]) by DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059%2]) with mapi id 15.20.0696.003; Mon, 9 Apr 2018
 00:25:30 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Matt Redfearn <matt.redfearn@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 124/161] MIPS: TXx9: use IS_BUILTIN() for
 CONFIG_LEDS_CLASS
Thread-Topic: [PATCH AUTOSEL for 4.14 124/161] MIPS: TXx9: use IS_BUILTIN()
 for CONFIG_LEDS_CLASS
Thread-Index: AQHTz5i35B5sXTqRnkuygn2sm+RC/Q==
Date:   Mon, 9 Apr 2018 00:21:34 +0000
Message-ID: <20180409001936.162706-124-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:Vkh4GFeLFH+3IgfLgSPwMjtIqJgMzYcuYU2QztAxoYoS1oK1GQ998+12oD9AS3kvNYDPN20HlIyHcqc2mz2/UmKZ2aRXwTI+FCbetS9Izmg+X80D4slcutjvc9v1xXjTnI+vAfyRTEjcMcNMroaj0gRaVWtGCIitrZ4/qTK2F6UNaI0i8kePdjNkf0y7xaJI4ZaZx7r0daORmz4NYj+JNX9iESvRocdISZSsppA/Zvo1rj/suBa6IaMeJhUAOgR/;20:o9gfW4QeoFDxcwidt9OD6NJLTKX659FWDciB5zXeobcpJJXAeeO80lFSmJjQLMhvVWxbaJnEKsTxFIXM4Ud4ZkR2LRnc0x2X/ANtqIFxhnMuPSYZc5mvtBf1MWj9H72L3Vk1VvhvwAE8P6tBi16VTIKH+TozhhiNUSlE1HyheAM=
X-MS-Office365-Filtering-Correlation-Id: 3b3d9764-1ee6-4a05-2385-08d59db06684
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB1013E8E726A7E431B9E413B9FBBF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(396003)(39860400002)(39380400002)(189003)(199004)(3280700002)(2616005)(8936002)(7736002)(476003)(446003)(11346002)(53936002)(3660700001)(86362001)(86612001)(81156014)(2906002)(186003)(81166006)(105586002)(1076002)(8676002)(26005)(97736004)(25786009)(6306002)(6512007)(3846002)(68736007)(72206003)(106356001)(5660300001)(6486002)(6116002)(966005)(14454004)(4326008)(305945005)(6436002)(2501003)(5250100002)(10290500003)(478600001)(2900100001)(59450400001)(22452003)(110136005)(316002)(99286004)(66066001)(10090500001)(107886003)(76176011)(102836004)(54906003)(6506007)(36756003)(486006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Y3eTXqwXTJ33Gc5ByTF6ZE52fLjXZcEKyBHu2CVbsh1sRnX1DutlwkKpriAwPgZebCr668PZzMGOwj5eMZ4x6a0Nx+dO4krO62RpgnvB6vZ9DV9CkwO9g9p/+5YrNUl/yjghUP+Rre/oml+pyHrhJQ49BA/WmDaMg5uH8cJ3IPyB6/4JtkCZDsNqptFQKn8ozJEmyWEdHjd3GTV/1CJz502zM4d8CUGvKiSQ6tBc/BTbfCaryXA0VWB0jY5e69zJiBs1PILKxYGPRHykkLg/GnKhTssc5WNyorlwyD4jnlme9DC1/FOVd713vlqSjxoxAXjyB3nEieGz715K2ZJ245Ozo4iLdi7zuAALv7mHfkaUsFvK/4LceOYIES2OlC4zM9FBKsDuhR2tJV1hZbJwdKzLpoFdO0Hcaco6pup6AbM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3d9764-1ee6-4a05-2385-08d59db06684
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:34.5811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63442
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

[ Upstream commit 0cde5b44a30f1daaef1c34e08191239dc63271c4 ]

When commit b27311e1cace ("MIPS: TXx9: Add RBTX4939 board support")
added board support for the RBTX4939, it added a call to
led_classdev_register even if the LED class is built as a module.
Built-in arch code cannot call module code directly like this. Commit
b33b44073734 ("MIPS: TXX9: use IS_ENABLED() macro") subsequently
changed the inclusion of this code to a single check that
CONFIG_LEDS_CLASS is either builtin or a module, but the same issue
remains.

This leads to MIPS allmodconfig builds failing when CONFIG_MACH_TX49XX=y
is set:

arch/mips/txx9/rbtx4939/setup.o: In function `rbtx4939_led_probe':
setup.c:(.init.text+0xc0): undefined reference to `of_led_classdev_register'
make: *** [Makefile:999: vmlinux] Error 1

Fix this by using the IS_BUILTIN() macro instead.

Fixes: b27311e1cace ("MIPS: TXx9: Add RBTX4939 board support")
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Reviewed-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/18544/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/txx9/rbtx4939/setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/txx9/rbtx4939/setup.c b/arch/mips/txx9/rbtx4939/setup.c
index 8b937300fb7f..fd26fadc8617 100644
--- a/arch/mips/txx9/rbtx4939/setup.c
+++ b/arch/mips/txx9/rbtx4939/setup.c
@@ -186,7 +186,7 @@ static void __init rbtx4939_update_ioc_pen(void)
 
 #define RBTX4939_MAX_7SEGLEDS	8
 
-#if IS_ENABLED(CONFIG_LEDS_CLASS)
+#if IS_BUILTIN(CONFIG_LEDS_CLASS)
 static u8 led_val[RBTX4939_MAX_7SEGLEDS];
 struct rbtx4939_led_data {
 	struct led_classdev cdev;
@@ -261,7 +261,7 @@ static inline void rbtx4939_led_setup(void)
 
 static void __rbtx4939_7segled_putc(unsigned int pos, unsigned char val)
 {
-#if IS_ENABLED(CONFIG_LEDS_CLASS)
+#if IS_BUILTIN(CONFIG_LEDS_CLASS)
 	unsigned long flags;
 	local_irq_save(flags);
 	/* bit7: reserved for LED class */
-- 
2.15.1
