Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2018 02:39:03 +0200 (CEST)
Received: from mail-co1nam03on0723.outbound.protection.outlook.com ([IPv6:2a01:111:f400:fe48::723]:32001
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994676AbeDIAiz3lbWV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2018 02:38:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=egl5oHKUj9IEp6n8lPvXOvwebXn6sDak8tt9H2HfQ8s=;
 b=FIzAquUv74sq96IkqeHxDL+5qXsDd9BbhRYl8DkmggvG0sir1inKZc70Sv+RWrZ3q/OujHi/IrLhF0EO3rvjKNiEIBY1M2H0KKsnURzPF4+s6PnapcTzjIIxAfAgpwLdEJszx7wYj/lpoFWTDWnD75glHA8ExnCf0wzBPgdc5Ys=
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com (52.132.128.13) by
 DM5PR2101MB1125.namprd21.prod.outlook.com (52.132.130.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Mon, 9 Apr 2018 00:38:46 +0000
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059]) by DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059%2]) with mapi id 15.20.0696.003; Mon, 9 Apr 2018
 00:38:46 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Matt Redfearn <matt.redfearn@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 148/162] MIPS: TXx9: use IS_BUILTIN() for
 CONFIG_LEDS_CLASS
Thread-Topic: [PATCH AUTOSEL for 4.4 148/162] MIPS: TXx9: use IS_BUILTIN() for
 CONFIG_LEDS_CLASS
Thread-Index: AQHTz5nc/TRX1VlvbEqbQqnjFki92g==
Date:   Mon, 9 Apr 2018 00:29:45 +0000
Message-ID: <20180409002738.163941-148-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1125;7:PsUN3m0X55NWHICTir3SOEgAXUFZMsfUzUI26bdhAHauOa+vnWkhmtfsOKbsQVDst4kFEKjHC0t28Ghb7EvEVe8eJ2mENiNKJSdL8rT+W7nTgiYTb3bwVA74Ym4fwepsL8O5QHJ2f9xI2XflmTzErbyvtXBtk0y3/PZqwJzgH2/ldSIoUiTbdhm1k5mn06USVY54/ecYPyv2HmSCe67w2ifaaA8iztJcDNolBt2c6m8fJ99BVmnW0smSdvlvwKAt;20:MmJnWvrzOsWS7MkgDYfRSURU3J0sMmFF4nY5wvdEWMGbff1goJSl8cH1Esk8HTAef7rb61lFfAKlit0BSA1kjyavY6wHC6RYSdpb4gcYoZEj2VemoacA98/USW32CwXtmj/ApZcLDAYvmdZIf5cCEjV37WxTY+H0KruAU4agESY=
X-MS-Office365-Filtering-Correlation-Id: 590832db-53d5-4be7-c32f-08d59db24122
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1125;
x-ms-traffictypediagnostic: DM5PR2101MB1125:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB1125680C6836FF00E1F9ECEEFBBF0@DM5PR2101MB1125.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1125;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1125;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(366004)(376002)(396003)(189003)(199004)(2906002)(25786009)(6512007)(10090500001)(3280700002)(10290500003)(6306002)(3660700001)(316002)(110136005)(54906003)(11346002)(107886003)(2616005)(476003)(446003)(36756003)(99286004)(86612001)(53936002)(4326008)(486006)(6436002)(3846002)(81156014)(305945005)(966005)(5250100002)(1076002)(102836004)(14454004)(66066001)(7736002)(105586002)(81166006)(59450400001)(106356001)(8676002)(97736004)(6116002)(6506007)(6486002)(5660300001)(186003)(76176011)(22452003)(72206003)(478600001)(2501003)(2900100001)(26005)(86362001)(8936002)(68736007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1125;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rbaz5VrpSwyv9GTOjnq+6phGOrOEbV1kv6tdozNEs7C4ENMHeQwrTPdXZDliL5H8x5CCWGvnulMT00uV4I7NxwJr5OHEYc/MI7DkbQgi0lxnnd9keHLwlVYtAv8eWpTROy85TcMZY4kI7J8HUN1GwlGyGpitwuilQ8HS1C99/tL7Mpor8l0hZS6+1UeyijKtlHraQvAMYyzW9GzbiucExlQlHGNXjLP5E9/qYax33KGgrdrWsfMXunR4fmdkf8TkDpNenFN+ArX0s0sgxSAjEtvYfv+BwMHrYqPTWi/5OX25pRZ/w80KDvrKARlZ0YTDgteENIL32uLbaiN/9OZt+FyvTlo3vPhNhYuMW67/Ml08HFGwiFZ9yLypw9k7SWgjpI63XIe+mC1cIl4q9pEEt1kAuCzJT04PPI5gin8jgjo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 590832db-53d5-4be7-c32f-08d59db24122
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:45.4902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1125
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63467
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
index 37030409745c..586ca7ea3e7c 100644
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
