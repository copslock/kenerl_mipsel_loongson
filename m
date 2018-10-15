Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2018 20:34:02 +0200 (CEST)
Received: from mail-eopbgr680119.outbound.protection.outlook.com ([40.107.68.119]:56666
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992081AbeJOSdb2OFk2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Oct 2018 20:33:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+HVH53BcL8fWKMQqxDeLSl/6sDxl8h/H+OrmLp2kD4=;
 b=NC84f5ORoDw0J8LZxyN079cpVYLB45uVv0DZildTZLeWx2tHfucSg55P9ki6zJMn2dzsNQERt3b6D5+32emsEzB2koC45vDK6qNgtcpFgZB2AzTMrQdjYurZWE+ejtnU8XKKYFqt4FxFgcwtTZkPLf8YRw2HCqHhcuLAPm5BMz4=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1710.namprd22.prod.outlook.com (10.164.206.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Mon, 15 Oct 2018 18:33:21 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::781f:63:481a:efdf]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::781f:63:481a:efdf%10]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 18:33:21 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 4/7] MIPS: Remove unused CAT macro
Thread-Topic: [PATCH 4/7] MIPS: Remove unused CAT macro
Thread-Index: AQHUZLWMBKdS/OuiRkG0Z+qvFhovLw==
Date:   Mon, 15 Oct 2018 18:33:21 +0000
Message-ID: <20181015183304.16782-5-paul.burton@mips.com>
References: <20181015183304.16782-1-paul.burton@mips.com>
In-Reply-To: <20181015183304.16782-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1701CA0018.namprd17.prod.outlook.com
 (2603:10b6:301:14::28) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1710;6:iWp2KWPYDnMaedTH4dV61PVffzDuiIKZSHaPBUg0yNCX4pmMaxYKAia0GyhAu50EwhEWY9wkdLdwSFKH55K4Mc1ogc0Jbxfr0ygdVZsXARHhyiLiwEQtimF6HmqEPa9MM1StoKgMZMof5MGD4neo0DnLStwrbqRlIvFhZx7/7S+T/bBiR56plMy4wdJkBxnLhv12mvf3jdzG/E6kFFyEycZp46riDSzXkIB6uy6iAhKJA/KRyb8Qhi9KZHei+jDD5M6U3RUXMKdTc2VK/t76m3vWlD5HKse/Tl/4g8tQewulzVihHDO6h+NBWrCNeJczOsPldFWp0v7Bwx53RZB+cOWe9GMNhxZ9BvjE+VncizX92kQfPTHPv/LQZq3iqSJSur5sd3BQ+93Yx2QoaVxmgytL1dsv2QAgNvY+VthKOndEjFUMbz8mSC7GfdUf0t9yWan35do6ZoiS/t3IzcneIw==;5:pxwxapOOfjM/GkzZPTgx6IRacc5a20eHC2G+WkjAIuWd08v6FTqJh208prsDS1Qd22pIKE9SxUcfLkCxfAJmmmk6HjpHyDZdcUP6mKeuyNF9ZLE5/Nr0vA1VYkn1fnFSp+qxLdEVs6wXUMq694X3aWyVRjtbnUmOTxFp1gflHMA=;7:zIU2H2gvtd6ViUV6uuBc5uaY832FswVqNQ3VSncDwtJ5gw5zoqf7LZyI4iRlUdIy96d553HQezwDhl9nqzcmExOGRUUZL98GUUDoBarj38JowCUrTQrHnec+lBVMrnU6fCiH11h5BUnZ+oZN2wIhzYpu0wiYr7yc7x/yhkN/Yi4h2mhxh0o3Pc0ADGEQleNcXFdwK0H2H2GoHGsaa8yJqCbyF5ZsSo+1USeqhbSyBtGFhlynKpM0mMbO55geMtCA
x-ms-office365-filtering-correlation-id: 0adb3dab-6dcf-4d97-dcbb-08d632ccaef8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1710;
x-ms-traffictypediagnostic: MWHPR2201MB1710:
x-microsoft-antispam-prvs: <MWHPR2201MB171090F091356FFCBF1243A2C1FD0@MWHPR2201MB1710.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3002001)(3231355)(944501410)(52105095)(10201501046)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(2016111802025)(20161123560045)(6043046)(201708071742011)(7699051)(76991067);SRVR:MWHPR2201MB1710;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1710;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(136003)(39840400004)(396003)(189003)(199004)(107886003)(5660300001)(14454004)(97736004)(81156014)(81166006)(1076002)(8676002)(106356001)(26005)(71190400001)(71200400001)(186003)(8936002)(3846002)(76176011)(25786009)(102836004)(66066001)(6486002)(6116002)(105586002)(4326008)(2351001)(5640700003)(508600001)(52116002)(486006)(6436002)(2900100001)(386003)(44832011)(6506007)(99286004)(5250100002)(476003)(36756003)(2906002)(7736002)(305945005)(2616005)(42882007)(6512007)(316002)(446003)(256004)(6916009)(2501003)(53936002)(11346002)(14444005)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1710;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QmT/VqqCJPaqreuFrAY8TO6B15AsayWYwuL5Of/vA4xteE8ipVqcvrmgWWwsTC1AEhp5IjIBd1qXZDTuG2WWh974e8TPX7vFk0cam0HUj4Ta5yv1gvQXGaNf9aDWVRa74bCAA1g3w6C5fhiHhed2m3w16MXE9taHZ26p5YmHtZ6jhA6RDuxMf4PGkjir1ivN+nuPneGep2HGtiogAgkMVybMPkXMuXsUhm0iRTBO8zLiBaT8tVhac6+dXuFTOD/TWwV+c6yOUZtqvNUjjYU6wMlIlHjdP0jSBOTlUIgqKffK5LEoZH4Qy3Jx2zpoDDF9vSCry/PeXyj9Q20YGdwxeRUFo6mKN/7zgvtDK0zOwNs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0adb3dab-6dcf-4d97-dcbb-08d632ccaef8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 18:33:21.3360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1710
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66851
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

asm/asm.h provides a CAT macro which is unused throughout the tree, and
if anyone wanted it the generic CONCATENATE macro in linux/kernel.h
provides the same functionality. Delete the dead code.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/include/asm/asm.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/mips/include/asm/asm.h b/arch/mips/include/asm/asm.h
index 0cd72b43079f..74b1c6fd8277 100644
--- a/arch/mips/include/asm/asm.h
+++ b/arch/mips/include/asm/asm.h
@@ -20,15 +20,6 @@
 #include <asm/sgidefs.h>
 #include <asm/asm-eva.h>
 
-#ifndef CAT
-#ifdef __STDC__
-#define __CAT(str1, str2) str1##str2
-#else
-#define __CAT(str1, str2) str1/**/str2
-#endif
-#define CAT(str1, str2) __CAT(str1, str2)
-#endif
-
 /*
  * LEAF - declare leaf routine
  */
-- 
2.19.1
