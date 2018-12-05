Return-Path: <SRS0=vpel=OO=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015CDC04EB9
	for <linux-mips@archiver.kernel.org>; Wed,  5 Dec 2018 22:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA92220989
	for <linux-mips@archiver.kernel.org>; Wed,  5 Dec 2018 22:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="IGNbRDoz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA92220989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeLEWUW (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:20:22 -0500
Received: from mail-eopbgr760138.outbound.protection.outlook.com ([40.107.76.138]:30360
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727436AbeLEWUW (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Wed, 5 Dec 2018 17:20:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uo+PNQxI6Td5bSr3HwHpy2sxz5amCogLbxkj3hwNmnM=;
 b=IGNbRDozBu47gpnj6fNi2jHQRQh+dPi/ZelhMU8L0hinrACB5P/yFrDQW6rvtoRGdZDrXQWRhWtMYxygrUK63zfMSgYWImHmlwuyEH07+jfN0I0VlVHh3LGoNrQTzi7gLosOnekabBsA9q5KLBfYmVGHspLHYCR+1K2Xoxe5Yd4=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1199.namprd22.prod.outlook.com (10.174.169.162) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Wed, 5 Dec 2018 22:20:13 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985%4]) with mapi id 15.20.1404.020; Wed, 5 Dec 2018
 22:20:13 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH 0/6] MIPS: OCTEON: cleanups, part II
Thread-Topic: [PATCH 0/6] MIPS: OCTEON: cleanups, part II
Thread-Index: AQHUjA29oXuz9OHqik+a5nZisqkmfaVwtjkAgAADCQA=
Date:   Wed, 5 Dec 2018 22:20:12 +0000
Message-ID: <20181205222010.77ckzxfblnt3b6n2@pburton-laptop>
References: <20181204201220.12667-1-aaro.koskinen@iki.fi>
 <20181205220918.GA19520@darkstar.musicnaut.iki.fi>
In-Reply-To: <20181205220918.GA19520@darkstar.musicnaut.iki.fi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0013.namprd19.prod.outlook.com
 (2603:10b6:300:d4::23) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2601:640:100:a82b:331a:3193:9711:95bb]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1199;6:Wyk/fsvuFJaGnoG37ErN17rlG6XX+PWIfJOEo5T+yMGlkdO2heLA2rhNxPBsMHhdYERIy7o2r1ZT1IKCBFMsMG64LwshYTdZOiM80g3KDzCMUCA7BxAupr9y1JDoal1lNqVInzKnMlv6Y7ctLpqOaP9H6WpcSQ9CNv2mxR22TE9VyDG+PU58JVUMR5Pythlktk5oKhF2NhlO2lJcqwW9eB7JaZyr0ezFEJuIxWYIvWx/Lsi5g8iPdre3D+aorJNmv9TVYGmQAjFgQkaAoHOulf2ALS9FvA890JPsswdCqyUVGL/3lpzAqhmGmW/cI3F5yQgwFqUl+iGgJmI/NTQ7YCjozoAMSRM6kEfTzG487lLLhR18iios+yp4SYKzmNP8HFEz+/OEqVXF+KWTigbmJgF9sBjttPi/eLspwmfZpESyU6pGnwZghzlmoiIGzlUyxfY9jE6brnyLeqHvoNZQow==;5:kdbiFJDpECE9DS2iVVlLRiedZym8UsWCZZe5jCfrRhTYXMwWuvOSacAJcfUwrm9N8xY31Sq8oZvGagX6TmQJHSkEVq//ho6NwIaJpwLYZAKwcrJqor5U32Z19UGIPM16ZdPIycDep0SuUFO3RMf/ibCuITQCvdvLuYIJLWyJG7A=;7:PNNWh1Q/3MHGyIWnhl/RJtMAYh9v46LHoLg6M9ceZ3j9QO3PyIvIup9a1/Y8IreeUGd+tRy4XUHo5da8UmtOYE6eTMinnMp1GGq9PO2a97RUAyl84lN90NY4Ci0217/bpwrE/TV+w0NkTYdQqXlo/g==
x-ms-office365-filtering-correlation-id: 383e629b-7662-4b35-334f-08d65affd32a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1199;
x-ms-traffictypediagnostic: MWHPR2201MB1199:
x-microsoft-antispam-prvs: <MWHPR2201MB119934B8678ADD5BBF056F2CC1A80@MWHPR2201MB1199.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231455)(999002)(944501520)(52105112)(93006095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1199;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1199;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(366004)(136003)(346002)(396003)(39840400004)(199004)(189003)(97736004)(76176011)(7736002)(71190400001)(81156014)(8676002)(8936002)(81166006)(42882007)(386003)(6506007)(102836004)(33896004)(52116002)(106356001)(105586002)(256004)(46003)(14444005)(71200400001)(68736007)(186003)(476003)(6512007)(11346002)(5660300001)(1076002)(6246003)(6436002)(6486002)(6116002)(9686003)(6916009)(53936002)(229853002)(486006)(2906002)(4326008)(33716001)(44832011)(99286004)(446003)(316002)(54906003)(25786009)(305945005)(14454004)(58126008)(508600001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1199;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Fd8S36H/PWgI28sBHvOsxIIODJIOaTMYOtZMuIytXhmYA4ZCqDXPUZZu3K2Pp3AgMl+E4gLcTYqNandraZ9ncvQaRMFqDD8wgE4aethnEowyuPkkm9XSxU66HLkjyWazt92b9tjQ9LKX2bUOC7aIpRJC3vo2/R9jvibw53wL9BNqM4mHgb+IiOtwGyxI3muDudyOBLQPhVkw7uNDFwPms90FaDeRwYG05+Gtq18YdPENCdCdlyA5b32/Mu4u1AL8qOWEjvuOlwVer+lTeMtd14a04dmDnq5O+Dvb37GU1RibPXPciE0vkIx8A6p25M4Vv9Xj3iHQjtfiUHFU1+J3P+6gEOGjl2/hrIFaBEXzLL0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ECD2D8F17D27254486EA6B2CA4BADC7C@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 383e629b-7662-4b35-334f-08d65affd32a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 22:20:12.9255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1199
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Aaro,

On Thu, Dec 06, 2018 at 12:09:18AM +0200, Aaro Koskinen wrote:
> Hi,
>=20
> On Tue, Dec 04, 2018 at 10:12:14PM +0200, Aaro Koskinen wrote:
> >   MIPS: OCTEON: delete redundant register definitions
> [...]
> >  39 files changed, 15 insertions(+), 7935 deletions(-)
>=20
> Looks like the last patch didn't get through (around 500 KB, maybe hit
> some limit). Please disregard this series for now, I'll rework the series
> to do changes with smaller patches.

I actually applied this already - patch 6 didn't make it through the
mailing list but I did receive it personally.

Let me know ASAP if you'd prefer that I drop it.

Thanks,
    Paul
