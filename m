Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2018 20:33:33 +0200 (CEST)
Received: from mail-eopbgr680119.outbound.protection.outlook.com ([40.107.68.119]:56666
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991162AbeJOSd2OGAT2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Oct 2018 20:33:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5q3MDfgZgxgGiD7m1+VQpj0hgpAZz+L+4OmP7uVwd2s=;
 b=KejZgwfsUQVwk+V/vZytNpa0qPe31QJtdRQLjCkV050hHEeRjtj7caUNlWwJdVMQTprsK+GOLrsqI+PO5as1igkP41q76cF3CMlkTmX6ym3ApmW3cu2SuSfc6nDXOfiD8U+kvA6VrsRK4gth8kfp2YPyTan2kMTHZD1H52KSUWA=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1710.namprd22.prod.outlook.com (10.164.206.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Mon, 15 Oct 2018 18:33:18 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::781f:63:481a:efdf]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::781f:63:481a:efdf%10]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 18:33:18 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 0/7] MIPS: Remove unused asm/asm.h macros
Thread-Topic: [PATCH 0/7] MIPS: Remove unused asm/asm.h macros
Thread-Index: AQHUZLWLQtmQ4nE/bkyekLIygsFlUg==
Date:   Mon, 15 Oct 2018 18:33:18 +0000
Message-ID: <20181015183304.16782-1-paul.burton@mips.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1710;6:MZsYhVqp3jFnBMi8WH9+XULLBFb2FCDsyMGsh2/LcMoWefDMYxcfJTUFGaq+weSf5i213mdq+A/7ZQGS+8enTz4FMg31/Su2VeACB37dF47zBXNW4KC6xeU4eH9q8pMkl19iw02YZy6K5yo3fHmCvegjsTV9E4CnYB8AyzMgPBo2c9Ah0AR1rmc9zdvIqpk2D5YCQS+9e560V4z7WdsKr4aXdrVzS41qvokJti7VPXtDvwv+GlLpQ8008Yi24erbabrDLp/5lfteg5WBVwQJiv4ADY9+Owv19Eg54P/1uA7uqBPDwu52Ya7Frax3TIbkwBNOA9cPuAlpdXVLvtBR3vbVyz0okM/vI4xGtJ+a5rbzIo2T+ZAf3FnzEJLHtt8x0jtlAUDGL3ZwUB8m6yJUPGlHjk8T5CMswuc6CYJW97zLaaqN277lO6Y0NqYkSClz328fVfN4MbfjYL37X5IMjQ==;5:Sq+YfdEbgIcJhS4yMMnf2CoumMnVxJZ9rwR5iJNQHgk1QVAGBe17xUPMZN4LPHfwTUUcDoOwgDFAj8ekYEY6IUaObe/8SzFNw01GYnrtDlnUKEThVeCfau9KDe1ExyKeoTtSba7eQbtfsWXC1mp2buom/016rpFvSbQPCaWRsPM=;7:ZmU32xi74FST/w3AAtJl05Yld5CtUH6jpu3lUf3nCROdoPCItNc0Onnv/JUAB9eg5tWwVR3wTunMreG8FJGA2zr+Tmhb9o5AzGPOF7+NxXCRe7ijRMs2hhxLv4+7h2gnQHrZRTtpaXFHOPyosOhunM/BT/yMw4SvA0Rv/AHEnpLT/A2TyackLkoVch9zraUonrfCdy1EgLC1E7MrXp6SDfo0EgJvHknKPZGu1L3k3jc/V2Ln6GG3WC6RCiPi8xz8
x-ms-office365-filtering-correlation-id: c4b6a0c7-6773-41be-6064-08d632ccad5c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1710;
x-ms-traffictypediagnostic: MWHPR2201MB1710:
x-microsoft-antispam-prvs: <MWHPR2201MB1710677A39F3B39F3F4E3BAFC1FD0@MWHPR2201MB1710.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3002001)(3231355)(944501410)(52105095)(10201501046)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(2016111802025)(20161123560045)(6043046)(201708071742011)(7699051)(76991067);SRVR:MWHPR2201MB1710;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1710;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(136003)(39840400004)(396003)(189003)(199004)(107886003)(5660300001)(14454004)(97736004)(81156014)(81166006)(1076002)(8676002)(106356001)(26005)(71190400001)(71200400001)(186003)(8936002)(3846002)(25786009)(102836004)(66066001)(6486002)(6116002)(105586002)(4326008)(2351001)(5640700003)(508600001)(52116002)(486006)(6436002)(2900100001)(386003)(44832011)(6506007)(99286004)(5250100002)(476003)(36756003)(2906002)(7736002)(305945005)(2616005)(42882007)(6512007)(316002)(256004)(6916009)(2501003)(53936002)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1710;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: f88Ffa4ejY2lZYhv/p4LK0rBgXeZjt+vfoiKBt1QvWaFDsWLy9xUKRcFgIn7GMb5QOKegafugO8kwQim2ja6fbTWLm1oSXvQmyN8QypwobVA4KvDVUh1UYU40DEfiZkSt7vFMWJ4+LE1GxIrNeRnPSQT4frk2CmR2WuMN34x/7WW5IKZmlwYpqtGR2h/MTjs8GlsPPZIbB90yKSCruxV1NnLtjZQvQpdiv7bVxLw0q/s9lRW4fbRCRbaBfJq4XTj6EBjzKBkdda5IX68knGNZ/XEqxHQN0LihVoBjjOjEt3HA+OB/oAV/oG7KWeLnCOVmJuBsuGTUHzvyaefpSktyyXqj3gwe5oc67noeD425DY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b6a0c7-6773-41be-6064-08d632ccad5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 18:33:18.7108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1710
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66848
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

This series removes a bunch of unused code from the MIPS asm/asm.h
header, shaving off a little over a hundred lines of dead code.

Applies cleanly atop mips-next as of commit 8b656253a7a4 ("MIPS: Provide
actually relaxed MMIO accessors").

Paul Burton (7):
  MIPS: Remove unused MOVN & MOVZ macros
  MIPS: Remove unused PIC macros
  MIPS: Remove unused TTABLE macro
  MIPS: Remove unused CAT macro
  MIPS: Add kernel_pref & user_pref helpers
  MIPS: lib: Use kernel_pref & user_pref in memcpy()
  MIPS: Remove unused PREF, PREFE & PREFX macros

 arch/mips/include/asm/asm-eva.h |   6 ++
 arch/mips/include/asm/asm.h     | 116 --------------------------------
 arch/mips/lib/memcpy.S          |  12 ++--
 3 files changed, 14 insertions(+), 120 deletions(-)

-- 
2.19.1
