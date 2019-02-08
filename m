Return-Path: <SRS0=Rn8T=QP=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7849EC282CB
	for <linux-mips@archiver.kernel.org>; Fri,  8 Feb 2019 18:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C66C20855
	for <linux-mips@archiver.kernel.org>; Fri,  8 Feb 2019 18:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="CDDtWWSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfBHSD4 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 8 Feb 2019 13:03:56 -0500
Received: from mail-eopbgr800133.outbound.protection.outlook.com ([40.107.80.133]:24116
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727391AbfBHSD4 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 8 Feb 2019 13:03:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flu4X3pO1c5nQCmr+c9SQclK0M/uYqahWeHgmEhaQ6g=;
 b=CDDtWWSSgDjTJo03RpyT3PcO8yfcBP2qon0TxZHzffJzlgexPoJESNvIq5DxAlYMlQRbuAnzZKY19b25QwsMwN4E+JpIFtF6PZ/aI787AyqMr4Z+CDT/AN6naOIAjdu+DpqALKQdN7CluctW+AFfPSxWwGlSwb7yorQcQG9yCIk=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1645.namprd22.prod.outlook.com (10.174.167.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Fri, 8 Feb 2019 18:03:53 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1580.019; Fri, 8 Feb 2019
 18:03:53 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Paul Burton <pburton@wavecomp.com>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Delete unused flush_cache_sigtramp()
Thread-Topic: [PATCH] MIPS: Delete unused flush_cache_sigtramp()
Thread-Index: AQHUvxhPZn12Pifqsk2N48ZYPYnNIKXWMxqA
Date:   Fri, 8 Feb 2019 18:03:52 +0000
Message-ID: <MWHPR2201MB1277F1A9EBB64CF8C24073E2C1690@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190207190646.10962-1-paul.burton@mips.com>
In-Reply-To: <20190207190646.10962-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR11CA0039.namprd11.prod.outlook.com
 (2603:10b6:a03:80::16) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1645;6:9DqPukTzX28HxyIlyU6rXC7nCIVzNA/6kJsXR0PGUWHJiMwggpBBG5dyJ/cXQSzk5V8p6Q+TJ3HBn+QdAYZ/Iunc5u10pAkxJqL3i2hFGdynBTwExZ0FF3yqoS3sC+fnFINmRV2JNY6cmScQGvblKNj/t+EphwCx/tmZ/gY4IbNxSORZ5M3k6hZ780YyIbTXGdB619Ae8uCqC3NUvG+OPnacnO2fuUpto4S0uSWgQ5pht88UZrccBjOYP9rAw2LH3xUBuUzIuGUgJSDZw1fSxrGs4R3XSDiUS90f2otc8aMdYvc6zH7+3ipB9SXDFTmhUTopU0o2l+FhNgpK4DQlPLDpQVyy3gTzCQ4vu2KHp4lH9l567e9OZgozwPPzonLuxAsgCLr7Z0mX98x7wU8yuWbh2OyDBjnKdKnWXMKjIxlfidgUnAT/XZQWnYNcIGtuYM3epTrSv5Wlu/USojGFvg==;5:KDn03BjFEWK9XJk5CLRFM2oK5YCcabzFQeRw7LUEeb6Qklga27htS4qS0tJRdWr44+Is8VRL6irX9wOPiIFxiT81EUxC2zE++JwvM72dWce+sirsf6KGNi5NlnC38H3+ZxItCp5Vb8V4LG6m17vLQthkW6YQXTGHlvjzXkZdu1Jf5YrzM85OMz5gTQ7FtyOupkpAGaaRUEL08w0al+9Idw==;7:o4BEBv7nCDsxpJ0heiQ/KCNnBJXmoe/OIHxm2rFMRQoGbrpwXRb+bJ/5rqOZugqe3KZOu7ToXbXipUNZoEdPa+DNb/Oojos/AsmMrsUjhe6Q1gUMazMSJCG7uHRacc2OX3JhT28wfC9AnanlWF0Hkw==
x-ms-office365-filtering-correlation-id: 394b2c2f-2891-42cc-e0b8-08d68defc8c6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1645;
x-ms-traffictypediagnostic: MWHPR2201MB1645:
x-microsoft-antispam-prvs: <MWHPR2201MB16456EE676035CBDA5D93E7CC1690@MWHPR2201MB1645.namprd22.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39840400004)(346002)(376002)(366004)(396003)(189003)(199004)(99286004)(316002)(54906003)(97736004)(33656002)(14444005)(256004)(3846002)(386003)(2906002)(6506007)(6116002)(7696005)(52116002)(76176011)(14454004)(478600001)(4326008)(102836004)(26005)(186003)(42882007)(106356001)(105586002)(68736007)(7736002)(74316002)(6246003)(229853002)(305945005)(66066001)(55016002)(8936002)(53936002)(71190400001)(6862004)(71200400001)(81166006)(9686003)(81156014)(6436002)(8676002)(11346002)(44832011)(486006)(476003)(4744005)(446003)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1645;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2PJvHrT3Td1xlG0MJf0OL0F+zpZOJOLGod7KyjYEAbEOOPR+hvrqdiiHNW+LZgQXYtyfg6kfbKm1GqMrq6DudxxleYbaDJ40lr+ASZDA5ahQSPSl8Pe5/pPvsgmF0kOaxhF5nV57+C1KxstmGiuFKGjH15l+JeZUFv2L7ZuFj0PGU5pY6ny+RlkCKxtjfv0g3WbnaLfAjdEeGyVC0jZAIHcqPMejeExhZJLGFZckmu/NI7CUo3TtjCsyQoKrBfDfXCv3pw7M3rN+FSB5eVmDRSeUZj96pN6n8qtKmqhZwS0wmAp4xri3hSUxzroerkUoP8PozY4IaIbpsihzBtWS8MA2ekAiDjirfEiDP1FKx27dx+lGaUnKRO74kBwmMn/QVdan3LWwv6Y/BxbeybmL0GtTK/uORBym17Ww2XZHkHw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 394b2c2f-2891-42cc-e0b8-08d68defc8c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 18:03:52.3509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1645
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello,

Paul Burton wrote:
> Commit adcc81f148d7 ("MIPS: math-emu: Write-protect delay slot emulation
> pages") left flush_cache_sigtramp() unused. Delete the dead code.
>=20
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
