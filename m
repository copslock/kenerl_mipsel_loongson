Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2018 00:14:19 +0100 (CET)
Received: from mail-eopbgr680128.outbound.protection.outlook.com ([40.107.68.128]:31840
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992871AbeKGXOEqV7SU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Nov 2018 00:14:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDEgBA8mk2Y62QChgCZGKED27qfuCTLr8zsbcoujf4c=;
 b=I6wNbClCBVhP4MbZ5aRijH6EPLZmj9WUu8CRwxadGr2TTI5zRElCFzASX6UcdNNXG0LHViyEjVFgFfBmJVJe9YfZ2M+Wol3dmE9q4of/ywk/gr/C0WwSzfG9o3dy+O5RKPKvex/y2/1pgaNXMWEFdVznRxHGkXg+tk09jlqQ/fo=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1472.namprd22.prod.outlook.com (10.174.170.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Wed, 7 Nov 2018 23:14:03 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 23:14:03 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 07/20] MIPS: Introduce CONFIG_MIPS_FP_SUPPORT
Thread-Topic: [PATCH 07/20] MIPS: Introduce CONFIG_MIPS_FP_SUPPORT
Thread-Index: AQHUdu+S9OtUP1m8VES9cLAEc/Or3A==
Date:   Wed, 7 Nov 2018 23:14:02 +0000
Message-ID: <20181107231341.4614-8-paul.burton@mips.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1472;6:Op+oVAGUK4CZnKiYqAD0TLjDUICHDz0YsOPbacoC1CQciG0evilk2MzIHaLkI1qQAE084lQ05I3ctNxefNhpEWQpX5UAAF7p2hfpGD1gdQFtSWfTUaWpjQCGoZsMbV6dcE1FsfCedlbuiZ8gUrgWVfV7RJPDPU9aSmSIxOYVH1S8xG6lcvG14oDuFb9LBxfDOO6hR2UP4MDMI5YdCjlNW83KTiLItua1WGV6q7rpO7uDWVh1Sx0u+ZsVwXD38OkQCtO5wIr+ZZYdRHUa1j+f2KsrDzS7wk+7fN5L3rBiQsARf8VqIF3UrX6bfNIi56fuElzmtHjyM8FE4cCDGMiumEvoKwJrhBxXo6yQdZ366Sx/RmZJdrGhmI9groX8XQRKwq1p0P8xP1azjvxmRpIWuclA1UNfazrrYZLVMe++qxJZbJ+eXrixJG4oTPyNpzCAj5k2KthJ4WNiEWfnrdZE8A==;5:sSAsZHTXgbBElRKIKVFgj7XkEepx4sJ6wbfDHMnYxyJwRg14cHWN0qj1mOGzXwZBJuwIr6ZHo/79PfdiUptWEdWoTsv/o3JdIsZBQECQfKv/JyR9VHyvYNvjrrtDMgfHosAqK/wvGzkmRVdrwzwietCOiE0eqq/zDnj4vCS3COo=;7:smb6vsH0M+KHVLHjk3yX5rXtrjeb904hoBd7SBg1AQUqrct+MWS3l26qJ3bXRA93EEJQK5vPdepUf5UIH1JD/pJV/5jMPmXusaoFiHo48xy/nti8e9qO2yhTG1CEeMDuF1QSMoVE6lo1Z1vBwAW88A==
x-ms-office365-filtering-correlation-id: 839052c4-182a-4f81-6514-08d64506b4b6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1472;
x-ms-traffictypediagnostic: MWHPR2201MB1472:
x-microsoft-antispam-prvs: <MWHPR2201MB1472373E755632CC27132063C1C40@MWHPR2201MB1472.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(3231382)(944501410)(52105095)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1472;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1472;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(136003)(376002)(39840400004)(189003)(199004)(99286004)(52116002)(256004)(26005)(186003)(386003)(76176011)(446003)(11346002)(102836004)(44832011)(476003)(2616005)(486006)(7736002)(5640700003)(2906002)(6506007)(6512007)(71200400001)(6436002)(71190400001)(316002)(2501003)(14454004)(8676002)(81156014)(97736004)(3846002)(6116002)(25786009)(8936002)(1076002)(81166006)(2900100001)(6916009)(6486002)(36756003)(66066001)(53936002)(305945005)(68736007)(107886003)(508600001)(5660300001)(4326008)(42882007)(2351001)(105586002)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1472;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WyFXwLm8jGT21g8aK9skT1cAUcStaxobnathn1C6RpX0bjXmI7zMWtpu9bzibgO4CeLl75vaeEpX2nCF1c/CBSLu+7jx6hmpWm9c7jRzARiK2MwOoXzXEQCzBWhkshi5JpZ2am71vfsg0DIsD98FrSvWsdUXvVtLQAl8MPz17soQ+l9RpskU69FA4eXgliT1x9TRksoxZfKpnb3oJ+UZuCn/BcapapjAEtms7BRX+zBTOxHwVCNdg60cZyd41sD5j8tRe/a05fV/S9vWRRaHyyDtSvuXLdPXzGOe16TmmbyOw3FzBysS8cWv+Urbf+1a9ar9DzGuq1MzfT/emV4mH5xRHKO5Uo1k3OwSfLO75+0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 839052c4-182a-4f81-6514-08d64506b4b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 23:14:02.9201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1472
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67143
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

Introduce a Kconfig variable that will indicate whether to include
support for floating point in the kernel. For now this is always
enabled, and will be made configurable in a later patch.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/Kconfig     | 7 +++++++
 arch/mips/kvm/Kconfig | 1 +
 2 files changed, 8 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index f69779491868..7736f9e004e7 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2254,12 +2254,17 @@ config CPU_GENERIC_DUMP_TLB
 	bool
 	default y if !(CPU_R3000 || CPU_R8000 || CPU_TX39XX)
 
+config MIPS_FP_SUPPORT
+	def_bool y
+
 config CPU_R2300_FPU
 	bool
+	depends on MIPS_FP_SUPPORT
 	default y if CPU_R3000 || CPU_TX39XX
 
 config CPU_R4K_FPU
 	bool
+	depends on MIPS_FP_SUPPORT
 	default y if !CPU_R2300_FPU
 
 config CPU_R4K_CACHE_TLB
@@ -2312,6 +2317,7 @@ config MIPS_MT_FPAFF
 config MIPSR2_TO_R6_EMULATOR
 	bool "MIPS R2-to-R6 emulator"
 	depends on CPU_MIPSR6
+	depends on MIPS_FP_SUPPORT
 	default y
 	help
 	  Choose this option if you want to run non-R6 MIPS userland code.
@@ -2459,6 +2465,7 @@ endchoice
 config CPU_HAS_MSA
 	bool "Support for the MIPS SIMD Architecture"
 	depends on CPU_SUPPORTS_MSA
+	depends on MIPS_FP_SUPPORT
 	depends on 64BIT || MIPS_O32_FP64_SUPPORT
 	help
 	  MIPS SIMD Architecture (MSA) introduces 128 bit wide vector registers
diff --git a/arch/mips/kvm/Kconfig b/arch/mips/kvm/Kconfig
index 76b93a9c8c9b..760aec70dce5 100644
--- a/arch/mips/kvm/Kconfig
+++ b/arch/mips/kvm/Kconfig
@@ -18,6 +18,7 @@ if VIRTUALIZATION
 config KVM
 	tristate "Kernel-based Virtual Machine (KVM) support"
 	depends on HAVE_KVM
+	depends on MIPS_FP_SUPPORT
 	select EXPORT_UASM
 	select PREEMPT_NOTIFIERS
 	select ANON_INODES
-- 
2.19.1
