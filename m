Return-Path: <SRS0=vpel=OO=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55C5C04EB9
	for <linux-mips@archiver.kernel.org>; Wed,  5 Dec 2018 22:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1EF20879
	for <linux-mips@archiver.kernel.org>; Wed,  5 Dec 2018 22:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="AR8tE+a+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1EF20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbeLEWjo (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:39:44 -0500
Received: from mail-eopbgr700090.outbound.protection.outlook.com ([40.107.70.90]:47776
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728083AbeLEWjo (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Wed, 5 Dec 2018 17:39:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0XFcTTlT7P2D5VoWJIeJNj50zmC1heASpMagVvVXIc=;
 b=AR8tE+a+u4uGyBBgd12HVY3RupUiSP9WsAmwS2wxp4BXf0nzyjs6KfnPus8jGNHYzcxk9I00mRLXm/IsnxOwNPmoRy3Iugwrud58rd98a83OL81S/Ak5pLOd+lhX6464Gi630YWCZQh3o349QV3JaX5O/oyWrfMOFysU0/HyN28=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1502.namprd22.prod.outlook.com (10.174.170.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Wed, 5 Dec 2018 22:39:00 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985%4]) with mapi id 15.20.1404.020; Wed, 5 Dec 2018
 22:39:00 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH 0/6] MIPS: OCTEON: cleanups, part II
Thread-Topic: [PATCH 0/6] MIPS: OCTEON: cleanups, part II
Thread-Index: AQHUjA29oXuz9OHqik+a5nZisqkmfaVwvoSA
Date:   Wed, 5 Dec 2018 22:39:00 +0000
Message-ID: <MWHPR2201MB1277A95DDA14F2B5A17E6E8DC1A80@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20181204201220.12667-1-aaro.koskinen@iki.fi>
In-Reply-To: <20181204201220.12667-1-aaro.koskinen@iki.fi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1001CA0006.namprd10.prod.outlook.com
 (2603:10b6:301:2a::19) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2601:640:100:a82b:331a:3193:9711:95bb]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1502;6:T7XmSz8eA75Jri581mknXCDq9OZUphjBu4JGLDDPRIWdLbv/zdqW5E+k90g8XEQLP9wMZU6XLcEdwpy9GEDeL1NDmEkBwufu6OnP6jJso04RYROm6YEtI+JCmnHYpZv6W3Cs1M9+4kkBTBc6O+Qcl9TSnGgoEeJYTC90XceiLPkpTvAtQ08Yjs2DyXx2PSbouCDp/x/YYyBQYov8Ss/VBBYmoTRtVI1F4kcsdJDAWYtChCM/Zhma3fhBheyH8lcmtRqHR2BggfiTSY3OzMH14hUAxCUMdn3i57XbDOBNa8iTyaLjnV0AbznZ3dpA8r2YiuO1kYIuDpCpYeX9q7pWOV8Yu4kBhzzpFGweqC0iNV5NiDHpRivX0iSdecPX19+vTdXmKlrLUvBwifPkfbI4YvzCvRGy/q8Waw6hhrknxzWxMwS0D0xfhlD5iqeOCFRFIqukEOwU4aqvRs32xKTRTw==;5:bnT93CIK1hhx0vfc5hS+CPe8Bk/zyLxtx7ALcc3N3ZjLbHtq9Q/pC7iyNz0KUy+ocQaWsmilb1Vt6a35XhUS9C30B9UKLUP9gqiLppQlpHYEsMm8MUB8JWDNUicvBbReMnDtzJhQsPT/fathbxrGayWT08hHRNid8/EDMWv8yFE=;7:JtYbpnfK8gMSGPK4NJp/94iYxLQui+WIelECkTn0DfT9PCbHFNTeqMI4su0X1v/etlSZwD4GeFy41h1ZeQf6z83Yb09JQZU7/T7DK8wHu1rDaQJpf9dvH5Tt6RO7lSIrx3c0qzDkoSbS2yJg96yM8Q==
x-ms-office365-filtering-correlation-id: 2787730d-10ee-40c2-58ad-08d65b027320
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1502;
x-ms-traffictypediagnostic: MWHPR2201MB1502:
x-microsoft-antispam-prvs: <MWHPR2201MB1502052D225D539FDA936976C1A80@MWHPR2201MB1502.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(148016)(149066)(150057)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1502;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1502;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(366004)(376002)(39840400004)(396003)(199004)(189003)(8936002)(6506007)(97736004)(6246003)(386003)(7736002)(14454004)(305945005)(6436002)(81156014)(8676002)(81166006)(2906002)(33656002)(14444005)(102836004)(71200400001)(71190400001)(186003)(74316002)(256004)(105586002)(106356001)(508600001)(229853002)(42882007)(55016002)(5660300001)(9686003)(53936002)(44832011)(6916009)(486006)(7696005)(46003)(476003)(11346002)(446003)(76176011)(99286004)(25786009)(6116002)(52116002)(54906003)(316002)(4326008)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1502;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fTGkHo3CB/zAv4qBz/04cxlNNeECy1D6EWffgAubdaNivdgG5+5itlzxP3NTryejK+mEe0cHZ8AgAUlgAQI768UlQ0y9lu8Gbui0zk0hy+1JeWwp5WZl+KXnED3g+ErctKO/nuLuNhcExwgQPNJeKcqMpoj1TubSuWbUxs13rNLtJmv3l+R6bNq7yJixBcXLr2tdJo532xlnSwbKKxWgUFXU/xcSxVb0MZZHqE1kRyz0gyke4TUmad1XAkv61r4e+5oFl00R7NDDMYdHZMgzuR+MTOoAxJIA/P0a4baqZNaRSJs0pa8zRM9XNjcDnR9rb+v8+AM1H6LydN7lr6pZ6ZFjT1uWyvMgbVu3MDOBkcg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2787730d-10ee-40c2-58ad-08d65b027320
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 22:39:00.2168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1502
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello,

Aaro Koskinen wrote:
> Hi,
>=20
> Continuing OCTEON cleanups:
>=20
> - Enable all drivers in defconfig to get the full build coverage.
>=20
> - Some small adjustements to platform code to allow mechanical deletion o=
f
> a huge amount of unneeded union fields.
>=20
> Boot tested on OCTEON+ (EdgeRouter Lite) and OCTEON 2 (EdgeRouter Pro).
>=20
> Build tested with cavium_octeon_defconfig.
>=20
> A.
>=20
> Aaro Koskinen (6):
> MIPS: OCTEON: enable all OCTEON drivers in defconfig
> MIPS: OCTEON: octeon-usb: use common gpio_bit definition
> MIPS: OCTEON: cvmx_pko_mem_debug8: use oldest forward compatible
> definition
> MIPS: OCTEON: cvmx_mio_fus_dat3: use oldest forward compatible
> definition
> MIPS: OCTEON: cvmx_gmxx_inf_mode: use oldest forward compatible
> definition
> MIPS: OCTEON: delete redundant register definitions
>=20
> .../cavium-octeon/executive/cvmx-cmd-queue.c  |    2 +-
> .../cavium-octeon/executive/cvmx-helper.c     |    4 +-
> .../executive/cvmx-interrupt-rsl.c            |    2 +-
> .../cavium-octeon/executive/octeon-model.c    |   12 +-
> arch/mips/cavium-octeon/octeon-usb.c          |    6 +-
> arch/mips/configs/cavium_octeon_defconfig     |    2 +-
> arch/mips/include/asm/octeon/cvmx-agl-defs.h  |  699 ----------
> arch/mips/include/asm/octeon/cvmx-asxx-defs.h |  105 --
> arch/mips/include/asm/octeon/cvmx-dbg-defs.h  |    4 -
> arch/mips/include/asm/octeon/cvmx-dpi-defs.h  |  178 ---
> arch/mips/include/asm/octeon/cvmx-fpa-defs.h  |  247 ----
> arch/mips/include/asm/octeon/cvmx-gmxx-defs.h |  118 --
> arch/mips/include/asm/octeon/cvmx-gpio-defs.h |  116 --
> arch/mips/include/asm/octeon/cvmx-iob-defs.h  |  375 ------
> arch/mips/include/asm/octeon/cvmx-ipd-defs.h  |  538 --------
> arch/mips/include/asm/octeon/cvmx-l2t-defs.h  |    6 -
> arch/mips/include/asm/octeon/cvmx-led-defs.h  |   78 --
> arch/mips/include/asm/octeon/cvmx-lmcx-defs.h |  514 -------
> arch/mips/include/asm/octeon/cvmx-mio-defs.h  | 1197 -----------------
> arch/mips/include/asm/octeon/cvmx-mixx-defs.h |  136 --
> arch/mips/include/asm/octeon/cvmx-npei-defs.h |  295 ----
> arch/mips/include/asm/octeon/cvmx-npi-defs.h  |  235 ----
> arch/mips/include/asm/octeon/cvmx-pci-defs.h  |  392 ------
> arch/mips/include/asm/octeon/cvmx-pcsx-defs.h |  185 ---
> .../mips/include/asm/octeon/cvmx-pcsxx-defs.h |  146 --
> arch/mips/include/asm/octeon/cvmx-pemx-defs.h |  144 --
> .../mips/include/asm/octeon/cvmx-pescx-defs.h |   59 -
> arch/mips/include/asm/octeon/cvmx-pip-defs.h  |  688 ----------
> arch/mips/include/asm/octeon/cvmx-pko-defs.h  |  619 ---------
> arch/mips/include/asm/octeon/cvmx-pko.h       |    2 +-
> arch/mips/include/asm/octeon/cvmx-pow-defs.h  |  317 -----
> arch/mips/include/asm/octeon/cvmx-rnm-defs.h  |   53 -
> arch/mips/include/asm/octeon/cvmx-rst-defs.h  |   28 -
> arch/mips/include/asm/octeon/cvmx-smix-defs.h |   88 --
> arch/mips/include/asm/octeon/cvmx-spxx-defs.h |   62 -
> .../mips/include/asm/octeon/cvmx-sriox-defs.h |  123 --
> arch/mips/include/asm/octeon/cvmx-srxx-defs.h |   22 -
> arch/mips/include/asm/octeon/cvmx-stxx-defs.h |   64 -
> .../mips/include/asm/octeon/cvmx-uctlx-defs.h |   89 --
> 39 files changed, 15 insertions(+), 7935 deletions(-)

Series applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
