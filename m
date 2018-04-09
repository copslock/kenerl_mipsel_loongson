Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2018 02:33:51 +0200 (CEST)
Received: from mail-co1nam03on0131.outbound.protection.outlook.com ([104.47.40.131]:60385
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994650AbeDIAbcAYaTV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2018 02:31:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=8JKFH0QMMAFtDZyDgyuspuV4dBOhqV769lYoWZHOhzo=;
 b=cC98K+frn0f1nAsIt7jzMAeWtiIV4+n6jLAz+2CiqmgNCYpjGoIsYzB0AUJQm4yqUwxeWT6tXN+l7e7ucArRFeoopRUaEHvlmEite7Td65zV2RAmB72qM2vtn94mo5PNQefHFaPvlGENLAXUzp22KbpLOeFmD3kXqCKl7M5edME=
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com (52.132.128.13) by
 DM5PR2101MB1126.namprd21.prod.outlook.com (52.132.132.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Mon, 9 Apr 2018 00:31:21 +0000
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059]) by DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059%2]) with mapi id 15.20.0696.003; Mon, 9 Apr 2018
 00:31:21 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Goran Ferenc <goran.ferenc@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 175/293] MIPS: VDSO: Add implementation of
 gettimeofday() fallback
Thread-Topic: [PATCH AUTOSEL for 4.9 175/293] MIPS: VDSO: Add implementation
 of gettimeofday() fallback
Thread-Index: AQHTz5k5Io1fjS0igEq/qoH3dQ1mTg==
Date:   Mon, 9 Apr 2018 00:25:11 +0000
Message-ID: <20180409002239.163177-175-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1126;7:f4BEBLN9wfOeByS8+wYh55d9ly7Hbd+cUrC/1CPHjCzBv8Eiuk4u4XnSKMEdiqP4shsNKibhAJJgsImwikzoCUa01kyTpTlZoyCyPIRCNvgXoCsZWYsWpwdiNP2ltPJtzhvF3Pktmd3VLyBf2rjitefRycRILlZBKkUvzibOb/MkBmsSTwElacP4IUgl4alj6kqrZl+965m3GIusb3j/iWOHaLatmfC4JiZGVBJ2fS9xQo/6L/jz1OV5nT2A04Um;20:Egs5B8dX4aRIn2Yw6ryRDMRu6Cu29cxc9U745LRy+liVWlu/5UuRc2enN4GPhpUSnqfoYw931PPARp45yWCQKnu1ZIZPH/S8HnYeCR+cTrDUpApcOZhet+g26fUweAFY2VaHMsDi74sIjY3Uh+gsKUVeAcoupOk2GK9Jnh9KoM8=
X-MS-Office365-Filtering-Correlation-Id: 7000980a-3669-4fe3-89b3-08d59db137c4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1126;
x-ms-traffictypediagnostic: DM5PR2101MB1126:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB112693E574433C357CD221E2FBBF0@DM5PR2101MB1126.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1126;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1126;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(39860400002)(346002)(376002)(189003)(199004)(2616005)(476003)(81156014)(8676002)(81166006)(3846002)(486006)(2900100001)(6436002)(186003)(478600001)(72206003)(110136005)(54906003)(6306002)(2906002)(86612001)(6666003)(2501003)(26005)(10090500001)(102836004)(6512007)(6116002)(14454004)(966005)(5250100002)(10290500003)(1076002)(575784001)(446003)(3280700002)(3660700001)(11346002)(8936002)(25786009)(59450400001)(6506007)(106356001)(4326008)(107886003)(36756003)(105586002)(7416002)(53936002)(86362001)(66066001)(6486002)(99286004)(5660300001)(316002)(22452003)(305945005)(76176011)(97736004)(68736007)(7736002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1126;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6aldkvcvGZjUqlNESMIRFzd4vNhs2TS5PM4EQrBjUXCE7KI6gWPtpWqeRPKI/xdWOPh+2JgB4huIBIOurUIdZcg1KQbpzSClBKJ3ht2nwRYPFiw+qywRXwT7GyhZGSHp4SWYb6OEaNPu4BeE8Cf2yPxS8Tx7zo2c8wi11I0oUDHh73EyxBbD+x4u7W2zmyLEjlOCY22xLJU83tETs+ubTwlPKZPi6JSGQAn0E4FaOFnOB47Zzx0RTQ0mlo74kgrduqT8J/FDQDDosxveEWN2cptxfSY0jWuLCAcmCUIgFrleZOGtsXVkUDy0S0z2mOYI3LO1SDLp/HlxHWsx+Tvq6JLua7W4SNMPupY582UuPIM/D45GqF0nqe+91LJQPlLzOn5cWGFSabwO9hO6ATC87vlAu5kcmjNp2Nv16vFXe4E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7000980a-3669-4fe3-89b3-08d59db137c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:11.9876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1126
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63455
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Alexander.Levin@microsoft.com
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

From: Goran Ferenc <goran.ferenc@imgtec.com>

[ Upstream commit 0b523a85e134d41f57ddd8c5193bd9f0a5e20b0d ]

This patch adds gettimeofday_fallback() function that wraps assembly
invocation of gettimeofday() syscall using __NR_gettimeofday.

This function is used if pure VDSO implementation gettimeofday()
does not succeed for any reason. Its imeplementation is enclosed in
"#ifdef CONFIG_MIPS_CLOCK_VSYSCALL" to be in sync with the similar
arrangement for __vdso_gettimeofday().

If syscall invocation via __NR_gettimeofday fails, register a3 will
be set. So, after the syscall, register a3 is tested and the return
valuem is negated if it's set.

Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
Cc: Douglas Leung <douglas.leung@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Petar Jovanovic <petar.jovanovic@imgtec.com>
Cc: Raghu Gandham <raghu.gandham@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/16640/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/vdso/gettimeofday.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/mips/vdso/gettimeofday.c b/arch/mips/vdso/gettimeofday.c
index 5f6337545ee2..23305bf6c7a2 100644
--- a/arch/mips/vdso/gettimeofday.c
+++ b/arch/mips/vdso/gettimeofday.c
@@ -20,6 +20,28 @@
 #include <asm/unistd.h>
 #include <asm/vdso.h>
 
+#ifdef CONFIG_MIPS_CLOCK_VSYSCALL
+
+static __always_inline long gettimeofday_fallback(struct timeval *_tv,
+					  struct timezone *_tz)
+{
+	register struct timezone *tz asm("a1") = _tz;
+	register struct timeval *tv asm("a0") = _tv;
+	register long ret asm("v0");
+	register long nr asm("v0") = __NR_gettimeofday;
+	register long error asm("a3");
+
+	asm volatile(
+	"       syscall\n"
+	: "=r" (ret), "=r" (error)
+	: "r" (tv), "r" (tz), "r" (nr)
+	: "memory");
+
+	return error ? -ret : ret;
+}
+
+#endif
+
 static __always_inline long clock_gettime_fallback(clockid_t _clkid,
 					   struct timespec *_ts)
 {
@@ -205,7 +227,7 @@ int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
 
 	ret = do_realtime(&ts, data);
 	if (ret)
-		return ret;
+		return gettimeofday_fallback(tv, tz);
 
 	if (tv) {
 		tv->tv_sec = ts.tv_sec;
-- 
2.15.1
