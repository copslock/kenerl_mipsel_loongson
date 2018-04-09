Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2018 02:38:25 +0200 (CEST)
Received: from mail-cys01nam02on0726.outbound.protection.outlook.com ([IPv6:2a01:111:f400:fe45::726]:17059
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994663AbeDIAhRMLuJV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2018 02:37:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=8JKFH0QMMAFtDZyDgyuspuV4dBOhqV769lYoWZHOhzo=;
 b=EC+gEnW7DzWuVcX3lVWOgfEbfKLEWyilXe842j69Omy58apMd5VJbw5t3SzC01fIgE/A0NreShc5/C3vJQq/4+EvAEWX8QgaCZxXhp+GisJls+GGIbYUMnnhNqtUMfRsDPjiHaIQjQW9x7ZGUEZ68vs9bjXmnKqNZps5rIN0zH8=
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com (52.132.128.13) by
 DM5PR2101MB1031.namprd21.prod.outlook.com (52.132.128.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Mon, 9 Apr 2018 00:37:07 +0000
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059]) by DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059%2]) with mapi id 15.20.0696.003; Mon, 9 Apr 2018
 00:37:07 +0000
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
Subject: [PATCH AUTOSEL for 4.4 089/162] MIPS: VDSO: Add implementation of
 gettimeofday() fallback
Thread-Topic: [PATCH AUTOSEL for 4.4 089/162] MIPS: VDSO: Add implementation
 of gettimeofday() fallback
Thread-Index: AQHTz5m6EOfXE2qNh0eyRGL+pncW8w==
Date:   Mon, 9 Apr 2018 00:28:49 +0000
Message-ID: <20180409002738.163941-89-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:OQqdnN8uoNPYSSK+gyM1kd+FzFKbq4CDEBkQgr5hU8D+sAQbFTGmfUG8zmuidONInrWW+gwew0+uhxgfD8zgt50a2SnznqQIM6VF9dEMsYKbOhWzK8nfagJNWSBbZSJ7zBl+mxZITcnN+/ZWLv3Te44UgQ3pSlTbCaJISIRrZCI8DcmkOT0c1D5zZssPUdOXV7vMneQV5mV9xngqYg2Bbsg7Jx3bLaHOg6/QGN3e/fqIWudA7A7HnCMbFTC6FNS4;20:c5UMIi1tWEaxWPKiTfzMQkOjzbRSilJl8gt1ltpdsi7H2rpZuJ7LgoHYDDKBlAusfxunwmTE0FhW6tervapPIQkx8UxrnkMP+wvV2+hgZJ+cwRoTzw74zyQvey7PR8igZtv8U2R9EjTF4C2JaXlCCS+bRpXddN9ZuZTsLnlbGlg=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0d7bd39f-8dc0-460c-35d0-08d59db20631
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB10317CB6A996856B41160F7EFBBF0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(2900100001)(10290500003)(99286004)(76176011)(14454004)(966005)(7736002)(11346002)(26005)(6666003)(86612001)(7416002)(72206003)(478600001)(36756003)(106356001)(66066001)(2616005)(186003)(575784001)(22452003)(86362001)(68736007)(305945005)(54906003)(102836004)(486006)(59450400001)(110136005)(316002)(6506007)(446003)(107886003)(53936002)(4326008)(105586002)(6306002)(6436002)(6486002)(476003)(6512007)(5660300001)(5250100002)(25786009)(3846002)(6116002)(1076002)(97736004)(3280700002)(2501003)(2906002)(81156014)(8676002)(10090500001)(81166006)(8936002)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 03doNE3AZrIXL5TFDFxj7ECLVatAtKdfrVFvVn2/2WTRNygOTVaLZQDF/97gwt1wQO0CPeMz4SCxcDbahZC4BlgZgBgtijoJBMdBJnbq+bXhQrNgmeN3i8v8B7kHaVH+qUicI529iq8NJ52lRC7GHCk0Saj/Ur9a6FMkZ+4EVerOt6h2G3urQVXpDVSn3mGATVIgH/nfhIc9srYAX2143yepNRHh8ar74vhDgpN5Z4pyOQ+EJLzU+xoSmfkM0aOPv52SL3RSstPBEVd5Q/tNabZRVGhsIwTJZpXk8CpIuNwSE+XpURHbO4MO4SD6URjQvb5rlcqwqxbadm/5Dz/6I91aO9Cj6VD3yNM+sPE6vbwxu62It715QQv3oIBzO6osZ5sP8vwdjPF3DBOWglB+CTBaw0SSkmd52hV3Db3LbgA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7bd39f-8dc0-460c-35d0-08d59db20631
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:49.5365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63465
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
