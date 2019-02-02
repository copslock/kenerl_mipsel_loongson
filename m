Return-Path: <SRS0=tpXJ=QJ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E94C282DB
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 01:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7952820857
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 01:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="H7RhJwt7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfBBBne (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 1 Feb 2019 20:43:34 -0500
Received: from mail-eopbgr770108.outbound.protection.outlook.com ([40.107.77.108]:47642
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726246AbfBBBne (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 1 Feb 2019 20:43:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUVCiA+W5cDJYlJkkUIpQTxOsT37cCv+s304O2TP4yQ=;
 b=H7RhJwt7f7T8czVU9Xpxd6Uws6EmyUDESKTgkIG1pOzHp5hOOk8UZKeeT8Nu+ecH5bGaCawJWeGl5ybSpOOc9qA56c55R9k+Nbq8EbTOc5XD1FuakmLjL9s4oJmx+ZjGP5RYjQbmPkdpmzH6SlzSZWni4r+BZwDC4GJuXCv65Q4=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1439.namprd22.prod.outlook.com (10.174.169.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Sat, 2 Feb 2019 01:43:20 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1580.019; Sat, 2 Feb 2019
 01:43:20 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 04/14] MIPS: mm: Avoid HTW stop/start when dropping an
 inactive mm
Thread-Topic: [PATCH 04/14] MIPS: mm: Avoid HTW stop/start when dropping an
 inactive mm
Thread-Index: AQHUupisV3Jm+Q5KfEiJf5WBtrtBxg==
Date:   Sat, 2 Feb 2019 01:43:18 +0000
Message-ID: <20190202014242.30680-5-paul.burton@mips.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1439;6:xhAhpiiOCQ/EM8FcTCBYHa3RAJ9uQGdDqPntrXqSY5WFlPGc2a8kLgrO+nj2urk4X1DwYT4J2W0tnCF+IS4d3n40rjtRYIScDFxprNcwNBqkJNdKjHPW1vCEKSTpCkMlQuvGywiS/EK3sToRaOjF5DX8+PgnVcSp7rKVCWyBAzt2l+scAmHykY6aP0Z8HKXzKBUNFvwoRYNEApRO/e4AvYDsayUo9WBZj1WQPIjRZ1kxrl6fkKuHwu1a1tL/ZRp1VboqEzomG3RPkKRQ1dZyz8X1kxlAko9J4W0Q8ED02yn2skzqHRagOvU6HzBLNqnNqnpw12c07TK2Fetd/AXNVKK2AhXQ3x0P9u5t3jcg5i13PCcSEyRi/d9v2i3Q9CgdbgO5yYZXC5L3TdMmfzjKiYpEjJ+Tb42Ogo4KxkE7f5B+VPpsvhdt9WaJrTmnx5H4q4BGwh2XnwtFzdKfSPkjyA==;5:lvMsjvcPT8JWtJLPMOtu9Z/3+5zMbwuTPzs8Wax6/gmPvkHFUahAt7JC16ZP3yU0FPYJTwB5Tpgy/7st8k0eLzgW9a5R2v36qcX97JOFna4A2i1M+LyKxnY5TVlr/s9YQhj47pt1Gdj57Re5RGRRWbnVrkfiAvOic+CDMGOqBUKFMF9w4krIerctPBsnpHXiT1rRpXHQzaZdJvOB8oS1OA==;7:U4QeVOHN9id6DV/52ixwNckI4h+Ih3rEH6ETm3eNzfzWkUMwMpTuJMzygu745B6xNLerQEy944LKvjwXmHXIKNvF0xC9ipZcJ+/est1HWbCSfW4qpE9eZxRmAX9PiKAopyvVyFm+fS2rCIwIZ+L8NA==
x-ms-office365-filtering-correlation-id: 4883a327-ec5b-4dd7-55cf-08d688afce61
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1439;
x-ms-traffictypediagnostic: MWHPR2201MB1439:
x-microsoft-antispam-prvs: <MWHPR2201MB1439CB9802045B263B5F1E78C1930@MWHPR2201MB1439.namprd22.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39850400004)(376002)(346002)(199004)(189003)(2616005)(6436002)(446003)(42882007)(106356001)(1076003)(386003)(2501003)(6506007)(305945005)(476003)(107886003)(316002)(25786009)(97736004)(105586002)(11346002)(7736002)(26005)(186003)(36756003)(3846002)(102836004)(6116002)(44832011)(50226002)(486006)(5640700003)(6916009)(68736007)(99286004)(4326008)(2906002)(8936002)(6486002)(76176011)(8676002)(71190400001)(256004)(14444005)(14454004)(2351001)(71200400001)(66066001)(52116002)(6512007)(478600001)(81156014)(81166006)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1439;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zCZQbjMWVooJLwHrn3v1oG7YykgEHENsvQ61ZRpT1IJQ6BOjYQY9or60ZPbGzlH5dqYokqNFAvFmJeopvUaE2kJMBLeMvVR3NoUtyzQB/kzCy74Nl4UtTtlabT/VtIE0kHOQ1Ss61iUfGEKw1edXvXuxVgi1MNhozU6ta1wSjQ7rSWRENoE2RCVe1kqbLhjysHm/JPSUIi0u4QvwMP66izUCSD3oYuQqpzmGYxS6jdz6xLeDGqSYNk0CGb/+32oerGTHjspafOtcmOPTLGjYZwf0UT94YwC7sq+y3IlWRbFwg9aeP9x4h0JGYWsA1m0anC3CanvmlUVaQ3LWthgqwDtkm/jMwe0wXQt/a4Z9xxioAxg0Ld/AtMRyuf7RDmo0vgz0CYza+X6Yb+5tTfGnQfnAcYN/g8x4y7O3SOHGoAk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4883a327-ec5b-4dd7-55cf-08d688afce61
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 01:43:18.1602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1439
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

If drop_mmu_context() is called with an mm that is not currently active
on the local CPU then there's no need for us to stop & start a hardware
page table walker because it can't be fetching entries for the ASID
corresponding to the mm we're operating on.

Move the htw_stop() & htw_start() calls into the block which we run only
if the mm is currently active, in order to avoid the redundant work.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/include/asm/mmu_context.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mm=
u_context.h
index 0d050d781737..5d0a73a5cf40 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -184,17 +184,18 @@ drop_mmu_context(struct mm_struct *mm)
 	unsigned int cpu;
=20
 	local_irq_save(flags);
-	htw_stop();
=20
 	cpu =3D smp_processor_id();
 	if (cpumask_test_cpu(cpu, mm_cpumask(mm)))  {
+		htw_stop();
 		get_new_mmu_context(mm);
 		write_c0_entryhi(cpu_asid(cpu, mm));
+		htw_start();
 	} else {
 		/* will get a new context next time */
 		cpu_context(cpu, mm) =3D 0;
 	}
-	htw_start();
+
 	local_irq_restore(flags);
 }
=20
--=20
2.20.1

