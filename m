Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2018 20:34:38 +0200 (CEST)
Received: from mail-eopbgr680119.outbound.protection.outlook.com ([40.107.68.119]:56666
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992241AbeJOSdc6Ucl2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Oct 2018 20:33:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WBPHNQ6mgsrnRf90oaiKGR7jlWqSTkgiWriZBzCKuk=;
 b=S0WCe0gfx4sr5VxeowJ55ffJAr8UqkqatAcItWizKLE/ubuzPmKAuQtEbc5aLXlG8p307f3OH22XxSRLLlmdmX10jy8o0kqutZY1xyWeco8QnU1G/kwGN//MxFqW09Swg6xcRc/dY576iC/FDcRcC7o6ThIaGXc021kKcSfAN98=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1710.namprd22.prod.outlook.com (10.164.206.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Mon, 15 Oct 2018 18:33:23 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::781f:63:481a:efdf]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::781f:63:481a:efdf%10]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 18:33:23 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 7/7] MIPS: Remove unused PREF, PREFE & PREFX macros
Thread-Topic: [PATCH 7/7] MIPS: Remove unused PREF, PREFE & PREFX macros
Thread-Index: AQHUZLWN04HkP8D9PEGq6scWIXcPEw==
Date:   Mon, 15 Oct 2018 18:33:23 +0000
Message-ID: <20181015183304.16782-8-paul.burton@mips.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1710;6:qqYsuCaQbDxpOG4WDpxLNhDNm6tph99mjLA3U1r7aadE6AutXQoiOE+2tMmVbJdqHFF0a0IF6sfDVhKUJjOzfw0QQ8gy/kUcFmAa1hLJCxIPYWJIpLXMFml4a2IU7HQSz/PiS2Klu+LP+QLcyFIrVXqisLAbkd7Q9AObzzTHw87860oM0ZzPfyZkNuqUwmPmxA2kFEPMHkTWcG28X8X3rSyQ1D3SYyisSY0kzIH9/v/pkmvJLsQnVSxmfaPv3L4nBTK4KlXUellMb+8nLC4+UwXi1wQ0OqDDv6v/ocCHzVzid1k9HleOAya5sNE1rjYOuei30rB7t5NqufwImQkBAMu1jdGF7AaGuuDO+km8K9BcWgZGQS8VHz6M26QF2RDZMXpWZNLtN+WZB6NQcQj3l36AGKLJ1Pokcza85itKe9nMGuXoyNyOqRBxDCeXsol1DhB6AWngIe8eRhpHxfr5tg==;5:1N1S550INupxrnXI8N8Ax39uLjkA+y5/yMQT6jXS/jREvp8A19gFg7ZePopkwmjuIlK+em8jD2Z7sp2sbz+JSSKg5M5oyZaMF216xfq2X30s995PRGYdonGRPx1RDwf6h0hKSM7dSgssEJnGO6KPsEFzm2btU28TmjdrIxbWhS8=;7:sgaSHhg4S9tkrA+htvtBXt2W+3GPyVMncyVNopaOmaxMIfzcN8HfvO3V+WbyXF0UXZxSFXMPTmBi1CKP1eG/v4o6pF0fnLy94TFeMew4OYUol82RpWGqVxdVAobMmLehuKMFx2gKmXoy7EkNN8/VqY6m8Fb3kgQqKfb/uSGve6WbBTuVaEN9sVYSmMAVISYHMJmOhqM+wF61wLCc3iYSfWk3w0bm2Ky9YdI3MoBSfqtrFRQRf2WVQiZmcU1xEHFS
x-ms-office365-filtering-correlation-id: c7118d6c-c3b5-4e95-9756-08d632ccb033
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1710;
x-ms-traffictypediagnostic: MWHPR2201MB1710:
x-microsoft-antispam-prvs: <MWHPR2201MB17106EEA40E2BD13B39E87E8C1FD0@MWHPR2201MB1710.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3002001)(3231355)(944501410)(52105095)(10201501046)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(2016111802025)(20161123560045)(6043046)(201708071742011)(7699051)(76991067);SRVR:MWHPR2201MB1710;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1710;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(136003)(39840400004)(396003)(189003)(199004)(107886003)(5660300001)(14454004)(97736004)(81156014)(81166006)(1076002)(8676002)(106356001)(26005)(71190400001)(71200400001)(186003)(8936002)(3846002)(76176011)(25786009)(102836004)(66066001)(6486002)(6116002)(105586002)(4326008)(2351001)(5640700003)(508600001)(52116002)(486006)(6436002)(2900100001)(386003)(44832011)(6506007)(99286004)(5250100002)(476003)(36756003)(2906002)(7736002)(305945005)(2616005)(42882007)(6512007)(316002)(446003)(256004)(6916009)(2501003)(53936002)(11346002)(14444005)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1710;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: is5bTnPpTnsvlgmFxQC5ZXjrRM5jteGoVQ2XbAAR3Whl2n9+yHdbdqinUX/5NDAj8K1NyMJn97BJwtKeKM/gjxTvx8A9bDFluUuPi+t13aI3LP63oFEL6OUzC9nsz9za+tgoiW1NZtSGXJHbz9+iylAo3Zw2KVG6DcVlSlgXuhBcZZEWCzXrSsaVC94qN5v2uVwG4NbUx15zf5SpW0lK3lgevb9IvwQxLD9Lvg2gOeCwx67zizNXry5IVllXIWM+/I73xhv1udjSgt6md1ogNujKvoiRgnC9WAQV7n9wuYrTvUe8qMn/TWEeOZuhiU/oQOMbV2AtglFcIH6r92jQZXmaKUJcelCEMR3f3sEVRqE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7118d6c-c3b5-4e95-9756-08d632ccb033
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 18:33:23.3986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1710
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66854
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

asm/asm.h provides PREF(), PREFE() & PREFX() macros which are now
entirely unused. Delete the dead code.

Signed-off-by: Paul Burton <paul.burton@mips.com>

---

 arch/mips/include/asm/asm.h | 36 ------------------------------------
 1 file changed, 36 deletions(-)

diff --git a/arch/mips/include/asm/asm.h b/arch/mips/include/asm/asm.h
index 74b1c6fd8277..c23527ba65d0 100644
--- a/arch/mips/include/asm/asm.h
+++ b/arch/mips/include/asm/asm.h
@@ -103,42 +103,6 @@ symbol		=	value
 8:		.asciiz msg;				\
 		.popsection;
 
-/*
- * MIPS IV pref instruction.
- * Use with .set noreorder only!
- *
- * MIPS IV implementations are free to treat this as a nop.  The R5000
- * is one of them.  So we should have an option not to use this instruction.
- */
-#ifdef CONFIG_CPU_HAS_PREFETCH
-
-#define PREF(hint,addr)					\
-		.set	push;				\
-		.set	arch=r5000;			\
-		pref	hint, addr;			\
-		.set	pop
-
-#define PREFE(hint, addr)				\
-		.set	push;				\
-		.set	mips0;				\
-		.set	eva;				\
-		prefe	hint, addr;			\
-		.set	pop
-
-#define PREFX(hint,addr)				\
-		.set	push;				\
-		.set	arch=r5000;			\
-		prefx	hint, addr;			\
-		.set	pop
-
-#else /* !CONFIG_CPU_HAS_PREFETCH */
-
-#define PREF(hint, addr)
-#define PREFE(hint, addr)
-#define PREFX(hint, addr)
-
-#endif /* !CONFIG_CPU_HAS_PREFETCH */
-
 /*
  * Stack alignment
  */
-- 
2.19.1
