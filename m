Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2018 20:33:53 +0200 (CEST)
Received: from mail-eopbgr680119.outbound.protection.outlook.com ([40.107.68.119]:56666
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991923AbeJOSdbAQ-n2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Oct 2018 20:33:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skCaqnmdPC7qfaLOM8wpxI2+trsNaQT49+wK31P7zmY=;
 b=D3vFEA7gKEHJutk+4/7uC3FjKUbT0pePr5ZZsX//Za1wGJ4YpD3aV/eDhDvsPKtS5HwChrC9rM7hFfVEcSXj5FSQ0jlZemg2AObl+5+SMzWOUwUqSiN+ehWC5XR4xXnEro6LqWWJdTrmwBSVJ6of2Fehp8+mbm+4Y/WZBzXtBFQ=
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
Subject: [PATCH 3/7] MIPS: Remove unused TTABLE macro
Thread-Topic: [PATCH 3/7] MIPS: Remove unused TTABLE macro
Thread-Index: AQHUZLWM4Z710PsGLEGx1Jnk0azg7g==
Date:   Mon, 15 Oct 2018 18:33:20 +0000
Message-ID: <20181015183304.16782-4-paul.burton@mips.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1710;6:MD7SMa+fp3aOhktt+sFDhwu9GhpZYlUM0Ibs7/YjuFQ3qGjpg+PW7yjVeqq6oaDiE5Iycw60nu+SDh5T7qYkY+Xmty6Bi4+MNu0h310muGMxp4e1c1s/+XIRoP7KRY7wcJN+6oDcyZei0xHqcHEn+CZEbLlowDe56NQ6ONwN5my1kkqCuZu8MWr0cM825n2yzd5WcvdgbMc10JVQDQVQZnCHhWGTgGEu8FMsxf8MVGGZt8/GpXYa6+a/JMbK1xjngDDAVUwN0zMHtoqxDLel1Hi16GrwEXLIzqAGC4sUQZnkDogAV4utNTcRDtTcpSbc7JxHP/nz3qQXOpWWdEmGIt40Pr47KQeghW0+BWTIHaZ/R8VHAUBDvVXEq4oimkzLFfWgrPSE23CjaiEH5hNh7emqPtx30NjwmKZanN64d7uX10ewZufOkpp32id+30/183fz1rDbvyYEg1UUJBwlXw==;5:luQCN1maiBOLmCqUloHvCzPvcf3xNi6D5NtynJUnZdgFolTsIK6ijD6oTd+cxuLRs1hRCsj0Dfq2NB2CJdKLdv42IG/8/5m4oC+f4YRDG2FCFtRAjnL1lNdwtE398Hn5OOVw67VLsUDAQ1NkvzsGANU83UBvjnyR1vEzBn2pYpk=;7:u3Xpxu0PkM7ns3fw7YRi/y6pcrzxLuz6nQvQKz8L8Zv97arlRopjCuBM6c/J/8t76koW05eUrWmsCfl8JKAQ33UeGK1r1W5bO1DRJXVmkZTLZ0ve8UwVgKIHx0sm/Uuy0nSZW2YN8/1Sbxy+8NoI8zpqsXn+aNBIhwKby9tPF6HR3nV6BGfXesh8eho6V7cyOH+OZzH5BUXlFumtY1w1jywU2huy4nsgYuRqgNbMopCzGR1wFe5L03ga1vU1p3Db
x-ms-office365-filtering-correlation-id: b86d7535-9c34-4341-b8a5-08d632ccae94
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1710;
x-ms-traffictypediagnostic: MWHPR2201MB1710:
x-microsoft-antispam-prvs: <MWHPR2201MB17103F48D841DAB904819A63C1FD0@MWHPR2201MB1710.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3002001)(3231355)(944501410)(52105095)(10201501046)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(2016111802025)(20161123560045)(6043046)(201708071742011)(7699051)(76991067);SRVR:MWHPR2201MB1710;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1710;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(136003)(39840400004)(396003)(189003)(199004)(107886003)(5660300001)(14454004)(97736004)(81156014)(81166006)(1076002)(8676002)(106356001)(26005)(71190400001)(71200400001)(186003)(8936002)(3846002)(76176011)(25786009)(102836004)(66066001)(6486002)(6116002)(105586002)(4326008)(2351001)(5640700003)(508600001)(52116002)(486006)(6436002)(2900100001)(386003)(44832011)(6506007)(99286004)(5250100002)(476003)(36756003)(2906002)(7736002)(305945005)(2616005)(42882007)(6512007)(316002)(446003)(256004)(6916009)(2501003)(53936002)(11346002)(14444005)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1710;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: r+3cjr8suBdqwujE0/Eb4ILrlzPLOkOZv4Xy9/HSNY3PdXxx3oOyjgYiPpRwYk3PKPKTjFlLOUn/ghBDcoKa3d5IDkfR6E6srfIYbvmkcrAumFiUEE6Pa9AWuMKuzXdDsLJfMSMcENqhK0O1aX7wmoLC62U0KNmDtIa83ZZmEfQ3GRUiCHXX/UBPVKRyx9UsCPm8DRH0oaYHaaOqqDdZgKJ6gSn7cKMcSYMApClbJ05n2eE5ZIX6qtJ0zxJ2Z2hvSnHX/dgnk7ll2KaBWlWO/EkCwoW6EzbvqDWNSHiOkIGu5tetSHbEYPyTv3RS2Qvdwk9A2W3CK075eIUWVr2YQXk2n9slRG2/g6jFN8YwNLI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b86d7535-9c34-4341-b8a5-08d632ccae94
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 18:33:20.6797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1710
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66850
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

asm/asm.h contains a TTABLE macro to generate "text tables" which would
appear to be arrays of pointers to strings. It is unused throughout the
kernel tree, so delete the dead code.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/include/asm/asm.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/mips/include/asm/asm.h b/arch/mips/include/asm/asm.h
index 03711771d51f..0cd72b43079f 100644
--- a/arch/mips/include/asm/asm.h
+++ b/arch/mips/include/asm/asm.h
@@ -112,17 +112,6 @@ symbol		=	value
 8:		.asciiz msg;				\
 		.popsection;
 
-/*
- * Build text tables
- */
-#define TTABLE(string)					\
-		.pushsection .text;			\
-		.word	1f;				\
-		.popsection				\
-		.pushsection .data;			\
-1:		.asciiz string;				\
-		.popsection
-
 /*
  * MIPS IV pref instruction.
  * Use with .set noreorder only!
-- 
2.19.1
