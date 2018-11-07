Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2018 00:14:15 +0100 (CET)
Received: from mail-eopbgr680094.outbound.protection.outlook.com ([40.107.68.94]:46351
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992907AbeKGXODCWncU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Nov 2018 00:14:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9HDqCM8mmbrpeKSFMOS/8HVizxOF14cQNHHj1TTEoY=;
 b=CrU40cPG64cwb6LA4Qq4QdG3QtHCSdgC5vtSoEMDoG2eYjYjO6rZjqyeHiVyU+M4iBb6QWrtjiiWG5Wpeg9SOqqZ4JEyN3up6RcZ+jhq8LezIWwcoMlC1NHJRA4rmGdo5UUVwmpSpG/Sx+pUTPKdePySWAW+2pEZahtRZ46S1tc=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1472.namprd22.prod.outlook.com (10.174.170.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Wed, 7 Nov 2018 23:14:01 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 23:14:01 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 05/20] MIPS: Drop forward declarations of sigcontext in
 asm/fpu.h
Thread-Topic: [PATCH 05/20] MIPS: Drop forward declarations of sigcontext in
 asm/fpu.h
Thread-Index: AQHUdu+RTlPe9D54PUq4cHK+4rZQuQ==
Date:   Wed, 7 Nov 2018 23:14:00 +0000
Message-ID: <20181107231341.4614-6-paul.burton@mips.com>
References: <20181107231341.4614-1-paul.burton@mips.com>
In-Reply-To: <20181107231341.4614-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0028.namprd21.prod.outlook.com
 (2603:10b6:300:129::14) To MWHSPR00MB117.namprd22.prod.outlook.com
 (2603:10b6:300:10c::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1472;6:sYxFA2vFmRa+fP+OxmOMb9i6NQ0j2v2p5dCOxN2iXvp2Tt/F/2Zqqo9Sc39l9/RrrSKOCp3AX0QWIiAfopnfRWyqIgvwEoCB5n6r6Xjz8zdI9tOj+FRjDl0njnPaEFw88sl9uNSNmCgKILW4LqGXLQ8j/fL8yifDNeqncCi70mMZqQON1/0XU2gRa/7leLzGLVcRFd9doi3pA7Dy2ktJsaF39KGVMfPW7m8ZWcY+rfV7MjzcoO55pI9xAwsQ73VeFUQmaMIG6R/7eKNjByLVqYc4bLsPcrfxlzGXE7ZlnCQ0MsiTWZAAApCIEKEzuKgD8C2uvI5sERDJC2lXxMwRqrPP8A7Lz4meMt9umxRBY5HmkXJ8Ob407Yz/a8SBxJOWOZVJs6kOiN+SEBGorEMytFt6t769S+QFyZAGEtiWZdUuCsHpuIn7biz44eseiDb9KFA7Y9TF3nUc+IOIXifsWg==;5:chQ4PwTmRxtVthuWyvEqAmgVPXwHBmCdRdeBOfbbZN8yc26gY2DxYrJsIkJPq6L5gIc4DqQWdN/FGnle1Uux5vN1RRVMuy9kbd967H9UYIii/0+bQGsYQHshZGOH23uMCYt/XYMv2DrFqi4pjRemmFmcIHtCq64d+jRMZuQ/G0A=;7:LtXRhegV7XCerpzZBYYRsuZRMUQ/jZPX6/mL6MUkgG3Nn4IRIXvJ5TC4KG5IeuspWZ95xmfqvwQQlqq9Xma+iVxRAuCZ6ygVI2YWxBTGMonoBP0m813SXPtwtKwjVFUlL5+0XilJyLT+QeObh5h27Q==
x-ms-office365-filtering-correlation-id: 500d7bbe-1afa-4810-ba9e-08d64506b3af
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1472;
x-ms-traffictypediagnostic: MWHPR2201MB1472:
x-microsoft-antispam-prvs: <MWHPR2201MB1472F76A0A9803C1E99F2726C1C40@MWHPR2201MB1472.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(3231382)(944501410)(52105095)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1472;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1472;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(136003)(376002)(39840400004)(189003)(199004)(99286004)(52116002)(256004)(14444005)(26005)(186003)(386003)(76176011)(446003)(11346002)(102836004)(44832011)(476003)(2616005)(486006)(7736002)(5640700003)(2906002)(6506007)(6512007)(71200400001)(6436002)(71190400001)(316002)(2501003)(14454004)(8676002)(81156014)(97736004)(3846002)(6116002)(25786009)(8936002)(1076002)(81166006)(2900100001)(6916009)(6486002)(36756003)(66066001)(53936002)(305945005)(68736007)(107886003)(508600001)(5660300001)(4326008)(42882007)(2351001)(105586002)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1472;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Iq9I7TqjjFNlNulQDuK+OmmKLuQt/dJaBiiG1DM1qyPX4wViTmVGRXwdzaa2WTqZM/jltPFKMHzAD1xA3tBZ6zMCQRI8vZtDUBsqnsqWiJz6dN2M9mtssIt1QX5Oz2fpVy0vMh2suI+Vjpr0OUqmVM0+z0Idism0RMM5YbseSgkQXnLNvRvlxkf+tMVnG7Qaa8qH3ppm0I2yTgAc4+yqoacXB6Ejysh5wqAlpEBN0A+8Tvv/HiDFTwite4OPwuKeI3iFv+nLO5IcMuey6DqlLnS+IKj11GnwPnnykATtFXYlQT/W68q9M2ogi93+khL5VCzwFY+mbzf9F5bNBkbh8LHB9eD2EDNAA8UyVHeNcUM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 500d7bbe-1afa-4810-ba9e-08d64506b3af
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 23:14:00.9004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1472
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67141
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

asm/fpu.h contains forward declarations of struct sigcontext & struct
sigcontext32 which appear to have been unused since commit 137f6f3e284e
("MIPS: Cleanup signal code initialization"). Remove the dead code.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/include/asm/fpu.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/mips/include/asm/fpu.h b/arch/mips/include/asm/fpu.h
index 84de64606ccf..2a631adb1fa8 100644
--- a/arch/mips/include/asm/fpu.h
+++ b/arch/mips/include/asm/fpu.h
@@ -30,9 +30,6 @@
 #include <asm/mips_mt.h>
 #endif
 
-struct sigcontext;
-struct sigcontext32;
-
 extern void _save_fp(struct task_struct *);
 extern void _restore_fp(struct task_struct *);
 
-- 
2.19.1
