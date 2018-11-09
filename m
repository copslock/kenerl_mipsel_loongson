Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Nov 2018 21:08:05 +0100 (CET)
Received: from mail-cys01nam02on0120.outbound.protection.outlook.com ([104.47.37.120]:26353
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992066AbeKIUH7EgCiU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Nov 2018 21:07:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVW4C0Xlx1UJYyTilKC7KIP2G/Nj6/bIQ1aSlRr+w8M=;
 b=CeZM5GNACAF94GW4rihBIKg0eamXV5qj4YHcjZlyCBJ7f8Rylw3VxeLwE1IByZ23OMjfh5ZF+QAvG8bwg0yLIJQgllw+/OOfsvQoKCQZB9m65SLAw9v1L1+F1c7maixULc8ExszcaarNVH/s/lhvwbeWBfel+0/zR9gNI0dLoV0=
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com (10.171.216.146) by
 CY4PR2201MB1525.namprd22.prod.outlook.com (10.171.241.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.29; Fri, 9 Nov 2018 20:07:56 +0000
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::ace0:f12e:c2a0:dc23]) by CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::ace0:f12e:c2a0:dc23%9]) with mapi id 15.20.1294.034; Fri, 9 Nov 2018
 20:07:55 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH] MIPS: Fix do_ade() closing brace indentation
Thread-Topic: [PATCH] MIPS: Fix do_ade() closing brace indentation
Thread-Index: AQHUeGfnVDSHVO5LlkaIa1/QnwM0jg==
Date:   Fri, 9 Nov 2018 20:07:55 +0000
Message-ID: <20181109200744.23399-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR11CA0011.namprd11.prod.outlook.com
 (2603:10b6:301:1::21) To CY4PR2201MB1272.namprd22.prod.outlook.com
 (2603:10b6:910:61::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR2201MB1525;6:OS82sYrDBlKGqYms0kXA22TnDpdK0mutWsGwqoWzu8WPVAAgNg9f+CIjTu6fGGtN+KgKM2Fu/FgQKB8myffIbrpf2X+X0lxUzAl3VCb5508aJHBogX1wupDDQWcc1dVVevgwN0elldfzxSB4YxQYjcgSAnYRCHTq/EBpUxlKXARU9mUwz/2gNUfArY9y5/m6TkW7ynv51DIyq6z8bJJuMrl1rIiFgjVcuJfvSpgJaMsn+dmn+rUOujUrhtMODveQoSWXQuE1hDD+KracJ5UkYbW+Zp1PFdib0sRAdn3VmtpwPwhQozDiQzFjJ5QXt3ZGoUTd9Qvqh3Jvn6LMWCNTCZyOgwTsyp1zrH1VT+6dj7wLWiIJ3/1HwkBaKQxwPAg8NEGfU9O3Qhap7LvDt+aGFlAn88AzHgZOOLsP8txanqG9D4fPEPORz4f5UNiOCmMr4Tx4f0vncOPQ+bi/llXD4g==;5:2aYAqMZF9vCPQZmxTzF+EldnbOW2rESqVxhWqdDEl87mOL324ygEZYRSbmhHRhtdwtKt+x+gZiP2AOoexhY+yn2Cn/bgWiRto9wKmJM9F0px+Yepga3RiSs5PCMTczpQU9y++qrMH95S6NPoh/zEpM19nBPWkKMGE0hbef7NNQU=;7:S7IYnsnYhE2883TX59Ca2ujeyJs+CbHTuvqCGjNN2CSt8yDOzIzH2Ig3n7EvL0q3+gSfKSm+jbnsIkNAQPgYSnynVXM3jMTeGWzi5RGoY+wmKp82KOZXRsEdFcdMC8/EnSImKUtPNf5rCPeNQ1q31g==
x-ms-office365-filtering-correlation-id: 16ebe1e0-1d09-43fb-142b-08d6467f0917
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR2201MB1525;
x-ms-traffictypediagnostic: CY4PR2201MB1525:
x-microsoft-antispam-prvs: <CY4PR2201MB1525BC15BDA51A5CE0725810C1C60@CY4PR2201MB1525.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231382)(944501410)(52105095)(3002001)(93006095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123560045)(2016111802025)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:CY4PR2201MB1525;BCL:0;PCL:0;RULEID:;SRVR:CY4PR2201MB1525;
x-forefront-prvs: 08512C5403
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(136003)(366004)(346002)(376002)(396003)(199004)(189003)(81156014)(52116002)(25786009)(8676002)(6436002)(8936002)(386003)(256004)(14444005)(102836004)(2351001)(42882007)(2900100001)(4326008)(68736007)(36756003)(6506007)(81166006)(6486002)(6512007)(53936002)(508600001)(2906002)(5640700003)(3846002)(71200400001)(14454004)(5660300001)(6916009)(1076002)(71190400001)(6116002)(66066001)(97736004)(476003)(2616005)(105586002)(106356001)(7736002)(99286004)(305945005)(44832011)(486006)(2501003)(107886003)(316002)(1857600001)(26005)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2201MB1525;H:CY4PR2201MB1272.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KAMvOA46D6P0tBLHzT2KMyKj9ZwRNlqJP6NLkv/+lgkG8m9+zJOJDBe/lLjKkegxGe3g2Em1sWYpWc1iXCr2OGk/B7BETJ3rNRqvz7Zx/H9mGHVdsvl3FK0mj5yrZgaEHK4i93LkOu44dA+Gtn8k/8M3Mnq1yJh+P7kuheZoM8Fyckjj1pNN8PP5uNMCT7+ROb7mjHHWNg+2BuxGVa8DOYmiIk2RN0RQ9RAeumb92ZFuTTkexizv2oRqV0dKZ7OVjKoetwRVCi41hbJxigh6aYZMr3+DcvWUIyCKO/3TMFpBDGwuPosXlot16vp+1+lP57n2BmpYiRHEU1WLb8tDyY+wQyeybrIFlX66d6FoGfw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ebe1e0-1d09-43fb-142b-08d6467f0917
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2018 20:07:55.8190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1525
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67212
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

A closing brace in do_ade() has misleading indentation; fix it.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/kernel/unaligned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index 3850c563e588..c60e7719ef77 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -2348,7 +2348,7 @@ asmlinkage void do_ade(struct pt_regs *regs)
 			set_fs(seg);
 
 			return;
-	}
+		}
 
 		goto sigbus;
 	}
-- 
2.19.1
