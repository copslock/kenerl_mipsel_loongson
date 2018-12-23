Return-Path: <SRS0=3MQT=PA=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DFDC43387
	for <linux-mips@archiver.kernel.org>; Sun, 23 Dec 2018 16:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB812184D
	for <linux-mips@archiver.kernel.org>; Sun, 23 Dec 2018 16:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="jtzVj1dw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbeLWQQw (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 23 Dec 2018 11:16:52 -0500
Received: from mail-eopbgr750120.outbound.protection.outlook.com ([40.107.75.120]:7174
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725832AbeLWQQw (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sun, 23 Dec 2018 11:16:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9hCk8jKi201WETQfUhccM170TgHpQj+9zUEcZgsG9w=;
 b=jtzVj1dw+BeWECITBVN2MPv9Cvpvryn/L7864rGbFeyKQpel/sWcxr8+M0Ma7nj3aUVclG5vq4wMHPL9saUgL9k7BmoIL/LhAjACbq9O6TuScjUnQ40DLYyYF5CQGIZ2DbYZQ8/DhdwQUCZB3yfSFC7zZXNb1cjNlNUhQ8mv8Yo=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1102.namprd22.prod.outlook.com (10.174.169.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.23; Sun, 23 Dec 2018 16:16:50 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%9]) with mapi id 15.20.1446.026; Sun, 23 Dec 2018
 16:16:50 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Manuel Lauss <manuel.lauss@gmail.com>
CC:     Linux-MIPS <linux-mips@vger.kernel.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH 4/5] MIPS: Alchemy: update cpu-feature-overrides
Thread-Topic: [PATCH 4/5] MIPS: Alchemy: update cpu-feature-overrides
Thread-Index: AQHUl2mdh5d/ydbdD0GQvopTFykRG6WMhvcA
Date:   Sun, 23 Dec 2018 16:16:50 +0000
Message-ID: <MWHPR2201MB1277855F2BBB7A7BBEABCBF3C1BA0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20181219070803.449981-5-manuel.lauss@gmail.com>
In-Reply-To: <20181219070803.449981-5-manuel.lauss@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::27) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.197.89.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1102;6:pPxwN3jVhUwE1QXJjqaHDUU1F4s7Mpb+kvRPmnd0SwWPN5orkCO5uMSU3s/9Ju7waFhGv51WTwedAFGzm1UM+Cfx2FiWIOzCNVbbyTj8OwU0hEDHm1Na3z08OYyOaKXAvvVi6utVnOrRYXAfJCxCXIyt9MkryvrARI3ObRPIy7pClIyxWu7NciyhGSU4c2FkZhnIFSqmf1CSXvlWRezri97vaLwsJZn2hC1yDcGo+q975VIpDpguy1Dzevisf5wT5PFnZJXHYJx+MYsbVmizCuPvuY67elxV6WA99dgvZYTCXALy8CQ1neeumfb/Ie7Yk/LEQWNu+jhtSKyQhz0zvKmKTZrRnsMIsOJeIVZt/sSZTNkT3k0qBye51EvNiLtUcQctPAhwc5kJQ0oJSWz3d4Skm8M7IkNWj5y9eJ32WcRIlPiVmXuPe24v7AcGMt8mD4OzEYBh4Mxeghp+NcWXeQ==;5:ScPkVFoPDHr1uGutIVWAfjxgckLHy1KBdqVvCybFeiHZ1yyOfM9uJh0fLohrx4jMQt3hS+PfN8uHi0L5/7f28o2yJGjN7Ld7Vhpj7nUqKHLgVafAHe2T5PKAX1faWmAZhqymnYEbbCxHrofsUqlDQ3qxhKMACnEyH0B4vebf8uw=;7:gOLgSrV7y4XSNS7MNvhog5lAsvcGiMCG+DevS9VbDT7vDbGEHL//FjzvRd2ApsdJ5Cub1/b8lxKceED76ORpaWl4tLfWA3HHtQBdrgnadCQmgNp8Ab4M+XoKydbJtSq0pOyYXestZi9Heyw3hRb3lQ==
x-ms-office365-filtering-correlation-id: 0595c987-9c3f-4353-08a6-08d668f20b2a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1102;
x-ms-traffictypediagnostic: MWHPR2201MB1102:
x-microsoft-antispam-prvs: <MWHPR2201MB11027CFABE04AC18B84A3B84C1BA0@MWHPR2201MB1102.namprd22.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(3002001)(93006095)(3231475)(944501520)(52105112)(6041310)(20161123560045)(20161123564045)(20161123562045)(2016111802025)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1102;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1102;
x-forefront-prvs: 0895DF8FFD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39830400003)(376002)(366004)(199004)(189003)(105586002)(6506007)(386003)(6116002)(71190400001)(102836004)(6436002)(558084003)(229853002)(99286004)(6246003)(76176011)(71200400001)(26005)(33656002)(106356001)(3846002)(6916009)(68736007)(7696005)(52116002)(54906003)(186003)(316002)(5660300001)(97736004)(55016002)(39060400002)(8936002)(15650500001)(2906002)(256004)(4326008)(476003)(8676002)(81156014)(81166006)(9686003)(7736002)(305945005)(74316002)(42882007)(14454004)(446003)(508600001)(53936002)(66066001)(44832011)(25786009)(11346002)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1102;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: W4f2FAk1V3pw5AJryv5/JrQU1HRr1eJmQa2er9yYhCrbDKegPVJ2j+IdSyO2+EvQYVHueTBRKlHZ84FrHa/uF3Ibx3wmbWNIlKoGJwlP8RS/+wSyWXekCtYYWYJDIaG4ZqXoRgZspWFSWaqR+ahm9JIK5D4HVwmtzFhi7V95sqVaDJsK91IN8TRWfnmnTrqp9ukszb/9EzaQCV7Qs4Mvt4JM0tpQE+0PB/jiHww5/Ul+DhlHHIPg5YXR4JZDBrqyMd7CRPFtrBIgivciz41sGHqeVBYEJtN2tOta4r08VxsGEYZXHSS/gBr1w/tM949U
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0595c987-9c3f-4353-08a6-08d668f20b2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2018 16:16:50.0604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1102
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello,

Manuel Lauss wrote:
> No shiny new stuff for Alchemy.
>=20
> Tested on DB1300 and DB1500.
>=20
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
