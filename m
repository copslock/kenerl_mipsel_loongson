Return-Path: <SRS0=SfrM=P7=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14024C282C3
	for <linux-mips@archiver.kernel.org>; Wed, 23 Jan 2019 01:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D9F20868
	for <linux-mips@archiver.kernel.org>; Wed, 23 Jan 2019 01:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="pkL6EsJM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfAWBej (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 22 Jan 2019 20:34:39 -0500
Received: from mail-eopbgr800119.outbound.protection.outlook.com ([40.107.80.119]:64217
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726814AbfAWBej (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 22 Jan 2019 20:34:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVP8fNjqdQV/fFHNb7yyGXtysCRlvYXV8kYU/mkhRKg=;
 b=pkL6EsJM45nyItr+2tVqYndM/Ya+jP6myYYj6PygyELioMrp9LeDOrfogjK1iPUBKivgLMTjEMVxc4tpfNVi8dylG7ki49vv8ELPlthtb1zcUNMAGGqFdKmbbqWWugwE6mZ4H+uyaka+K1hkUXTI6iXbpGCBqjTZg0e5czgEpdo=
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com (10.171.216.146) by
 CY4PR2201MB1287.namprd22.prod.outlook.com (10.171.216.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.30; Wed, 23 Jan 2019 01:34:37 +0000
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::f560:2a93:e4fd:f50e]) by CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::f560:2a93:e4fd:f50e%7]) with mapi id 15.20.1537.031; Wed, 23 Jan 2019
 01:34:37 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "keguang.zhang@gmail.com" <keguang.zhang@gmail.com>,
        Paul Burton <pburton@wavecomp.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH 4/6] MIPS: Loongson32: clarify we don't support MIPS16 and
  merge configs
Thread-Topic: [PATCH 4/6] MIPS: Loongson32: clarify we don't support MIPS16
 and  merge configs
Thread-Index: AQHUsrvNsoW/vgBpWUa0MfdAHVw7Lg==
Date:   Wed, 23 Jan 2019 01:34:37 +0000
Message-ID: <CY4PR2201MB12725610CB0D245BDEF27022C1990@CY4PR2201MB1272.namprd22.prod.outlook.com>
References: <20190122130415.3440-4-jiaxun.yang@flygoat.com>
In-Reply-To: <20190122130415.3440-4-jiaxun.yang@flygoat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR0201CA0036.namprd02.prod.outlook.com
 (2603:10b6:301:74::49) To CY4PR2201MB1272.namprd22.prod.outlook.com
 (2603:10b6:910:61::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [96.64.207.177]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR2201MB1287;6:VrCl3loRl2/NaJKe7ZjdMm6+dcWVlgMlJt1iHM8S39mPbx4HVkZTtuN26Xe4FVGcHPd3qBCszj36AG0X5OXafhTUaBLVmCi/311vg5X/CluwdMIBtIlZVbbKkgYcV/FRqLz7rAHCaVSj8KNE5H6+x8XNFewBp7iFgI6uB96LWI918hMQWCoSgSYkyvcJewTEqdIkFXQYal87PlKhXbzz0LqcPOz6nEiV6FXKWp/8uJa2CFRseQmlemyf/LPR0sxCvthjK+aspgE5WAYiXH96Rl6b46fVn6QLB6knt3TVrjLtdzKe7XTP8M95x/IEdR76XVTAPBpEFUHTfzM+IfDZwkQkzS0enLl69uYMjWScUXVDXcmYin4FWrHYz52+FzSfipRQqLPcdGIU23QsnTwzjiu15QywgVUreo8hwYADN40ZB8IjE61HzKWemhLiGUvYxJaGmGXbJ5G9qb/l5Gw8rQ==;5:2pyC5WPBe7lN5ZMmrO4vSH1TdyyT+lWMB8h4KyRfyOZYlDjdhLCQXTiux1QxkjcoHvslgztxWlfHMGQAhvwQVpAM/ZINHrRFROiZLX/83hJJVVpQnOVwxbqzX9uSjaZFk0nvajJBOB7xi2kMZ0hwf5vxAKteNj+MWFxjV0dluR8q4fpTWK2HMNQDCLm7n1ByuphCvJpJGNooP/JqcMsQ/A==;7:A9SwJDHYpaFhXuo4XXAvLUICY6W/swXxByjyOv+PdBP5hExfItp42LQelyJGeVw8jfVmim3rFmOGgcHeY3lZoSvqHZn7sjiZ+QiRN+UxXLI8Bsi1RVtncbQ0VZMvvLbeqL6mqvTFNPPXWzMLe7ubdQ==
x-ms-office365-filtering-correlation-id: ba7be027-6648-4c05-c15a-08d680d2ef75
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR2201MB1287;
x-ms-traffictypediagnostic: CY4PR2201MB1287:
x-microsoft-antispam-prvs: <CY4PR2201MB1287137061D619B2A99AF898C1990@CY4PR2201MB1287.namprd22.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(346002)(39840400004)(366004)(189003)(199004)(11346002)(478600001)(102836004)(8676002)(386003)(26005)(25786009)(97736004)(316002)(81166006)(8936002)(186003)(81156014)(14454004)(6916009)(229853002)(7736002)(71200400001)(71190400001)(6506007)(305945005)(6246003)(446003)(2906002)(33656002)(558084003)(39060400002)(476003)(53936002)(44832011)(74316002)(486006)(4326008)(52116002)(7696005)(105586002)(6436002)(106356001)(99286004)(9686003)(76176011)(66066001)(3846002)(55016002)(256004)(68736007)(54906003)(42882007)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2201MB1287;H:CY4PR2201MB1272.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 28hCoBC5mpL8QXuKKPG3VbCPAUxil70pT2LfE3dwmRhuD5yU9/b088gSbDJ8o0Pu+yL108IBGPMSkMIES7fyaLi3Eb3Pe1Mhz/nhEEyzWLMINPLKH+3fWziDyk3S6RHvYHdDZgGf3PgT+9jtNUgimzQQbO8r77oRcGnZ3sQSis2Hy9ahvFOtH5/FGKaomT5lB5Emy0rVkNc9MMa+W7L1txaPVt+Nvq4dQTL6Kw5AmAeZF4Ln+P7KN0AedQNjG3WjmznnRzezfnyllUtagz6A6Kc5mkZBNlV1+PMw4q/DO5Y0bmgMaPFpZPJ8Fa9fqUeq//wwVbCTktSTw2WDQMOJy3BjjLCb3nBmOqbQvZd27Nf5QikJ/po1x2p8gBEazhr6AQ8noZHfuC8O5bCRYpw2xkDyabn1nspMYO39HgqHOeE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba7be027-6648-4c05-c15a-08d680d2ef75
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 01:34:36.6900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1287
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello,

Jiaxun Yang wrote:
> Accorading to GS232 core user's manual, it doesn't support MIPS16.
>=20
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
