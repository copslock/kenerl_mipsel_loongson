Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2018 02:33:17 +0200 (CEST)
Received: from mail-co1nam03on0131.outbound.protection.outlook.com ([104.47.40.131]:60385
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994668AbeDIAbbBGP-V convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2018 02:31:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=w6FXLNY9G/Jo22NlqPfpK0LIemLxgD4DyXA25o2rT9w=;
 b=c6n/ZWvgDpEOKvWyO3bdr/5rfBvLeDwyeJueHcguKGIC2Tu1lMBiJiQ4ii/aGNbkCj8Hm4KxNp+pzUpdfe2PIRKTPGp4mya0YGduKNKjEqmgjOsmmzvcYSgKQE99DVjnGYeAEoFMzB+kX9M+mGQyO82Wl/2FoWwEcyMTGkXxBUE=
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com (52.132.128.13) by
 DM5PR2101MB1126.namprd21.prod.outlook.com (52.132.132.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Mon, 9 Apr 2018 00:31:20 +0000
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059]) by DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059%2]) with mapi id 15.20.0696.003; Mon, 9 Apr 2018
 00:31:20 +0000
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
Subject: [PATCH AUTOSEL for 4.9 174/293] MIPS: VDSO: Add implementation of
 clock_gettime() fallback
Thread-Topic: [PATCH AUTOSEL for 4.9 174/293] MIPS: VDSO: Add implementation
 of clock_gettime() fallback
Thread-Index: AQHTz5k4pM0dugySr0yQpi2cLA+z1w==
Date:   Mon, 9 Apr 2018 00:25:10 +0000
Message-ID: <20180409002239.163177-174-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1126;7:nux26CNS+9/aaUEgKoodO1LBHxH2YV2nWaZi2kUQBOjtJa8AzGfByC3sYOmuUh5PdYMdBREYKpsgs9C2m/dcH11hbJ/50r+kCmw8DApNQR+47H7qN47Xu2cJIKE9J3QKti8mOzbQrcTsR9YK3n3Lr7q2jNi7dhfjrlHcoPY8JiRUyTvwd+tt8k2I0X1lb5aISNwZck/mF2A/4yR9PdwQzwPzh1mh8qaSyf9kP3Cnq59GsGrPd+FqDrVZDYfFeF16;20:Bo4tM+rJH30kqgG04sn8PEufz3mRFENVTrWVEGJsrVaAm9D2ciY9MbNNOQlpxI7v6vI4UPh1mJBcIcHb0c0CabmX0r+TSCbQIjBGLH0XkBJFD+1n4wk+nGM1CUHjPMcbGWb+S0nh6vS03jTpljTS1csKy+ZJrxfCXWSO17m970U=
X-MS-Office365-Filtering-Correlation-Id: 66f7c7b9-832f-48e7-cbd9-08d59db13724
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1126;
x-ms-traffictypediagnostic: DM5PR2101MB1126:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB1126B4EE5696733AFE675D05FBBF0@DM5PR2101MB1126.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1126;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1126;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(39860400002)(346002)(376002)(189003)(199004)(2616005)(476003)(81156014)(8676002)(81166006)(3846002)(486006)(2900100001)(6436002)(186003)(478600001)(72206003)(110136005)(54906003)(6306002)(2906002)(86612001)(6666003)(2501003)(26005)(10090500001)(102836004)(6512007)(6116002)(14454004)(966005)(5250100002)(10290500003)(1076002)(446003)(3280700002)(3660700001)(11346002)(8936002)(25786009)(6506007)(106356001)(4326008)(107886003)(36756003)(105586002)(7416002)(53936002)(86362001)(66066001)(6486002)(99286004)(5660300001)(316002)(22452003)(305945005)(76176011)(97736004)(68736007)(7736002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1126;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: eXBkZxpTa/bVuGDtBYLxKr0/WSeKa1dam/MfXtsnV4GOKHW60pJUh/UgpzHRR/vg2swDb5+RmiAloQQdA8O9VeCDsbkjeJU+JzpptZ1lqEf7ey1R1CmYOuTrS14iHdlZzbkSxM2yo7KfM5lGSFdnOW/UXqufzh6FfLFkW0B8EpKs670ZVc1hMnF3UMZkMp95lU04T6P2OskI4MBn842+w6iDl5uUyk2Sf/BEUnj+msCIhBk5SqigDar2HqM/n6whrW16aN29+zV/dz4CW2NUQRGRXHW6tR8AXCqEgp1d8+VMGsumUGgXBLTGR/jlZXtZpEZRWGv69PxThId8RgZU+/Sh61AiUo7pj5zhOicSI/BTsORW2qADL10rH10nzz6Q6JJBgOHQ2vaefTeYqkdrqU+XKJTSCXDnUYo2WMUJwqY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f7c7b9-832f-48e7-cbd9-08d59db13724
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:10.9407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1126
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63453
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

[ Upstream commit 180902e08f051f72c89ffa366f4e4f7a8e9c753e ]

This patch adds clock_gettime_fallback() function that wraps assembly
invocation of clock_gettime() syscall using __NR_clock_gettime.

This function is used if pure VDSO implementation of clock_gettime()
does not succeed for any reason. For example, it is called if the
clkid parameter of clock_gettime() is not one of the clkids listed
in the switch-case block of the function __vdso_clock_gettime()
(one such case for clkid is CLOCK_BOOTIME).

If syscall invocation via __NR_clock_gettime fails, register a3 will
be set. So, after the syscall, register a3 is tested and the return
value is negated if it's set.

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
Patchwork: https://patchwork.linux-mips.org/patch/16639/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/vdso/gettimeofday.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/mips/vdso/gettimeofday.c b/arch/mips/vdso/gettimeofday.c
index fd7d433970bf..5f6337545ee2 100644
--- a/arch/mips/vdso/gettimeofday.c
+++ b/arch/mips/vdso/gettimeofday.c
@@ -20,6 +20,24 @@
 #include <asm/unistd.h>
 #include <asm/vdso.h>
 
+static __always_inline long clock_gettime_fallback(clockid_t _clkid,
+					   struct timespec *_ts)
+{
+	register struct timespec *ts asm("a1") = _ts;
+	register clockid_t clkid asm("a0") = _clkid;
+	register long ret asm("v0");
+	register long nr asm("v0") = __NR_clock_gettime;
+	register long error asm("a3");
+
+	asm volatile(
+	"       syscall\n"
+	: "=r" (ret), "=r" (error)
+	: "r" (clkid), "r" (ts), "r" (nr)
+	: "memory");
+
+	return error ? -ret : ret;
+}
+
 static __always_inline int do_realtime_coarse(struct timespec *ts,
 					      const union mips_vdso_data *data)
 {
@@ -207,7 +225,7 @@ int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
 int __vdso_clock_gettime(clockid_t clkid, struct timespec *ts)
 {
 	const union mips_vdso_data *data = get_vdso_data();
-	int ret;
+	int ret = -1;
 
 	switch (clkid) {
 	case CLOCK_REALTIME_COARSE:
@@ -223,10 +241,11 @@ int __vdso_clock_gettime(clockid_t clkid, struct timespec *ts)
 		ret = do_monotonic(ts, data);
 		break;
 	default:
-		ret = -ENOSYS;
 		break;
 	}
 
-	/* If we return -ENOSYS libc should fall back to a syscall. */
+	if (ret)
+		ret = clock_gettime_fallback(clkid, ts);
+
 	return ret;
 }
-- 
2.15.1
