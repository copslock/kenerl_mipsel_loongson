Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2018 20:26:31 +0200 (CEST)
Received: from mail-eopbgr720100.outbound.protection.outlook.com ([40.107.72.100]:45312
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990947AbeJOS0Wjiob2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Oct 2018 20:26:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qiykc6uRH6hbdkCgt7xAeeZa+/vOHjXW50KR+wbIrvk=;
 b=opeq3F+GJObGWjAhUVbqZTi/ab1o64Vdcq1ZupS03uuosTsE1AXLt6dfqcQ4CEGHGVGpScyxbdAd/NLKbLHAI1OnuGSzHGAjmyQ03ytMgEkPKKST9PmRkFbzzV6oA13fHOGRFh5UK/QUT0EJEvbWbqkhGQdplsuCptz9BUFPDVs=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1199.namprd22.prod.outlook.com (10.174.169.162) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.26; Mon, 15 Oct 2018 18:26:12 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::781f:63:481a:efdf]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::781f:63:481a:efdf%10]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 18:26:12 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH] MIPS: Cleanup DSP ASE detection
Thread-Topic: [PATCH] MIPS: Cleanup DSP ASE detection
Thread-Index: AQHUZLSNncF1I35ZS0mNMRNssfFMmg==
Date:   Mon, 15 Oct 2018 18:26:12 +0000
Message-ID: <20181015182600.15423-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR13CA0044.namprd13.prod.outlook.com
 (2603:10b6:300:95::30) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1199;6:HI5L7l6hSDBpHAZPQYqWzGWgYvucAbSDPSEK6SwTsBzaadKA7muu+EF1fYnl51uqac0aUAW5HuO918IUSZwuL5h4EuFI2WYK545O2lE5GemyCbpK9+xnzkTmvyo/7SA0JlXLb9R4akC67mEqz4mRaqzkd5AKNd67YgFhG46iyf2Pqy2+CzpcFk2YtM3AXTHpzSLP9fcAlSLaon2I9kZKZ2vu7OfCgym04goIpEm60+uGcpPw5CqnkjeWn0OiNdj63zG070vgmI8iM1jKH7QQsegwze4/qsOC1NttF1AsM5dLKWACIRxUCbSL747cqzBOjy5IJPZNHBDXk6djmh2SZ/fzXWAjmQfmtm9poZMy5lP9+mBC4h36NGBjVXY9+Q7+NZZYx9EQ2AXGi2XodVtaIKWd5U4/ri74Z4gbtgwWqt30EnvcaUWwb/c/QJriqFZLUTWcgG2OPxoOhDlf8W87Eg==;5:GOgC5JHMya+Z3cCwrNSJw7dxKKq9ZA2yZvlb3uLcfqVruRqIDVX48JVydLXYC5uQ7E9xK9O/6uRK0WqY+S4PDXOy6NF8D8d7wfzz5KFTmkHU+LALE8X6KXOdCAFYT9tmIh3nsaaiLWzKP2kvz2WqEMCB+WRHzqp8ZcTf4JsrRwk=;7:GpFW5l74pkJhYnQaziJPRgkcfum2nl0/Kx+z5fwiAKiMhMxB2n5wxwdCTfDpjmKpQ0wtWQnhY0sz8RQd2vFiDjeXhua4cXGSZrQ0nchy30g0YPD6yBZt1fi1MmxYO5eFOdOhqOyJ5pVth7OdHK9nLXdMiDQerJNGyJHiBHCPUgObj8diFdoh/dFHN2QygPGPoFYP21/9+g37FNpQfGQS2kgajHXSWrQTZEYBr8LE39y22a5jLGYldtp9icjKOsOj
x-ms-office365-filtering-correlation-id: 396e72a5-927d-49b9-1824-08d632cbaf1a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1199;
x-ms-traffictypediagnostic: MWHPR2201MB1199:
x-microsoft-antispam-prvs: <MWHPR2201MB11998DE29B83D0D4F40A8FC4C1FD0@MWHPR2201MB1199.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(10201501046)(3231355)(944501410)(52105095)(3002001)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(2016111802025)(20161123560045)(6043046)(201708071742011)(7699051)(76991067);SRVR:MWHPR2201MB1199;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1199;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(396003)(366004)(39840400004)(346002)(189003)(199004)(1076002)(2900100001)(3846002)(6116002)(71190400001)(97736004)(71200400001)(508600001)(36756003)(5250100002)(2351001)(2501003)(105586002)(106356001)(14454004)(4326008)(25786009)(107886003)(81166006)(486006)(7736002)(305945005)(42882007)(6506007)(386003)(44832011)(5640700003)(53936002)(26005)(476003)(186003)(102836004)(52116002)(81156014)(6436002)(316002)(99286004)(68736007)(6916009)(256004)(8676002)(8936002)(217873002)(1857600001)(6486002)(6512007)(66066001)(2906002)(2616005)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1199;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: t49GVpkTO3dI/mEBtczBLgsVsI+LQ81rvdAlxJDy7SpQ0eu7Rc8tQCgfas/Olf+L7ykWZ7EdoxpanprkH7Ll/xszCqCVyS8HTibZbCS1BZp6lrsyWRzwDtcrg+RnNmMlnLxlZK2KNNUq5kobOWk1ZtoVEJuJ58fA4EL1GpwwrJX6DrQxvkR30swDE+tbB9HrFL8z8wn0f/4BQoNXdLjnbb7IbXX81SVCm2pqqevLg8LYc0AlxA+YU7i6b5FgYRDU6ntdLy9Fp+6Yl3mmrqTR0XALhAUkgr+cw4sC3MAWJAJq/fFdkmWhyPRGn/FU8HNINYka0Q2dPi3D2DwikR+DQPT5wsWFHBNQewz5ZQpeUmM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 396e72a5-927d-49b9-1824-08d632cbaf1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 18:26:12.4632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1199
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66847
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

Currently we hardcode a list of files for which we specify that the
toolchain has DSP ASE support when building for MIPSr2 only. This has a
number of problems:

  1) It doesn't actually ensure that the toolchain supports the DSP ASE
     at all.

  2) It's fragile if we try to use DSP ASE macros in other files.

  3) It makes no provision for MIPSr6 & later systems which also support
     the DSP ASE & end up using the .word directive implementation of
     the DSP macros.

Fix this by detecting assembler support for the DSP ASE globally, not
just for a small set of files, and not just for MIPSr2.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---
 arch/mips/Makefile               |  2 ++
 arch/mips/include/asm/mipsregs.h |  2 +-
 arch/mips/kernel/Makefile        | 18 ------------------
 3 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index c28b9bf617d5..a8f8ca8ccf89 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -231,6 +231,8 @@ toolchain-xpa				:= $(call cc-option-yn,$(xpa-cflags-y) -mxpa)
 cflags-$(toolchain-xpa)			+= -DTOOLCHAIN_SUPPORTS_XPA
 toolchain-crc				:= $(call cc-option-yn,$(mips-cflags) -Wa$(comma)-mcrc)
 cflags-$(toolchain-crc)			+= -DTOOLCHAIN_SUPPORTS_CRC
+toolchain-dsp				:= $(call cc-option-yn,$(mips-cflags) -Wa$(comma)-mdsp)
+cflags-$(toolchain-crc)			+= -DTOOLCHAIN_SUPPORTS_DSP
 
 #
 # Firmware support
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index a1187e516e47..2493bda9d03e 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -2287,7 +2287,7 @@ do {									\
 	_write_32bit_cp1_register(dest, val, )
 #endif
 
-#ifdef HAVE_AS_DSP
+#ifdef TOOLCHAIN_SUPPORTS_DSP
 #define rddsp(mask)							\
 ({									\
 	unsigned int __dspctl;						\
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index f10e1e15e1c6..210c2802cf4d 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -113,22 +113,4 @@ obj-$(CONFIG_MIPS_CPC)		+= mips-cpc.o
 obj-$(CONFIG_CPU_PM)		+= pm.o
 obj-$(CONFIG_MIPS_CPS_PM)	+= pm-cps.o
 
-#
-# DSP ASE supported for MIPS32 or MIPS64 Release 2 cores only. It is not
-# safe to unconditionnaly use the assembler -mdsp / -mdspr2 switches
-# here because the compiler may use DSP ASE instructions (such as lwx) in
-# code paths where we cannot check that the CPU we are running on supports it.
-# Proper abstraction using HAVE_AS_DSP and macros is done in
-# arch/mips/include/asm/mipsregs.h.
-#
-ifeq ($(CONFIG_CPU_MIPSR2), y)
-CFLAGS_DSP 			= -DHAVE_AS_DSP
-
-CFLAGS_signal.o			= $(CFLAGS_DSP)
-CFLAGS_signal32.o		= $(CFLAGS_DSP)
-CFLAGS_process.o		= $(CFLAGS_DSP)
-CFLAGS_branch.o			= $(CFLAGS_DSP)
-CFLAGS_ptrace.o			= $(CFLAGS_DSP)
-endif
-
 CPPFLAGS_vmlinux.lds		:= $(KBUILD_CFLAGS)
-- 
2.19.1
