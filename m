Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Nov 2018 21:10:07 +0100 (CET)
Received: from mail-eopbgr680116.outbound.protection.outlook.com ([40.107.68.116]:42048
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990883AbeKIUIiWgFEU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Nov 2018 21:08:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEyzrcuZe6rZKfc6JLMWVLMxv8gsl7w9lvHMMy6VJUg=;
 b=inhc84qvS0ocTmkD1zMFVtpnkulSA2TGoaxiLJ6X+2a419o3mhP+aGZ8n8CNU46lqsbpO0dfNkydADxC0J0HpxmPdAqCearWYLbqtM/nx3IqeV7x0thGRJQGfvcKnUfXl4ct3ZUZ749VcM391CIHAHfvWp8fJHw5uz8AnQf7nWE=
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com (10.171.216.146) by
 CY4PR2201MB1525.namprd22.prod.outlook.com (10.171.241.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.29; Fri, 9 Nov 2018 20:08:36 +0000
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::ace0:f12e:c2a0:dc23]) by CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::ace0:f12e:c2a0:dc23%9]) with mapi id 15.20.1294.034; Fri, 9 Nov 2018
 20:08:36 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH] MIPS: Don't dump Hi & Lo regs on >= MIPSr6
Thread-Topic: [PATCH] MIPS: Don't dump Hi & Lo regs on >= MIPSr6
Thread-Index: AQHUeGf/Q66CdebQjkWysLhfAhtVUA==
Date:   Fri, 9 Nov 2018 20:08:36 +0000
Message-ID: <20181109200817.23597-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0069.namprd19.prod.outlook.com
 (2603:10b6:300:94::31) To CY4PR2201MB1272.namprd22.prod.outlook.com
 (2603:10b6:910:61::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR2201MB1525;6:P6brH5pGwlKSZCsY9jDEzOTmGaR+G+V57xKZQ4NclV4r5D+vU5cTizBqnsaE9XdnWFYFlqTUZh/WgEtCz+Rtpvb3viOHLo1OzOUdu4Bj/yqWlzrFptp6mPfp111XZmQU4niV1k47mINhsN14dF/nzVDLg6qX8WgwRJLIIxH0hxw9BsKdy6KVUczdkk87v2We3/jSfbewKhKG3AqzK2Uw5RzBDV/BuXkj1fiP0DTsM2CujJ8pIvFNcz+51VsfaiBpxICHVQQ/8hPxQwUI8E06xwFKhvvMADM8v1M/WjHcCR0ooZrdbp8bWOyvjob9Hxua7aFhTBDsHEFHSMD3hqN/7fzUrDnFzuoIhovjc1pFRZ7q5A+r6ZQectQGaJMOHoMQDWBa85njDPD6ZR1a0UfKz2UBPEVU2SRDuISeVevK2muwPxAh+vnjOJLZvndWVO+DRJiHqNjNreB05FLnKJ14oQ==;5:0LqGKXARcmLS4ZcyV5WpcGsdftCRP3Ske0gv+u4DC99gbvsVFbmtO816xbVdCZ80faj8AS4oEWQJ7CFRnUpgpzmTnfoF2SxXYTtskNlezKT2x+tS9uIkLDFluyoaDTiMzg/M1EVFFrU0lNeNgwTWVxXJyf+ik6jSZtsnnitYRw8=;7:aordKhanIqnbJ2+Ul1DO7a6shwrxv3+s4iddEyEdLh+7J9Fl3w9vjdpYMEx3eFZh6In/GJvx6o7jbBAcIO1EapLE5Vlx0996uHNJrCtYXNa2k65jJkVIkrPEsCxZVph+Ua+HwyF/EKC3wRp+8KICUA==
x-ms-office365-filtering-correlation-id: 3318461d-8210-447f-2550-08d6467f21f4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR2201MB1525;
x-ms-traffictypediagnostic: CY4PR2201MB1525:
x-microsoft-antispam-prvs: <CY4PR2201MB15256832F7288C042CBF61C1C1C60@CY4PR2201MB1525.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231382)(944501410)(52105095)(3002001)(93006095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123560045)(2016111802025)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:CY4PR2201MB1525;BCL:0;PCL:0;RULEID:;SRVR:CY4PR2201MB1525;
x-forefront-prvs: 08512C5403
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(136003)(366004)(346002)(376002)(396003)(199004)(189003)(81156014)(52116002)(25786009)(8676002)(6436002)(8936002)(386003)(256004)(102836004)(2351001)(42882007)(2900100001)(4326008)(68736007)(36756003)(6506007)(81166006)(6486002)(6512007)(53936002)(508600001)(2906002)(5640700003)(3846002)(71200400001)(14454004)(5660300001)(6916009)(1076002)(71190400001)(6116002)(66066001)(97736004)(476003)(2616005)(105586002)(106356001)(7736002)(99286004)(305945005)(44832011)(486006)(2501003)(107886003)(316002)(1857600001)(26005)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2201MB1525;H:CY4PR2201MB1272.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: k9tgXp28EOw65SOR74jGT7Yx06ndNRdelUoRTvvc68mAz/euFnOWBsGpUFXaqToHslbndKuxT3ST/RPl89LXJKD6Ixi/jJfh3jo1AoVlqRihD1A6jL95y1TsuDbKYteGh4rWRGrK005tVIDyFC/OY6Jb+x6N2BhiklL4hrtgseJIq3MhMCyf5AQcEY9kuYBMRnCVpKJ8D45YhmIh2h9pSKBFxLYGqYAj4i8VjspYco4z6cHAq9QWDsT3FCyNHoq7jCg+YlbXQLubgaUS7TiQTX06YwkL/yJzH2wqpRytYJO4tmxJXSoWyKY/3NfrPlFx7sqjVEY+Dpi68ERZsWnS7WBeYF8vWuzBBlyqRNUK1ro=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3318461d-8210-447f-2550-08d6467f21f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2018 20:08:36.5824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1525
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67213
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

MIPSr6 removed the Hi & Lo registers, so displaying their values on
MIPSr6 systems is pointless. Avoid doing so.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/kernel/traps.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 21f36c9e8a86..a88994a77d52 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -51,6 +51,7 @@
 #include <asm/fpu.h>
 #include <asm/fpu_emulator.h>
 #include <asm/idle.h>
+#include <asm/isa-rev.h>
 #include <asm/mips-cps.h>
 #include <asm/mips-r2-to-r6-emul.h>
 #include <asm/mipsregs.h>
@@ -279,8 +280,10 @@ static void __show_regs(const struct pt_regs *regs)
 #ifdef CONFIG_CPU_HAS_SMARTMIPS
 	printk("Acx    : %0*lx\n", field, regs->acx);
 #endif
-	printk("Hi    : %0*lx\n", field, regs->hi);
-	printk("Lo    : %0*lx\n", field, regs->lo);
+	if (MIPS_ISA_REV < 6) {
+		printk("Hi    : %0*lx\n", field, regs->hi);
+		printk("Lo    : %0*lx\n", field, regs->lo);
+	}
 
 	/*
 	 * Saved cp0 registers
-- 
2.19.1
