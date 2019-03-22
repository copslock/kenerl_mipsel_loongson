Return-Path: <SRS0=ULQD=RZ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906EDC43381
	for <linux-mips@archiver.kernel.org>; Fri, 22 Mar 2019 18:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C795213F2
	for <linux-mips@archiver.kernel.org>; Fri, 22 Mar 2019 18:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="BW8qj9aB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfCVSEH (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 22 Mar 2019 14:04:07 -0400
Received: from mail-eopbgr690097.outbound.protection.outlook.com ([40.107.69.97]:39815
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727693AbfCVSEG (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 22 Mar 2019 14:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvVg/4F0xAp0bKgCeN15OisFemH1UZviPd54ARPJKtQ=;
 b=BW8qj9aBGZ7ZgSkdc1sHWYonZPxerHZy5yToDEAMpzgNEUB9HwNUM/AI1Vcm3PMCU7u3GdYrg/GPghmtivudQC2xAaJD/KCJccqhgCRtA0XvLsrZhElHRk56j/jkK+phCYz37gSSC0hvyR2YQU5I3IEoV7hAHsnPdQJYqML587M=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1294.namprd22.prod.outlook.com (10.174.162.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Fri, 22 Mar 2019 18:04:04 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018%3]) with mapi id 15.20.1730.013; Fri, 22 Mar 2019
 18:04:04 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
CC:     Paul Burton <pburton@wavecomp.com>, George Spelvin <lkml@sdf.org>,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH] MIPS: KVM: Use prandom_u32_max() to generate tlbwr index
Thread-Topic: [PATCH] MIPS: KVM: Use prandom_u32_max() to generate tlbwr index
Thread-Index: AQHU4NmiNa7OUdhgaUe67JGmz2BUCw==
Date:   Fri, 22 Mar 2019 18:04:04 +0000
Message-ID: <20190322180349.4256-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:a03:180::14) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.21.0
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c40c4e5d-6774-4704-33ab-08d6aef0c50a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1294;
x-ms-traffictypediagnostic: MWHPR2201MB1294:
x-microsoft-antispam-prvs: <MWHPR2201MB12944E66C9E0B701125F2166C1430@MWHPR2201MB1294.namprd22.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(136003)(396003)(39830400003)(52314003)(189003)(199004)(3846002)(5660300002)(6916009)(68736007)(2501003)(6116002)(106356001)(105586002)(2351001)(2906002)(81166006)(8676002)(1076003)(316002)(7736002)(66066001)(54906003)(81156014)(305945005)(4326008)(5640700003)(6436002)(186003)(6486002)(36756003)(53936002)(6512007)(6506007)(386003)(102836004)(99286004)(52116002)(256004)(71200400001)(14454004)(478600001)(71190400001)(44832011)(97736004)(26005)(476003)(25786009)(486006)(42882007)(50226002)(2616005)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1294;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GeeC10glZZpw+CJW2PqLYFlobDTcJEVruzBIUn+kMSjGdiLzZkNO6NQblW5w1axVH3B7oJjkYNvTQ2oxq5hPtmj7Uud0kzb8VwyivkHCiXDzvH2/PQmPPn/xMIBmd/AEzLfmimREDP6FW0g84rmX/A1SPs6SlRh7gpaY2MFVRmi6+CDcwZyfBwvAelhVIriWPhd/HajmPv6W6YWA7qrwK0acmoap1icMh1AWXFQsiu+A+HbBveiZnCyIrSoBmIvsIgdo1iTRyMCw6DfawpI9Bl7g9s8ZMfdHB1toOV4Oiw0TqUoWwwZv/lPj0VZPEASUhueMgEx1BJHpYi7Dw2a0y+xj48QkiFSxxJzSceo5V6sMwdGb5RDcYqNW2u/V0DwyOr+OM+WDfhc4UL5btKSC3tmR3qvqwCHkAnMuBjae5W0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c40c4e5d-6774-4704-33ab-08d6aef0c50a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 18:04:04.5301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1294
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Emulation of the tlbwr instruction, which writes a TLB entry to a random
index in the TLB, currently uses get_random_bytes() to generate a 4 byte
random number which we then mask to form the index. This is overkill in
a couple of ways:

  - We don't need 4 bytes here since we mask the value to form a 6 bit
    number anyway, so we waste /dev/random entropy generating 3 random
    bytes that are unused.

  - We don't need crypto-grade randomness here - the architecture spec
    allows implementations to use any algorithm & merely encourages that
    some pseudo-randomness be used rather than a simple counter. The
    fast prandom_u32() function fits that criteria well.

So rather than using get_random_bytes() & consuming /dev/random entropy,
switch to using the faster prandom_u32_max() which provides what we need
here whilst also performing the masking/modulo for us.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Reported-by: George Spelvin <lkml@sdf.org>
Cc: James Hogan <jhogan@kernel.org>
---

 arch/mips/kvm/emulate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 0074427b04fb..e5de6bac8197 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -1141,9 +1141,7 @@ enum emulation_result kvm_mips_emul_tlbwr(struct kvm_=
vcpu *vcpu)
 	unsigned long pc =3D vcpu->arch.pc;
 	int index;
=20
-	get_random_bytes(&index, sizeof(index));
-	index &=3D (KVM_MIPS_GUEST_TLB_SIZE - 1);
-
+	index =3D prandom_u32_max(KVM_MIPS_GUEST_TLB_SIZE);
 	tlb =3D &vcpu->arch.guest_tlb[index];
=20
 	kvm_mips_invalidate_guest_tlb(vcpu, tlb);
--=20
2.21.0

