Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2018 00:16:11 +0100 (CET)
Received: from mail-eopbgr740095.outbound.protection.outlook.com ([40.107.74.95]:44352
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991923AbeKGXOIz8F7U convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Nov 2018 00:14:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=098vLKyBvmNIJhWydtAwL751ieu9WnjUK5m2lDxQMzA=;
 b=Z0AjkiceT/EzN2kIyIAiboRVSiMdjlA8qB5akD+nA/emg6KP8R7Y8DqwWCHcMqJfxL4qfMZasBzOGTvdgLeVZXM7DHk0h0IJhhTMpB9YDVmITf25S/GrBOb7HGqVFfad6vM/K//s4qNEd4pFaKQQ79QiHIguAZqd9PUeJdBgd1c=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1566.namprd22.prod.outlook.com (10.172.63.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Wed, 7 Nov 2018 23:14:05 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 23:14:05 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 10/20] MIPS: cpu-probe: Avoid probing FPU when
 CONFIG_MIPS_FP_SUPPORT=n
Thread-Topic: [PATCH 10/20] MIPS: cpu-probe: Avoid probing FPU when
 CONFIG_MIPS_FP_SUPPORT=n
Thread-Index: AQHUdu+Tpx2ywEprc02gqPUIuHInjQ==
Date:   Wed, 7 Nov 2018 23:14:05 +0000
Message-ID: <20181107231341.4614-11-paul.burton@mips.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1566;6:LC4TLZNemgvORK/O+6JBtE/WEVUV6ElS6Kn/I2jRi4BeDnh15AeSKVmslz9nWaf4+dtJHVle2WjajK9pWV7Gnw2J6DSbq6TyZgW998FT9Q4scnFdfEpajqx9q57PqNMfLmGJW1HEJMI/l5hR1vnaccXq4QYPIbk7pnzxx//N8AcePjHyuuRkkhZx3NyG/RAPE3QwKskJQGzAlxw6TNWJzrOD1CsrBbZRhz1disqCPGCnvKdHQKKN7vrqx0287W50tyOfX1vGCZAthgMjNGlf0tuPrxA2IDswafTIK8pVrTFJzHf/Vd67OZa/yD64wdIhttik2uQPFHQwd8xzJVJ5NyJ8sSO69MHZufYBRrF/ZjLZBJcBSceiZu4JmhSeFr/xsFZvBR5ECLXnr0TSsBW1bDxOWEKvjbCjMrGn9YPW/u6gzLgKJsjoYQ2Y5O/8eL5by7lmOQYXfCvdfkATJ8Z09w==;5:HkQqli60QN3eOfl9OtVIGT8i+4Msk4PyiOAnKitSGm82xQDV8x0Y8QUnkOL4L28swl01Z8zOed/JLVOUvo4ljQxRqaUVOEd6HFxSLJZCr8JJg2oOq5K8hY61MFWvT80EX3ey2ZiNlpwqDtR2wcSmeopzy1Zgz+MslxXeAptu540=;7:qv7W9PvZQiQUv986xbn22V0CxOmujwxQ7W2yBU4zFBDZ8tcIKdVaJfDSZDURSAGkysxy3pUWgEC+hgdgS50yGwATzKuL6Utv1VZTjDZFwuhGmXd8sNDQm8a6E5JiTcovYlDDO5St3P+H/c1P7bsiDQ==
x-ms-office365-filtering-correlation-id: c93b4b80-3e97-45bb-7b8e-08d64506b653
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1566;
x-ms-traffictypediagnostic: MWHPR2201MB1566:
x-microsoft-antispam-prvs: <MWHPR2201MB1566C89DFB35A8B1D73B7269C1C40@MWHPR2201MB1566.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3231382)(944501410)(52105095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1566;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1566;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39840400004)(136003)(199004)(189003)(66066001)(2501003)(386003)(6512007)(53936002)(8936002)(6486002)(81156014)(81166006)(2906002)(3846002)(25786009)(6436002)(6116002)(71200400001)(102836004)(2900100001)(5640700003)(97736004)(1076002)(99286004)(476003)(4326008)(106356001)(186003)(42882007)(52116002)(105586002)(6916009)(71190400001)(2351001)(44832011)(36756003)(76176011)(6506007)(107886003)(508600001)(8676002)(68736007)(305945005)(316002)(5660300001)(11346002)(2616005)(14454004)(26005)(256004)(14444005)(486006)(446003)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1566;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1RHclQYhPoXqmrzut9lliuK7hAys1cXkx7u3OKsktaWZ6NKbx6ilEmRYOR3Ery69XvrKl6hFzQTwBQFhkQDuq+HJ4mmm7WaqtYyaRM3c3JUJXLR4GUL7z8jiCsCDSIW7fSSSJHVn0kyOFG7szVHMvvaHhheeGWLGuaL7zm0THpkd+sjo3bqB1xMovOhqqAfU1KDoCgH4xR71iP30irLm3MJeZHwkJCuKziJZoz489DAWVDQ+bgT/HPb0ikvsdw44slDY5O64Hvzpx6zjSRrIyr4kU1RyeS+shlf/VDXaBBAfCOsbywlD8jqLMTVmXWzCFDsOlghT0i/qCmQOHg720sQBEZo6LM6vVaeQ4OuIKIU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c93b4b80-3e97-45bb-7b8e-08d64506b653
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 23:14:05.3160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1566
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67155
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

When CONFIG_MIPS_FP_SUPPORT=n we don't support floating point so there's
no point in attempting to detect an FPU. Avoid doing so.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/kernel/cpu-probe.c | 54 +++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 13 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index d535fc706a8b..71dcef851ca0 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -36,6 +36,8 @@
 unsigned int elf_hwcap __read_mostly;
 EXPORT_SYMBOL_GPL(elf_hwcap);
 
+#ifdef CONFIG_MIPS_FP_SUPPORT
+
 /*
  * Get the FPU Implementation/Revision.
  */
@@ -58,19 +60,6 @@ static inline int __cpu_has_fpu(void)
 	return (cpu_get_fpu_id() & FPIR_IMP_MASK) != FPIR_IMP_NONE;
 }
 
-static inline unsigned long cpu_get_msa_id(void)
-{
-	unsigned long status, msa_id;
-
-	status = read_c0_status();
-	__enable_fpu(FPU_64BIT);
-	enable_msa();
-	msa_id = read_msa_ir();
-	disable_msa();
-	write_c0_status(status);
-	return msa_id;
-}
-
 /*
  * Determine the FCSR mask for FPU hardware.
  */
@@ -326,6 +315,45 @@ static int __init fpu_disable(char *s)
 
 __setup("nofpu", fpu_disable);
 
+#else /* !CONFIG_MIPS_FP_SUPPORT */
+
+#define mips_fpu_disabled 1
+
+static inline unsigned long cpu_get_fpu_id(void)
+{
+	return FPIR_IMP_NONE;
+}
+
+static inline int __cpu_has_fpu(void)
+{
+	return 0;
+}
+
+static void cpu_set_fpu_opts(struct cpuinfo_mips *c)
+{
+	/* no-op */
+}
+
+static void cpu_set_nofpu_opts(struct cpuinfo_mips *c)
+{
+	/* no-op */
+}
+
+#endif /* CONFIG_MIPS_FP_SUPPORT */
+
+static inline unsigned long cpu_get_msa_id(void)
+{
+	unsigned long status, msa_id;
+
+	status = read_c0_status();
+	__enable_fpu(FPU_64BIT);
+	enable_msa();
+	msa_id = read_msa_ir();
+	disable_msa();
+	write_c0_status(status);
+	return msa_id;
+}
+
 static int mips_dsp_disabled;
 
 static int __init dsp_disable(char *s)
-- 
2.19.1
