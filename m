Return-Path: <SRS0=rTdo=QL=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F648C282C4
	for <linux-mips@archiver.kernel.org>; Mon,  4 Feb 2019 21:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28EF220811
	for <linux-mips@archiver.kernel.org>; Mon,  4 Feb 2019 21:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="rJsACrus"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbfBDVSU (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 4 Feb 2019 16:18:20 -0500
Received: from mail-eopbgr820121.outbound.protection.outlook.com ([40.107.82.121]:40321
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729301AbfBDVST (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 4 Feb 2019 16:18:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnicsbxTb9YmDSa6KwAZTFHHLX9m2mqvTCDjg1DaE4U=;
 b=rJsACrusQ+pwQNKAHeHIXkC/dsgE8vBukVhO0MJytPiVyQRw+QNIIyoXCNDvsBR7hkiwr2HljEmv0i0G9RFXkR5J5rb/kzEjUVmd9WUAxgoFo7AmHnlQ4LdfoHHgOpzwkJc2lNgvU2OIre9mx9tbQ1uFfoyzzFya2f4B+C0ULu8=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1118.namprd22.prod.outlook.com (10.174.169.156) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Mon, 4 Feb 2019 21:17:43 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 21:17:43 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Paul Burton <pburton@wavecomp.com>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Use lower case for addresses in nexys4ddr.dts
Thread-Topic: [PATCH] MIPS: Use lower case for addresses in nexys4ddr.dts
Thread-Index: AQHUvMNbFxehwwP5KUqKM4zM2jGMxqXQJJoA
Date:   Mon, 4 Feb 2019 21:17:43 +0000
Message-ID: <MWHPR2201MB12772967EACC2B237AB83877C16D0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190204195337.9120-1-paul.burton@mips.com>
In-Reply-To: <20190204195337.9120-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0063.prod.exchangelabs.com (2603:10b6:a03:94::40)
 To MWHPR2201MB1277.namprd22.prod.outlook.com (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1118;6:JyzqiXVm5zlppwUEWZzaWVf23qcZYuMybjJ9O7KOON9GYKJ4n01rhjGwzYiTbuFZoZuonmZCzmMUEgLXldw6TcQYllvRiJaPFO/9RHvSyBluD17OAOCCnTEiju0Tq2TfOikCqYSqE4wCavVRNS9a3ExvOKb+GyD86ycFhWWnoeC1NsD5AKCithkO0xGcUDZPmmS+6AjxIexP94FaY//coVaL/Qx0WyiwroTg0QFlIm6SOUOrasNr6UAmn3C8GTssKTGWyOT3lG63DqFjBchLuq1A9bX16c7LI3hBPSQcjYmZmYLf+cwRlUkjA1YNaGGYy1IQzE8uUlnHhm2LOTUvvzueZG2BAA2FLnShkSZez+qHnyaKqyc2vtgBpi1c5C7gr/ClkY4AREfV6DxPGhsA8aqNgcEAovNqQR6wFNtpdFIW8RAvNcQBxAZMjHQ30QASdMjtfvuv2lmMsw7ee+8eww==;5:da4JXTJ1HbLIUAK9gsGzkkJcG4IUyPv6i7kdv8OuE9U7bHSwqQjHvr7a+Bp2Q/CHkilVOCOI5t5ytVJ5J9PWV5pBsvNESrc6Ztewq6fGhaNa+gxWiV2vtH76nGSyXWVWtKG+LM+sKJNos1Z9ylextj5fS3HYJDLId8U75gOge7u6hCKnND/ebM5ytoroGiCGxYSYllBA8e3i5ctH14/czQ==;7:Dv6Dm8zeH51o/tDr6xg6BtPMj0PMJNFIsNCgY86cXHtLwjsBGp0v9tRahdYkkeUHXUag0IAtDywb2y65lxgzf8XaQ29FHYBcYjrHGMbGeaSs77oHJlXhyOdJ4e4EJjKQSMVV+t5hcryzgy2+qQ9HEg==
x-ms-office365-filtering-correlation-id: 9d69a3b8-59f5-48eb-0f9c-08d68ae633b1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1118;
x-ms-traffictypediagnostic: MWHPR2201MB1118:
x-microsoft-antispam-prvs: <MWHPR2201MB1118276096325ECCE33C6570C16D0@MWHPR2201MB1118.namprd22.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(136003)(39840400004)(396003)(346002)(189003)(199004)(76176011)(81156014)(81166006)(476003)(6116002)(11346002)(3846002)(7696005)(14454004)(486006)(52116002)(97736004)(4326008)(71190400001)(6436002)(229853002)(44832011)(33656002)(66066001)(9686003)(6506007)(55016002)(386003)(2906002)(99286004)(7736002)(54906003)(42882007)(71200400001)(102836004)(6862004)(450100002)(478600001)(105586002)(186003)(6246003)(106356001)(26005)(256004)(14444005)(25786009)(74316002)(446003)(305945005)(53936002)(8936002)(8676002)(316002)(4744005)(68736007)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1118;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qEQTDy8+aa19O5caI3F7Opf2NP+/cXhDMBw8CW23hZTyZ8V/HZBZwbZGWUccW9nSRgkZQ8ZKKe00VEGpohNy6bZhqfMndktOv/1w+AI/LXkJIrLoLtrfXSmHGv21V4QbNWPlnqb+236FcSPd7ZTKh3S1nCQPl+M75ANDDmjdRL3UkYZlYcVyRDRuZxASMQCbp7DJjXtVHebTzm5Vmxvax2RIMEghe67zE3pUGNbLPTDZswsRnvI8GX45pD/EAFSKVf47IhBWw62aIdn3ILrM7hDhV/67wIXrkdzrA8qYXRGSqCyFXLwjujjq6rt4522+10/ErKYR6dhSOaNBcKEKvBl5ZPG4zisOSmjMzS5pgED1nCgEhnNQsSVSFBG7LSaaGUoGJhux5Zmawxgz/XKlQqNvGJMjAaH+GQAxQWaUIIg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d69a3b8-59f5-48eb-0f9c-08d68ae633b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 21:17:43.2705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1118
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello,

Paul Burton wrote:
> DTC introduced an i2c_bus_reg check in v1.4.7, used since Linux v4.20,
> which complains about upper case addresses used in the unit name.
>=20
> nexys4ddr.dts names an I2C device node "ad7420@4B", leading to:
>=20
> arch/mips/boot/dts/xilfpga/nexys4ddr.dts:109.16-112.8: Warning
> (i2c_bus_reg): /i2c@10A00000/ad7420@4B: I2C bus unit address format
> error, expected "4b"
>=20
> Fix this by switching to lower case addresses throughout the file, as is
> *mostly* the case in the file already & fairly standard throughout the
> tree.
>=20
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Cc: stable@vger.kernel.org # v4.20+

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
