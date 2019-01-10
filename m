Return-Path: <SRS0=2fGM=PS=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA558C43387
	for <linux-mips@archiver.kernel.org>; Thu, 10 Jan 2019 18:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8546420675
	for <linux-mips@archiver.kernel.org>; Thu, 10 Jan 2019 18:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="Cr8rim7O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbfAJS66 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:58:58 -0500
Received: from mail-eopbgr720112.outbound.protection.outlook.com ([40.107.72.112]:59247
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727000AbfAJS66 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 10 Jan 2019 13:58:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITlRUIO59Z8gBn1HLotp3uUa3HLJb8Vncb1BkfTbM9Y=;
 b=Cr8rim7OC0zCbf5ZZg7aN8FVkxzSemT3KHWilrymevfNX5Pmvax+mfNvHc88S9gruftFkInhVU9wN6uJhOO5Ge+zzmJ9T7V9wUOnIKrrYyf27SU6K360nOX2GCRxy8tLBdjC2zuiFRSest+/AZTb0nQkKUw40oscFwzhqNc6ano=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1037.namprd22.prod.outlook.com (10.174.167.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.16; Thu, 10 Jan 2019 18:58:54 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110%4]) with mapi id 15.20.1516.015; Thu, 10 Jan 2019
 18:58:54 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     YunQiang Su <syq@debian.org>
CC:     Paul Burton <pburton@wavecomp.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "aaro.koskinen@iki.fi" <aaro.koskinen@iki.fi>,
        Yunqiang Su <ysu@wavecomp.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH v2] Disable MSI also when pcie-octeon.pcie_disable on
Thread-Topic: [PATCH v2] Disable MSI also when pcie-octeon.pcie_disable on
Thread-Index: AQHUpxVYS+YSucY4hEqdri6AUUk7laWo3uSA
Date:   Thu, 10 Jan 2019 18:58:54 +0000
Message-ID: <MWHPR2201MB12770678FC8D33EC92ED7850C1840@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190108054510.7393-1-syq@debian.org>
In-Reply-To: <20190108054510.7393-1-syq@debian.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR11CA0106.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::47) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1037;6:9YNktvSlJWmfH1aVuotq+q9gLV99/vg6aYZi/ZrIH0ReEoobgQI0tn5J9Zb+kGztLYCwNVmDjJTcJH+HRfThXnda4dHq1DVLn4GCqLtvkc5nsDz8Cy98NZJhHkuzNtejFvNCCFCTQHw4eVb0OyhMiKCoEfxApxEDR9ybDwTmOLuyIuTgVyQlNpJVfkI33w35wOhMC2k82eRJySsWmWlNNonQjbJ2mnFuokORru++2+ZSEEmCGmtz2brXLwj3kl5XnnGdDU8uZs/uBaElTSQb7qCr/YplFXaJ/GDXpOGZA5HPOJiKvION7V/VqBjhbUQtlfT0NeodPwpe/LJ048cjXqZQX2WnzHVqOod4HAbVuu0Nwv23znQ5TXA7ZXzugAuzyBSWala2NGxUXGDhvhSjgfOvzrQmAKF7YvzDyexTRchMAiWMFxjUWv9SZ2eAcAnz+hoSQ1flsbeV8KbVd8jPoA==;5:617TM6UhvkTuTZ4uOKctPycbawKayGEYrIucW03nVEcq+lYZT+s7XQa2AUZSEQ9JMgqgtOJa6fte0cveQnSUFCOe91V8bu2GkcbLWTFuMm2w7lfOEAFinF9uVpl+dfpok8wmDUDKpTQB1xsbGoFE23L9KcbDb7+4tUEZnw9jNERmJE52eCcW07XVfNy+qLnVenX9fX7WSYCvYzIAN4B9+g==;7:QgkT80RcTc8ORgChburexR4YyBHBcaUkkpm67+XW+nE2aQJN2luw2wMJW3XCg8O3pLEDHtB3Wabj9BzKbKKbqxwNDsvo5QQMOaLffzc9xVDYC2JjjbSAlL9BoZKGgIelYbz67SL8cdkhaBBplBdGWQ==
x-ms-office365-filtering-correlation-id: 8c8dc293-3330-4232-74b6-08d6772daad2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1037;
x-ms-traffictypediagnostic: MWHPR2201MB1037:
x-microsoft-antispam-prvs: <MWHPR2201MB103735A8910E2F754338302FC1840@MWHPR2201MB1037.namprd22.prod.outlook.com>
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39840400004)(346002)(376002)(396003)(199004)(189003)(256004)(106356001)(446003)(6506007)(386003)(76176011)(7696005)(26005)(6346003)(102836004)(52116002)(186003)(25786009)(44832011)(33656002)(11346002)(105586002)(486006)(42882007)(476003)(68736007)(71200400001)(71190400001)(2906002)(305945005)(14454004)(7736002)(54906003)(81156014)(81166006)(55016002)(8676002)(8936002)(316002)(99286004)(66066001)(74316002)(4744005)(97736004)(53936002)(478600001)(4326008)(5660300001)(6246003)(6436002)(6916009)(229853002)(6116002)(3846002)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1037;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wCOErcQ/3JWRnHHzL3lcSaz8WxJiEn691P6G/WoIqKOtztNS1yzoYPTsdV+7uemM4A8tqINFaCW6rj4n43AeWTZAFfVwErNTywKtb4FcZErIK+8R+WHcj+80Dn/fBIpcEbHBvjV/E5EKHxb8i/1Xpp0n5lmkpG+R/7pvdl3SUD4l9+gW3CKpEPSHvgL7buL4umI7YftvN3wH7dY4mUx4QWDbwmmL3eBgXIR8VldtsdjLUZqP38b83P4v7We63/WedFzwq6hp/gZUYCHNguGr4SWLyei085jkNmnWr8m6F7wWik1uSbt07Fcnd/NTUgVhY9TrRcbV0I6gYof619d7b40ym2rqyPS6MeaRddhNw2M2hAdl1vegiruVs5hio8Mn04i/wcIz2a4wTl6IIoCOcPnyVIqbvYFPHK1mINLDD2cQiAeWPOdp6+ZuTyolzcXT13r025+X0k+103Ev61laKQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8dc293-3330-4232-74b6-08d6772daad2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 18:58:54.4648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1037
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello,

YunQiang Su wrote:
> From: YunQiang Su <ysu@wavecomp.com>
>=20
> Octeon has an boot-time option to disable pcie.
>=20
> Since MSI depends on PCI-E, we should also disable MSI also with
> this options is on.
>=20
> Signed-off-by: YunQiang Su <ysu@wavecomp.com>

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
