Return-Path: <SRS0=qAeu=OX=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EF3C43387
	for <linux-mips@archiver.kernel.org>; Fri, 14 Dec 2018 19:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40EC206C0
	for <linux-mips@archiver.kernel.org>; Fri, 14 Dec 2018 19:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="YtuK7bNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbeLNTDR (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 14 Dec 2018 14:03:17 -0500
Received: from mail-eopbgr680128.outbound.protection.outlook.com ([40.107.68.128]:6382
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730414AbeLNTDR (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 14 Dec 2018 14:03:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15I0KAPmtu8gTWc+YWSE45H400WzO+AgK+mspp+MwC0=;
 b=YtuK7bNtNFEVjM+iEDn556WUlYpLcxwqk3pxKenGucAQcdb+NH0YmMffG5gbazvfTeTU8ONZe85MRpw+LJn/zSZW+y5HefCk6N11EPmFADXO6lvIKNL3lqfI9UmbPONHsx9KqIq8qs9sFX+sMoyOFk6D3RowCF1g8l8RgwHrzvU=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1725.namprd22.prod.outlook.com (10.164.206.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Fri, 14 Dec 2018 19:03:12 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%7]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 19:03:12 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Jonas Gorski <jonas.gorski@gmail.com>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] MIPS: BCM63XX: fix switch core reset on BCM6368
Thread-Topic: [PATCH] MIPS: BCM63XX: fix switch core reset on BCM6368
Thread-Index: AQHUkH0z1uT7O+RuaE+a+yUxIRXJzaV+nlaA
Date:   Fri, 14 Dec 2018 19:03:12 +0000
Message-ID: <MWHPR2201MB127760DA21D422C6BC95F664C1A10@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20181210114038.24162-1-jonas.gorski@gmail.com>
In-Reply-To: <20181210114038.24162-1-jonas.gorski@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR08CA0034.namprd08.prod.outlook.com
 (2603:10b6:301:5f::47) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1725;6:ymgFGjgnQO61vn4snYevreYiQ2nUb4NLvXCDmgDIJjaJlGN+Cn/kCLYT4g0x/99G1hF32R9lf51GcwGbvSwkSHRPlpfK/S1TJr018jSp5RnEBHbRfVmP5CxtFBQDKF8V+wqOVgpU6RlbhJEXFWNrMe08nVmByXWpenOowNMP4Pd6nsP97/j7ygpSKWVNl4K84ttG0d/jYceb383svw40N9vnfWDrMhSzkwCLeYMDJwwcpgkNKxrtosQ5+/B0/SdXculW/C5yXDJlr8ci+0UL+nZTUo+vv62jwQOjbf6A4d1fOUSdcx35yOmsIOfl0hLceLBAUaFOYtZeq2j5N3kkjOAZ/DNgbzHhcL9dHNsxczjF6RlI319WUnYJC8ff+uQnDDNB545nw1YeeN5nW1ZDvAPUoQ8VhM5S14PhhDYbtWje3TPFFIUxiydBoryJMJIZyOzH/Ca46f+jUxiydL8AEg==;5:Eg3y1sDpJA5w0umRSbzLf4wCF8kmjRFdi7GhdKhgpRN4JIN9AA0yxl274BDPSsvU185Z1f0Ad2+367nyNGH4CXIk0y7pBo4jkmTlTyfZFD79GVX+9TyHhB57C7A2LNqpp6T77RWDmm2HB9mMxVkAKRzwge0vUxh4UdTF3rNwj4w=;7:lcxymjt4ttPH7Vw58etpf7pNsWVYjRTHvJiBeZnDkIMU2GRBypCr7wTWxFVyO50E3l89AXyQJ4zdwk2OzdUaL0p1cmCF8ddUCfDoQRDlWfeoykhubQsK4nfrQygRvXSA+tKV76M/m02FNMMxOi2+Cw==
x-ms-office365-filtering-correlation-id: 2470026c-8378-4488-bec5-08d661f6cb67
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1725;
x-ms-traffictypediagnostic: MWHPR2201MB1725:
x-microsoft-antispam-prvs: <MWHPR2201MB17257A9D7BC589B2F881235CC1A10@MWHPR2201MB1725.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(93006095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(2016111802025)(20161123560045)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1725;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1725;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(136003)(396003)(366004)(376002)(346002)(189003)(199004)(74316002)(5660300001)(6436002)(66066001)(33656002)(476003)(11346002)(446003)(71190400001)(71200400001)(305945005)(6506007)(486006)(68736007)(256004)(7736002)(97736004)(26005)(386003)(105586002)(4326008)(52116002)(14454004)(7696005)(76176011)(106356001)(2906002)(25786009)(99286004)(8676002)(8936002)(42882007)(53936002)(229853002)(55016002)(186003)(39060400002)(6916009)(6246003)(9686003)(508600001)(44832011)(81156014)(81166006)(3846002)(6116002)(54906003)(102836004)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1725;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 77X4sUK62UrqZO77FYu2wa3WkTyyyMSeIvS4XoFw3YDDQC1XaBLl5q6IKNjcwvK+Tmjc5KP74wo2oQdlHa7hdPXUHzo/sroYqwjN7YmP0SD9xQFrX/qD5inQdnkK81k9WJh93iaosSrg+FqRsnNt1OB9zkOGIMQi18a5ZI6jv2K2tB20jbbgL7bXBYnfz65Ii5h8ihz7HGrJFNtIqZKywSqLXaVPyw3RfRZPf6IACsMpNOt5YiLdc5HJC2gNVxZ5u+wt13RnK8cyDNthAI/Rn1MDqT2iftI7PvhbT7kluifyIjbD+oi80W3cDQ/A6/4B
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2470026c-8378-4488-bec5-08d661f6cb67
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 19:03:12.5989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1725
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello,

Jonas Gorski wrote:
> The Ethernet Switch core mask was set to 0, causing the switch core to
> be not reset on BCM6368 on boot. Provide the proper mask so the switch
> core gets reset to a known good state.
>=20
> Fixes: 799faa626c71 ("MIPS: BCM63XX: add core reset helper")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
