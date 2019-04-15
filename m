Return-Path: <SRS0=MCbt=SR=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BE4C10F0E
	for <linux-mips@archiver.kernel.org>; Mon, 15 Apr 2019 17:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A82202073F
	for <linux-mips@archiver.kernel.org>; Mon, 15 Apr 2019 17:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="JSX4WXux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfDORhG (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:37:06 -0400
Received: from mail-eopbgr770137.outbound.protection.outlook.com ([40.107.77.137]:32583
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727490AbfDORhG (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 15 Apr 2019 13:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/NDw3P8O2seC2cXxn2b0Fzs0GEXYKtE53y/3Rc05hA=;
 b=JSX4WXuxzgJpvfHi5QXQDL5mwgdS3IAODx4hCjihSg3hhyQFEEGX88y3N5Bg15/hX5YvYOWIw0ABOZeWyx4m48k2q1xfT7BWvs+E4tAvFzO3BW0J2NVVU/+Ww3lVcawS6sBgdrRM5t1nRVSjiaa44pyE+PLtUR6yhQa2OR3SsCk=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1341.namprd22.prod.outlook.com (10.174.162.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.14; Mon, 15 Apr 2019 17:37:04 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765%7]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 17:37:04 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Paul Burton <pburton@wavecomp.com>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH 1/3] MIPS: jump_label: Remove redundant nops
Thread-Topic: [PATCH 1/3] MIPS: jump_label: Remove redundant nops
Thread-Index: AQHU7AH7CwG3ZcEkaU69Sdva8A7leqY9i6cA
Date:   Mon, 15 Apr 2019 17:37:04 +0000
Message-ID: <MWHPR2201MB127787844B78DFFD6F81E95FC12B0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190405225014.15236-1-paul.burton@mips.com>
In-Reply-To: <20190405225014.15236-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0048.namprd08.prod.outlook.com
 (2603:10b6:a03:117::25) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62dee778-c09f-4e09-62cb-08d6c1c8f95f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR2201MB1341;
x-ms-traffictypediagnostic: MWHPR2201MB1341:
x-microsoft-antispam-prvs: <MWHPR2201MB13411B2D26B0F71FD21B678FC12B0@MWHPR2201MB1341.namprd22.prod.outlook.com>
x-forefront-prvs: 000800954F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(366004)(39840400004)(376002)(199004)(189003)(42882007)(3846002)(71190400001)(68736007)(81166006)(11346002)(2906002)(7696005)(55016002)(81156014)(229853002)(8676002)(52116002)(256004)(6436002)(99286004)(97736004)(8936002)(9686003)(71200400001)(476003)(14454004)(478600001)(6116002)(446003)(486006)(102836004)(386003)(105586002)(44832011)(5660300002)(4326008)(6506007)(106356001)(316002)(66066001)(4744005)(25786009)(52536014)(6862004)(53936002)(6246003)(33656002)(76176011)(26005)(74316002)(54906003)(305945005)(7736002)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1341;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +DKKpRgJxLDxbryp/AsTthog4K+C9wXOH0SZSO5k9jr/OTfkaZwiQ75xv8p3ygizLLvZ0oHKhUoDoS4uJv+zCqnpoF1exOJrpMaMD/znbvaovkBebPJ+7bmM+8Apadj3U17wSpfMOPvNNp0VslKzB0IMpxsMohqeWV2mm38RufDgIXXwPKHZO/Yld/NaQ1i0jZkZ4JiVIw5yJGkReNZZ3S8d2n1hXNJi6Nyd/qo65716TO2sNF5Ieqtsdt0zXs8rH1u08pJMU08SdYQqGD56d3B1IczoKMF7WTv2kFvyFyYHAXX8FT2k5tJ9GR7mq159Rjq1ciRreNGSLadcjyFLNZsZyAroHMDqpMC9FGGq3q/5iFsBXpPIRmkxy5YzrhdFhg4aQJTlDt2wy9+7pyTRt31hG9vCMDvx6ulMNrGAj70=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62dee778-c09f-4e09-62cb-08d6c1c8f95f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 17:37:04.4204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1341
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

SGVsbG8sDQoNClBhdWwgQnVydG9uIHdyb3RlOg0KPiBCb3RoIGFyY2hfc3RhdGljX2JyYW5jaCgp
ICYgYXJjaF9zdGF0aWNfYnJhbmNoX2p1bXAoKSBlbWl0IGEgY29udHJvbA0KPiB0cmFuc2ZlciBp
bnN0cnVjdGlvbiAoaWUuIGJyYW5jaCBvciBqdW1wKSB3aXRob3V0IGRpc2FibGluZyBhc3NlbWJs
ZXINCj4gcmUtb3JkZXJpbmcuIEFzIHN1Y2ggdGhlIGFzc2VtYmxlciB3aWxsIGF1dG9tYXRpY2Fs
bHkgZmlsbCB0aGVpciBkZWxheQ0KPiBzbG90cy4NCj4gDQo+IEJvdGggZnVuY3Rpb25zIGZvbGxv
dyB0aGVpciBicmFuY2ggb3IganVtcCB3aXRoIGFuIGV4cGxpY2l0IG5vcCB0aGF0IGF0DQo+IGZp
cnN0IGFwcGVhcnMgdG8gYmUgdGhlcmUgdG8gZmlsbCB0aGUgZGVsYXkgc2xvdCwgYnV0IGdpdmVu
IHRoYXQgdGhlDQo+IGFzc2VtYmxlciB3aWxsIGRvIHRoYXQgdGhlIGV4cGxpY2l0IG5vcHMgc2Vy
dmUgbm8gcHVycG9zZSAmIHdlIGVuZCB1cA0KPiB3aXRoIG91ciBicmFuY2ggb3IganVtcCBmb2xs
b3dlZCBieSAyIG5vcHMuIFJlbW92ZSB0aGUgcmVkdW5kYW50IG5vcHMuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBQYXVsIEJ1cnRvbiA8cGF1bC5idXJ0b25AbWlwcy5jb20+DQoNClNlcmllcyBhcHBs
aWVkIHRvIG1pcHMtbmV4dC4NCg0KVGhhbmtzLA0KICAgIFBhdWwNCg0KWyBUaGlzIG1lc3NhZ2Ug
d2FzIGF1dG8tZ2VuZXJhdGVkOyBpZiB5b3UgYmVsaWV2ZSBhbnl0aGluZyBpcyBpbmNvcnJlY3QN
CiAgdGhlbiBwbGVhc2UgZW1haWwgcGF1bC5idXJ0b25AbWlwcy5jb20gdG8gcmVwb3J0IGl0LiBd
DQo=
