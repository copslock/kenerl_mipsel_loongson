Return-Path: <SRS0=dgrR=U6=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0103C0650F
	for <linux-mips@archiver.kernel.org>; Mon,  1 Jul 2019 04:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C83CB20B7C
	for <linux-mips@archiver.kernel.org>; Mon,  1 Jul 2019 04:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="UHF2w9wG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfGAE0j (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 1 Jul 2019 00:26:39 -0400
Received: from mail-eopbgr710094.outbound.protection.outlook.com ([40.107.71.94]:26647
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727167AbfGAE0i (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 1 Jul 2019 00:26:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVufBjG11yP5Kn9mpPA4ezGyxg/ciXlU4UkVR9tyxmXB529z4AjGVqn+vNo6hZ4Siumi2ptljD3z+02XIbL38nTf2Zvu5kznG8FH41n7i8hZ4fh8pjBOythmy9TTWSZKrTf2j0lSol7m4eLNdMjJVrMedVRw192jdqR3mtcwpoeUYCQDyBlg22Rno1csCCAAWxyHcAlLqQAGuYlbsNOJ0TpSxqMLHZ4tvPwG80a5UH4xvSp2+BLRNoWjXAtlhG3L2RSMrzR8XaYQvpC/cFETZbewDyo6Lejsw9oqstCeMKuH1syiSE3dYjU8qrccNatlTUfb9hLs7NeZ1o2ocxZWew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vdp6UCy+/WUEFnLzzQKsXWhk5QMewMEzfsYGPSw59J8=;
 b=QqdPyhw8C4nnDeJJUNprp7+a72kRQrMRGa5hk9OqwSIGDwU3vx8QYSX4nC6phzvLwOQyNx05FvSYEA/aIOkPhERla91lagOiOp0nOqduMwXWQxlzN5fSsO00rSeAPYmHsRBSwxj+uoHj3jqS1uUZiqOlfwZhlk2JVJVThPvHnbfuNbqs3uqLHbXUMwpdQkBqiKDkz3Gr8ljuLRib1fdOoHDg2O6xl/qSZBMwV+OgvL8aCkfpJdQZFlw7AQTbTRvj/sNJYdgkBdkXoBnf8mz5MAcTywrjS+kpDqDZLYw+zY0tl9IorrEidPIfR87jzP7WUBEBe3MwN4ge7++k/s+aFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vdp6UCy+/WUEFnLzzQKsXWhk5QMewMEzfsYGPSw59J8=;
 b=UHF2w9wGJTjaN4e2HroJVzn4KznIFveaK908kkjspsnJR0LmfogqXv/q2y5nB6sms2+gh1R2vy3HjkRR0AtNROjfg6okQE7wIZNYkLdl2es/QquyYL6PSzLqI97FKVJddLEPWt7A3iTD1OeZSDBmGNLGh6Bv9c/aov0rUZZiMBY=
Received: from BYAPR21MB1335.namprd21.prod.outlook.com (20.179.60.209) by
 BYAPR21MB1159.namprd21.prod.outlook.com (20.179.56.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.1; Mon, 1 Jul 2019 04:26:07 +0000
Received: from BYAPR21MB1335.namprd21.prod.outlook.com
 ([fe80::71df:6122:56a2:2a4f]) by BYAPR21MB1335.namprd21.prod.outlook.com
 ([fe80::71df:6122:56a2:2a4f%2]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 04:26:07 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>
CC:     Michael Kelley <mikelley@microsoft.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "paul.burton@mips.com" <paul.burton@mips.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "salyzyn@android.com" <salyzyn@android.com>,
        "pcc@google.com" <pcc@google.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "huw@codeweavers.com" <huw@codeweavers.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: [PATCH v5 2/2] clocksource/drivers: Continue making Hyper-V
 clocksource ISA agnostic
Thread-Topic: [PATCH v5 2/2] clocksource/drivers: Continue making Hyper-V
 clocksource ISA agnostic
Thread-Index: AQHVL8UaurZUV7SxyEWyNf7yaXZfwQ==
Date:   Mon, 1 Jul 2019 04:26:06 +0000
Message-ID: <1561955054-1838-3-git-send-email-mikelley@microsoft.com>
References: <1561955054-1838-1-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1561955054-1838-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR01CA0015.prod.exchangelabs.com (2603:10b6:903:1f::25)
 To BYAPR21MB1335.namprd21.prod.outlook.com (2603:10b6:a03:115::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [167.220.2.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 100e92c5-83b9-4fa2-e665-08d6fddc3c4b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR21MB1159;
x-ms-traffictypediagnostic: BYAPR21MB1159:|BYAPR21MB1159:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BYAPR21MB1159A13D5BB33C8B217C115DD7F90@BYAPR21MB1159.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(189003)(199004)(6436002)(54906003)(4326008)(316002)(110136005)(8676002)(10090500001)(446003)(11346002)(6486002)(86362001)(81166006)(2616005)(476003)(486006)(81156014)(256004)(186003)(7736002)(2501003)(53946003)(6116002)(3846002)(6512007)(36756003)(14444005)(66946007)(305945005)(73956011)(66446008)(66476007)(66556008)(64756008)(8936002)(30864003)(22452003)(53936002)(4720700003)(25786009)(68736007)(26005)(99286004)(2906002)(5660300002)(50226002)(71200400001)(386003)(71190400001)(6506007)(10290500003)(102836004)(478600001)(14454004)(52116002)(2201001)(76176011)(66066001)(7416002)(7406005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR21MB1159;H:BYAPR21MB1335.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BNVrl/pkNeENVR6/RZAFAj4h0YP7UnJMScqmf9buhrmrLXAEA5INy0K9ieO3agkhZmXd81XGNHtzrm4ZwFLL1S6RdaiZ3XaNsKgeFE7SpoMiEYblELhvHjJNcvMIOIwMED4ztWP1oo4l5JWyZUPT2t+1W2lw7cQgg738j5Pc13n63I9XTS0MM9yIzN3KOGIeMcnjFFl6atkO6ky1Wy4IEVNIy+txIeGD/UDnuE0SWKK1H14ZfmyE6g5f+2ytNrV+KgQcjXZP2hIYgVUpyk9TP00FB+GaS4V7l0q/28NYisoZNcOrnhJdZGRgk6IEssW/+zpAtvfU2uo5DRodznaLzMfzcgOAu306rRJ1YqJXnOnND4Fk+kdR26fjX1pglovPgs6ohucs2iMLgTFa/DAmAc02vwkx1u2xnOUrD4mHAUA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 100e92c5-83b9-4fa2-e665-08d6fddc3c4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 04:26:06.8885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lkmlmhk@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1159
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Q29udGludWUgY29uc29saWRhdGluZyBIeXBlci1WIGNsb2NrIGFuZCB0aW1lciBjb2RlIGludG8g
YW4gSVNBDQppbmRlcGVuZGVudCBIeXBlci1WIGNsb2Nrc291cmNlIGRyaXZlci4gTW92ZSB0aGUg
ZXhpc3RpbmcgY2xvY2tzb3VyY2UNCmNvZGUgdW5kZXIgZHJpdmVycy9odiBhbmQgYXJjaC94ODYg
dG8gdGhlIG5ldyBjbG9ja3NvdXJjZSBkcml2ZXINCndoaWxlIHNlcGFyYXRpbmcgb3V0IHRoZSBJ
U0EgZGVwZW5kZW5jaWVzLiBVcGRhdGUgSHlwZXItVg0KaW5pdGlhbGl6YXRpb24gdG8gY2FsbCBp
bml0aWFsaXphdGlvbiBhbmQgY2xlYW51cCByb3V0aW5lcyBzaW5jZSB0aGUNCkh5cGVyLVYgc3lu
dGhldGljIGNsb2NrIGlzIG5vdCBpbmRlcGVuZGVudGx5IGVudW1lcmF0ZWQgaW4gQUNQSS4NClVw
ZGF0ZSBIeXBlci1WIGNsb2Nrc291cmNlIHVzZXJzIGluIEtWTSBhbmQgVkRTTyB0byBnZXQgZGVm
aW5pdGlvbnMNCmZyb20gYSBuZXcgaW5jbHVkZSBmaWxlLg0KDQpObyBiZWhhdmlvciBpcyBjaGFu
Z2VkIGFuZCBubyBuZXcgZnVuY3Rpb25hbGl0eSBpcyBhZGRlZC4NCg0KU3VnZ2VzdGVkLWJ5OiBN
YXJjIFp5bmdpZXIgPG1hcmMuenluZ2llckBhcm0uY29tPg0KUmV2aWV3ZWQtYnk6IFZpdGFseSBL
dXpuZXRzb3YgPHZrdXpuZXRzQHJlZGhhdC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIEtl
bGxleSA8bWlrZWxsZXlAbWljcm9zb2Z0LmNvbT4NCi0tLQ0KIGFyY2gveDg2L2VudHJ5L3Zkc28v
dm1hLmMgICAgICAgICAgICAgICAgfCAgIDIgKy0NCiBhcmNoL3g4Ni9oeXBlcnYvaHZfaW5pdC5j
ICAgICAgICAgICAgICAgIHwgIDkxICstLS0tLS0tLS0tLS0tLS0tLS0tDQogYXJjaC94ODYvaW5j
bHVkZS9hc20vbXNoeXBlcnYuaCAgICAgICAgICB8ICA4MSArKystLS0tLS0tLS0tLS0tLS0NCiBh
cmNoL3g4Ni9pbmNsdWRlL2FzbS92ZHNvL2dldHRpbWVvZmRheS5oIHwgICAyICstDQogYXJjaC94
ODYva3ZtL3g4Ni5jICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQogZHJpdmVycy9jbG9j
a3NvdXJjZS9oeXBlcnZfdGltZXIuYyAgICAgICB8IDEzOSArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrDQogZHJpdmVycy9odi9odl91dGlsLmMgICAgICAgICAgICAgICAgICAgICB8ICAg
MSArDQogaW5jbHVkZS9jbG9ja3NvdXJjZS9oeXBlcnZfdGltZXIuaCAgICAgICB8ICA3OCArKysr
KysrKysrKysrKysrKw0KIDggZmlsZXMgY2hhbmdlZCwgMjM1IGluc2VydGlvbnMoKyksIDE2MCBk
ZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2VudHJ5L3Zkc28vdm1hLmMgYi9h
cmNoL3g4Ni9lbnRyeS92ZHNvL3ZtYS5jDQppbmRleCA4ZGIxZjU5Li4zNDlhNjFkIDEwMDY0NA0K
LS0tIGEvYXJjaC94ODYvZW50cnkvdmRzby92bWEuYw0KKysrIGIvYXJjaC94ODYvZW50cnkvdmRz
by92bWEuYw0KQEAgLTIyLDcgKzIyLDcgQEANCiAjaW5jbHVkZSA8YXNtL3BhZ2UuaD4NCiAjaW5j
bHVkZSA8YXNtL2Rlc2MuaD4NCiAjaW5jbHVkZSA8YXNtL2NwdWZlYXR1cmUuaD4NCi0jaW5jbHVk
ZSA8YXNtL21zaHlwZXJ2Lmg+DQorI2luY2x1ZGUgPGNsb2Nrc291cmNlL2h5cGVydl90aW1lci5o
Pg0KIA0KICNpZiBkZWZpbmVkKENPTkZJR19YODZfNjQpDQogdW5zaWduZWQgaW50IF9fcmVhZF9t
b3N0bHkgdmRzbzY0X2VuYWJsZWQgPSAxOw0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2h5cGVydi9o
dl9pbml0LmMgYi9hcmNoL3g4Ni9oeXBlcnYvaHZfaW5pdC5jDQppbmRleCAxNjA4MDUwLi4wZTAz
M2VmIDEwMDY0NA0KLS0tIGEvYXJjaC94ODYvaHlwZXJ2L2h2X2luaXQuYw0KKysrIGIvYXJjaC94
ODYvaHlwZXJ2L2h2X2luaXQuYw0KQEAgLTE3LDY0ICsxNywxMyBAQA0KICNpbmNsdWRlIDxsaW51
eC92ZXJzaW9uLmg+DQogI2luY2x1ZGUgPGxpbnV4L3ZtYWxsb2MuaD4NCiAjaW5jbHVkZSA8bGlu
dXgvbW0uaD4NCi0jaW5jbHVkZSA8bGludXgvY2xvY2tjaGlwcy5oPg0KICNpbmNsdWRlIDxsaW51
eC9oeXBlcnYuaD4NCiAjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0KICNpbmNsdWRlIDxsaW51eC9j
cHVob3RwbHVnLmg+DQotDQotI2lmZGVmIENPTkZJR19IWVBFUlZfVFNDUEFHRQ0KLQ0KLXN0YXRp
YyBzdHJ1Y3QgbXNfaHlwZXJ2X3RzY19wYWdlICp0c2NfcGc7DQotDQotc3RydWN0IG1zX2h5cGVy
dl90c2NfcGFnZSAqaHZfZ2V0X3RzY19wYWdlKHZvaWQpDQotew0KLQlyZXR1cm4gdHNjX3BnOw0K
LX0NCi1FWFBPUlRfU1lNQk9MX0dQTChodl9nZXRfdHNjX3BhZ2UpOw0KLQ0KLXN0YXRpYyB1NjQg
cmVhZF9odl9jbG9ja190c2Moc3RydWN0IGNsb2Nrc291cmNlICphcmcpDQotew0KLQl1NjQgY3Vy
cmVudF90aWNrID0gaHZfcmVhZF90c2NfcGFnZSh0c2NfcGcpOw0KLQ0KLQlpZiAoY3VycmVudF90
aWNrID09IFU2NF9NQVgpDQotCQlyZG1zcmwoSFZfWDY0X01TUl9USU1FX1JFRl9DT1VOVCwgY3Vy
cmVudF90aWNrKTsNCi0NCi0JcmV0dXJuIGN1cnJlbnRfdGljazsNCi19DQotDQotc3RhdGljIHN0
cnVjdCBjbG9ja3NvdXJjZSBoeXBlcnZfY3NfdHNjID0gew0KLQkJLm5hbWUJCT0gImh5cGVydl9j
bG9ja3NvdXJjZV90c2NfcGFnZSIsDQotCQkucmF0aW5nCQk9IDQwMCwNCi0JCS5yZWFkCQk9IHJl
YWRfaHZfY2xvY2tfdHNjLA0KLQkJLm1hc2sJCT0gQ0xPQ0tTT1VSQ0VfTUFTSyg2NCksDQotCQku
ZmxhZ3MJCT0gQ0xPQ0tfU09VUkNFX0lTX0NPTlRJTlVPVVMsDQotfTsNCi0jZW5kaWYNCi0NCi1z
dGF0aWMgdTY0IHJlYWRfaHZfY2xvY2tfbXNyKHN0cnVjdCBjbG9ja3NvdXJjZSAqYXJnKQ0KLXsN
Ci0JdTY0IGN1cnJlbnRfdGljazsNCi0JLyoNCi0JICogUmVhZCB0aGUgcGFydGl0aW9uIGNvdW50
ZXIgdG8gZ2V0IHRoZSBjdXJyZW50IHRpY2sgY291bnQuIFRoaXMgY291bnQNCi0JICogaXMgc2V0
IHRvIDAgd2hlbiB0aGUgcGFydGl0aW9uIGlzIGNyZWF0ZWQgYW5kIGlzIGluY3JlbWVudGVkIGlu
DQotCSAqIDEwMCBuYW5vc2Vjb25kIHVuaXRzLg0KLQkgKi8NCi0JcmRtc3JsKEhWX1g2NF9NU1Jf
VElNRV9SRUZfQ09VTlQsIGN1cnJlbnRfdGljayk7DQotCXJldHVybiBjdXJyZW50X3RpY2s7DQot
fQ0KLQ0KLXN0YXRpYyBzdHJ1Y3QgY2xvY2tzb3VyY2UgaHlwZXJ2X2NzX21zciA9IHsNCi0JLm5h
bWUJCT0gImh5cGVydl9jbG9ja3NvdXJjZV9tc3IiLA0KLQkucmF0aW5nCQk9IDQwMCwNCi0JLnJl
YWQJCT0gcmVhZF9odl9jbG9ja19tc3IsDQotCS5tYXNrCQk9IENMT0NLU09VUkNFX01BU0soNjQp
LA0KLQkuZmxhZ3MJCT0gQ0xPQ0tfU09VUkNFX0lTX0NPTlRJTlVPVVMsDQotfTsNCisjaW5jbHVk
ZSA8Y2xvY2tzb3VyY2UvaHlwZXJ2X3RpbWVyLmg+DQogDQogdm9pZCAqaHZfaHlwZXJjYWxsX3Bn
Ow0KIEVYUE9SVF9TWU1CT0xfR1BMKGh2X2h5cGVyY2FsbF9wZyk7DQotc3RydWN0IGNsb2Nrc291
cmNlICpoeXBlcnZfY3M7DQotRVhQT1JUX1NZTUJPTF9HUEwoaHlwZXJ2X2NzKTsNCiANCiB1MzIg
Kmh2X3ZwX2luZGV4Ow0KIEVYUE9SVF9TWU1CT0xfR1BMKGh2X3ZwX2luZGV4KTsNCkBAIC0zNDMs
NDIgKzI5Miw4IEBAIHZvaWQgX19pbml0IGh5cGVydl9pbml0KHZvaWQpDQogDQogCXg4Nl9pbml0
LnBjaS5hcmNoX2luaXQgPSBodl9wY2lfaW5pdDsNCiANCi0JLyoNCi0JICogUmVnaXN0ZXIgSHlw
ZXItViBzcGVjaWZpYyBjbG9ja3NvdXJjZS4NCi0JICovDQotI2lmZGVmIENPTkZJR19IWVBFUlZf
VFNDUEFHRQ0KLQlpZiAobXNfaHlwZXJ2LmZlYXR1cmVzICYgSFZfTVNSX1JFRkVSRU5DRV9UU0Nf
QVZBSUxBQkxFKSB7DQotCQl1bmlvbiBodl94NjRfbXNyX2h5cGVyY2FsbF9jb250ZW50cyB0c2Nf
bXNyOw0KLQ0KLQkJdHNjX3BnID0gX192bWFsbG9jKFBBR0VfU0laRSwgR0ZQX0tFUk5FTCwgUEFH
RV9LRVJORUwpOw0KLQkJaWYgKCF0c2NfcGcpDQotCQkJZ290byByZWdpc3Rlcl9tc3JfY3M7DQot
DQotCQloeXBlcnZfY3MgPSAmaHlwZXJ2X2NzX3RzYzsNCi0NCi0JCXJkbXNybChIVl9YNjRfTVNS
X1JFRkVSRU5DRV9UU0MsIHRzY19tc3IuYXNfdWludDY0KTsNCi0NCi0JCXRzY19tc3IuZW5hYmxl
ID0gMTsNCi0JCXRzY19tc3IuZ3Vlc3RfcGh5c2ljYWxfYWRkcmVzcyA9IHZtYWxsb2NfdG9fcGZu
KHRzY19wZyk7DQotDQotCQl3cm1zcmwoSFZfWDY0X01TUl9SRUZFUkVOQ0VfVFNDLCB0c2NfbXNy
LmFzX3VpbnQ2NCk7DQotDQotCQloeXBlcnZfY3NfdHNjLmFyY2hkYXRhLnZjbG9ja19tb2RlID0g
VkNMT0NLX0hWQ0xPQ0s7DQotDQotCQljbG9ja3NvdXJjZV9yZWdpc3Rlcl9oeigmaHlwZXJ2X2Nz
X3RzYywgTlNFQ19QRVJfU0VDLzEwMCk7DQotCQlyZXR1cm47DQotCX0NCi1yZWdpc3Rlcl9tc3Jf
Y3M6DQotI2VuZGlmDQotCS8qDQotCSAqIEZvciAzMiBiaXQgZ3Vlc3RzIGp1c3QgdXNlIHRoZSBN
U1IgYmFzZWQgbWVjaGFuaXNtIGZvciByZWFkaW5nDQotCSAqIHRoZSBwYXJ0aXRpb24gY291bnRl
ci4NCi0JICovDQotDQotCWh5cGVydl9jcyA9ICZoeXBlcnZfY3NfbXNyOw0KLQlpZiAobXNfaHlw
ZXJ2LmZlYXR1cmVzICYgSFZfTVNSX1RJTUVfUkVGX0NPVU5UX0FWQUlMQUJMRSkNCi0JCWNsb2Nr
c291cmNlX3JlZ2lzdGVyX2h6KCZoeXBlcnZfY3NfbXNyLCBOU0VDX1BFUl9TRUMvMTAwKTsNCi0N
CisJLyogUmVnaXN0ZXIgSHlwZXItViBzcGVjaWZpYyBjbG9ja3NvdXJjZSAqLw0KKwlodl9pbml0
X2Nsb2Nrc291cmNlKCk7DQogCXJldHVybjsNCiANCiByZW1vdmVfY3B1aHBfc3RhdGU6DQpkaWZm
IC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vbXNoeXBlcnYuaCBiL2FyY2gveDg2L2luY2x1
ZGUvYXNtL21zaHlwZXJ2LmgNCmluZGV4IGNjNjBlNjEuLmY0ZmE4YTkgMTAwNjQ0DQotLS0gYS9h
cmNoL3g4Ni9pbmNsdWRlL2FzbS9tc2h5cGVydi5oDQorKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9tc2h5cGVydi5oDQpAQCAtMTA1LDYgKzEwNSwxNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgdm1i
dXNfc2lnbmFsX2VvbShzdHJ1Y3QgaHZfbWVzc2FnZSAqbXNnLCB1MzIgb2xkX21zZ190eXBlKQ0K
ICNkZWZpbmUgaHZfZ2V0X2NyYXNoX2N0bCh2YWwpIFwNCiAJcmRtc3JsKEhWX1g2NF9NU1JfQ1JB
U0hfQ1RMLCB2YWwpDQogDQorI2RlZmluZSBodl9nZXRfdGltZV9yZWZfY291bnQodmFsKSBcDQor
CXJkbXNybChIVl9YNjRfTVNSX1RJTUVfUkVGX0NPVU5ULCB2YWwpDQorDQorI2RlZmluZSBodl9n
ZXRfcmVmZXJlbmNlX3RzYyh2YWwpIFwNCisJcmRtc3JsKEhWX1g2NF9NU1JfUkVGRVJFTkNFX1RT
QywgdmFsKQ0KKyNkZWZpbmUgaHZfc2V0X3JlZmVyZW5jZV90c2ModmFsKSBcDQorCXdybXNybChI
Vl9YNjRfTVNSX1JFRkVSRU5DRV9UU0MsIHZhbCkNCisjZGVmaW5lIGh2X3NldF9jbG9ja3NvdXJj
ZV92ZHNvKHZhbCkgXA0KKwkoKHZhbCkuYXJjaGRhdGEudmNsb2NrX21vZGUgPSBWQ0xPQ0tfSFZD
TE9DSykNCisjZGVmaW5lIGh2X2dldF9yYXdfdGltZXIoKSByZHRzY19vcmRlcmVkKCkNCisNCiB2
b2lkIGh5cGVydl9jYWxsYmFja192ZWN0b3Iodm9pZCk7DQogdm9pZCBoeXBlcnZfcmVlbmxpZ2h0
ZW5tZW50X3ZlY3Rvcih2b2lkKTsNCiAjaWZkZWYgQ09ORklHX1RSQUNJTkcNCkBAIC0xMzMsNyAr
MTQ0LDYgQEAgc3RhdGljIGlubGluZSB2b2lkIGh2X2Rpc2FibGVfc3RpbWVyMF9wZXJjcHVfaXJx
KGludCBpcnEpIHt9DQogDQogDQogI2lmIElTX0VOQUJMRUQoQ09ORklHX0hZUEVSVikNCi1leHRl
cm4gc3RydWN0IGNsb2Nrc291cmNlICpoeXBlcnZfY3M7DQogZXh0ZXJuIHZvaWQgKmh2X2h5cGVy
Y2FsbF9wZzsNCiBleHRlcm4gdm9pZCAgX19wZXJjcHUgICoqaHlwZXJ2X3BjcHVfaW5wdXRfYXJn
Ow0KIA0KQEAgLTM4Nyw3MyArMzk3LDQgQEAgc3RhdGljIGlubGluZSBpbnQgaHlwZXJ2X2ZsdXNo
X2d1ZXN0X21hcHBpbmdfcmFuZ2UodTY0IGFzLA0KIH0NCiAjZW5kaWYgLyogQ09ORklHX0hZUEVS
ViAqLw0KIA0KLSNpZmRlZiBDT05GSUdfSFlQRVJWX1RTQ1BBR0UNCi1zdHJ1Y3QgbXNfaHlwZXJ2
X3RzY19wYWdlICpodl9nZXRfdHNjX3BhZ2Uodm9pZCk7DQotc3RhdGljIGlubGluZSB1NjQgaHZf
cmVhZF90c2NfcGFnZV90c2MoY29uc3Qgc3RydWN0IG1zX2h5cGVydl90c2NfcGFnZSAqdHNjX3Bn
LA0KLQkJCQkgICAgICAgdTY0ICpjdXJfdHNjKQ0KLXsNCi0JdTY0IHNjYWxlLCBvZmZzZXQ7DQot
CXUzMiBzZXF1ZW5jZTsNCi0NCi0JLyoNCi0JICogVGhlIHByb3RvY29sIGZvciByZWFkaW5nIEh5
cGVyLVYgVFNDIHBhZ2UgaXMgc3BlY2lmaWVkIGluIEh5cGVydmlzb3INCi0JICogVG9wLUxldmVs
IEZ1bmN0aW9uYWwgU3BlY2lmaWNhdGlvbiB2ZXIuIDMuMCBhbmQgYWJvdmUuIFRvIGdldCB0aGUN
Ci0JICogcmVmZXJlbmNlIHRpbWUgd2UgbXVzdCBkbyB0aGUgZm9sbG93aW5nOg0KLQkgKiAtIFJF
QUQgUmVmZXJlbmNlVHNjU2VxdWVuY2UNCi0JICogICBBIHNwZWNpYWwgJzAnIHZhbHVlIGluZGlj
YXRlcyB0aGUgdGltZSBzb3VyY2UgaXMgdW5yZWxpYWJsZSBhbmQgd2UNCi0JICogICBuZWVkIHRv
IHVzZSBzb21ldGhpbmcgZWxzZS4gVGhlIGN1cnJlbnRseSBwdWJsaXNoZWQgc3BlY2lmaWNhdGlv
bg0KLQkgKiAgIHZlcnNpb25zICh1cCB0byA0LjBiKSBjb250YWluIGEgbWlzdGFrZSBhbmQgd3Jv
bmdseSBjbGFpbSAnLTEnDQotCSAqICAgaW5zdGVhZCBvZiAnMCcgYXMgdGhlIHNwZWNpYWwgdmFs
dWUsIHNlZSBjb21taXQgYzM1YjgyZWYwMjk0Lg0KLQkgKiAtIFJlZmVyZW5jZVRpbWUgPQ0KLQkg
KiAgICAgICAgKChSRFRTQygpICogUmVmZXJlbmNlVHNjU2NhbGUpID4+IDY0KSArIFJlZmVyZW5j
ZVRzY09mZnNldA0KLQkgKiAtIFJFQUQgUmVmZXJlbmNlVHNjU2VxdWVuY2UgYWdhaW4uIEluIGNh
c2UgaXRzIHZhbHVlIGhhcyBjaGFuZ2VkDQotCSAqICAgc2luY2Ugb3VyIGZpcnN0IHJlYWRpbmcg
d2UgbmVlZCB0byBkaXNjYXJkIFJlZmVyZW5jZVRpbWUgYW5kIHJlcGVhdA0KLQkgKiAgIHRoZSB3
aG9sZSBzZXF1ZW5jZSBhcyB0aGUgaHlwZXJ2aXNvciB3YXMgdXBkYXRpbmcgdGhlIHBhZ2UgaW4N
Ci0JICogICBiZXR3ZWVuLg0KLQkgKi8NCi0JZG8gew0KLQkJc2VxdWVuY2UgPSBSRUFEX09OQ0Uo
dHNjX3BnLT50c2Nfc2VxdWVuY2UpOw0KLQkJaWYgKCFzZXF1ZW5jZSkNCi0JCQlyZXR1cm4gVTY0
X01BWDsNCi0JCS8qDQotCQkgKiBNYWtlIHN1cmUgd2UgcmVhZCBzZXF1ZW5jZSBiZWZvcmUgd2Ug
cmVhZCBvdGhlciB2YWx1ZXMgZnJvbQ0KLQkJICogVFNDIHBhZ2UuDQotCQkgKi8NCi0JCXNtcF9y
bWIoKTsNCi0NCi0JCXNjYWxlID0gUkVBRF9PTkNFKHRzY19wZy0+dHNjX3NjYWxlKTsNCi0JCW9m
ZnNldCA9IFJFQURfT05DRSh0c2NfcGctPnRzY19vZmZzZXQpOw0KLQkJKmN1cl90c2MgPSByZHRz
Y19vcmRlcmVkKCk7DQotDQotCQkvKg0KLQkJICogTWFrZSBzdXJlIHdlIHJlYWQgc2VxdWVuY2Ug
YWZ0ZXIgd2UgcmVhZCBhbGwgb3RoZXIgdmFsdWVzDQotCQkgKiBmcm9tIFRTQyBwYWdlLg0KLQkJ
ICovDQotCQlzbXBfcm1iKCk7DQotDQotCX0gd2hpbGUgKFJFQURfT05DRSh0c2NfcGctPnRzY19z
ZXF1ZW5jZSkgIT0gc2VxdWVuY2UpOw0KLQ0KLQlyZXR1cm4gbXVsX3U2NF91NjRfc2hyKCpjdXJf
dHNjLCBzY2FsZSwgNjQpICsgb2Zmc2V0Ow0KLX0NCi0NCi1zdGF0aWMgaW5saW5lIHU2NCBodl9y
ZWFkX3RzY19wYWdlKGNvbnN0IHN0cnVjdCBtc19oeXBlcnZfdHNjX3BhZ2UgKnRzY19wZykNCi17
DQotCXU2NCBjdXJfdHNjOw0KLQ0KLQlyZXR1cm4gaHZfcmVhZF90c2NfcGFnZV90c2ModHNjX3Bn
LCAmY3VyX3RzYyk7DQotfQ0KLQ0KLSNlbHNlDQotc3RhdGljIGlubGluZSBzdHJ1Y3QgbXNfaHlw
ZXJ2X3RzY19wYWdlICpodl9nZXRfdHNjX3BhZ2Uodm9pZCkNCi17DQotCXJldHVybiBOVUxMOw0K
LX0NCi0NCi1zdGF0aWMgaW5saW5lIHU2NCBodl9yZWFkX3RzY19wYWdlX3RzYyhjb25zdCBzdHJ1
Y3QgbXNfaHlwZXJ2X3RzY19wYWdlICp0c2NfcGcsDQotCQkJCSAgICAgICB1NjQgKmN1cl90c2Mp
DQotew0KLQlCVUcoKTsNCi0JcmV0dXJuIFU2NF9NQVg7DQotfQ0KLSNlbmRpZg0KICNlbmRpZg0K
ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3Zkc28vZ2V0dGltZW9mZGF5LmggYi9h
cmNoL3g4Ni9pbmNsdWRlL2FzbS92ZHNvL2dldHRpbWVvZmRheS5oDQppbmRleCBhMTQwMzlhLi5h
ZTkxNDI5IDEwMDY0NA0KLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vdmRzby9nZXR0aW1lb2Zk
YXkuaA0KKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vdmRzby9nZXR0aW1lb2ZkYXkuaA0KQEAg
LTE4LDcgKzE4LDcgQEANCiAjaW5jbHVkZSA8YXNtL3VuaXN0ZC5oPg0KICNpbmNsdWRlIDxhc20v
bXNyLmg+DQogI2luY2x1ZGUgPGFzbS9wdmNsb2NrLmg+DQotI2luY2x1ZGUgPGFzbS9tc2h5cGVy
di5oPg0KKyNpbmNsdWRlIDxjbG9ja3NvdXJjZS9oeXBlcnZfdGltZXIuaD4NCiANCiAjZGVmaW5l
IF9fdmRzb19kYXRhIChWVkFSKF92ZHNvX2RhdGEpKQ0KIA0KZGlmZiAtLWdpdCBhL2FyY2gveDg2
L2t2bS94ODYuYyBiL2FyY2gveDg2L2t2bS94ODYuYw0KaW5kZXggOTg1Nzk5Mi4uMDdkZGIxZSAx
MDA2NDQNCi0tLSBhL2FyY2gveDg2L2t2bS94ODYuYw0KKysrIGIvYXJjaC94ODYva3ZtL3g4Ni5j
DQpAQCAtNjcsNiArNjcsNyBAQA0KICNpbmNsdWRlIDxhc20vbXNoeXBlcnYuaD4NCiAjaW5jbHVk
ZSA8YXNtL2h5cGVydmlzb3IuaD4NCiAjaW5jbHVkZSA8YXNtL2ludGVsX3B0Lmg+DQorI2luY2x1
ZGUgPGNsb2Nrc291cmNlL2h5cGVydl90aW1lci5oPg0KIA0KICNkZWZpbmUgQ1JFQVRFX1RSQUNF
X1BPSU5UUw0KICNpbmNsdWRlICJ0cmFjZS5oIg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xvY2tz
b3VyY2UvaHlwZXJ2X3RpbWVyLmMgYi9kcml2ZXJzL2Nsb2Nrc291cmNlL2h5cGVydl90aW1lci5j
DQppbmRleCA2OGEyOGFmLi5iYTJjNzllIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jbG9ja3NvdXJj
ZS9oeXBlcnZfdGltZXIuYw0KKysrIGIvZHJpdmVycy9jbG9ja3NvdXJjZS9oeXBlcnZfdGltZXIu
Yw0KQEAgLTE0LDYgKzE0LDggQEANCiAjaW5jbHVkZSA8bGludXgvcGVyY3B1Lmg+DQogI2luY2x1
ZGUgPGxpbnV4L2NwdW1hc2suaD4NCiAjaW5jbHVkZSA8bGludXgvY2xvY2tjaGlwcy5oPg0KKyNp
bmNsdWRlIDxsaW51eC9jbG9ja3NvdXJjZS5oPg0KKyNpbmNsdWRlIDxsaW51eC9zY2hlZF9jbG9j
ay5oPg0KICNpbmNsdWRlIDxsaW51eC9tbS5oPg0KICNpbmNsdWRlIDxjbG9ja3NvdXJjZS9oeXBl
cnZfdGltZXIuaD4NCiAjaW5jbHVkZSA8YXNtL2h5cGVydi10bGZzLmg+DQpAQCAtMTk4LDMgKzIw
MCwxNDAgQEAgdm9pZCBodl9zdGltZXJfZ2xvYmFsX2NsZWFudXAodm9pZCkNCiAJaHZfc3RpbWVy
X2ZyZWUoKTsNCiB9DQogRVhQT1JUX1NZTUJPTF9HUEwoaHZfc3RpbWVyX2dsb2JhbF9jbGVhbnVw
KTsNCisNCisvKg0KKyAqIENvZGUgYW5kIGRlZmluaXRpb25zIGZvciB0aGUgSHlwZXItViBjbG9j
a3NvdXJjZXMuICBUd28NCisgKiBjbG9ja3NvdXJjZXMgYXJlIGRlZmluZWQ6IG9uZSB0aGF0IHJl
YWRzIHRoZSBIeXBlci1WIGRlZmluZWQgTVNSLCBhbmQNCisgKiB0aGUgb3RoZXIgdGhhdCB1c2Vz
IHRoZSBUU0MgcmVmZXJlbmNlIHBhZ2UgZmVhdHVyZSBhcyBkZWZpbmVkIGluIHRoZQ0KKyAqIFRM
RlMuICBUaGUgTVNSIHZlcnNpb24gaXMgZm9yIGNvbXBhdGliaWxpdHkgd2l0aCBvbGQgdmVyc2lv
bnMgb2YNCisgKiBIeXBlci1WIGFuZCAzMi1iaXQgeDg2LiAgVGhlIFRTQyByZWZlcmVuY2UgcGFn
ZSB2ZXJzaW9uIGlzIHByZWZlcnJlZC4NCisgKi8NCisNCitzdHJ1Y3QgY2xvY2tzb3VyY2UgKmh5
cGVydl9jczsNCitFWFBPUlRfU1lNQk9MX0dQTChoeXBlcnZfY3MpOw0KKw0KKyNpZmRlZiBDT05G
SUdfSFlQRVJWX1RTQ1BBR0UNCisNCitzdGF0aWMgc3RydWN0IG1zX2h5cGVydl90c2NfcGFnZSAq
dHNjX3BnOw0KKw0KK3N0cnVjdCBtc19oeXBlcnZfdHNjX3BhZ2UgKmh2X2dldF90c2NfcGFnZSh2
b2lkKQ0KK3sNCisJcmV0dXJuIHRzY19wZzsNCit9DQorRVhQT1JUX1NZTUJPTF9HUEwoaHZfZ2V0
X3RzY19wYWdlKTsNCisNCitzdGF0aWMgdTY0IG5vdHJhY2UgcmVhZF9odl9zY2hlZF9jbG9ja190
c2Modm9pZCkNCit7DQorCXU2NCBjdXJyZW50X3RpY2sgPSBodl9yZWFkX3RzY19wYWdlKHRzY19w
Zyk7DQorDQorCWlmIChjdXJyZW50X3RpY2sgPT0gVTY0X01BWCkNCisJCWh2X2dldF90aW1lX3Jl
Zl9jb3VudChjdXJyZW50X3RpY2spOw0KKw0KKwlyZXR1cm4gY3VycmVudF90aWNrOw0KK30NCisN
CitzdGF0aWMgdTY0IHJlYWRfaHZfY2xvY2tfdHNjKHN0cnVjdCBjbG9ja3NvdXJjZSAqYXJnKQ0K
K3sNCisJcmV0dXJuIHJlYWRfaHZfc2NoZWRfY2xvY2tfdHNjKCk7DQorfQ0KKw0KK3N0YXRpYyBz
dHJ1Y3QgY2xvY2tzb3VyY2UgaHlwZXJ2X2NzX3RzYyA9IHsNCisJLm5hbWUJPSAiaHlwZXJ2X2Ns
b2Nrc291cmNlX3RzY19wYWdlIiwNCisJLnJhdGluZwk9IDQwMCwNCisJLnJlYWQJPSByZWFkX2h2
X2Nsb2NrX3RzYywNCisJLm1hc2sJPSBDTE9DS1NPVVJDRV9NQVNLKDY0KSwNCisJLmZsYWdzCT0g
Q0xPQ0tfU09VUkNFX0lTX0NPTlRJTlVPVVMsDQorfTsNCisjZW5kaWYNCisNCitzdGF0aWMgdTY0
IG5vdHJhY2UgcmVhZF9odl9zY2hlZF9jbG9ja19tc3Iodm9pZCkNCit7DQorCXU2NCBjdXJyZW50
X3RpY2s7DQorCS8qDQorCSAqIFJlYWQgdGhlIHBhcnRpdGlvbiBjb3VudGVyIHRvIGdldCB0aGUg
Y3VycmVudCB0aWNrIGNvdW50LiBUaGlzIGNvdW50DQorCSAqIGlzIHNldCB0byAwIHdoZW4gdGhl
IHBhcnRpdGlvbiBpcyBjcmVhdGVkIGFuZCBpcyBpbmNyZW1lbnRlZCBpbg0KKwkgKiAxMDAgbmFu
b3NlY29uZCB1bml0cy4NCisJICovDQorCWh2X2dldF90aW1lX3JlZl9jb3VudChjdXJyZW50X3Rp
Y2spOw0KKwlyZXR1cm4gY3VycmVudF90aWNrOw0KK30NCisNCitzdGF0aWMgdTY0IHJlYWRfaHZf
Y2xvY2tfbXNyKHN0cnVjdCBjbG9ja3NvdXJjZSAqYXJnKQ0KK3sNCisJcmV0dXJuIHJlYWRfaHZf
c2NoZWRfY2xvY2tfbXNyKCk7DQorfQ0KKw0KK3N0YXRpYyBzdHJ1Y3QgY2xvY2tzb3VyY2UgaHlw
ZXJ2X2NzX21zciA9IHsNCisJLm5hbWUJPSAiaHlwZXJ2X2Nsb2Nrc291cmNlX21zciIsDQorCS5y
YXRpbmcJPSA0MDAsDQorCS5yZWFkCT0gcmVhZF9odl9jbG9ja19tc3IsDQorCS5tYXNrCT0gQ0xP
Q0tTT1VSQ0VfTUFTSyg2NCksDQorCS5mbGFncwk9IENMT0NLX1NPVVJDRV9JU19DT05USU5VT1VT
LA0KK307DQorDQorI2lmZGVmIENPTkZJR19IWVBFUlZfVFNDUEFHRQ0KK3N0YXRpYyBib29sIF9f
aW5pdCBodl9pbml0X3RzY19jbG9ja3NvdXJjZSh2b2lkKQ0KK3sNCisJdTY0CQl0c2NfbXNyOw0K
KwlwaHlzX2FkZHJfdAlwaHlzX2FkZHI7DQorDQorCWlmICghKG1zX2h5cGVydi5mZWF0dXJlcyAm
IEhWX01TUl9SRUZFUkVOQ0VfVFNDX0FWQUlMQUJMRSkpDQorCQlyZXR1cm4gZmFsc2U7DQorDQor
CXRzY19wZyA9IHZtYWxsb2MoUEFHRV9TSVpFKTsNCisJaWYgKCF0c2NfcGcpDQorCQlyZXR1cm4g
ZmFsc2U7DQorDQorCWh5cGVydl9jcyA9ICZoeXBlcnZfY3NfdHNjOw0KKwlwaHlzX2FkZHIgPSBw
YWdlX3RvX3BoeXModm1hbGxvY190b19wYWdlKHRzY19wZykpOw0KKw0KKwkvKg0KKwkgKiBUaGUg
SHlwZXItViBUTEZTIHNwZWNpZmllcyB0byBwcmVzZXJ2ZSB0aGUgdmFsdWUgb2YgcmVzZXJ2ZWQN
CisJICogYml0cyBpbiByZWdpc3RlcnMuIFNvIHJlYWQgdGhlIGV4aXN0aW5nIHZhbHVlLCBwcmVz
ZXJ2ZSB0aGUNCisJICogbG93IG9yZGVyIDEyIGJpdHMsIGFuZCBhZGQgaW4gdGhlIGd1ZXN0IHBo
eXNpY2FsIGFkZHJlc3MNCisJICogKHdoaWNoIGFscmVhZHkgaGFzIGF0IGxlYXN0IHRoZSBsb3cg
MTIgYml0cyBzZXQgdG8gemVybyBzaW5jZQ0KKwkgKiBpdCBpcyBwYWdlIGFsaWduZWQpLiBBbHNv
IHNldCB0aGUgImVuYWJsZSIgYml0LCB3aGljaCBpcyBiaXQgMC4NCisJICovDQorCWh2X2dldF9y
ZWZlcmVuY2VfdHNjKHRzY19tc3IpOw0KKwl0c2NfbXNyICY9IEdFTk1BU0tfVUxMKDExLCAwKTsN
CisJdHNjX21zciA9IHRzY19tc3IgfCAweDEgfCAodTY0KXBoeXNfYWRkcjsNCisJaHZfc2V0X3Jl
ZmVyZW5jZV90c2ModHNjX21zcik7DQorDQorCWh2X3NldF9jbG9ja3NvdXJjZV92ZHNvKGh5cGVy
dl9jc190c2MpOw0KKwljbG9ja3NvdXJjZV9yZWdpc3Rlcl9oeigmaHlwZXJ2X2NzX3RzYywgTlNF
Q19QRVJfU0VDLzEwMCk7DQorDQorCS8qIHNjaGVkX2Nsb2NrX3JlZ2lzdGVyIGlzIG5lZWRlZCBv
biBBUk02NCBidXQgaXMgYSBuby1vcCBvbiB4ODYgKi8NCisJc2NoZWRfY2xvY2tfcmVnaXN0ZXIo
cmVhZF9odl9zY2hlZF9jbG9ja190c2MsIDY0LCBIVl9DTE9DS19IWik7DQorCXJldHVybiB0cnVl
Ow0KK30NCisjZWxzZQ0KK3N0YXRpYyBib29sIF9faW5pdCBodl9pbml0X3RzY19jbG9ja3NvdXJj
ZSh2b2lkKQ0KK3sNCisJcmV0dXJuIGZhbHNlOw0KK30NCisjZW5kaWYNCisNCisNCit2b2lkIF9f
aW5pdCBodl9pbml0X2Nsb2Nrc291cmNlKHZvaWQpDQorew0KKwkvKg0KKwkgKiBUcnkgdG8gc2V0
IHVwIHRoZSBUU0MgcGFnZSBjbG9ja3NvdXJjZS4gSWYgaXQgc3VjY2VlZHMsIHdlJ3JlDQorCSAq
IGRvbmUuIE90aGVyd2lzZSwgc2V0IHVwIHRoZSBNU1IgY2xvY2tzb3J1Y2UuICBBdCBsZWFzdCBv
bmUgb2YNCisJICogdGhlc2Ugd2lsbCBhbHdheXMgYmUgYXZhaWxhYmxlIGV4Y2VwdCBvbiB2ZXJ5
IG9sZCB2ZXJzaW9ucyBvZg0KKwkgKiBIeXBlci1WIG9uIHg4Ni4gIEluIHRoYXQgY2FzZSB3ZSB3
b24ndCBoYXZlIGEgSHlwZXItVg0KKwkgKiBjbG9ja3NvdXJjZSwgYnV0IExpbnV4IHdpbGwgc3Rp
bGwgcnVuIHdpdGggYSBjbG9ja3NvdXJjZSBiYXNlZA0KKwkgKiBvbiB0aGUgZW11bGF0ZWQgUElU
IG9yIExBUElDIHRpbWVyLg0KKwkgKi8NCisJaWYgKGh2X2luaXRfdHNjX2Nsb2Nrc291cmNlKCkp
DQorCQlyZXR1cm47DQorDQorCWlmICghKG1zX2h5cGVydi5mZWF0dXJlcyAmIEhWX01TUl9USU1F
X1JFRl9DT1VOVF9BVkFJTEFCTEUpKQ0KKwkJcmV0dXJuOw0KKw0KKwloeXBlcnZfY3MgPSAmaHlw
ZXJ2X2NzX21zcjsNCisJY2xvY2tzb3VyY2VfcmVnaXN0ZXJfaHooJmh5cGVydl9jc19tc3IsIE5T
RUNfUEVSX1NFQy8xMDApOw0KKw0KKwkvKiBzY2hlZF9jbG9ja19yZWdpc3RlciBpcyBuZWVkZWQg
b24gQVJNNjQgYnV0IGlzIGEgbm8tb3Agb24geDg2ICovDQorCXNjaGVkX2Nsb2NrX3JlZ2lzdGVy
KHJlYWRfaHZfc2NoZWRfY2xvY2tfbXNyLCA2NCwgSFZfQ0xPQ0tfSFopOw0KK30NCitFWFBPUlRf
U1lNQk9MX0dQTChodl9pbml0X2Nsb2Nrc291cmNlKTsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2h2
L2h2X3V0aWwuYyBiL2RyaXZlcnMvaHYvaHZfdXRpbC5jDQppbmRleCA3ZDNkMzFmLi5lMzI2ODFl
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9odi9odl91dGlsLmMNCisrKyBiL2RyaXZlcnMvaHYvaHZf
dXRpbC5jDQpAQCAtMTcsNiArMTcsNyBAQA0KICNpbmNsdWRlIDxsaW51eC9oeXBlcnYuaD4NCiAj
aW5jbHVkZSA8bGludXgvY2xvY2tjaGlwcy5oPg0KICNpbmNsdWRlIDxsaW51eC9wdHBfY2xvY2tf
a2VybmVsLmg+DQorI2luY2x1ZGUgPGNsb2Nrc291cmNlL2h5cGVydl90aW1lci5oPg0KICNpbmNs
dWRlIDxhc20vbXNoeXBlcnYuaD4NCiANCiAjaW5jbHVkZSAiaHlwZXJ2X3ZtYnVzLmgiDQpkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9jbG9ja3NvdXJjZS9oeXBlcnZfdGltZXIuaCBiL2luY2x1ZGUvY2xv
Y2tzb3VyY2UvaHlwZXJ2X3RpbWVyLmgNCmluZGV4IDBjZDczZjcuLmVjYzA0NGQgMTAwNjQ0DQot
LS0gYS9pbmNsdWRlL2Nsb2Nrc291cmNlL2h5cGVydl90aW1lci5oDQorKysgYi9pbmNsdWRlL2Ns
b2Nrc291cmNlL2h5cGVydl90aW1lci5oDQpAQCAtMTMsNiArMTMsMTAgQEANCiAjaWZuZGVmIF9f
Q0xLU09VUkNFX0hZUEVSVl9USU1FUl9IDQogI2RlZmluZSBfX0NMS1NPVVJDRV9IWVBFUlZfVElN
RVJfSA0KIA0KKyNpbmNsdWRlIDxsaW51eC9jbG9ja3NvdXJjZS5oPg0KKyNpbmNsdWRlIDxsaW51
eC9tYXRoNjQuaD4NCisjaW5jbHVkZSA8YXNtL21zaHlwZXJ2Lmg+DQorDQogI2RlZmluZSBIVl9N
QVhfTUFYX0RFTFRBX1RJQ0tTIDB4ZmZmZmZmZmYNCiAjZGVmaW5lIEhWX01JTl9ERUxUQV9USUNL
UyAxDQogDQpAQCAtMjQsNCArMjgsNzggQEANCiBleHRlcm4gdm9pZCBodl9zdGltZXJfZ2xvYmFs
X2NsZWFudXAodm9pZCk7DQogZXh0ZXJuIHZvaWQgaHZfc3RpbWVyMF9pc3Iodm9pZCk7DQogDQor
I2lmIElTX0VOQUJMRUQoQ09ORklHX0hZUEVSVikNCitleHRlcm4gc3RydWN0IGNsb2Nrc291cmNl
ICpoeXBlcnZfY3M7DQorZXh0ZXJuIHZvaWQgaHZfaW5pdF9jbG9ja3NvdXJjZSh2b2lkKTsNCisj
ZW5kaWYgLyogQ09ORklHX0hZUEVSViAqLw0KKw0KKyNpZmRlZiBDT05GSUdfSFlQRVJWX1RTQ1BB
R0UNCitleHRlcm4gc3RydWN0IG1zX2h5cGVydl90c2NfcGFnZSAqaHZfZ2V0X3RzY19wYWdlKHZv
aWQpOw0KK3N0YXRpYyBpbmxpbmUgdTY0IGh2X3JlYWRfdHNjX3BhZ2VfdHNjKGNvbnN0IHN0cnVj
dCBtc19oeXBlcnZfdHNjX3BhZ2UgKnRzY19wZywNCisJCQkJICAgICAgIHU2NCAqY3VyX3RzYykN
Cit7DQorCXU2NCBzY2FsZSwgb2Zmc2V0Ow0KKwl1MzIgc2VxdWVuY2U7DQorDQorCS8qDQorCSAq
IFRoZSBwcm90b2NvbCBmb3IgcmVhZGluZyBIeXBlci1WIFRTQyBwYWdlIGlzIHNwZWNpZmllZCBp
biBIeXBlcnZpc29yDQorCSAqIFRvcC1MZXZlbCBGdW5jdGlvbmFsIFNwZWNpZmljYXRpb24gdmVy
LiAzLjAgYW5kIGFib3ZlLiBUbyBnZXQgdGhlDQorCSAqIHJlZmVyZW5jZSB0aW1lIHdlIG11c3Qg
ZG8gdGhlIGZvbGxvd2luZzoNCisJICogLSBSRUFEIFJlZmVyZW5jZVRzY1NlcXVlbmNlDQorCSAq
ICAgQSBzcGVjaWFsICcwJyB2YWx1ZSBpbmRpY2F0ZXMgdGhlIHRpbWUgc291cmNlIGlzIHVucmVs
aWFibGUgYW5kIHdlDQorCSAqICAgbmVlZCB0byB1c2Ugc29tZXRoaW5nIGVsc2UuIFRoZSBjdXJy
ZW50bHkgcHVibGlzaGVkIHNwZWNpZmljYXRpb24NCisJICogICB2ZXJzaW9ucyAodXAgdG8gNC4w
YikgY29udGFpbiBhIG1pc3Rha2UgYW5kIHdyb25nbHkgY2xhaW0gJy0xJw0KKwkgKiAgIGluc3Rl
YWQgb2YgJzAnIGFzIHRoZSBzcGVjaWFsIHZhbHVlLCBzZWUgY29tbWl0IGMzNWI4MmVmMDI5NC4N
CisJICogLSBSZWZlcmVuY2VUaW1lID0NCisJICogICAgICAgICgoUkRUU0MoKSAqIFJlZmVyZW5j
ZVRzY1NjYWxlKSA+PiA2NCkgKyBSZWZlcmVuY2VUc2NPZmZzZXQNCisJICogLSBSRUFEIFJlZmVy
ZW5jZVRzY1NlcXVlbmNlIGFnYWluLiBJbiBjYXNlIGl0cyB2YWx1ZSBoYXMgY2hhbmdlZA0KKwkg
KiAgIHNpbmNlIG91ciBmaXJzdCByZWFkaW5nIHdlIG5lZWQgdG8gZGlzY2FyZCBSZWZlcmVuY2VU
aW1lIGFuZCByZXBlYXQNCisJICogICB0aGUgd2hvbGUgc2VxdWVuY2UgYXMgdGhlIGh5cGVydmlz
b3Igd2FzIHVwZGF0aW5nIHRoZSBwYWdlIGluDQorCSAqICAgYmV0d2Vlbi4NCisJICovDQorCWRv
IHsNCisJCXNlcXVlbmNlID0gUkVBRF9PTkNFKHRzY19wZy0+dHNjX3NlcXVlbmNlKTsNCisJCWlm
ICghc2VxdWVuY2UpDQorCQkJcmV0dXJuIFU2NF9NQVg7DQorCQkvKg0KKwkJICogTWFrZSBzdXJl
IHdlIHJlYWQgc2VxdWVuY2UgYmVmb3JlIHdlIHJlYWQgb3RoZXIgdmFsdWVzIGZyb20NCisJCSAq
IFRTQyBwYWdlLg0KKwkJICovDQorCQlzbXBfcm1iKCk7DQorDQorCQlzY2FsZSA9IFJFQURfT05D
RSh0c2NfcGctPnRzY19zY2FsZSk7DQorCQlvZmZzZXQgPSBSRUFEX09OQ0UodHNjX3BnLT50c2Nf
b2Zmc2V0KTsNCisJCSpjdXJfdHNjID0gaHZfZ2V0X3Jhd190aW1lcigpOw0KKw0KKwkJLyoNCisJ
CSAqIE1ha2Ugc3VyZSB3ZSByZWFkIHNlcXVlbmNlIGFmdGVyIHdlIHJlYWQgYWxsIG90aGVyIHZh
bHVlcw0KKwkJICogZnJvbSBUU0MgcGFnZS4NCisJCSAqLw0KKwkJc21wX3JtYigpOw0KKw0KKwl9
IHdoaWxlIChSRUFEX09OQ0UodHNjX3BnLT50c2Nfc2VxdWVuY2UpICE9IHNlcXVlbmNlKTsNCisN
CisJcmV0dXJuIG11bF91NjRfdTY0X3NocigqY3VyX3RzYywgc2NhbGUsIDY0KSArIG9mZnNldDsN
Cit9DQorDQorc3RhdGljIGlubGluZSB1NjQgaHZfcmVhZF90c2NfcGFnZShjb25zdCBzdHJ1Y3Qg
bXNfaHlwZXJ2X3RzY19wYWdlICp0c2NfcGcpDQorew0KKwl1NjQgY3VyX3RzYzsNCisNCisJcmV0
dXJuIGh2X3JlYWRfdHNjX3BhZ2VfdHNjKHRzY19wZywgJmN1cl90c2MpOw0KK30NCisNCisjZWxz
ZSAvKiBDT05GSUdfSFlQRVJWX1RTQ19QQUdFICovDQorc3RhdGljIGlubGluZSBzdHJ1Y3QgbXNf
aHlwZXJ2X3RzY19wYWdlICpodl9nZXRfdHNjX3BhZ2Uodm9pZCkNCit7DQorCXJldHVybiBOVUxM
Ow0KK30NCisNCitzdGF0aWMgaW5saW5lIHU2NCBodl9yZWFkX3RzY19wYWdlX3RzYyhjb25zdCBz
dHJ1Y3QgbXNfaHlwZXJ2X3RzY19wYWdlICp0c2NfcGcsDQorCQkJCSAgICAgICB1NjQgKmN1cl90
c2MpDQorew0KKwlyZXR1cm4gVTY0X01BWDsNCit9DQorI2VuZGlmIC8qIENPTkZJR19IWVBFUlZf
VFNDUEFHRSAqLw0KKw0KICNlbmRpZg0KLS0gDQoxLjguMy4xDQoNCg==
