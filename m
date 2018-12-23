Return-Path: <SRS0=3MQT=PA=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534D2C43387
	for <linux-mips@archiver.kernel.org>; Sun, 23 Dec 2018 16:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1719C2184D
	for <linux-mips@archiver.kernel.org>; Sun, 23 Dec 2018 16:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="dmi6S4yn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbeLWQRU (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 23 Dec 2018 11:17:20 -0500
Received: from mail-eopbgr690091.outbound.protection.outlook.com ([40.107.69.91]:40384
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729679AbeLWQRU (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sun, 23 Dec 2018 11:17:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxppYEN2VPpi7dF+CLOTQxjgrN6+8blnfAnDqqjpU2w=;
 b=dmi6S4ynqLfGGg+BEWR6Kbep/HKFpfmPlk4ndyrkF9kWi6FRkYz5Wvqbqqc1mtXX3qtFZNB9MSB4sZ4GLBo16QDhki8xpdDaLNinwT+45f9HE3whldnMvlVn9RA/d4kSb5zTbspcpn5/USVqrNnxVuGwejNs3jXd7H0Xa+WClH4=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1102.namprd22.prod.outlook.com (10.174.169.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.23; Sun, 23 Dec 2018 16:17:17 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%9]) with mapi id 15.20.1446.026; Sun, 23 Dec 2018
 16:17:17 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Stefan Roese <sr@denx.de>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Paul Burton <pburton@wavecomp.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] MIPS: ralink: Select CONFIG_CPU_MIPSR2_IRQ_VI on MT7620/8
Thread-Topic: [PATCH] MIPS: ralink: Select CONFIG_CPU_MIPSR2_IRQ_VI on
 MT7620/8
Thread-Index: AQHUle2YnEO8Lb8+Nkaw0lnxzQ5ocqWMihAA
Date:   Sun, 23 Dec 2018 16:17:17 +0000
Message-ID: <MWHPR2201MB1277D905BE702671A7F8E56CC1BA0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20181217094748.16059-1-sr@denx.de>
In-Reply-To: <20181217094748.16059-1-sr@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP265CA0004.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::16) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.197.89.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1102;6:/oWCqo8A1uA18w4DCQCTcLwXy0vZNYjtkIZWXV/fOgSu/8IhVFqKCYQcfHoe4WARJAlYAh57yH+bYws7NoHytdYNBvzvWQ/NElhj6KSqe1xf67U1uqDue1qMTPDGiF5FsP3D0rHidjGHNVpptlXVovll7mtIZs5tYBl6EqiBTS1DFWInGwe3R66uDrifTIko0dqan0AuzNkYB+SE229lAFss/8/1SQMpS3NdBsWR6hWtvCycIy4DMrvFDs8sD+a2m4kcsTWfmSnUztuZ4+TO15SoT3WZClTanyik1duszhT4GYOUA9nXMex2sBAiy5FdXtFYcpN5Y0W6n3/mdJbUQzPvCVIOqt3rXD/yMIoOqFE7dnhBLr1lA4mWP+d14afEoFQ+wHUjJEbHQbfyZn9QTCif9xaLYoJQ7DSH8lypWk/g+Yd2S357Fu0KzfV230jexCLl94sPiFzeHisScV5jCg==;5:LfttJJkMJ5n9Aejc1jrUBByaVO2rbe5QqMzoZNM5vlxLkD0Xe2Ui3u+4nrhyXlTi8CZFOEa32sxzAP64TsLkOHu64ES/oqyXp/O00/ENr4+Ms1rxD/sOaFXpYLqlGbS1uKODyvbTm9pgSlobkgbNPMR39UfznitkxhGlH6vneb4=;7:90yLfxJCPBS9bbZ3Lf8kbxDznCLylEyyQ+aSyB23h319fnHpR5v+FblGzlT5pwsJX37cuyEcmbsQ8si/lMb5GERaN+vWsIxEOJyPmgSk0K3NSQxdiBm018gRMhq+s5Dmbt/II9nl8pa7yznFJtdBRg==
x-ms-office365-filtering-correlation-id: 973f1841-0bcb-4201-3d87-08d668f21b88
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1102;
x-ms-traffictypediagnostic: MWHPR2201MB1102:
x-microsoft-antispam-prvs: <MWHPR2201MB1102834269D499A5524EB76CC1BA0@MWHPR2201MB1102.namprd22.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(3002001)(93006095)(3231475)(944501520)(52105112)(6041310)(20161123560045)(20161123564045)(20161123562045)(2016111802025)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1102;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1102;
x-forefront-prvs: 0895DF8FFD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39830400003)(376002)(366004)(199004)(189003)(105586002)(6506007)(386003)(6116002)(71190400001)(102836004)(6436002)(229853002)(99286004)(6246003)(76176011)(71200400001)(26005)(33656002)(106356001)(3846002)(6916009)(68736007)(7696005)(52116002)(54906003)(186003)(316002)(5660300001)(97736004)(55016002)(39060400002)(8936002)(2906002)(256004)(14444005)(4326008)(476003)(8676002)(81156014)(81166006)(9686003)(7736002)(305945005)(74316002)(42882007)(14454004)(446003)(508600001)(53936002)(66066001)(44832011)(25786009)(11346002)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1102;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Kn786gvGonTXpqZxPkheWUP7ho9tKCeZ0yLHctLq4EEjx38HlBuh8gbl81tLg2TzljMlPpBBRh8heb+z8rGHYG7tsXie5WKE1wsQEkqe7xP6aJsYKB2SGxgkXURTFfsvUaSUfQ2gy/SdLBnbPcAc+ejSXzsQXJn+I2mkAj4PqIBouf1Od4XDNWZkxdXslol8/yjcLoGfijgx4/ShqD5haj4biRH4nKiDrEcGyEKq5PMQbuxomb+FzEitCxDRrQ0sObF/fNMlxiA1DA6LiCWbfKp0xRFgcK0KZ+OaJ8tg3hkhcNfPFi9SVWC4U37ZZMZk
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 973f1841-0bcb-4201-3d87-08d668f21b88
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2018 16:17:17.5604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1102
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello,

Stefan Roese wrote:
> Testing has shown, that when using mainline U-Boot on MT7688 based
> boards, the system may hang or crash while mounting the root-fs. The
> main issue here is that mainline U-Boot configures EBase to a value
> near the end of system memory. And with CONFIG_CPU_MIPSR2_IRQ_VI
> disabled, trap_init() will not allocate a new area to place the
> exception handler. The original value will be used and the handler
> will be copied to this location, which might already be used by some
> userspace application.
>=20
> The MT7688 supports VI - its config3 register is 0x00002420, so VInt
> (Bit 5) is set. But without setting CONFIG_CPU_MIPSR2_IRQ_VI this
> bit will not be evaluated to result in "cpu_has_vi" beeing set. This
> patch now selects CONFIG_CPU_MIPSR2_IRQ_VI on MT7620/8 which results
> trap_init() to allocate some memory for the exception handler.
>=20
> Please note that this issue was not seen with the Mediatek U-Boot
> version, as it does not touch EBase (stays at default of 0x8000.0000).
> This is strictly also not correct as the kernel (_text) resides
> here.
>=20
> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: John Crispin <blogic@openwrt.org>
> Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
