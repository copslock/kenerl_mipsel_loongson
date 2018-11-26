Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Nov 2018 19:47:39 +0100 (CET)
Received: from mail-eopbgr730092.outbound.protection.outlook.com ([40.107.73.92]:18765
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993083AbeKZSrgLwsTH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Nov 2018 19:47:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJ3wpyF1Ek4mkqzeekA+u1ilj1UfWaJ4l3kU+gB61EU=;
 b=UcUTkgNfM7lj91BlVbsIYgrVzx+JA1UmZvQSOqG6Vay+0B1b3A+ALg7Une+wIUSr4zXiUrQwDA1v8m/Hpqqa+xw9XFlvp1LnZOuCIyQrnbEL2XJqnBBWCywj/FIlHsQ5HCIvbQE5hPEEmwC4xnPwngDafGe3uZQSCOGfAU0lMqI=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1375.namprd22.prod.outlook.com (10.174.160.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Mon, 26 Nov 2018 18:47:33 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985%3]) with mapi id 15.20.1361.019; Mon, 26 Nov 2018
 18:47:33 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH] MIPS: MT: Remove norps command line parameter
Thread-Topic: [PATCH] MIPS: MT: Remove norps command line parameter
Thread-Index: AQHUhbh9xMtQWCky7UyKhL9qbkyd5A==
Date:   Mon, 26 Nov 2018 18:47:33 +0000
Message-ID: <20181126184723.9324-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:300:95::14) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1375;6:D7Jny2/frK6TKpB+KLYOTrbIMEpusWSFodkfXtKd+YwcHIHQJCHIJxRKtFp76nd18zEAAFcgWiCLH6ovAls9SNCm6mIy8zxXI92hy/RCG0OESaRbfv6eOygDkf2xpYxXWzC1fpqmUVFz4gs5jlT6FLZ2C9Ml1VQZTcgMtNsfXB3kB2/tUIYZ4Q6iasgjNzibvcVj1FuucuNNw2tjNA/FpmqXL8Bd8Ez5nOZ81CwXl1ajQIpgvWPaAP/1eIbqMhuhdaC4LYDKpQsLUEvrk9lvMrYKwCR5pxwzzUHoa08nljxKP+agsQpeXhyfrJ2xI4vGVb+qsGCIcethre6X4nkVsECyVxEBc492Tf0mtJhpOC2jjKi9tyrQC6MogDa8s5OdqQpcF9bRNooHVCwB4/DKjf0zdAPIfPGzJ+QML7+BlMRLRbNX6Sb9FZLwIknAgo+3aSaxDk+lOsUJR3mck9e6sw==;5:0SnwVKEVEyzEfSHqW1OAAohT7s7MRfcMwHBTiKflnFr3DPl7NZJvKFrg4iZhmVnfJurDNedHC7pOxWwrl/2eZlYYqETHSHosv2sdVCWrWjSw4s1Zhe7rSbS1bUnZ30GF6KB52WIY9xWuxQUZhMVzfBQMRwxOKmVURHLz50hDxd4=;7:HPQeD4P3lyiudF9QdN6ClQMKl2RgG6Ax67JS3OajcaN7UwaJeSpbwRPY8nEXgvD9XRceayRjmdZ34bzCmfaO+gIU7fyNHfnINNZB0lmxhUueKgs0MluOSUIHe5prbF5XUHIqwUZRgM/iIg1jqz2IQg==
x-ms-office365-filtering-correlation-id: 885d2b86-b5d2-4560-3b93-08d653cfa016
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1375;
x-ms-traffictypediagnostic: MWHPR2201MB1375:
x-microsoft-antispam-prvs: <MWHPR2201MB1375ABE63285B2904820DFA3C1D70@MWHPR2201MB1375.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(3002001)(3231443)(944501410)(52105112)(148016)(149066)(150057)(6041310)(2016111802025)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1375;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1375;
x-forefront-prvs: 086831DFB4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(376002)(346002)(396003)(39830400003)(199004)(189003)(6436002)(186003)(52116002)(6916009)(105586002)(3846002)(386003)(6116002)(7736002)(305945005)(316002)(6506007)(5660300001)(26005)(2351001)(66066001)(36756003)(1076002)(106356001)(508600001)(2906002)(53936002)(2616005)(44832011)(5640700003)(486006)(476003)(81156014)(81166006)(42882007)(8936002)(8676002)(107886003)(14454004)(2501003)(71190400001)(71200400001)(6512007)(256004)(97736004)(14444005)(1857600001)(102836004)(99286004)(4326008)(6486002)(25786009)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1375;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: beV//17hoNXntJYhGE9lmZmnAlLsFb84NZhmDm39GZT07VPtCwoIPhd9XNFRMh6mRibYo7/5YZKoHwtCgErsalNklr9SXhArVqhcIZwL8azX72GYLiCQw+Q/zqdVb5WUGs0ltFqrI7yx0kvIaOEDvobDQwuzEi66OLgImqE/6zW6SHA9Y1gwv08T+GG7gCRw3go9DsOrPzOeI6dJl7ZGT6HjgW2SldXEIykZh9bVovmXQUg48zu/vk9O2e7HCuJNV3aP5cNzHTa8lM9P6ZDYSrzR/FFTaff+wHoZIQw9BPQ/u5NPLGMw/bayK3+r8IWA6nDl5YEsrvN2HdJAiwudK/egNviSOSaAmUP3v7v7U7o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 885d2b86-b5d2-4560-3b93-08d653cfa016
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 18:47:33.5057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1375
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67516
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

The "norps" kernel command line parameter has apparently been deprecated
ever since it was added to the kernel back in 2006 - all it does is
print a message telling the user to use something else.

Remove the long dead "norps" parameter.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/kernel/mips-mt.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/mips/kernel/mips-mt.c b/arch/mips/kernel/mips-mt.c
index 9f85b98d24ac..d5f7362e8c24 100644
--- a/arch/mips/kernel/mips-mt.c
+++ b/arch/mips/kernel/mips-mt.c
@@ -119,19 +119,11 @@ void mips_mt_regdump(unsigned long mvpctl)
 	local_irq_restore(flags);
 }
 
-static int mt_opt_norps;
 static int mt_opt_rpsctl = -1;
 static int mt_opt_nblsu = -1;
 static int mt_opt_forceconfig7;
 static int mt_opt_config7 = -1;
 
-static int __init rps_disable(char *s)
-{
-	mt_opt_norps = 1;
-	return 1;
-}
-__setup("norps", rps_disable);
-
 static int __init rpsctl_set(char *str)
 {
 	get_option(&str, &mt_opt_rpsctl);
@@ -169,9 +161,6 @@ void mips_mt_set_cpuoptions(void)
 	unsigned int oconfig7 = read_c0_config7();
 	unsigned int nconfig7 = oconfig7;
 
-	if (mt_opt_norps) {
-		printk("\"norps\" option deprecated: use \"rpsctl=\"\n");
-	}
 	if (mt_opt_rpsctl >= 0) {
 		printk("34K return prediction stack override set to %d.\n",
 			mt_opt_rpsctl);
-- 
2.19.1
