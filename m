Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2018 00:14:06 +0100 (CET)
Received: from mail-eopbgr680125.outbound.protection.outlook.com ([40.107.68.125]:11886
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992872AbeKGXOAArnpU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Nov 2018 00:14:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7UnU2S7HcFSRQ7L24dWHiSl886kBYLfjeE2NxCdWu4=;
 b=nNMQEW0oIK1GgrJWC23zdnIEu71KHfTg5SZOnAVpxfy+aY5ujNyfG78Bk0vvWeAYpuxGTjM6nCDWycPJ0vHFBx2t+Vt3tNzjYtD2yEx831dE8/6Mo61DR3mX6je72fBKYKrprT7EndYyLvWosdAEB70S6T/WnfQ/R+/Y7ZMY8gk=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1472.namprd22.prod.outlook.com (10.174.170.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Wed, 7 Nov 2018 23:13:58 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 23:13:58 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 01/20] MIPS: Hide CONFIG_MIPS_O32_FP64_SUPPORT prompt for >=
 MIPSr6
Thread-Topic: [PATCH 01/20] MIPS: Hide CONFIG_MIPS_O32_FP64_SUPPORT prompt for
 >= MIPSr6
Thread-Index: AQHUdu+P+S/tY3KDjkukEGNxk4RKkA==
Date:   Wed, 7 Nov 2018 23:13:58 +0000
Message-ID: <20181107231341.4614-2-paul.burton@mips.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1472;6:6aex2aXhpO6ZEwOoF0iiV7Op6L2iVBW5cXTHV/oVgK3PHsEJeGtAXiqhJtQKl4zi1t52W6gsHqKRfA6sfMakGuYkI+MkwBSWsQ2ox5tqvLerF9/0ID0AmmJUs1m9lovCFsT75XnGqlb+I3yLE+GOqcFKvdGnD1Je7D867bywjE5OSGrfznMDXFRkd2OoL0FakI3B0ro3EaMw/vi/Rg/6ndovRpqR2eDqEtXNlR4oXtU4KxFX/TbUMEL+5vm8YTpkLOP7oxDxefJNPFH+wAkau3D+IQzFDAhMIuS4ceIKY/twiXtFenvuQCdwUWeYYi8XqtHxiG/OT9BxPcTo/FDKmsdpLacPFjjaHvoGbDb57qrY2eCObwzc3IVr4DQrh5RI7aF0a3KJ72dLcs0CNCkhvDU24Fa2aJ/6iFvGNlzHrwf325OVWzwph+YR2EH5U/QqrGV+7qMrDbzrq482XZlNLQ==;5:kI45H6s+doZpgcv1JNe5taq7wdRxGbjfpe04JMlNyfRKbUiwGfsMc4MZQvac42x3o3zrTcKdQxK345DiPKnVInbuBAD3cojHzqFXLuAKt8sEv3SUrX/umodeD7rewQryLYg7K4SDkOxjIItakXUJQTjHSoo+2C/ibK6AJPqfDCU=;7:oGBlGT0DwQ/0fOP39K1irRcftlBPV3PavoyOA1T8t1NL4LeqXnCq3KzKkiyIF6lcBDDtp9+zlaKNqurO+16f59vWgm7iEfknOnNnrSQBohAVOIavdpy4Am+27/osaNjkMraQZWI3pUQFMQe4Val3Hw==
x-ms-office365-filtering-correlation-id: a7855d10-8015-4a66-7bd4-08d64506b21d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1472;
x-ms-traffictypediagnostic: MWHPR2201MB1472:
x-microsoft-antispam-prvs: <MWHPR2201MB1472FCA6E4D2BAC9DF342356C1C40@MWHPR2201MB1472.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(3231382)(944501410)(52105095)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1472;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1472;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(136003)(376002)(39840400004)(189003)(199004)(99286004)(52116002)(256004)(14444005)(26005)(186003)(386003)(76176011)(446003)(11346002)(102836004)(44832011)(476003)(2616005)(486006)(7736002)(5640700003)(2906002)(6506007)(6512007)(71200400001)(6436002)(71190400001)(316002)(575784001)(2501003)(14454004)(8676002)(81156014)(97736004)(3846002)(6116002)(25786009)(8936002)(1076002)(81166006)(2900100001)(6916009)(6486002)(36756003)(66066001)(53936002)(305945005)(68736007)(107886003)(508600001)(5660300001)(4326008)(42882007)(2351001)(105586002)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1472;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xlrBtX3iDniSR5WsioclL9HjWNA7DUx/qTJuBkumKhibRA9cgET6FQiV7DFa9mAUYLpftu/KiBOb8ZTxcMT9XxBlx+eR5N3HPj6Np5OmfHGJauW87AKN9Kb79evfDzrtDSujn8rp0x3zvCIZIC+fSbvcXtedKbzWMeG3ibpJuNMpZt5a8lMo4mSqSkJhubOaWMefhKjmBfYpGOEAKHySDMGT4846d4K5h9PE4NK0qrPWCAQ6Sc7N0fFOK9AojqA5JGhrIzgaANq0oMPJcEjMNQ7Ju7D49vCuzmrXWXIBbRrH2KBBHOXrheur3+pWXkK1B+w3g249RIyqzQg58ffKwv8dBOyqhw74/fTkw10q3E0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7855d10-8015-4a66-7bd4-08d64506b21d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 23:13:58.3093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1472
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67137
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

From MIPSr6 onwards FP64 support is mandatory, and so
CONFIG_MIPS_O32_FP64_SUPPORT is always selected for configurations which
support O32 binaries. Hide the useless unchangeable prompt in these
cases.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8272ea4c7264..cf0f5a55a0a4 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2902,7 +2902,7 @@ config SECCOMP
 	  If unsure, say Y. Only embedded should say N here.
 
 config MIPS_O32_FP64_SUPPORT
-	bool "Support for O32 binaries using 64-bit FP"
+	bool "Support for O32 binaries using 64-bit FP" if !CPU_MIPSR6
 	depends on 32BIT || MIPS32_O32
 	help
 	  When this is enabled, the kernel will support use of 64-bit floating
-- 
2.19.1
