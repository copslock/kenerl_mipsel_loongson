Return-Path: <SRS0=z0u9=PQ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBE9C43387
	for <linux-mips@archiver.kernel.org>; Tue,  8 Jan 2019 18:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394E620685
	for <linux-mips@archiver.kernel.org>; Tue,  8 Jan 2019 18:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="AUG8Jped"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbfAHSTh (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:19:37 -0500
Received: from mail-eopbgr800092.outbound.protection.outlook.com ([40.107.80.92]:6123
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727484AbfAHSTg (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 8 Jan 2019 13:19:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QScZFj4cXuUUzAohrOI683lX3eZqma6Bi3gv8uAbJDk=;
 b=AUG8JpedGOCkt8kqRGgINREBk2QzJrNHxmqRAY31Y1/8jhwFJLoNytyRz+PeL5nqCBQxToyb1ULUbVdadDPhEHkPUUEk902iMFrAdz4A4HoGVRe1xUrv8NT8g+Sf6TzcCKQM5Gfq6LOJ7jrVonFwL1w/3/X0k467m9FGDe0lqJE=
Received: from SN6PR13MB2494.namprd13.prod.outlook.com (52.135.95.148) by
 SN6PR13MB2319.namprd13.prod.outlook.com (52.135.94.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.3; Tue, 8 Jan 2019 18:19:32 +0000
Received: from SN6PR13MB2494.namprd13.prod.outlook.com
 ([fe80::7dd2:1e4f:2de1:eb27]) by SN6PR13MB2494.namprd13.prod.outlook.com
 ([fe80::7dd2:1e4f:2de1:eb27%4]) with mapi id 15.20.1516.010; Tue, 8 Jan 2019
 18:19:31 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Oleksij Rempel <linux@rempel-privat.de>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Crispin <john@phrozen.org>,
        "antonynpavlov@gmail.com" <antonynpavlov@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Subject: Re: MIPS: ath79: net boot related regressions
Thread-Topic: MIPS: ath79: net boot related regressions
Thread-Index: AQHUp3xXzCnL5fi+4UKJv9jdDhqOUKWlrmsA
Date:   Tue, 8 Jan 2019 18:19:31 +0000
Message-ID: <EC57E8B2-0E44-45F6-9D23-8FE41A1CC76E@hammerspace.com>
References: <6fcd16d9-84fc-891e-a295-9146c8071900@rempel-privat.de>
 <de5f0808-11e2-0e7c-573d-327b66235e86@rempel-privat.de>
In-Reply-To: <de5f0808-11e2-0e7c-573d-327b66235e86@rempel-privat.de>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR13MB2319;6:R95+CRsPZ2ERFCRTc4q+my0cIp+uJm6yWobJSyFTMiEe80/etyp2QepTJHvQ7yEMYAAXSr96yqFPT7hJvlxuMU2plHviBSvI6qscKnRSxV1C2lHpOXXjEc6mbAIYusapRPR4xA33SBZTkl5wDzq1HGkOZ/ySHtH5A6sIZxgGZgydzimWDM+yg9wdx8/8LqqObefXAYXZf1f8Tn1HIR1dSaBmrF0B2CrEGUy1jw/VzyTUtGpDQQZP4/HuViMJPWg6H1d3pNl/6cfqk8GaNwL9bFhQ767W/iI2DwTZgvJ2EtKWV9b60Ggxmx6+VO+bI5i75rvjjuE9slZVAy41zD1VHdA/b6QTczf+3BCTtDwapgw8uTa725XOyLysCGG8+bw9QsHsIpeqnctYUo+/9xzEZIT/B8DgirVnH2MOJ/MIp+N/7TNeGE9rZBE8cvRu2qK6M3btL2BNxYHzu9skH96kOQ==;5:RvyK1z/mfiGvUibP1+fB84bnmMrulTNQ8Zk71Ywm/Ht42t11kCcPMdLCbXpA+gvMLdf4DG2YjXMhKyOo5U8E2LMEgvPiK01cowg6SAh9QWkCg5xJSPPbyDiBfsPw3YsFWsJ7CsLH3bSzjTI4A+NSePSEAce8EebxQLL9qgVLlwBv52ugxd/fqpx8PtZIyXNZ3hCU7YzUJClpVH2g5mMvwA==;7:n4WUqsFAnvLD3WIVttlTim4GR1EueNEGblESo/kUk9ldN3s/EVRyVTppSH62ZTX29TgjBuOiWZj4lbOHFNsTNHCvhc55PMXbUEobG9YnqlqcMO7+6TsRQMbkFHpX+CESCypl4Y3yE88sZNnfnPenXg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(979002)(366004)(136003)(396003)(346002)(39840400004)(376002)(199004)(189003)(3846002)(6116002)(82746002)(2906002)(256004)(105586002)(86362001)(102836004)(68736007)(966005)(54906003)(99286004)(486006)(478600001)(106356001)(97736004)(316002)(36756003)(6306002)(6512007)(4326008)(39060400002)(476003)(6246003)(6916009)(2616005)(25786009)(33656002)(6436002)(71200400001)(71190400001)(446003)(305945005)(6486002)(186003)(5660300001)(53936002)(11346002)(14454004)(83716004)(7736002)(66066001)(81156014)(81166006)(6506007)(53546011)(6346003)(26005)(76176011)(229853002)(8676002)(8936002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR13MB2319;H:SN6PR13MB2494.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: d86d4c9c-70c9-471e-b7ec-08d67595d5c6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR13MB2319;
x-ms-traffictypediagnostic: SN6PR13MB2319:
x-microsoft-antispam-prvs: <SN6PR13MB2319B0B1FD7558B6B12475AFB88A0@SN6PR13MB2319.namprd13.prod.outlook.com>
x-forefront-prvs: 0911D5CE78
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZU++entbyHC2itF+okg7uUJZ4wztM6UN58UzvZlpBtLDx4CZpk98QKeL+RMlyC8YfxtXN+4HpU/LD+WzBVWfWRCg7A1jJ5mdPORLXvPjpM8Mz+cVOjnas1WKrGMhZOwjoMD1pCkoZM9v5f8IhE3Obe9Wqa3U319Xo07ZE31gWcMcNwhghSY/T7B9RgqMIhh3dm/yJODQmmoGlWSyXDKcHTUNShgASwnaaIt9n8WF7IpicIcWjO0HSsS57dQ1XuXoQuAEGaNzszIZhRktT87/evfaHnFm/luVNck7FVwo1WAp1FvOZklaG5hjSqRB8kU4
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6F9EC0335B2CF44A83E498077CAD81CC@namprd13.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d86d4c9c-70c9-471e-b7ec-08d67595d5c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 18:19:31.4689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR13MB2319
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org



> On Jan 8, 2019, at 13:02, Oleksij Rempel <linux@rempel-privat.de> wrote:
> First patch seems to be:
> commit 277e4ab7d530bf287e02b65cfcd3ea8f489784f6 (HEAD, refs/bisect/bad)
> Author: Trond Myklebust <trond.myklebust@hammerspace.com>
> Date:   Fri Sep 14 09:49:06 2018 -0400
>=20
>    SUNRPC: Simplify TCP receive code by switching to using iterators
>=20
>    Most of this code should also be reusable with other socket types.
>=20
>    Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
>=20
> nfs-for-4.20-6 tag do not have fixes covering this issue. @Trond, can
> you please help me here?


Please see https://lore.kernel.org/linux-nfs/20190103140445.22627-1-trond.m=
yklebust@hammerspace.com/T/#u

Cheers
 Trond

_________________________________
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com

