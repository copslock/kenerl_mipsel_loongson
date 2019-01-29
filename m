Return-Path: <SRS0=QFq2=QF=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA935C169C4
	for <linux-mips@archiver.kernel.org>; Tue, 29 Jan 2019 19:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF692080F
	for <linux-mips@archiver.kernel.org>; Tue, 29 Jan 2019 19:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="lTQr+ywv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbfA2Tvk (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:51:40 -0500
Received: from mail-eopbgr730093.outbound.protection.outlook.com ([40.107.73.93]:24903
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729244AbfA2Tvk (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 29 Jan 2019 14:51:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12shLTRGVC8JFRRag4QENMGpCGsV1/LiQbORHgsLdWI=;
 b=lTQr+ywvHPTu9IE2QWiSuzvCyfdOaHZFdgS3sq6wnaLNRuVt+NUoM7azBKhcbBUSp/zpevwwGyv5/WwjWGz/P9KWEwPEmB40dJCmi2CJoXplX+TT2msSDJw7IroLkrZ6APKRebHF8KmwfcuCI87j/Y9W8bULNlIkydLT654UInE=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1487.namprd22.prod.outlook.com (10.174.170.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Tue, 29 Jan 2019 19:51:36 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 19:51:36 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH 1/2] MIPS: OCTEON: delete SMI/MDIO enable
Thread-Topic: [PATCH 1/2] MIPS: OCTEON: delete SMI/MDIO enable
Thread-Index: AQHUtn5oeKW1vWYFBUeUuzanuFMPQqXGqxeA
Date:   Tue, 29 Jan 2019 19:51:36 +0000
Message-ID: <MWHPR2201MB1277B6574ADFF3E7FA56B174C1970@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190127202431.7107-1-aaro.koskinen@iki.fi>
In-Reply-To: <20190127202431.7107-1-aaro.koskinen@iki.fi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR02CA0047.namprd02.prod.outlook.com
 (2603:10b6:301:60::36) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1487;6:fE5TRosTP8p4HQ5+3m+9koM7wgI9CbYoRJNvJwCvXzWpUee3YKEftCKeTAfCfhRq/KxGleiXXFxRB8i+O8CdjlMFdJk0j1giedoSJjEk5hkQL8v0g4BQdm4eoXeV/M+Ip1TLqlUGSt2Od3+y8X3w5XuJJFOIzrG8kWk+Do4rpOy2k0MpFGlGVYC21r3XsHeHVpTIqcrOWBol7mefrmVCMSWkO3XOWdVyYvj5eVuTrpSCunr6h+BCX9nuQPhX8sho2C+nQ/fqJY1q2Ez9RQXinOUQp1Lv/A8bt9ZifGWgWp9vM2OuSSvi7uiXoiRzzlp+shI6gjL2bdcmud1OrE26mPb9pimdh1wzIkaKhGQSTrPaUJFeGzMozB6FN/RvYoJgd8/WAyCdnyCYuRgnjiHti3PnM4edphz/xFjl38Vyhyw6kESkUIE9CI/tsyO3ha2Abw2Nqj8hD/j95VkWudyXaQ==;5:18bn2S/fSn+VCgU/Spph1ojJf7Q/r7hpQ//6hO9BrCwktraBRHaRNhGuqI9MoKJbIUpfkJIzp0pzfEB/ZXviRcG7+d9do5IKy08YFqdrWSNGQkE/U175IbY88EtAt8hd1BCerOysdqVEM/unkmg5q5nUaz5CL0B1rg/gdUjsiig1BmcVVIjNk61xNB8SGwrAZ3HZPR8zi5AoZ+zs8sAeBA==;7:68g+2Swr5/xcJ9Kco45xI5MmIZ12EzwpyW8PoxoeJH/9TcXE7DggRJkHWXFqndyvV5/06BvFYh8TCXiGi0BApAnOat+WW3tnpJcQ4+0WIvDRQaTcDMNCCpw+zoxRK5+JD1HwAYsvNEtvVAiuSUO/GQ==
x-ms-office365-filtering-correlation-id: 19b257af-1df5-4de0-428a-08d686232d46
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1487;
x-ms-traffictypediagnostic: MWHPR2201MB1487:
x-microsoft-antispam-prvs: <MWHPR2201MB14873A6C11FAC63313916025C1970@MWHPR2201MB1487.namprd22.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(39840400004)(366004)(136003)(189003)(199004)(316002)(102836004)(486006)(44832011)(8676002)(8936002)(26005)(478600001)(6436002)(42882007)(81166006)(476003)(76176011)(2906002)(305945005)(97736004)(33656002)(81156014)(446003)(186003)(54906003)(105586002)(74316002)(229853002)(99286004)(106356001)(7736002)(386003)(11346002)(14454004)(6506007)(3846002)(6116002)(66066001)(7696005)(68736007)(4326008)(4744005)(71190400001)(6916009)(6246003)(55016002)(52116002)(14444005)(53936002)(9686003)(256004)(25786009)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1487;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4kQ4Fz/uIR/ga/EcTtxkHTPg0cxCGTD9GIiqcQCRJowYh9CIUKy8ppBznYZMkOVmzg24kythRAczbK6TSXPt1edfNW2LBeex985PuR8X8ZJQDCpX/EuQY0B/hLETLCMvbZlWh0McRPIMxIDYnrNOOyAK4nphkDsmBBfkHQGrHwkEpLpKKd8CIJme/dFueVvy4zuR0kSYsN3FNg2n4zTZQ0lNVKYZp3qr8w0KF91ogS7bHXq7NXHS2AoQwshLtc9cxjk+z8L8TfZ+R483tzrycgCkg5DxLLWVjB11aUi2sdfPl8Slw64zXsbV0cHEsldEZB8GvFwIZl+aA5WSBQDhcj231A9J3nEDL2dX5ujL7FvTm/BIpnvE0SWFPilyd+uZCmDus9eeD2rpoHHQM1CWtQh2m+u63fDARekaHojANq4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b257af-1df5-4de0-428a-08d686232d46
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 19:51:36.0435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1487
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello,

Aaro Koskinen wrote:
> SMI/MDIO enable is handled by the OCTEON MDIO driver, so we can delete
> the duplicated functionality from the platform code.
>=20
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Series applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
