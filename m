Return-Path: <SRS0=nWPK=SH=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD7EC282CE
	for <linux-mips@archiver.kernel.org>; Fri,  5 Apr 2019 22:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711EB2171F
	for <linux-mips@archiver.kernel.org>; Fri,  5 Apr 2019 22:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="Dv8rRivI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfDEWuj (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 5 Apr 2019 18:50:39 -0400
Received: from mail-eopbgr740120.outbound.protection.outlook.com ([40.107.74.120]:4924
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726206AbfDEWuj (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 5 Apr 2019 18:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWdQyE4NWb82Aahva76qEhK/y1svkWEIMIlo8/ry+ec=;
 b=Dv8rRivIp2N8VikWfJrL6XpOF02JD4ti74yVX3m3YXKXmoFfIoMUc+vsDMvg/daWkFTrx+gIgx43X/1gl9oB/g3V1NygE7BmVORBMH9yNxOYA3u3R3VLzmtMRg464vKuAXzHc4TVR5idwoVzCJs7sRysiFxe9eaOTH0A3/eSAkQ=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1278.namprd22.prod.outlook.com (10.174.162.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.22; Fri, 5 Apr 2019 22:50:35 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765%7]) with mapi id 15.20.1771.016; Fri, 5 Apr 2019
 22:50:35 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 1/3] MIPS: jump_label: Remove redundant nops
Thread-Topic: [PATCH 1/3] MIPS: jump_label: Remove redundant nops
Thread-Index: AQHU7AH7CwG3ZcEkaU69Sdva8A7leg==
Date:   Fri, 5 Apr 2019 22:50:35 +0000
Message-ID: <20190405225014.15236-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0079.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::20) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.21.0
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3acfb56-024c-4311-ae17-08d6ba191d6f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR2201MB1278;
x-ms-traffictypediagnostic: MWHPR2201MB1278:
x-microsoft-antispam-prvs: <MWHPR2201MB12788242A8BF1420D68B69D0C1510@MWHPR2201MB1278.namprd22.prod.outlook.com>
x-forefront-prvs: 0998671D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(366004)(376002)(346002)(396003)(136003)(189003)(199004)(486006)(305945005)(8936002)(105586002)(14454004)(25786009)(52116002)(2351001)(476003)(44832011)(6512007)(2616005)(81166006)(53936002)(186003)(5640700003)(107886003)(99286004)(81156014)(4326008)(316002)(26005)(7736002)(8676002)(5660300002)(2501003)(50226002)(386003)(102836004)(42882007)(2906002)(106356001)(97736004)(66066001)(36756003)(1076003)(6436002)(71190400001)(6506007)(6916009)(478600001)(256004)(3846002)(6116002)(6486002)(71200400001)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1278;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U3S3Bg9uuPAMre6hRQ5jHoLy66FULMQ+6006P1yInS+OMa/FWLbhQsbNadJHKkxR43geoZ3vEoXXThkg6Kh96KBGi4IZ8Ee4aExI2A8lGbhj6zk+FAoVlChuf6OlDkk5r7222kKA/auymArlB4yzhNk+VqVESdaKLqJabLGUrLC8Hxs3Hm3+8OZ5Hf8H79Wg6FXcbB6WH+04PHPTYntH2b+nEz429dZwuhKB1cW8PxYnq4sHHyZ5BZ6eMgdAKf/cqQg6oUjtN8GSVL7fe5NVCCd88af4Mgyvl4Ul7T6RrhHjYe2tQivLpJLqjufHqLUUz+BYYPH8dZ8QFsn6j6wSWlpCezZ66dV2xcoTGcwM7mzn4W/REt9JDCB7pHmts8Xft9GBLGEA/gAATxBAVqllsM7vSYUTCBgl5mxsF3VYWho=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3acfb56-024c-4311-ae17-08d6ba191d6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2019 22:50:35.5154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1278
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Qm90aCBhcmNoX3N0YXRpY19icmFuY2goKSAmIGFyY2hfc3RhdGljX2JyYW5jaF9qdW1wKCkgZW1p
dCBhIGNvbnRyb2wNCnRyYW5zZmVyIGluc3RydWN0aW9uIChpZS4gYnJhbmNoIG9yIGp1bXApIHdp
dGhvdXQgZGlzYWJsaW5nIGFzc2VtYmxlcg0KcmUtb3JkZXJpbmcuIEFzIHN1Y2ggdGhlIGFzc2Vt
YmxlciB3aWxsIGF1dG9tYXRpY2FsbHkgZmlsbCB0aGVpciBkZWxheQ0Kc2xvdHMuDQoNCkJvdGgg
ZnVuY3Rpb25zIGZvbGxvdyB0aGVpciBicmFuY2ggb3IganVtcCB3aXRoIGFuIGV4cGxpY2l0IG5v
cCB0aGF0IGF0DQpmaXJzdCBhcHBlYXJzIHRvIGJlIHRoZXJlIHRvIGZpbGwgdGhlIGRlbGF5IHNs
b3QsIGJ1dCBnaXZlbiB0aGF0IHRoZQ0KYXNzZW1ibGVyIHdpbGwgZG8gdGhhdCB0aGUgZXhwbGlj
aXQgbm9wcyBzZXJ2ZSBubyBwdXJwb3NlICYgd2UgZW5kIHVwDQp3aXRoIG91ciBicmFuY2ggb3Ig
anVtcCBmb2xsb3dlZCBieSAyIG5vcHMuIFJlbW92ZSB0aGUgcmVkdW5kYW50IG5vcHMuDQoNClNp
Z25lZC1vZmYtYnk6IFBhdWwgQnVydG9uIDxwYXVsLmJ1cnRvbkBtaXBzLmNvbT4NCi0tLQ0KDQog
YXJjaC9taXBzL2luY2x1ZGUvYXNtL2p1bXBfbGFiZWwuaCB8IDMgKy0tDQogMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9t
aXBzL2luY2x1ZGUvYXNtL2p1bXBfbGFiZWwuaCBiL2FyY2gvbWlwcy9pbmNsdWRlL2FzbS9qdW1w
X2xhYmVsLmgNCmluZGV4IGU0NDU2ZTQ1MGY5NC4uZGYwNDQ0OWIyNjFiIDEwMDY0NA0KLS0tIGEv
YXJjaC9taXBzL2luY2x1ZGUvYXNtL2p1bXBfbGFiZWwuaA0KKysrIGIvYXJjaC9taXBzL2luY2x1
ZGUvYXNtL2p1bXBfbGFiZWwuaA0KQEAgLTI5LDcgKzI5LDcgQEANCiBzdGF0aWMgX19hbHdheXNf
aW5saW5lIGJvb2wgYXJjaF9zdGF0aWNfYnJhbmNoKHN0cnVjdCBzdGF0aWNfa2V5ICprZXksIGJv
b2wgYnJhbmNoKQ0KIHsNCiAJYXNtX3ZvbGF0aWxlX2dvdG8oIjE6XHQiIEJfSU5TTiAiIDJmXG5c
dCINCi0JCSIyOlx0bm9wXG5cdCINCisJCSIyOlx0Lmluc25cblx0Ig0KIAkJIi5wdXNoc2VjdGlv
biBfX2p1bXBfdGFibGUsICBcImF3XCJcblx0Ig0KIAkJV09SRF9JTlNOICIgMWIsICVsW2xfeWVz
XSwgJTBcblx0Ig0KIAkJIi5wb3BzZWN0aW9uXG5cdCINCkBAIC00Myw3ICs0Myw2IEBAIHN0YXRp
YyBfX2Fsd2F5c19pbmxpbmUgYm9vbCBhcmNoX3N0YXRpY19icmFuY2goc3RydWN0IHN0YXRpY19r
ZXkgKmtleSwgYm9vbCBicmFuDQogc3RhdGljIF9fYWx3YXlzX2lubGluZSBib29sIGFyY2hfc3Rh
dGljX2JyYW5jaF9qdW1wKHN0cnVjdCBzdGF0aWNfa2V5ICprZXksIGJvb2wgYnJhbmNoKQ0KIHsN
CiAJYXNtX3ZvbGF0aWxlX2dvdG8oIjE6XHRqICVsW2xfeWVzXVxuXHQiDQotCQkibm9wXG5cdCIN
CiAJCSIucHVzaHNlY3Rpb24gX19qdW1wX3RhYmxlLCAgXCJhd1wiXG5cdCINCiAJCVdPUkRfSU5T
TiAiIDFiLCAlbFtsX3llc10sICUwXG5cdCINCiAJCSIucG9wc2VjdGlvblxuXHQiDQotLSANCjIu
MjEuMA0KDQo=
