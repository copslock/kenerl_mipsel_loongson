Return-Path: <SRS0=T+hk=OK=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DD0C04EB9
	for <linux-mips@archiver.kernel.org>; Sat,  1 Dec 2018 06:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A46920834
	for <linux-mips@archiver.kernel.org>; Sat,  1 Dec 2018 06:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="HmUdg/L0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A46920834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbeLAR2j (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 1 Dec 2018 12:28:39 -0500
Received: from mail-eopbgr710130.outbound.protection.outlook.com ([40.107.71.130]:33285
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725893AbeLAR2i (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sat, 1 Dec 2018 12:28:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jF1VFnWIiOB2rykz+2rc017IVmLlqNvg+gVAG1ElN1o=;
 b=HmUdg/L0RMSYxpE23YHUJaFNKk1WOhKXMTndcgTHLkajuzRM7wdhY5nbdrA4cPwmlzsF87g5Mvx45KAnhb1h2A28HAs+blws8TXzU/HNoo4e8l9k+U3e1sNxDj7IFcXEMm2LK7z0hg4ZOOCHd5TQgT6suOYdh426oJ95eSC1Q74=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHSPR01MB336.namprd22.prod.outlook.com (10.174.251.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.25; Sat, 1 Dec 2018 06:16:50 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985%4]) with mapi id 15.20.1382.020; Sat, 1 Dec 2018
 06:16:50 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [RFC] Migration from linux-mips.org to kernel.org
Thread-Topic: [RFC] Migration from linux-mips.org to kernel.org
Thread-Index: AQHUh1JyYgbm8WKxf0aPFFad2WolxaVpbDwA
Date:   Sat, 1 Dec 2018 06:16:50 +0000
Message-ID: <20181201061648.bj2kumoefkxcd6z2@pburton-laptop>
References: <20181128194206.yhdp6247xobkj5cu@pburton-laptop>
In-Reply-To: <20181128194206.yhdp6247xobkj5cu@pburton-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:a03:74::34) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2601:647:4100:4687:76db:7cfe:65a3:6aea]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR01MB336;6:sJSndzplnLF6MzcCANX74KfMttKk0Dfden/WEyn7vG0qaUGNzhAT/8FjmtbABBYA2jwDx77F38WMHPLeeI2Hk09rssJi7bKS7GWUIiTKuIKDidz80DZ3pIugL8UWoSiJ588VNcQD/YAA2bohT+D8ydazNipkh2axfYMfrFbFkj6/f9Dzh57285Rnc2FFXdpZt4WIZYIBN3vY0mOrloslYU6l0uvYAukhbfOcgto2sTrra/Na98tE6kzoB6ICbXSBQMhIuE/hQK7mb+GEBR2r80RzhyOSH2VtUnxLGiu1v7dN5p8+Ykpnj3OkvI+ucxoRj1MKRf7NKbV4nKgdejHMV9A8qvuQRqWA5c+jUc6WIu9ZfeZxiX6/tz4+9x/h638iGvogGRwqCadVMj71grrnsbEfQom8BUxqgmY5/yKj/O2SnrrxXK2HJmixfnev0yVbA66d4WTz/A/R61BS/fBTIw==;5:L+KqKBpJGxnH6+RxtU9dN2DdV5Cq/ZceY8cZebuLVL7EzmP/TqHs+r2dakQsqn3diBHCQXSEC8X4iRulKYYLDA7H2tB1bSoFGLFIMwYMKn1fwJAWrQlUIUWh1RjHwa6aV7oYNStRK4j9VkmNn4qg5CNle0Rw1ncThX11KPy2kto=;7:H5DlPCHH+daXMcaGfF02hh9ysrV3RjEEFA9epPTz6CwK171SydbizL6L9o/5o20OTYN0RVAu8HvuRPtH8zXfvzOEGgt+X16xDo8Lq9SfswIwVfpmmvKtf+1bagjb22b4lZEATAGL+iFoEfwxc0/HAw==
x-ms-office365-filtering-correlation-id: 23eb8abc-66a7-482d-fbac-08d657549479
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHSPR01MB336;
x-ms-traffictypediagnostic: MWHSPR01MB336:
x-microsoft-antispam-prvs: <MWHSPR01MB336831AB5E19101868938C2C1AC0@MWHSPR01MB336.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231454)(999002)(944501410)(52105112)(10201501046)(93006095)(148016)(149066)(150057)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHSPR01MB336;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB336;
x-forefront-prvs: 087396016C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(39850400004)(396003)(376002)(346002)(366004)(199004)(189003)(53754006)(316002)(14454004)(33716001)(6436002)(97736004)(2906002)(25786009)(6506007)(386003)(68736007)(6246003)(33896004)(966005)(8676002)(9686003)(6512007)(508600001)(46003)(5660300001)(256004)(110136005)(6486002)(99286004)(305945005)(58126008)(7736002)(81166006)(11346002)(229853002)(486006)(44832011)(53936002)(6116002)(71190400001)(1076002)(2501003)(8936002)(71200400001)(42882007)(81156014)(105586002)(52116002)(6306002)(186003)(102836004)(106356001)(446003)(76176011)(476003)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR01MB336;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rtgYacyP/Mt5LwvO8yEznXegeIKD90G9r9ye/DwOdt/yBf7C3BTvG6oLrFk1RbY3bei0TbkC5ua4Sn/SF2yENIcme0PE7N7H7KSdAYYNX8rrkBy2HyTidpyUZYnBIe99y3/7tvYXPBLXXCDcxBrU9v8TlKAGJZyJDDB29igElbXCv8D0CNcz1+nE5soFFLxR4F/awLNcuEEnojGnDGB7smb6ttyOiJDPVdRdCPsk2NDZDoGjQY+EhubbxeZmJSvgBSfeDzppIu9Ld2B6bug9cR2NG8Hhn/7UxhRLvx4JzintqR01LD//NAsLZ2btwxNUCrUDAl8H9d83rx2Hgx7Kktp4pWu5GLNEtGqnrZ0V+u4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <36D378DCEC5E1241A675C8C3C3158670@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23eb8abc-66a7-482d-fbac-08d657549479
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2018 06:16:50.2498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB336
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello all,

On Wed, Nov 28, 2018 at 07:42:07PM +0000, Paul Burton wrote:
>   2) patchwork.linux-mips.org could easily be replaced by any other
>      patchwork installation, and kernel.org has one.
>=20
>   3) The mailing list(s) are what I see as the biggest pain point, but
>      we could migrate towards kernel.org infrastructure for this too.
>      This may require me to monitor two lists for a while, but that's
>      fine.
>=20
>%
>=20
> So I'm considering asking for a linux-mips mailing list to be set up at
> kernel.org, with content from linux-mips@linux-mips.org archived on
> lore.kernel.org. MAINTAINERS would be updated to reference the new list,
> and I'd monitor both lists for a while until submissions to the old one
> taper off.
>=20
> None of this would mean linux-mips.org will go away - I have no control
> over that. It would simply mean that kernel development is no longer
> reliant upon it, instead being based around the kernel.org
> infrastructure which is well maintained and not our problem.
>=20
> Before I ask for the new mailing list to be set up, I'm asking here
> whether anyone has thoughts or objections?

This is now done - please start using linux-mips@vger.kernel.org instead
of linux-mips@linux-mips.org. The MAINTAINERS file has been updated to
reflect this, so anyone using get_maintainers.pl should start to see the
new list once they update to a new enough kernel.

The list is being archived at https://lore.kernel.org/linux-mips/ - this
contains the history of the @linux-mips.org list, and new mail from the
@vger.kernel.org list going forwards.

Patchwork is available at https://patchwork.kernel.org/project/linux-mips/

As I said before, I'm still subscribed to linux-mips@linux-mips.org &
I'll keep an eye on it for a while, so if you already sent a patch there
please don't feel any need to resend it to the new list - just use the
new list next time.

Thanks,
    Paul
