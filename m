Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Aug 2017 21:44:53 +0200 (CEST)
Received: from mail-sn1nam01on0111.outbound.protection.outlook.com ([104.47.32.111]:45056
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994843AbdHGToeTq3F2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Aug 2017 21:44:34 +0200
Received: from SN1PR0101MB1565.prod.exchangelabs.com (10.163.128.23) by
 SN1PR0101MB1568.prod.exchangelabs.com (10.163.128.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.1.1304.22; Mon, 7 Aug 2017 19:44:22 +0000
Received: from SN1PR0101MB1565.prod.exchangelabs.com ([10.163.128.23]) by
 SN1PR0101MB1565.prod.exchangelabs.com ([10.163.128.23]) with mapi id
 15.01.1304.027; Mon, 7 Aug 2017 19:44:22 +0000
From:   Hartley Sweeten <HartleyS@visionengravers.com>
To:     Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
CC:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        "Cyrille Pitchen" <cyrille.pitchen@wedev4u.fr>,
        Peter Pan <peterpandong@micron.com>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        "Aaro Koskinen" <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        "Alexander Clouter" <alex@digriz.org.uk>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Steven Miao <realmz6@gmail.com>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Wenyou Yang <wenyou.yang@atmel.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Han Xu" <han.xu@nxp.com>, Harvey Hunt <harveyhuntnexus@gmail.com>,
        "Vladimir Zapolskiy" <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Wan ZongShun <mcuos.com@gmail.com>,
        "Neil Armstrong" <narmstrong@baylibre.com>,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        Stefan Agner <stefan@agner.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "adi-buildroot-devel@lists.sourceforge.net" 
        <adi-buildroot-devel@lists.sourceforge.net>,
        "linux-cris-kernel@axis.com" <linux-cris-kernel@axis.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-oxnas@lists.tuxfamily.org" <linux-oxnas@lists.tuxfamily.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>
Subject: RE: [PATCH] mtd: nand: Rename nand.h into rawnand.h
Thread-Topic: [PATCH] mtd: nand: Rename nand.h into rawnand.h
Thread-Index: AQHTDTZzfplHvw6zWUavdC+FZm8F/qJ0UmkAgAT90bA=
Date:   Mon, 7 Aug 2017 19:44:22 +0000
Message-ID: <SN1PR0101MB1565E57B6E4B074BC235DCACD0B50@SN1PR0101MB1565.prod.exchangelabs.com>
References: <1501860550-16506-1-git-send-email-boris.brezillon@free-electrons.com>
 <1501860550-16506-2-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1501860550-16506-2-git-send-email-boris.brezillon@free-electrons.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=HartleyS@visionengravers.com; 
x-originating-ip: [184.183.19.121]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR0101MB1568;6:YzlvuU3S9Kas1n4u7OqUW7m3wiUR791GfrIzf4SJ4MDWn9g1d4n86j/PaKbhvvUa+NcKlf2dxEzFduM58zUAE5sWnbOxy9xsv3Hw5b4Cow0jM+kwqzhPs018vxdk+hkV29qVnmzqIgFtLdSx/+eItYfSlRO9EqEiZ8ZtbZGZhTM4TO/WIp1y2BEYNdWLE2i2Z+twfuMQWGZPeL4UXIXJdPm61p9esIkogQcTJgueRUG8OiM1O7p/50xmz6eLI56HlmJJgtdGDT3//wMBqBeqdYLs4UOAK2FmJVlKUo17doXN8yHc/t81gllnvS1gilEXEXoXfZ2ACHhESf2p0Ex9NA==;5:bjQbteG3lpEN0obkLcObhdxIeMIgTMGQc4is8tqUK0qnq33+z6fA+cK96WhKKFMhfyb1MN+lS8ul8NVbkQEw5Pjv/obzN/Udt9jvK713VHNwxqB5X+ZZo2dbj2WL/ZV8qaOk8pj8iLpEb4NPJn4qeQ==;24:WDh0gRyl42cN5Q2PzreJTc5JogOHqmf5VMj+CsrgZY0+ydQsG4Dp9NFnAYQqzGOps77j2Keg0OqdZ0j4wKM+n7UOlfIDOlHc56vPaT4+8/Q=;7:XlqrSvwZzdLCbFvOYB1xuDGleipr9ux7bMLs8nb+MOmXRlCotCAyIho2txa2hAhrEhDapfJy+u7k2gCgQXudJ4Ajk1Kht90HlgosUfFo76rXqF38O2NsnzQbQp0HurJNQnY8zPzIkA/V5AdtA6crfotRrbTZG/H/m0DVkhhGOVK30BGISImJdouRJc5YzDOfRMlgB3HoACnjdXRFTizaobTzH5jJLTH5hfR4RL/0EwE=
x-ms-office365-filtering-correlation-id: d1c38cfe-4f1e-4812-2fae-08d4ddccb3bb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(2017082002075)(300000503095)(300135400095)(2017052603031)(201703131423075)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:SN1PR0101MB1568;
x-ms-traffictypediagnostic: SN1PR0101MB1568:
x-exchange-antispam-report-test: UriScan:;
x-microsoft-antispam-prvs: <SN1PR0101MB1568D089DA40B10D595867ECD0B50@SN1PR0101MB1568.prod.exchangelabs.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(100000703101)(100105400095)(6041248)(20161123555025)(20161123558100)(2016111802025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123562025)(20161123560025)(6072148)(6043046)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN1PR0101MB1568;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN1PR0101MB1568;
x-forefront-prvs: 0392679D18
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(39410400002)(39400400002)(39450400003)(39840400002)(199003)(189002)(377454003)(24454002)(14454004)(9686003)(76176999)(53936002)(6246003)(50986999)(97736004)(7736002)(5660300001)(54356999)(4326008)(74316002)(3280700002)(53546010)(102836003)(6116002)(54906002)(68736007)(106356001)(101416001)(3660700001)(305945005)(3846002)(38730400002)(99286003)(80792005)(8656003)(105586002)(8936002)(6506006)(189998001)(229853002)(2900100001)(33656002)(86362001)(2950100002)(25786009)(39060400002)(7366002)(7696004)(55016002)(7406005)(6436002)(7416002)(66066001)(2906002)(77096006)(478600001)(2501003)(8676002)(81156014)(72206003)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR0101MB1568;H:SN1PR0101MB1565.prod.exchangelabs.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (protection.outlook.com: visionengravers.com does not
 designate permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: visionengravers.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2017 19:44:22.0944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d698601f-af92-4269-8099-fd6f11636477
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0101MB1568
Return-Path: <HartleyS@visionengravers.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59398
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: HartleyS@visionengravers.com
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

T24gRnJpZGF5LCBBdWd1c3QgMDQsIDIwMTcgODoyOSBBTSwgQm9yaXMgQnJlemlsbG9uIHdyb3Rl
Og0KPiBXZSBhcmUgcGxhbm5pbmcgdG8gc2hhcmUgbW9yZSBjb2RlIGJldHdlZW4gZGlmZmVyZW50
IE5BTkQgYmFzZWQNCj4gZGV2aWNlcyAoU1BJIE5BTkQsIE9uZU5BTkQgYW5kIHJhdyBOQU5Ecyks
IGJ1dCBiZWZvcmUgZG9pbmcgdGhhdA0KPiB3ZSBuZWVkIHRvIG1vdmUgdGhlIGV4aXN0aW5nIGlu
Y2x1ZGUvbGludXgvbXRkL25hbmQuaCBmaWxlIGludG8NCj4gaW5jbHVkZS9saW51eC9tdGQvcmF3
bmFuZC5oIHNvIHdlIGNhbiBsYXRlciBjcmVhdGUgYSBuYW5kLmggaGVhZGVyDQo+IGNvbnRhaW5p
bmcgYWxsIGNvbW1vbiBzdHJ1Y3R1cmUgYW5kIGZ1bmN0aW9uIHByb3RvdHlwZXMuDQoNCkZvciBl
cDkzeHgsDQoNCkFja2VkLWJ5OiBIIEhhcnRsZXkgU3dlZXRlbiA8aHN3ZWV0ZW5AdmlzaW9uZW5n
cmF2ZXJzLmNvbT4NCg==
