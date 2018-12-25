Return-Path: <SRS0=5pPM=PC=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D833C43387
	for <linux-mips@archiver.kernel.org>; Tue, 25 Dec 2018 21:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260002177B
	for <linux-mips@archiver.kernel.org>; Tue, 25 Dec 2018 21:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=darbyshire-bryant.me.uk header.i=@darbyshire-bryant.me.uk header.b="gC/VzTkw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbeLYVfj (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 25 Dec 2018 16:35:39 -0500
Received: from mail-eopbgr20063.outbound.protection.outlook.com ([40.107.2.63]:46448
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725857AbeLYVfj (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 25 Dec 2018 16:35:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=darbyshire-bryant.me.uk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kXEYdrBQlSy2jQR7qmm+RhPuKTqUViYnmR/K+rU+Cc=;
 b=gC/VzTkwlbAyYXxRkPiIjU1dTypRywbOnIbrPxLfFMN9WK6RrwSWSuJGTjYox+Mocsmga26/8xakGjRYc5ZO9Kol0BoU+DZ3ReSptusbB0eY+3Ggfbx0ql9yqX5N15DFVKdjFd1jEgx6lLMGEoAFbK/6dmvCuhdAIrlvRIW2XQM=
Received: from VI1PR0302MB2750.eurprd03.prod.outlook.com (10.171.105.143) by
 VI1PR0302MB3439.eurprd03.prod.outlook.com (52.134.14.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.26; Tue, 25 Dec 2018 21:35:34 +0000
Received: from VI1PR0302MB2750.eurprd03.prod.outlook.com
 ([fe80::d77:d217:1660:c5d4]) by VI1PR0302MB2750.eurprd03.prod.outlook.com
 ([fe80::d77:d217:1660:c5d4%2]) with mapi id 15.20.1446.027; Tue, 25 Dec 2018
 21:35:34 +0000
From:   Kevin 'ldir' Darbyshire-Bryant <ldir@darbyshire-bryant.me.uk>
To:     Hauke Mehrtens <hauke@hauke-m.de>
CC:     "paul.burton@mips.com" <paul.burton@mips.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "jonas.gorski@gmail.com" <jonas.gorski@gmail.com>
Subject: Re: [PATCH] MIPS: Add CPU option reporting to /proc/cpuinfo
Thread-Topic: [PATCH] MIPS: Add CPU option reporting to /proc/cpuinfo
Thread-Index: AQHUmxJAeVFEpnFmuk+WQwjlWhVAMaWNmOUAgABN7ICAABEaAIACBXiA
Date:   Tue, 25 Dec 2018 21:35:34 +0000
Message-ID: <FA3C385D-0FE2-4462-A7CA-89D984BBB234@darbyshire-bryant.me.uk>
References: <20181223225224.23042-1-hauke@hauke-m.de>
 <81623E5E-FAB2-4C91-B7F9-8C5BB8422D5C@darbyshire-bryant.me.uk>
 <89c9e62d-850c-2c78-3d09-269ce0c619a1@hauke-m.de>
 <4088FEE6-B2A4-49CE-8816-1A33D5443E21@darbyshire-bryant.me.uk>
In-Reply-To: <4088FEE6-B2A4-49CE-8816-1A33D5443E21@darbyshire-bryant.me.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ldir@darbyshire-bryant.me.uk; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2a02:c7f:1240:ee00::dc83]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0302MB3439;6:o4E95519Lxj6yVpOGl3Z3SHNZ+wz0pCC6JcDweTxb3QV3/wc6vChCa+0bwiawjc/DhoATj4sXHUWRB8E2c1syt1XgHb3FNEnMMiJOr3/hAR8gV8pDn+XC4g1JwtBbyEUujp1Y55Av2PRiQrCIivfOrX/jjluWWFVqRD/tJqtBZXbKZD+DFBu+TNqTW/k/9vp2n7JlBKW7xK1r36ss9H4rsHS4ZKwK7ADWm7UE2U/OYJP0EZQNldT1D1z9efDJPbUIMQLwV0+ljQrzTA6MsI8MIBB2WpRJ8cpSTiZi8W1io9BZTVIltKPut4hQwW8EYmJvnY5rw1y3rF5H8qpQZAxPyZwMxsgZKpYw5Dmvg41mC775gsEv9oCPh8KiNf9K9Lk5y3Jzr9A6JSUbiBk6cPqtPmlLzZ6FQ8EvrLtLA0QQ8A0qL4BxmaRa4L4+SoJDqy72jjElTsQcwwJi1/33W5FdA==;5:WktV+gNkej7O0wtfvwRKRRGdKsQjwtMyN4osp0m4uG/5qID+MsyNlGoIV8fxkdgkLUxPkDbchKfa25r5HMnnUpIMgRAgRI6wJ/SW130+7ODQQijI2R3miP0VZ4Fhy+eol+6B3Cc3KK1YDL5in3cnHZWEztJsOypDede47rH50ag=;7:gTYYHP9bnosXqZMEBMGSC+p0nFvjvFDM32YKJrzvymmSHvAHeE9wjz0Cwug3bRXBpl/FbXIWpDTmzSyi8FEO6jhoAguw3ah7J8O4/ehMSh1ELHd2pszQ4jNi3h/1xw1vBaxjNwhA1ygKkiQjSITQEw==
x-ms-office365-filtering-correlation-id: b4f80d37-521f-4f8a-b31f-08d66ab0e746
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0302MB3439;
x-ms-traffictypediagnostic: VI1PR0302MB3439:
x-microsoft-antispam-prvs: <VI1PR0302MB3439DF7D61902E9B4A8BCA94C9B40@VI1PR0302MB3439.eurprd03.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(93006095)(93001095)(3002001)(3231475)(944501520)(52105112)(10201501046)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6043046)(201708071742011)(7699051)(76991095);SRVR:VI1PR0302MB3439;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0302MB3439;
x-forefront-prvs: 08978A8F5C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(376002)(39830400003)(366004)(189003)(199004)(39060400002)(486006)(7736002)(74482002)(6512007)(11346002)(476003)(2616005)(46003)(446003)(53936002)(6246003)(186003)(106356001)(6436002)(97736004)(25786009)(33656002)(105586002)(102836004)(4326008)(36756003)(229853002)(6916009)(93886005)(6486002)(71200400001)(53546011)(2906002)(99286004)(508600001)(83716004)(71190400001)(14454004)(256004)(6506007)(8936002)(76176011)(8676002)(81166006)(81156014)(54906003)(305945005)(6116002)(82746002)(68736007)(316002)(86362001)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0302MB3439;H:VI1PR0302MB2750.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: darbyshire-bryant.me.uk does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ey1fXHAwIgIThyXnvXXXvQSf8UbxmSnQq1n8SFCJr6irVOwBARRCAX2LB4mQ/HKw4iIKFi3E4g8jmmyKvQHfKZ2dL2hAdkritN7bF108jt9o7zWMG06rPsO8sS8WQJEs/lp5CCI9rUmfjJbOOs/0mJtXRx3Yrs6PyMsaFJZv0VswGPLPhb0mCNfRCyjd995IRbPx9WuG/7C7U2PdLiZC/gyXPg9FfLQTc7pVCWjaJa39jE7ubz3U6K6KnZQfnLZdYt+PeObMk4S6bQdbicK8QZ8fI7i6nckUZ5VU7uNXU/Ro5lMu26iHt8b4pCinkXEH
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8D3370AFDF73174F9CF60119469D8F4A@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: darbyshire-bryant.me.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f80d37-521f-4f8a-b31f-08d66ab0e746
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2018 21:35:34.5831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9151708b-c553-406f-8e56-694f435154a4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0302MB3439
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org



> On 24 Dec 2018, at 14:43, Kevin 'ldir' Darbyshire-Bryant <ldir@darbyshire=
-bryant.me.uk> wrote:
>=20
>=20
>=20
>> On 24 Dec 2018, at 13:42, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>>=20
> <snip>
>> Hi Kevin,
>>=20
>> Normally you should not deactivate any features in cpu-feature-overrides=
.h which are supported by the CPU, when you do not define any thing the ker=
nel will use auto detection.
>>=20
>> I think we should use the cpu_has_foo features as these are the features=
 which could be used by user space applications, if it is only accidentally=
 deactivated by the kernel, which should not happen, it could be that this =
feature is not fully set up by the kernel and will not work.
>>=20
>> Hauke
>=20
> Fair enough.

Tried your patch and discovered you need to wrap the cpu_has_mipsmt_pertcco=
unters:

+#ifdef CONFIG_MIPS_PERF_SHARED_TC_COUNTERS
+      if (cpu_has_mipsmt_pertccounters)
+              seq_printf(m, "%s", " mipsmt_pertccounters");
+#endif

otherwise when building for archer c7 v2 (74kc) in openwrt this happens:

arch/mips/kernel/proc.c: In function 'show_cpuinfo':
arch/mips/kernel/proc.c:245:6: error: 'cpu_has_mipsmt_pertccounters' undecl=
ared (first use in this function); did you mean 'can_use_mips_counter'?
  if (cpu_has_mipsmt_pertccounters)
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
      can_use_mips_counter


Cheers,

Kevin D-B

012C ACB2 28C6 C53E 9775  9123 B3A2 389B 9DE2 334A

