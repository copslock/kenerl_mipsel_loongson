Return-Path: <SRS0=SHWW=RO=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B09DC43381
	for <linux-mips@archiver.kernel.org>; Mon, 11 Mar 2019 18:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092EA206BA
	for <linux-mips@archiver.kernel.org>; Mon, 11 Mar 2019 18:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="olCfCjIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfCKSOL (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:14:11 -0400
Received: from mail-eopbgr720107.outbound.protection.outlook.com ([40.107.72.107]:36769
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728034AbfCKSOK (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 11 Mar 2019 14:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Lt8U/jnpmqM4U/5NYQucIbsh9JwE8iLSRMD3qKhUSg=;
 b=olCfCjIA4tPIoZb76QzkOx44XLGAQ/vQro9dDdWSK2tx68LUXSxh5Nu3fyo3jxWH00eWAXLzfBkwfTOg7OWa355x/TqtxSuYJHiUWgY+7zuaXJlkTqjor2Vvejmx+/Y8Od/YkaC15R0a3PaE0iauXrS6v3mXgQSXAyrtSLlhaBc=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1455.namprd22.prod.outlook.com (10.174.170.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Mon, 11 Mar 2019 18:14:07 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018%3]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 18:14:07 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Archer Yan <ayan@wavecomp.com>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Archer Yan <ayan@wavecomp.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] Fix Kernel crash for MIPS rel6 in jump label branch
 function.
Thread-Topic: [PATCH] Fix Kernel crash for MIPS rel6 in jump label branch
 function.
Thread-Index: AQHU1V8dzO7oBULX/0Sep/akK9JeA6YGwa8A
Date:   Mon, 11 Mar 2019 18:14:07 +0000
Message-ID: <MWHPR2201MB1277A9E773B601A33D71BBCDC1480@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190308032907.10110-1-ayan@wavecomp.com>
In-Reply-To: <20190308032907.10110-1-ayan@wavecomp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:a03:74::15) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04dfde5d-bed2-4caa-0b26-08d6a64d5a26
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1455;
x-ms-traffictypediagnostic: MWHPR2201MB1455:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR2201MB1455;23:ipKVV+i5u73ErXTZy1eJ8jft9VaBhnKe/J4qr?=
 =?iso-8859-1?Q?lmaGIZOFQGrfRia89qfvtBJTLXfVUmgIxz0N03bxh/9dREUrR1dy/qSm/J?=
 =?iso-8859-1?Q?LSa08f73OG86z66XIx+rRbBLDHxHACbRoxCej7Hq3zAM56yxechegQ8B8P?=
 =?iso-8859-1?Q?UQpcnJdpKb3kBVMzo7oY37Ts/jcw1yiw0AdUp0KqMhsll7DzqFIgi18T4R?=
 =?iso-8859-1?Q?8zClJYbkTquHYQQp0d28BbXOPh4Ywqgn/AmUTnAaYWsDmhIWZmP8xjp36C?=
 =?iso-8859-1?Q?EDP9iha6d43EWMbapE8rj5jiVfcHPq5bVNIg0gAfUf1HWaDXWEt8ueLV0t?=
 =?iso-8859-1?Q?v+Fv2fDsMgiljBT4K5hznFsujWA6D+VA67nWII61fKSpOq1MaPHFZreMHG?=
 =?iso-8859-1?Q?b5maFM5gIf6uaWgcZscRt3yug7oeoQbRliVHO/tLrYt4Dhw/8SfSBVSqQZ?=
 =?iso-8859-1?Q?utsNouJN9sRjcwA8Xpp2lc6qkpHUoszjkBiKPLH5N53z6l5VN8DkT9i2V4?=
 =?iso-8859-1?Q?wLi+vAAqVkdfTGccFJJX2ARpMlglZ8ZVEy3IDv2lt2kJzssRh3okvqqXhY?=
 =?iso-8859-1?Q?jaYt95L+14ZAoci8nEDabePRnWc6rJBDNMBxgQSIlrW6LcmvC37TRXP44F?=
 =?iso-8859-1?Q?CoIS5e4kKdNBc1Vfy+Ea7QFiuJ6IG8AtZIzs4a7NkjVLekx0+HV8Vrknm+?=
 =?iso-8859-1?Q?Gdg89qiZqQftJA3A0IunBPbcE+xDL2JIkRFVgOp0nMjuOoBX6BUjJUyJV/?=
 =?iso-8859-1?Q?Hl0cYhxeVy5NkzUJ5RSfshg6/Fn8wbEsfoNnWan0g/aUIvhngvAS0KPMsq?=
 =?iso-8859-1?Q?leuXGSQivh0D547FH83SvNwdi7Lm+Pi21G1Ecav9tWMQzoS/L3TypfPdni?=
 =?iso-8859-1?Q?8OZiXU/qm3hSb71OD8gcaayDfaghogVBeS1fr2qpkWekwH9wSHR8o8NvRS?=
 =?iso-8859-1?Q?Y+LLBrA+JfbjbK4Zkiu+uH7oVw55dG8SWFi5WnJuuM8HlOtGWTQ7mG0yn0?=
 =?iso-8859-1?Q?7VvAF7BzLj3Fw4PLJdQ8E3FMzkeARtjtWAfJKzPXpQE+7vFgWnioFnw7Ai?=
 =?iso-8859-1?Q?/NIi7ohvsn4FEs4xUnvqyMik8AO9LQAPzl7bjJwty9zgSQci3bHpsBk2w7?=
 =?iso-8859-1?Q?N8/5ckZs2qrh7hf0f0p8Z5bNGgwQRPpPc96ljIgtHa6yBRN1qNqvLk8xbr?=
 =?iso-8859-1?Q?Gdz9lTrzIJm/lBH5dA5FCR1TrrM/T8KSLeQrhKc0c1orQrMBsKPBapob08?=
 =?iso-8859-1?Q?fB3CuAsT7VPkFccWI3lh4gkICyy1T2NE0bxgrNi4U3a87zb0wi1iEfLbla?=
 =?iso-8859-1?Q?kQ6zMOcgPAPwpvDF6GFvdy22MGYN2sb/3Ff4ZBvLkeSg0GA=3D=3D?=
x-microsoft-antispam-prvs: <MWHPR2201MB1455FF839B166A6426A16326C1480@MWHPR2201MB1455.namprd22.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(376002)(39850400004)(396003)(346002)(189003)(199004)(81156014)(8676002)(81166006)(54906003)(3846002)(25786009)(99286004)(6116002)(53936002)(68736007)(8936002)(106356001)(55016002)(105586002)(9686003)(97736004)(6436002)(4326008)(66066001)(6246003)(256004)(446003)(11346002)(71190400001)(42882007)(4744005)(186003)(476003)(6862004)(44832011)(486006)(7736002)(71200400001)(386003)(26005)(2906002)(14454004)(33656002)(5660300002)(478600001)(52536013)(52116002)(76176011)(7696005)(102836004)(6506007)(305945005)(229853002)(74316002)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1455;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rJ0bvRcLPoyFsYtVOreETEvwWuaKLXydzJCCieSXe9TzDcUiMI08G14LfRbx5UnAwPS1LCixXqR/7Z5MNI2D3Rv3gT/zJhrfpD+G09QfUZ7AHMRzhX+pUbsAOMYdYK0uMg1BslUY/p9DYaJI907sYXDQzt166f6mMggLVgDKIxDY041/dqM1v+VVY2leDok1XX5JiiFd+AG8i7Yekxy/Rdv/W5CqJ9pt5JWswg10ocejmFjNROtUzzDKPjcCTxxD8WFQ+xt3ts/3QuqJoHqltCeO3a/AhziQsIadamoNOj1WIUtjiPofaknknHpkZPpPl6RUQ0W0J2a0fIX+bAUJDfHaMOx2adc4/AJlTMZLxq20Rbm6Mw6FD0rdsaJj1bfaGsOrOGD5piplCb3zLzj+XVJqwoocCLO50fyqgLQ8pMI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04dfde5d-bed2-4caa-0b26-08d6a64d5a26
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 18:14:07.7711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1455
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello,

Archer Yan wrote:
> Insert Branch instruction instead of NOP to make sure assembler don't
> patch code in forbidden slot. In jump label function, it might
> be possible to patch Control Transfer Instructions(CTIs) into
> forbidden slot, which will generate Reserved Instruction exception
> in MIPS release 6.
>=20
> Signed-off-by: Archer Yan <ayan@wavecomp.com>
> Reviewed-by: Paul Burton <paul.burton@mips.com>

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
