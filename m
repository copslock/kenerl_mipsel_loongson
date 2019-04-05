Return-Path: <SRS0=nWPK=SH=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A64C282DC
	for <linux-mips@archiver.kernel.org>; Fri,  5 Apr 2019 22:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF9C2171F
	for <linux-mips@archiver.kernel.org>; Fri,  5 Apr 2019 22:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="rIsN6PB3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfDEWun (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 5 Apr 2019 18:50:43 -0400
Received: from mail-eopbgr740120.outbound.protection.outlook.com ([40.107.74.120]:4924
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726206AbfDEWun (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 5 Apr 2019 18:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEzMvOIf7x0ouwuCVCRrCgf1Hzvijuzyj0ak8tcLsNk=;
 b=rIsN6PB3CDtj9FJGrnOB35FbPOR097B6yXo297gN7XZ94PSNot364em9vzHKPQjEr88dQ86WC7qjXikDN4j0eyvJhV1F6hTVakONLj0WJmQ2RaYk2TelrQF+gUUs4dHJc5nNcemaDLnsVkdlnoOM3HTbgLj6Qsmfvsv4YnAakBA=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1278.namprd22.prod.outlook.com (10.174.162.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.22; Fri, 5 Apr 2019 22:50:37 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765%7]) with mapi id 15.20.1771.016; Fri, 5 Apr 2019
 22:50:37 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 3/3] MIPS: generic: Enable CONFIG_JUMP_LABEL
Thread-Topic: [PATCH 3/3] MIPS: generic: Enable CONFIG_JUMP_LABEL
Thread-Index: AQHU7AH8CErdwUearEmY9sLCsMvvNw==
Date:   Fri, 5 Apr 2019 22:50:37 +0000
Message-ID: <20190405225014.15236-3-paul.burton@mips.com>
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
x-ms-office365-filtering-correlation-id: 02f8aee2-626a-4bfa-12b5-08d6ba191e72
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR2201MB1278;
x-ms-traffictypediagnostic: MWHPR2201MB1278:
x-microsoft-antispam-prvs: <MWHPR2201MB1278312B028D3D686AF46C0BC1510@MWHPR2201MB1278.namprd22.prod.outlook.com>
x-forefront-prvs: 0998671D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(366004)(376002)(346002)(396003)(136003)(189003)(199004)(486006)(305945005)(8936002)(76176011)(105586002)(14454004)(25786009)(52116002)(2351001)(476003)(44832011)(6512007)(2616005)(81166006)(53936002)(186003)(446003)(5640700003)(107886003)(99286004)(81156014)(4326008)(316002)(26005)(7736002)(8676002)(5660300002)(2501003)(11346002)(50226002)(386003)(102836004)(42882007)(2906002)(106356001)(97736004)(66066001)(14444005)(36756003)(1076003)(6436002)(71190400001)(6506007)(6916009)(4744005)(478600001)(256004)(3846002)(6116002)(6486002)(71200400001)(68736007)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1278;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: drSWsoD8cdLNyzASmKwBcVS5E4at62sf5WDaApyPFsOn2NVcTlNbe5VBsBRBuoSQgW0n7+qJ/MSh/05RMBWACSu+9Ham0/uMn40ONpRsJXVthci9KdhC8klAO3/qo2SDtR4rSiwM7NwtTCOjToU/O8JUnxo0TVS+TAxKywa0tvdbfaA5DHdEFzOg7qZu1GXlwXKaHa3Ot1BP4Y+KanCWFex3WYFTKW6ULDcB0Q2ntF/OVfs16ONUGyHeYGTj7NEdFoBIQLjNk1qXHJ6ILg+ZMYWuc5GGVyvo5oq4MiFm0x9XYRCOSfWS+z1HKds6E3GxgkDsGDZ0QPbhj0GRyEWctqoZ+IQBYBV5pO8eVq5nnqR9PkrE553WVS1ltePTNuxdVKhcnuMBPJMP+U5WoWxqPGpGwFaNyWrO1if5dklej8k=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f8aee2-626a-4bfa-12b5-08d6ba191e72
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2019 22:50:37.0517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1278
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

RW5hYmxlIENPTkZJR19KVU1QX0xBQkVMIGZvciBnZW5lcmljIGNvbmZpZ3MgaW4gb3JkZXIgdG8g
YmV0dGVyIG9wdGltaXplDQphdCBydW50aW1lIGFuZCBnZXQgYmV0dGVyIHRlc3QgY292ZXJhZ2Ug
Zm9yIG91ciBqdW1wIGxhYmVsIHN1cHBvcnQuDQoNClNpZ25lZC1vZmYtYnk6IFBhdWwgQnVydG9u
IDxwYXVsLmJ1cnRvbkBtaXBzLmNvbT4NCi0tLQ0KDQogYXJjaC9taXBzL2NvbmZpZ3MvZ2VuZXJp
Y19kZWZjb25maWcgfCAxICsNCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCg0KZGlm
ZiAtLWdpdCBhL2FyY2gvbWlwcy9jb25maWdzL2dlbmVyaWNfZGVmY29uZmlnIGIvYXJjaC9taXBz
L2NvbmZpZ3MvZ2VuZXJpY19kZWZjb25maWcNCmluZGV4IDVkODA1MjFlNWQ1YS4uNzE0MTY5ZTQx
MWNmIDEwMDY0NA0KLS0tIGEvYXJjaC9taXBzL2NvbmZpZ3MvZ2VuZXJpY19kZWZjb25maWcNCisr
KyBiL2FyY2gvbWlwcy9jb25maWdzL2dlbmVyaWNfZGVmY29uZmlnDQpAQCAtMjYsNiArMjYsNyBA
QCBDT05GSUdfTUlQU19DUFM9eQ0KIENPTkZJR19ISUdITUVNPXkNCiBDT05GSUdfTlJfQ1BVUz0x
Ng0KIENPTkZJR19NSVBTX08zMl9GUDY0X1NVUFBPUlQ9eQ0KK0NPTkZJR19KVU1QX0xBQkVMPXkN
CiBDT05GSUdfTU9EVUxFUz15DQogQ09ORklHX01PRFVMRV9VTkxPQUQ9eQ0KIENPTkZJR19UUklN
X1VOVVNFRF9LU1lNUz15DQotLSANCjIuMjEuMA0KDQo=
