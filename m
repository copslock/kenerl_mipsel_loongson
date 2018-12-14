Return-Path: <SRS0=qAeu=OX=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B69BC43387
	for <linux-mips@archiver.kernel.org>; Fri, 14 Dec 2018 21:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4D1206DD
	for <linux-mips@archiver.kernel.org>; Fri, 14 Dec 2018 21:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="jQVuVJOM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730854AbeLNVbO (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 14 Dec 2018 16:31:14 -0500
Received: from mail-eopbgr810114.outbound.protection.outlook.com ([40.107.81.114]:27253
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730758AbeLNVbN (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 14 Dec 2018 16:31:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PiQElyAEmCYqOoWTi1kN8axHhrPJ/mKNFrJgFNCjLM=;
 b=jQVuVJOMPZvMiIbael4aUFSFZ9d9mQBZKsyt/+f4gGjxmE8eOr1XWYIbFWnQ3aa5jqxcbF11cemcouDzOmZ/8CAmq8vDN21eMVvVI/ElPAgV/4Vblg0JpiiueKUSky2LcQkNOAMYy8xskhJHBj2rvaT5mhMTLMg9RJv2k/OlmIg=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1070.namprd22.prod.outlook.com (10.174.169.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Fri, 14 Dec 2018 21:31:10 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%7]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 21:31:10 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Stefan Roese <sr@denx.de>
CC:     Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: MIPS (mt7688): EBase change in U-Boot breaks Linux
Thread-Topic: MIPS (mt7688): EBase change in U-Boot breaks Linux
Thread-Index: AQHUkfNMcpdXGl+ESEeHCV0Kj78/+qV72oOAgACZdgCAADdbAIAAAhyAgAANi4CAAFqIgIAAuwCAgAD0PoA=
Date:   Fri, 14 Dec 2018 21:31:10 +0000
Message-ID: <20181214213109.3u37o7azx2jstg2d@pburton-laptop>
References: <e4f0fff9-a3c5-85ce-c4be-6e0aa0f74592@denx.de>
 <d81ac18d-47ed-02ec-bc37-f5a7e0ab9223@gmail.com>
 <543512d8-91ea-2a49-5423-680860c0ba9f@denx.de>
 <CACUy__X434rmJnX96i057-ir8yiCBjMac_V41HJ+pyG0xLPcRg@mail.gmail.com>
 <dad02a31-ed34-f99a-26c5-60e4a7209057@denx.de>
 <CACUy__XtyDY08KTTMnKoXXKq4oUrNYdRXZOmtuXEmnfD7UveiA@mail.gmail.com>
 <20181213194740.mtphrijpnkzo2za4@pburton-laptop>
 <4ff76006-c524-ebaa-235a-6b253ce9cc09@denx.de>
In-Reply-To: <4ff76006-c524-ebaa-235a-6b253ce9cc09@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0054.namprd19.prod.outlook.com
 (2603:10b6:300:94::16) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1070;6:iSJZBIEBLkk6bIVyzbas7gW/7zUzrWWpxz+M5rYPeLBRkqnsVYUIVu55Xpa2fv91iJnVKnJlb3N4VRDuAAZC3eVg8w5JknuP3gfumYlzWh2NzYa/vh1mxfkmH6vUkyeCM5En1JC70avcwyFfrW+Oq2p1uGIcxd/LupIGFvTCkB7MNm1YO0RqoJHYMBsDeTOmChUwm4fmJ80qsn5cenz14xG8Y6jZt0mdO7oycwRFWrtoRbbh4Pu4CdSQm80FJ2yDQyIReDyQwTOjkbCwn6Oxm+/GdzKwegPj90q2NEuIj0kxblrrIurQwFGqkNpJQkYfrpneYIvvrqKSatvsHgCZKRjMMHouvjr7vsrDqzfXizr10NMK34qZON1zXGn4JgRxtGRXmcpB4UChqsZrRHa797c6FcTIEXi5khZqWJooW5Ka2NJMRjJHubGUqQ/V5PxncaMfvEYd6U/QpzTcfQR27g==;5:KGlFlcTAPU3jK3RQuyY3KwcI/rh32dhyBeo0qyOUH6fvnoyl3OTarJpO2nXedajiuYnt4jSFq87ZlJ/V0MlvVdmF8gyVoXsJnh9yxzRpbWRimOXa6zlGAw1Xic8Wy9gtAppEjWJ0fIVtfj0oOrBmVPw8Dt/0XdKnR8lwU9cQd4s=;7:gHdz1HrOejZ/ZeCjlPUU+HdIniwbsU/EIVT/AA25soZ1MOJMNHSokHqppw/9W9o4Thu1w7wv7MpW7eE0ig51lVElTdYI9rrAnvSTAWCsJ9PnLvvS3ljyVUQUC+Er5NjqtyBsn7YQXHnSLjDL6MtgZw==
x-ms-office365-filtering-correlation-id: e7a20d0b-8277-4399-44b5-08d6620b770e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1070;
x-ms-traffictypediagnostic: MWHPR2201MB1070:
x-microsoft-antispam-prvs: <MWHPR2201MB1070054A686D215A6FAC8130C1A10@MWHPR2201MB1070.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(10201501046)(93006095)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(2016111802025)(20161123564045)(20161123562045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1070;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1070;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(136003)(346002)(396003)(366004)(39840400004)(199004)(189003)(106356001)(81156014)(4326008)(8676002)(229853002)(81166006)(6246003)(14454004)(39060400002)(6916009)(54906003)(97736004)(66066001)(99286004)(93886005)(44832011)(446003)(476003)(486006)(11346002)(58126008)(1076002)(3846002)(6116002)(2906002)(316002)(8936002)(68736007)(256004)(71200400001)(25786009)(6486002)(105586002)(71190400001)(6436002)(6512007)(9686003)(26005)(386003)(6506007)(102836004)(508600001)(53936002)(33716001)(5660300001)(305945005)(186003)(76176011)(52116002)(42882007)(7736002)(33896004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1070;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Daj7PM5zv9R6hdq71Q+sIY50sXKkrfV2B6fJMbq5eqJLirgXJrzlwos1KDgzYIC6Sv0b/QsynV3cNHm7RJh66Hc4v6Z/7bRv7/gFkZdFI2Zz4M3aLx76tfM8mHY83uPUKgzMy7DHfK+EtEEuSzAZMthbZ9+5rG6sHisiEImBRpskwEc7A1bhOBCkwjpcelgFPSXoIa2fztIxe3r8isb0NrOq8Oejse2+rH1Zk7v5+vKjXVs0PQ+eRouLcagKLllmw5Jsju1Oxksa8D8P0P/IKl5eHInU4BChjSkqfjUb78pkPRtoF5oNi9t0qZ9pcgr9
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A270562201F389469C7044F1F308704D@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a20d0b-8277-4399-44b5-08d6620b770e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 21:31:10.3589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1070
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Stefan,

On Fri, Dec 14, 2018 at 07:56:59AM +0100, Stefan Roese wrote:
> So how to proceed? Should I enable CONFIG_CPU_MIPSR2_IRQ_VI or #define
> "cpu_has_veic" to 1 as Lantiq does?

...and on that point in particular, it really depends on your hardware.

You shouldn't need to do either of those things just to avoid this bug,
but if your hardware actually supports VI or EIC then it may be
beneficial to enable them.

Thanks,
    Paul
