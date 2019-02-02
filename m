Return-Path: <SRS0=tpXJ=QJ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84AEC282DA
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 01:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADEF20857
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 01:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="rzFumByw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfBBBng (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 1 Feb 2019 20:43:36 -0500
Received: from mail-eopbgr810108.outbound.protection.outlook.com ([40.107.81.108]:62863
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726506AbfBBBng (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 1 Feb 2019 20:43:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08M9DvEqjVw/kk7l4sYM71dKbNepFroYMdizxMZcu+Y=;
 b=rzFumBywmcKAizl4YiPI3ewazPyHn4mOCfXH/zGcsoKt/yJmmqDTT5Rto09VzA1zSq6vlgbwZip0wSkr0H4N7WWsya3iJPvACHixphTVbWKcfn5POMll7y/Eknc09a2U0FtBMlydpgZQosVbZKMRRiH9TxEhgR0n8q3wyvbamnM=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1439.namprd22.prod.outlook.com (10.174.169.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Sat, 2 Feb 2019 01:43:24 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1580.019; Sat, 2 Feb 2019
 01:43:24 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 07/14] MIPS: mm: Remove redundant preempt_disable in
 local_flush_tlb_mm()
Thread-Topic: [PATCH 07/14] MIPS: mm: Remove redundant preempt_disable in
 local_flush_tlb_mm()
Thread-Index: AQHUupitlEdYKgFZBk+A78mGWOv45Q==
Date:   Sat, 2 Feb 2019 01:43:21 +0000
Message-ID: <20190202014242.30680-8-paul.burton@mips.com>
References: <20190202014242.30680-1-paul.burton@mips.com>
In-Reply-To: <20190202014242.30680-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0021.prod.exchangelabs.com (2603:10b6:a02:80::34)
 To MWHPR2201MB1277.namprd22.prod.outlook.com (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1439;6:SDfnSGi+gf5bL0ztau8B+qxNWCFXUnNSdUjt0eoCPfS3PQvFAnTTS5/UiiwcQGaDqh2+RFfQX6KNu8wKQGZ7l66XiXN1JJxw4kUwyHW+4MOdG2jJFv9VCuyMotWPVbRYLetapbOX3AKOZhjPBYvzJ9ESKaT/9U2Fkc6LSRZ4XC0uk5m9efgHu4IKAUZ55KKioeCLn8b2+vViENb2zr7sDFaLBQWXda1I0r6z2Fzt5yTUdkcfHg3pWlZ/ADgV0U8tCXzAe5OWKvXr5ALOZH8JDBHVeCb5hfjlpumen3mjXJlM5M5pdmkonwRcd2UcDD1aiJxWxWrmqbxcN0rwd7HxRMZonigSpWo0fZAO7H+BfJOrVMtp70hoSg5SAFoKHiBfy8cw6+ZCh1+L9B9NdxbnErJrszaYY9GcC8HFFt0NwIq6C0kKlNAFieOBNmMjQSd5NIUQmWIc6W3MuCfUfH4ECQ==;5:5YUsMgMgKqZdbGW1mZcwaKuYL1IC/uDojb+wPzByqoWUIUWCXMueeZTCPUVoaBlqKg9fZeRw1YzuMDPt97VtNOsP3dlkJOdfHv8QhMUSc10CtZuY0PsZoSknVLxpbatYMElKBqBJ0Esq4tus+WXGA4IvAne6/EDmrurs8hHyrIeZMVf/pOcIyFN9LfTdV5iYctnE6RGafeUuzUTqMJtyvQ==;7:K8CLKm6Gpb3E9r7JygpNjqNbCNDNWhjjFz54Okr5bzZckt/t0TIzx3Gp7eJSoViTWwsGLtL15o1mkgYE2c8qpBoCwuXV73n/lBwCg29YnD724CTv8QHxWUSbmNHUdy0mzoDIoU5QOrqlFjIkK40IKA==
x-ms-office365-filtering-correlation-id: 05a1e3d8-c0f2-4588-5374-08d688afd001
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1439;
x-ms-traffictypediagnostic: MWHPR2201MB1439:
x-microsoft-antispam-prvs: <MWHPR2201MB143947CC9BA7E8B6975B8EC8C1930@MWHPR2201MB1439.namprd22.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39850400004)(376002)(346002)(199004)(189003)(2616005)(6436002)(446003)(42882007)(106356001)(1076003)(386003)(2501003)(6506007)(305945005)(476003)(107886003)(316002)(25786009)(97736004)(105586002)(11346002)(7736002)(26005)(186003)(36756003)(3846002)(102836004)(6116002)(44832011)(50226002)(486006)(5640700003)(6916009)(68736007)(6666004)(99286004)(4326008)(2906002)(8936002)(6486002)(76176011)(8676002)(71190400001)(256004)(14444005)(14454004)(2351001)(71200400001)(66066001)(52116002)(6512007)(478600001)(81156014)(81166006)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1439;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DKjq4Vuo46NFr1mKzzw2l/pG2XArq9LOvxhu9ndcfQpfV7j8qKQ5CigkOtoxZKwPAtz0J/yH/ekaFFqRj6A7vkyz2dvBcr1p67nUfbmx0bCJ8ETfRjMf5C9xkm+uvcGXyCivTKyl8Zy5R7fzBFERL+gknziCwBQc00SyihOz5vfs9ZCzB+w2Rh0MnmXy67IW3Jiq9T9unRfzo/lc0R0z74mv+1CfYIKnlcOZhM2MByYYr8rwYUl9E4JpSd29Q2LNQyDWJayLrJmk76Xo58FXRASR4H1YpfnYxPKKVjUaDbaeFT15UZ/dj+1pl6+T5wkfQkv11eVvfDcmfVsN/p4AoVgGtoUDDl2nwyt4YblETp2iDFgFy00q5O365bU/QHt3FWa+TNYE2Prj6WeUC1n90L7Gtj6P1mSfElv1iR69wgs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a1e3d8-c0f2-4588-5374-08d688afd001
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 01:43:20.8855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1439
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

The r4k variant of local_flush_tlb_mm() wraps its call to
drop_mmu_context() with a preempt_disable() & preempt_enable() pair, but
this is redundant since drop_mmu_context() disables interrupts and from
Documentation/preempt-locking.txt:

  Note that you do not need to explicitly prevent preemption if you are
  holding any locks or interrupts are disabled, since preemption is
  implicitly disabled in those cases.

Remove the redundant preempt_disable() & preempt_enable() calls.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/mm/tlb-r4k.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index ba76b0c11d38..9fff08eabe8f 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -108,9 +108,7 @@ EXPORT_SYMBOL(local_flush_tlb_all);
    these entries, we just bump the asid. */
 void local_flush_tlb_mm(struct mm_struct *mm)
 {
-	preempt_disable();
 	drop_mmu_context(mm);
-	preempt_enable();
 }
=20
 void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start=
,
--=20
2.20.1

