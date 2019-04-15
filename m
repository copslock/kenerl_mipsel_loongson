Return-Path: <SRS0=MCbt=SR=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E711FC10F0E
	for <linux-mips@archiver.kernel.org>; Mon, 15 Apr 2019 17:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F152183F
	for <linux-mips@archiver.kernel.org>; Mon, 15 Apr 2019 17:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="jD1PfT2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfDORRm (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:17:42 -0400
Received: from mail-eopbgr740103.outbound.protection.outlook.com ([40.107.74.103]:16686
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726516AbfDORRm (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 15 Apr 2019 13:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r72tlMdQf8v4QRRTSqEqzdj358OhDoujuxG9oXLjMJw=;
 b=jD1PfT2TnN5kag4/LOzenj4hV/SSBx0AXpBjs1SJwImzAehgXpkBKPS9LxQ/kkZiKXdMJdQRkMtS3hgpOJRcyNcZW5ZbMHJP9KroR76Zio3II4MQe+PZy2d3ttTNtnSi0PGitD8A1WX1uAD/uOsqX/bgD6OOTWpvf/85s4eIbzw=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1646.namprd22.prod.outlook.com (10.174.167.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Mon, 15 Apr 2019 17:17:35 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765%7]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 17:17:35 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Fredrik Noring <noring@nocrew.org>
CC:     =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [RFC] MIPS: Install final length of TLB refill handler rather
 than 256 bytes
Thread-Topic: [RFC] MIPS: Install final length of TLB refill handler rather
 than 256 bytes
Thread-Index: AQHU68lq3wUQBrEF3UCWayG0YT0sRaY8OBWAgAEuhwCAACAEAA==
Date:   Mon, 15 Apr 2019 17:17:35 +0000
Message-ID: <20190415171728.hzplt56qt2f5c7ab@pburton-laptop>
References: <20190405160531.GF33393@sx9>
 <5b42742e-b9fb-996a-fbe4-918d48aa0a18@amsat.org> <20190415152252.GA7205@sx9>
In-Reply-To: <20190415152252.GA7205@sx9>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR11CA0055.namprd11.prod.outlook.com
 (2603:10b6:a03:80::32) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a864b637-d4e0-4ae5-f4ee-08d6c1c64079
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR2201MB1646;
x-ms-traffictypediagnostic: MWHPR2201MB1646:
x-microsoft-antispam-prvs: <MWHPR2201MB1646393A52F8CC66F55AF035C12B0@MWHPR2201MB1646.namprd22.prod.outlook.com>
x-forefront-prvs: 000800954F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(376002)(346002)(39840400004)(366004)(396003)(189003)(199004)(6916009)(58126008)(6116002)(478600001)(3846002)(33716001)(99286004)(4744005)(476003)(4326008)(486006)(1076003)(316002)(68736007)(44832011)(106356001)(256004)(229853002)(305945005)(97736004)(54906003)(14454004)(2906002)(105586002)(52116002)(6486002)(6436002)(7736002)(9686003)(71200400001)(71190400001)(5660300002)(81156014)(81166006)(8936002)(26005)(102836004)(8676002)(386003)(6506007)(186003)(76176011)(25786009)(6246003)(446003)(66066001)(42882007)(53936002)(6512007)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1646;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3Mqok3t7pdbYyTYCYOZ5+OzHbSHwAcPXPPvor8qZxCx3NsIMAGYpoW8kwK0qWy8yZKtL/UjCkPx4rucbe6ayG15OAOxL3L555fOWEcKXWX8uMl5UlEDqLPvdzD5PyC4jOSfAmgpoSjks69GYw/XsGghrJmmDxR8cY6B55u2z3i3Xnh2YUt5FHdY2PYCW0yneAK1TVNxFHgotDG+CYUwhu4LwawctfhgAjZXQTfKfXQxtODfcT3T5tcER4BNR6eCqCzLHLF5/Vi2N+z7zIjpJZv5US7YeB9K8sYHodoYj/74S3yd69SCHPO3zs4KjE4sfjtDC0cekcl6VWCDX0XEMXl4VA3jTdWWMqzcQQ7e98ijY3+TCpQAALvDDPDnH2wb4X/i77ZttD+RoXKKUaPT1oFw+BB0UelXDnwoz7FGGFh0=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <507683DB9079A74880CCEE3F728CC258@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a864b637-d4e0-4ae5-f4ee-08d6c1c64079
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 17:17:35.5989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1646
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Fredrik,

On Mon, Apr 15, 2019 at 05:22:52PM +0200, Fredrik Noring wrote:
> > Maybe you could modify the logic few lines earlier that check and
> > panic("TLB refill handler space exceeded") and add a case for your cpu
> > type. There you could set a handler_max_size =3D 0x80, 0x100 else.
> >=20
> > Take my comment as RFC too, I'm just wondering :)
>=20
> To check the length we would need to define CPU_R5900 first. :)
>=20
> Are any MIPS kernel maintainers happy to review an initial R5900 patch
> submission?

Yes, please submit it if you think it's ready :)

> [ The patch in the original RFC is generic and it does not depend on
> the availability of CPU_R5900, although it avoids clobbering the R5900
> performance counter handler. ]

That's true, and I don't have any real problem with it if you want to
submit it without the RFC tag. The change does only really benefit the
R5900 though so my preference would be that you include the patch as
part of your series adding R5900 support.

Thanks,
    Paul
