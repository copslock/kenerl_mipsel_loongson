Return-Path: <SRS0=nWPK=SH=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405EBC282DA
	for <linux-mips@archiver.kernel.org>; Fri,  5 Apr 2019 22:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009DC2171F
	for <linux-mips@archiver.kernel.org>; Fri,  5 Apr 2019 22:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="Vmq+7VYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfDEWul (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 5 Apr 2019 18:50:41 -0400
Received: from mail-eopbgr740120.outbound.protection.outlook.com ([40.107.74.120]:4924
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726384AbfDEWul (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 5 Apr 2019 18:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4soFz8TJ4lT+1PYwh+XzMTCD636I7KxICWWSoMhzqm0=;
 b=Vmq+7VYmctWU5LHt5FJHxcm0aJnY7CS5cLKHeA7dd3brcGtdXDCNBRgMbjmjGdeDYAP5/ywo0ECKRYFLLPcA6ezYBEPmz+8gQOo2zgB6z8hG6fonVKWWjagfE2imXEr9o9U+ZKUNp4SZjRP2lXFzYOtGBFFYVYQ6kjNMGgHC7fs=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1278.namprd22.prod.outlook.com (10.174.162.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.22; Fri, 5 Apr 2019 22:50:36 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765%7]) with mapi id 15.20.1771.016; Fri, 5 Apr 2019
 22:50:36 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 2/3] MIPS: jump_label: Use compact branches for >= r6
Thread-Topic: [PATCH 2/3] MIPS: jump_label: Use compact branches for >= r6
Thread-Index: AQHU7AH7l3WWxLhIgE2nt3nAQ5lAlQ==
Date:   Fri, 5 Apr 2019 22:50:36 +0000
Message-ID: <20190405225014.15236-2-paul.burton@mips.com>
References: <20190405225014.15236-1-paul.burton@mips.com>
In-Reply-To: <20190405225014.15236-1-paul.burton@mips.com>
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
x-ms-office365-filtering-correlation-id: dbbd42d2-9ec9-4a15-fc34-08d6ba191df6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR2201MB1278;
x-ms-traffictypediagnostic: MWHPR2201MB1278:
x-microsoft-antispam-prvs: <MWHPR2201MB1278EAED5D16956565CC73F3C1510@MWHPR2201MB1278.namprd22.prod.outlook.com>
x-forefront-prvs: 0998671D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(366004)(376002)(346002)(396003)(136003)(189003)(199004)(486006)(305945005)(8936002)(76176011)(105586002)(14454004)(25786009)(52116002)(2351001)(476003)(44832011)(6512007)(2616005)(81166006)(53936002)(186003)(446003)(5640700003)(107886003)(99286004)(81156014)(4326008)(316002)(26005)(7736002)(8676002)(5660300002)(2501003)(11346002)(50226002)(386003)(102836004)(42882007)(2906002)(106356001)(97736004)(66066001)(14444005)(36756003)(1076003)(6436002)(71190400001)(6506007)(6916009)(478600001)(256004)(3846002)(6116002)(6486002)(71200400001)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1278;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eMcH4HATiWIlJ1PC9xlTf6w70W0pMo0Nux9gr3uHP05RRkLVDVDkSosFUFQJgnxyKRgOpQ7XghyDoIy1C8tAaEitc+npksfigC3x45PIbxSllvjyXzahpeSICJzH4Xns7ZmkfRalNP5yao4ycz+XYN13zcCANJPd8rA3rsd11hhCXJLHQ0vm+lHh+1vn/zPfIE48B6JxZk0KJKF2uPEGSx2xAbSAHfNZZOnZogemYJmt3XuzTzFBsCnQsB441hUoRDhFG5+7CAH/tU0eUWPHwRJ9tibmbaxRkTu6uCszJDZswZlRFxdOyuwb0NhWaMym8gUFWaTQbMroffMPG3HH//WVHGsDl4+eQ4OJjilDwFEekrnaVHopS3lxoZUCe6KAN4KRErdBDAQAwWr2pzO4zJXqr/vd46fH6epO1I8iAQE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbbd42d2-9ec9-4a15-fc34-08d6ba191df6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2019 22:50:36.3181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1278
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

TUlQU3I2IGludHJvZHVjZWQgY29tcGFjdCBicmFuY2hlcyB3aGljaCBoYXZlIG5vIGRlbGF5IHNs
b3RzLiBNYWtlIHVzZQ0Kb2YgdGhlbSBmb3IganVtcCBsYWJlbHMgaW4gb3JkZXIgdG8gYXZvaWQg
dGhlIG5lZWQgZm9yIGEgbm9wIHRvIGZpbGwgdGhlDQpicmFuY2ggb3IganVtcCBkZWxheSBzbG90
LCBzYXZpbmcgNCBieXRlcyBvZiBjb2RlIGZvciBlYWNoIHN0YXRpYyBicmFuY2guDQoNClNpZ25l
ZC1vZmYtYnk6IFBhdWwgQnVydG9uIDxwYXVsLmJ1cnRvbkBtaXBzLmNvbT4NCi0tLQ0KDQogYXJj
aC9taXBzL2luY2x1ZGUvYXNtL2p1bXBfbGFiZWwuaCB8IDEyICsrKysrKysrKy0tLQ0KIGFyY2gv
bWlwcy9rZXJuZWwvanVtcF9sYWJlbC5jICAgICAgfCAzMCArKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0NCiAyIGZpbGVzIGNoYW5nZWQsIDM0IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25z
KC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL21pcHMvaW5jbHVkZS9hc20vanVtcF9sYWJlbC5oIGIv
YXJjaC9taXBzL2luY2x1ZGUvYXNtL2p1bXBfbGFiZWwuaA0KaW5kZXggZGYwNDQ0OWIyNjFiLi4z
MTg1ZmQzMjIwZWMgMTAwNjQ0DQotLS0gYS9hcmNoL21pcHMvaW5jbHVkZS9hc20vanVtcF9sYWJl
bC5oDQorKysgYi9hcmNoL21pcHMvaW5jbHVkZS9hc20vanVtcF9sYWJlbC5oDQpAQCAtMTEsNiAr
MTEsNyBAQA0KICNpZm5kZWYgX19BU1NFTUJMWV9fDQogDQogI2luY2x1ZGUgPGxpbnV4L3R5cGVz
Lmg+DQorI2luY2x1ZGUgPGFzbS9pc2EtcmV2Lmg+DQogDQogI2RlZmluZSBKVU1QX0xBQkVMX05P
UF9TSVpFIDQNCiANCkBAIC0yMSw5ICsyMiwxNCBAQA0KICNlbmRpZg0KIA0KICNpZmRlZiBDT05G
SUdfQ1BVX01JQ1JPTUlQUw0KLSNkZWZpbmUgQl9JTlNOICJiMzIiDQorIyBkZWZpbmUgQl9JTlNO
ICJiMzIiDQorIyBkZWZpbmUgSl9JTlNOICJqMzIiDQorI2VsaWYgTUlQU19JU0FfUkVWID49IDYN
CisjIGRlZmluZSBCX0lOU04gImJjIg0KKyMgZGVmaW5lIEpfSU5TTiAiYmMiDQogI2Vsc2UNCi0j
ZGVmaW5lIEJfSU5TTiAiYiINCisjIGRlZmluZSBCX0lOU04gImIiDQorIyBkZWZpbmUgSl9JTlNO
ICJqIg0KICNlbmRpZg0KIA0KIHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgYm9vbCBhcmNoX3N0YXRp
Y19icmFuY2goc3RydWN0IHN0YXRpY19rZXkgKmtleSwgYm9vbCBicmFuY2gpDQpAQCAtNDIsNyAr
NDgsNyBAQCBzdGF0aWMgX19hbHdheXNfaW5saW5lIGJvb2wgYXJjaF9zdGF0aWNfYnJhbmNoKHN0
cnVjdCBzdGF0aWNfa2V5ICprZXksIGJvb2wgYnJhbg0KIA0KIHN0YXRpYyBfX2Fsd2F5c19pbmxp
bmUgYm9vbCBhcmNoX3N0YXRpY19icmFuY2hfanVtcChzdHJ1Y3Qgc3RhdGljX2tleSAqa2V5LCBi
b29sIGJyYW5jaCkNCiB7DQotCWFzbV92b2xhdGlsZV9nb3RvKCIxOlx0aiAlbFtsX3llc11cblx0
Ig0KKwlhc21fdm9sYXRpbGVfZ290bygiMTpcdCIgSl9JTlNOICIgJWxbbF95ZXNdXG5cdCINCiAJ
CSIucHVzaHNlY3Rpb24gX19qdW1wX3RhYmxlLCAgXCJhd1wiXG5cdCINCiAJCVdPUkRfSU5TTiAi
IDFiLCAlbFtsX3llc10sICUwXG5cdCINCiAJCSIucG9wc2VjdGlvblxuXHQiDQpkaWZmIC0tZ2l0
IGEvYXJjaC9taXBzL2tlcm5lbC9qdW1wX2xhYmVsLmMgYi9hcmNoL21pcHMva2VybmVsL2p1bXBf
bGFiZWwuYw0KaW5kZXggYWI5NDM5MjdmOTdhLi42NjJjOGRiOWY0NWIgMTAwNjQ0DQotLS0gYS9h
cmNoL21pcHMva2VybmVsL2p1bXBfbGFiZWwuYw0KKysrIGIvYXJjaC9taXBzL2tlcm5lbC9qdW1w
X2xhYmVsLmMNCkBAIC00MCwxOCArNDAsMzggQEAgdm9pZCBhcmNoX2p1bXBfbGFiZWxfdHJhbnNm
b3JtKHN0cnVjdCBqdW1wX2VudHJ5ICplLA0KIHsNCiAJdW5pb24gbWlwc19pbnN0cnVjdGlvbiAq
aW5zbl9wOw0KIAl1bmlvbiBtaXBzX2luc3RydWN0aW9uIGluc247DQorCWxvbmcgb2Zmc2V0Ow0K
IA0KIAlpbnNuX3AgPSAodW5pb24gbWlwc19pbnN0cnVjdGlvbiAqKW1za19pc2ExNl9tb2RlKGUt
PmNvZGUpOw0KIA0KLQkvKiBKdW1wIG9ubHkgd29ya3Mgd2l0aGluIGFuIGFsaWduZWQgcmVnaW9u
IGl0cyBkZWxheSBzbG90IGlzIGluLiAqLw0KLQlCVUdfT04oKGUtPnRhcmdldCAmIH5KX1JBTkdF
X01BU0spICE9ICgoZS0+Y29kZSArIDQpICYgfkpfUkFOR0VfTUFTSykpOw0KLQ0KIAkvKiBUYXJn
ZXQgbXVzdCBoYXZlIHRoZSByaWdodCBhbGlnbm1lbnQgYW5kIElTQSBtdXN0IGJlIHByZXNlcnZl
ZC4gKi8NCiAJQlVHX09OKChlLT50YXJnZXQgJiBKX0FMSUdOX01BU0spICE9IEpfSVNBX0JJVCk7
DQogDQogCWlmICh0eXBlID09IEpVTVBfTEFCRUxfSk1QKSB7DQotCQlpbnNuLmpfZm9ybWF0Lm9w
Y29kZSA9IEpfSVNBX0JJVCA/IG1tX2ozMl9vcCA6IGpfb3A7DQotCQlpbnNuLmpfZm9ybWF0LnRh
cmdldCA9IGUtPnRhcmdldCA+PiBKX1JBTkdFX1NISUZUOw0KKwkJaWYgKCFJU19FTkFCTEVEKENP
TkZJR19DUFVfTUlDUk9NSVBTKSAmJiBNSVBTX0lTQV9SRVYgPj0gNikgew0KKwkJCW9mZnNldCA9
IGUtPnRhcmdldCAtICgodW5zaWduZWQgbG9uZylpbnNuX3AgKyA0KTsNCisJCQlvZmZzZXQgPj49
IDI7DQorDQorCQkJLyoNCisJCQkgKiBUaGUgYnJhbmNoIG9mZnNldCBtdXN0IGZpdCBpbiB0aGUg
aW5zdHJ1Y3Rpb24ncyAyNg0KKwkJCSAqIGJpdCBmaWVsZC4NCisJCQkgKi8NCisJCQlXQVJOX09O
KChvZmZzZXQgPj0gQklUKDI1KSkgfHwNCisJCQkJKG9mZnNldCA8IC0obG9uZylCSVQoMjUpKSk7
DQorDQorCQkJaW5zbi5qX2Zvcm1hdC5vcGNvZGUgPSBiYzZfb3A7DQorCQkJaW5zbi5qX2Zvcm1h
dC50YXJnZXQgPSBvZmZzZXQ7DQorCQl9IGVsc2Ugew0KKwkJCS8qDQorCQkJICogSnVtcCBvbmx5
IHdvcmtzIHdpdGhpbiBhbiBhbGlnbmVkIHJlZ2lvbiBpdHMgZGVsYXkNCisJCQkgKiBzbG90IGlz
IGluLg0KKwkJCSAqLw0KKwkJCVdBUk5fT04oKGUtPnRhcmdldCAmIH5KX1JBTkdFX01BU0spICE9
DQorCQkJCSgoZS0+Y29kZSArIDQpICYgfkpfUkFOR0VfTUFTSykpOw0KKw0KKwkJCWluc24ual9m
b3JtYXQub3Bjb2RlID0gSl9JU0FfQklUID8gbW1fajMyX29wIDogal9vcDsNCisJCQlpbnNuLmpf
Zm9ybWF0LnRhcmdldCA9IGUtPnRhcmdldCA+PiBKX1JBTkdFX1NISUZUOw0KKwkJfQ0KIAl9IGVs
c2Ugew0KIAkJaW5zbi53b3JkID0gMDsgLyogbm9wICovDQogCX0NCi0tIA0KMi4yMS4wDQoNCg==
