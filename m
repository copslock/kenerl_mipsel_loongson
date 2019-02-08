Return-Path: <SRS0=Rn8T=QP=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1BCC169C4
	for <linux-mips@archiver.kernel.org>; Fri,  8 Feb 2019 18:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 141012075D
	for <linux-mips@archiver.kernel.org>; Fri,  8 Feb 2019 18:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="b9kVFLBq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfBHSDw (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 8 Feb 2019 13:03:52 -0500
Received: from mail-eopbgr800095.outbound.protection.outlook.com ([40.107.80.95]:22719
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727391AbfBHSDw (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 8 Feb 2019 13:03:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThOz754vu8vP4/2SjeldkLsQLHqv0hCVewcKRugWHCs=;
 b=b9kVFLBqNBJbt7YOaU/FFHiUnM43FDtluKA/5jehvQODmsmr2gUBNhL0JUtydZ7osuBTBMVO2SUivI20/zszPa1byUpB1Vrpsk8FW5/ABoagfp8Bj3NOui4GVxKMg7wBX4oONBhJV4kwvgxoBx9DbB3OsUl/8PNRVDGWOJpkoHE=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1645.namprd22.prod.outlook.com (10.174.167.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Fri, 8 Feb 2019 18:03:48 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1580.019; Fri, 8 Feb 2019
 18:03:48 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH 0/5] MIPS: OCTEON: avoid board-specific stuff in ethernet
 code
Thread-Topic: [PATCH 0/5] MIPS: OCTEON: avoid board-specific stuff in ethernet
 code
Thread-Index: AQHUvNrXNfENPq/WAk6dWU16YG2eYaXWN48A
Date:   Fri, 8 Feb 2019 18:03:47 +0000
Message-ID: <MWHPR2201MB127782A096A96D96A5846298C1690@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190204224149.8139-1-aaro.koskinen@iki.fi>
In-Reply-To: <20190204224149.8139-1-aaro.koskinen@iki.fi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR11CA0061.namprd11.prod.outlook.com
 (2603:10b6:a03:80::38) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1645;6:FQSt01EMGV1oh/ZnqqPH6IlB9dM2ja2a+oGjWRyw2+YgxPDXalyuiS9ruFtfajvCbx8pd8b2JvlFiaCKQhOV7TsOFZ7P5XVOAU8CYJZmDHba2q5P+nVrNtFGaznaJ6Nxp81JVahmzccEeF6JZUgVqftyJDFKPCokruHR1EsNpTG8INrRDB8jawgFMjKdEFgNpPju1xn1tj+m/iPsLTFl/SAkU/gPTPoqSSMRbWgIFYdoQvJkGvcNCkQPvYihLt0VYaxxurfXq+wIXfRdYmzPJhNH7tO9Tg7QlN9wYG0C1+iYqlatdLSBwchbMRdYvgTPMrrxEX28jh3b8duTaAe6gFwJLcBueXZAoWn6ZslM9fWT+sY5VNlt0r/4yxEukofUlvwwlSU34ja3uT6YkknD/zhsgE+1Mzf+RXQ1vEVs8ALnzBHVCHWjfvgOLkbh7lHNjmrEv4h0LCIhsfsmS+ESiA==;5:lqnpZgJXCKWp3zEDSI8Sk/7qdKpVFdpXFpZ/NQ4BQq9r597rhERYSIEwS8ZWhVdTTtSXgzMTcYFXa2q/Tni9/4YJlVgSmGeSC+m1csQJQZtXwa0tZW+Y81gvKfF55mgqXu8Nn1PwL9RlZ+/FqrQbyEUG13lg8/2mdqGnez6nKBeVY0wDietUszBBvkr069U+JJDfTuOsLPPSD8ETC8N23Q==;7:RGS3zSGN8X/mz/BFtT3LWWvWiFh5QPV5yi5AvL4tUzxuxH5tHVE/xHBez2rSg0LZ6LZpLBWWr280qBTt05S0clydasg3cR64jO+lxV+huWSyn5n6wizDwwUv/VGdpsggBGP+Q6QKfEzUQNl58MXi+g==
x-ms-office365-filtering-correlation-id: 8f75a18b-70ed-469d-d45d-08d68defc5e2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1645;
x-ms-traffictypediagnostic: MWHPR2201MB1645:
x-microsoft-antispam-prvs: <MWHPR2201MB164566A60738BAB224952192C1690@MWHPR2201MB1645.namprd22.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39840400004)(346002)(376002)(366004)(396003)(189003)(199004)(99286004)(6916009)(316002)(54906003)(97736004)(33656002)(14444005)(256004)(3846002)(386003)(2906002)(6506007)(6116002)(7696005)(52116002)(76176011)(14454004)(478600001)(4326008)(102836004)(26005)(186003)(42882007)(106356001)(105586002)(68736007)(7736002)(74316002)(6246003)(229853002)(305945005)(66066001)(55016002)(8936002)(53936002)(71190400001)(71200400001)(81166006)(9686003)(81156014)(6436002)(8676002)(11346002)(44832011)(486006)(476003)(446003)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1645;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RGtohmrvJtN8CJPAC8tg2XTxTnbB4rnAeexxPN2twQwaQzfmaVjq1q3A9yAN34DTbPs0eYBH+h/Rqf+SJGZID+JEIErR202ABW7foMIOACOYuq1kOnWkGiBe6ZW5IJR1R8vwDky1rA8/CkbTve0Pc144gbAcPMXnqqM9bJvpytHb6sUKak71UON/7Q0Ea5Mm84lzOkJHA6D3nXw9cw+m/UHNE64+wiKJp12/MyzOzTWM3t6nkQKUAm+LEep61jL9uFeYiYo3ryLKD0V0irsPrWm/C03LGGTfi187mlLCWHRAaSbVdfPVDCxRytAzQ1rhCms+9PD3NKzyOrBEtQgwoHlrECzYhmxT4jca0I9Y+qL/T4yfPS+V1bjoaKzILm0DYJTD6+5kHM6NQZvV4qrmCvZ0Zucsuksh8GydrHbozu4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f75a18b-70ed-469d-d45d-08d68defc5e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 18:03:47.5610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1645
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello,

Aaro Koskinen wrote:
> Hi,
>=20
> A small series that deletes some board-specific Ethernet knowledge
> from the generic OCTEON code and moves it into the DT.
>=20
> A.
>=20
> Aaro Koskinen (5):
> MIPS: OCTEON: add fixed-link nodes to in-kernel device tree
> MIPS: OCTEON: warn if deprecated link status is being used
> MIPS: OCTEON: don't lie about interface type of CN3005 board
> MIPS: OCTEON: delete board-specific link status
> MIPS: OCTEON: program rx/tx-delay always from DT
>=20
> .../boot/dts/cavium-octeon/octeon_3xxx.dts    | 14 +++
> .../mips/boot/dts/cavium-octeon/ubnt_e100.dts |  6 ++
> .../executive/cvmx-helper-board.c             | 86 ++-----------------
> .../cavium-octeon/executive/cvmx-helper.c     | 19 +---
> arch/mips/cavium-octeon/octeon-platform.c     | 64 ++++++++++++++
> .../include/asm/octeon/cvmx-helper-board.h    | 12 ---
> 6 files changed, 91 insertions(+), 110 deletions(-)

Series applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
