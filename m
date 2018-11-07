Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2018 00:15:10 +0100 (CET)
Received: from mail-bl2nam02on0095.outbound.protection.outlook.com ([104.47.38.95]:33683
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992928AbeKGXOdloYUU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Nov 2018 00:14:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UFxFzi4nRPxBYlEFGylVL5ZzzHSWbUfwym1b5fQSJ8=;
 b=YaUR/TX5TXHZ4VCxgMT60WE2zmJNRHc4lBDMVgrkV0SGwG9+2hfjpRi6C/FMJfIPMDMnYGvq2mZivpREjkj3L+1g2b9XZhJcWX6UZLmAlxwcwUTV/8V9Q0fTNKNZi8afe4EvPqGV/ooZnAl3mYtyaStaJspm1vORqaA4GuzPbfA=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1581.namprd22.prod.outlook.com (10.174.167.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Wed, 7 Nov 2018 23:14:09 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 23:14:09 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 16/20] MIPS: Avoid FP ELF checks when CONFIG_MIPS_FP_SUPPORT=n
Thread-Topic: [PATCH 16/20] MIPS: Avoid FP ELF checks when
 CONFIG_MIPS_FP_SUPPORT=n
Thread-Index: AQHUdu+Wc9EPCdRBLkCu2QC/fRFE6g==
Date:   Wed, 7 Nov 2018 23:14:09 +0000
Message-ID: <20181107231341.4614-17-paul.burton@mips.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1581;6:PRxA6o+uW/zFj9rq58l+jrVA/FRilh4boAcjUgu6z7mNxkz5buSt0uriBOJDxWDxs5P9puzmnDeZWKfsDkGnMJLZW6a0hzGMZGkfmcIndJO4/v9iLoqHueXlD9QRgT5+qE4CjRnDaf7JKpEpNyaAJSnTm7zzU7FKvYIJydBT2ZzCTWOGRmhA8/2sdbnUFzlFP4QfKsoeSeh8p5Qd/751lp+CXH9VmRmIGgcDycG55ZYrZ23su3ykZumiYu+PZzNOrLTJUtjSxaOyxBqyRnjOCFJBi+v06buHna4W6FtmHGUtr/FpdhCrxBBJkfKMA2OLF6anQFAeQHh/rzIp84r7kTmzEe4NDc2ZBOjxfDA31NxchJ6d0D7KkBDIqGNXc71hw1RQBZ1GChWI1e9Vqbs/x4T8x5etJnpE1+Wqnp0dkmdlYym3s6fQgl53SROj06ZnTNRbLNZtiFfJTtTzIW5wNQ==;5:U1UBJWFB8yFR5k4Q4NtIJaonw1MM+fMLGi6mee4+OI65lmq+obYO7Cp8bWpTDfKZTNJ0YnUjcNByOJzGttCDXectOSXExONIudgEXaBufHdPHBwRrugBj6NqDLbHwgMHkiKN7r8I3YXIH1q9yYv8tN3LPAqjjlO5hnuQwtiwkbo=;7:8mtAs0QaBcBnxTP8+EMytTAPQZm29JKl07snWZy/MHfrU9vUAc/E+lYOx5eyOBRW1x3VYuQQZWwbznDRyG8kvAj/lutIZ3/s7vYaNgrLt7wyipUMHz3yLS/7Am+OL9V3HF1WsYX6J/aDj42KQHYhYQ==
x-ms-office365-filtering-correlation-id: e555e300-982d-41f9-ec71-08d64506b885
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1581;
x-ms-traffictypediagnostic: MWHPR2201MB1581:
x-microsoft-antispam-prvs: <MWHPR2201MB1581CF8C047D9B01F62E2E2CC1C40@MWHPR2201MB1581.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(10201501046)(3002001)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1581;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1581;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(396003)(136003)(376002)(346002)(189003)(199004)(14454004)(99286004)(6486002)(97736004)(36756003)(66066001)(68736007)(486006)(446003)(105586002)(11346002)(2906002)(2616005)(476003)(6116002)(44832011)(1076002)(3846002)(2351001)(106356001)(53936002)(6512007)(6436002)(5640700003)(256004)(7736002)(25786009)(71200400001)(26005)(305945005)(386003)(186003)(6916009)(42882007)(6506007)(2501003)(76176011)(71190400001)(52116002)(5660300001)(8936002)(8676002)(316002)(4326008)(81166006)(508600001)(2900100001)(107886003)(102836004)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1581;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0vPAVtbbm02NKs6aLShct6uQ3DPe+8YBn6pqOxWaYqkPAtX/HZ+ZdHbD/tvq85eqZRSu/Ycl0rL0qg4T7Cp4/TSuaEOWMyLWa+CPCQ3csRt9Bh3s9qNTeX2lW102lEsNMwnyQlCOzO0cW5fENRMQgBqm3J1zHU3osMshh607NT6FDNon5XRoXAMV9RnES95YMFeRYYrU15kqBnNz/lZ7pjtCrFUjcwmiJmmjlp8DAe3WDJVyBQ1MWKJDd6x3i+P7mwjVARfHeo5jjzn7Ei6sGhSPIPRWIDS1EOrtL4n+6217cauXgp83eNT0igt/DcHBd478AcwgwTapVz7A1De0CH9iaVUi4K3Wo4mlHkTE2Io=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e555e300-982d-41f9-ec71-08d64506b885
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 23:14:09.1151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1581
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67151
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

When CONFIG_MIPS_FP_SUPPORT=n we don't support floating point, so we can
avoid needless checks of ELF headers specifying the FP ABI or NaN
encoding to use. Deselect CONFIG_ARCH_BINFMT_ELF_STATE in this case to
avoid the need for our arch_elf_pt_proc() & arch_check_elf() functions,
and stub out the mips_set_personality_nan() & mips_set_personality_fp()
functions such that SET_PERSONALITY() doesn't need to worry about any of
this.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/Kconfig           |  2 +-
 arch/mips/include/asm/elf.h | 26 ++++++++++++++++++++++----
 arch/mips/kernel/elf.c      |  4 ++++
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 7736f9e004e7..2b3891c45461 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2,7 +2,7 @@
 config MIPS
 	bool
 	default y
-	select ARCH_BINFMT_ELF_STATE
+	select ARCH_BINFMT_ELF_STATE if MIPS_FP_SUPPORT
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_DISCARD_MEMBLOCK
 	select ARCH_HAS_ELF_RANDOMIZE
diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index 0eb1a75be105..f8f44b1a6cbb 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -481,6 +481,8 @@ struct linux_binprm;
 extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 				       int uses_interp);
 
+#ifdef CONFIG_MIPS_FP_SUPPORT
+
 struct arch_elf_state {
 	int nan_2008;
 	int fp_abi;
@@ -497,19 +499,35 @@ struct arch_elf_state {
 	.overall_fp_mode = -1,			\
 }
 
-/* Whether to accept legacy-NaN and 2008-NaN user binaries.  */
-extern bool mips_use_nan_legacy;
-extern bool mips_use_nan_2008;
-
 extern int arch_elf_pt_proc(void *ehdr, void *phdr, struct file *elf,
 			    bool is_interp, struct arch_elf_state *state);
 
 extern int arch_check_elf(void *ehdr, bool has_interpreter, void *interp_ehdr,
 			  struct arch_elf_state *state);
 
+/* Whether to accept legacy-NaN and 2008-NaN user binaries.  */
+extern bool mips_use_nan_legacy;
+extern bool mips_use_nan_2008;
+
 extern void mips_set_personality_nan(struct arch_elf_state *state);
 extern void mips_set_personality_fp(struct arch_elf_state *state);
 
+#else /* !CONFIG_MIPS_FP_SUPPORT */
+
+struct arch_elf_state;
+
+static inline void mips_set_personality_nan(struct arch_elf_state *state)
+{
+	/* no-op */
+}
+
+static inline void mips_set_personality_fp(struct arch_elf_state *state)
+{
+	/* no-op */
+}
+
+#endif /* !CONFIG_MIPS_FP_SUPPORT */
+
 #define elf_read_implies_exec(ex, stk) mips_elf_read_implies_exec(&(ex), stk)
 extern int mips_elf_read_implies_exec(void *elf_ex, int exstack);
 
diff --git a/arch/mips/kernel/elf.c b/arch/mips/kernel/elf.c
index 731325a61a78..72056d54a2b8 100644
--- a/arch/mips/kernel/elf.c
+++ b/arch/mips/kernel/elf.c
@@ -16,6 +16,8 @@
 #include <asm/cpu-features.h>
 #include <asm/cpu-info.h>
 
+#ifdef CONFIG_MIPS_FP_SUPPORT
+
 /* Whether to accept legacy-NaN and 2008-NaN user binaries.  */
 bool mips_use_nan_legacy;
 bool mips_use_nan_2008;
@@ -326,6 +328,8 @@ void mips_set_personality_nan(struct arch_elf_state *state)
 	}
 }
 
+#endif /* CONFIG_MIPS_FP_SUPPORT */
+
 int mips_elf_read_implies_exec(void *elf_ex, int exstack)
 {
 	if (exstack != EXSTACK_DISABLE_X) {
-- 
2.19.1
