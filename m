Return-Path: <SRS0=Zu9z=PB=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A75C64E79
	for <linux-mips@archiver.kernel.org>; Mon, 24 Dec 2018 14:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A9F2184A
	for <linux-mips@archiver.kernel.org>; Mon, 24 Dec 2018 14:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=darbyshire-bryant.me.uk header.i=@darbyshire-bryant.me.uk header.b="GVwsiR4H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbeLXOnf (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 24 Dec 2018 09:43:35 -0500
Received: from mail-eopbgr50051.outbound.protection.outlook.com ([40.107.5.51]:26944
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725355AbeLXOnf (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 24 Dec 2018 09:43:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=darbyshire-bryant.me.uk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7tv64xdTw+ZKfkKRLu/FABUWrKojReV9YsN+tBiKro=;
 b=GVwsiR4HJF6n5c4A2oVedrXXL964tGWYbI8Kcnc+j2ZbDSJfHTy2b0F8LQgWA1arXtNoXTtqqPcLEl0Ma8vmEA5VDlBm//ucK7MxjN9RfCFQV/YWgi83M8NnNavE4V4FeeYOe2keCuYXo4+l8gNgxL7LxSUQ881Z8FM1AyBFLtQ=
Received: from VI1PR0302MB2750.eurprd03.prod.outlook.com (10.171.105.143) by
 VI1PR0302MB2703.eurprd03.prod.outlook.com (10.171.105.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.21; Mon, 24 Dec 2018 14:43:30 +0000
Received: from VI1PR0302MB2750.eurprd03.prod.outlook.com
 ([fe80::d77:d217:1660:c5d4]) by VI1PR0302MB2750.eurprd03.prod.outlook.com
 ([fe80::d77:d217:1660:c5d4%2]) with mapi id 15.20.1446.026; Mon, 24 Dec 2018
 14:43:30 +0000
From:   Kevin 'ldir' Darbyshire-Bryant <ldir@darbyshire-bryant.me.uk>
To:     Hauke Mehrtens <hauke@hauke-m.de>
CC:     "paul.burton@mips.com" <paul.burton@mips.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "jonas.gorski@gmail.com" <jonas.gorski@gmail.com>
Subject: Re: [PATCH] MIPS: Add CPU option reporting to /proc/cpuinfo
Thread-Topic: [PATCH] MIPS: Add CPU option reporting to /proc/cpuinfo
Thread-Index: AQHUmxJAeVFEpnFmuk+WQwjlWhVAMaWNmOUAgABN7ICAABEaAA==
Date:   Mon, 24 Dec 2018 14:43:29 +0000
Message-ID: <4088FEE6-B2A4-49CE-8816-1A33D5443E21@darbyshire-bryant.me.uk>
References: <20181223225224.23042-1-hauke@hauke-m.de>
 <81623E5E-FAB2-4C91-B7F9-8C5BB8422D5C@darbyshire-bryant.me.uk>
 <89c9e62d-850c-2c78-3d09-269ce0c619a1@hauke-m.de>
In-Reply-To: <89c9e62d-850c-2c78-3d09-269ce0c619a1@hauke-m.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ldir@darbyshire-bryant.me.uk; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2a02:c7f:1240:ee00::dc83]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0302MB2703;6:wy2o/8a18vzuZVfKys/LDTe97G1acMnb+h8VV8r0niqSeiuK/gZolLBvFo0hPyR7bH+Uxi57n0gXQTWTN2Pqc3a8A659Q+tvGrprLpMA/e6sOBrhaN9n8rdsV70ou3RSpZPodobO6LtH1FdzwnFqf58/6ppDxW8hzFNL+kuyvzNOPwHp0Uh5AaGVvsdWygyF5py1kUS4vlsPwNcxCqNdQmZU2eupHHSrG43epf7vBB2z4+IzdMYeYD2yF3KTtHUZk1HOpCstxVS1fxX+IrYUdpgU5Fn9RNdbdbTBQyPfIJ9OSivoJFXQn1tjH97sMXLOh72rBZY77B0xY0wR5l8DWBu0qGj9Wi6NsGZ+Ogz7d8/mQnCbdW1cUcf5nggQa3tSV+zY0hto8Uq4tfnT9fouihdQ9AXAu1gZbwP+sX6cfOVUxweS0Fe+0+DDYJXUUyMnmJ7riMOiJGcFqoLl/nHswg==;5:q50bTmdrxt64q7jg2sR7GJ40lgGldYLfZEMxrqEk1wv0iz1xYlwf+TSzoW+9kesyDMQSiKXuHTT9ovrqpa5IdBaOuyBpVjPRLKDplZj7TxTgr2zedCPPUlZOKnfTTL3gQMyN4a4O/TcSMs6MntKvKPDjazsvlHErAddpfiZzVhI=;7:Ygsbb34VroCxdjWUZ+btdSqZ79FITM8Adqg6re1bSEo1taOm2Ito+tKWE+NFV3vTsMG9Dmhlcegec7vvimuXe/cW09YHnaRZxuzbdqF3QZVUkO7wISV0TWnDh3LZQCBQn+CIleXycZS3zo0SWPKojA==
x-ms-office365-filtering-correlation-id: 759fd784-5ce0-4ca4-bd89-08d669ae2be4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0302MB2703;
x-ms-traffictypediagnostic: VI1PR0302MB2703:
x-microsoft-antispam-prvs: <VI1PR0302MB2703396F8306DA299C701F83C9BB0@VI1PR0302MB2703.eurprd03.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(10201501046)(93006095)(93001095)(6041310)(20161123560045)(2016111802025)(20161123558120)(20161123564045)(20161123562045)(6043046)(201708071742011)(7699051)(76991095);SRVR:VI1PR0302MB2703;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0302MB2703;
x-forefront-prvs: 0896BFCE6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(366004)(39830400003)(376002)(189003)(199004)(74482002)(39060400002)(106356001)(36756003)(7736002)(6512007)(76176011)(99286004)(82746002)(2906002)(4326008)(229853002)(25786009)(6916009)(6246003)(97736004)(71200400001)(53936002)(83716004)(33656002)(105586002)(71190400001)(86362001)(508600001)(102836004)(316002)(81166006)(8676002)(81156014)(5660300001)(6486002)(8936002)(6116002)(46003)(305945005)(256004)(2616005)(476003)(6436002)(11346002)(14454004)(446003)(54906003)(6506007)(53546011)(486006)(68736007)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0302MB2703;H:VI1PR0302MB2750.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: darbyshire-bryant.me.uk does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: F5JjcHh301dAWNxtslYoREFo3E5PRWCUpV4zRs9C/wqbysUS2lTWcrRNA15cAasu7M8WiT07H3v6+razx3gCoRC0UI/rf8SHlU3HP8TfYO4jbsWSxB69kP4+eqmtPqw8Jx07HxQRI4VPda8UG1pgxRK0SxIg+TZ1fyiVqqAKmivsRacau/4ZJZ1Svnx709EoewrvzQ6sSPP27DNGfdaGRnuMCA2WaXwXWsws1kHMv8oQ4IkhZ61YiNlO0N/FjwsIeIwXmKpSeeZMqykFH1y6ORXR1be/cbCOqkEuOzuIkh2nHaPfXVYbJk71JX68Nf9l
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <884559D788858A46A2AC25F773F04A56@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: darbyshire-bryant.me.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: 759fd784-5ce0-4ca4-bd89-08d669ae2be4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2018 14:43:29.9179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9151708b-c553-406f-8e56-694f435154a4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0302MB2703
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org



> On 24 Dec 2018, at 13:42, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>=20
<snip>
> Hi Kevin,
>=20
> Normally you should not deactivate any features in cpu-feature-overrides.=
h which are supported by the CPU, when you do not define any thing the kern=
el will use auto detection.
>=20
> I think we should use the cpu_has_foo features as these are the features =
which could be used by user space applications, if it is only accidentally =
deactivated by the kernel, which should not happen, it could be that this f=
eature is not fully set up by the kernel and will not work.
>=20
> Hauke

Fair enough.

Kevin

