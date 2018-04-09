Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2018 02:38:12 +0200 (CEST)
Received: from mail-cys01nam02on0726.outbound.protection.outlook.com ([IPv6:2a01:111:f400:fe45::726]:17059
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994652AbeDIAhQkrBcV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2018 02:37:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=w6FXLNY9G/Jo22NlqPfpK0LIemLxgD4DyXA25o2rT9w=;
 b=WR2Og1o5MzCKdXjMX1iZJ30h+SrfgAE4vGQ3eZpBF2h6xjtjNqdZp5PcMSfVJ3212To4uSMSjVv8KwA7hEr9NIhAJQ5zAHPmRPGEQs9Ei0YQRPFRdANQJldVkSYEmQoPxLNItwZbjSmn922OWUGVnxWPh+4dIXbdUG/Ph2Bw79c=
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
Subject: [PATCH AUTOSEL for 4.4 088/162] MIPS: VDSO: Add implementation of
 clock_gettime() fallback
Thread-Topic: [PATCH AUTOSEL for 4.4 088/162] MIPS: VDSO: Add implementation
 of clock_gettime() fallback
Thread-Index: AQHTz5m6JPnNOUhCHki+WclvGAYoFg==
Date:   Mon, 9 Apr 2018 00:28:48 +0000
Message-ID: <20180409002738.163941-88-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:/Md7bapkHRBCtoeUyZzwzP75qns18LSyYmWjyv6iDB5k+bWJSnY5tF96lBjXVBo142T808YRYIZOREF156ij7q7W5DyMhtkP1YowKFAEFl9TxPyWY0a79Z3MRCEE+6/crl6DFSHBm31unDQWe/nwkFvqPGNvqCppRSOvi4neDkXPO9QyfL3GWlJmajiwfazgYpqHnmI33RWmxS5/OpyGO6VylqX7qy0aom5EjcTpXMjbTKs+aON6zsvLYLDGmboJ;20:csEaiZN7D30z9UPnXSjbTRGgfVBCPO9T0MmmigwpROvQNrMvZfd5tHC/XXE5/5QG9x+viGWtY9sk0CEh2OeEKFZ3pacMF8RA8DAqAS8CROk9U38W9xwJ1vI2yoVNHOSo1pXGY/fHTvekotxBtxwYPjWAPFRnXMdEIeTdxO0xeSs=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6750a2c3-9414-4f21-c380-08d59db205dd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB103182982A87BB5E6921A02AFBBF0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(2900100001)(10290500003)(99286004)(76176011)(14454004)(966005)(7736002)(11346002)(26005)(6666003)(86612001)(7416002)(72206003)(478600001)(36756003)(106356001)(66066001)(2616005)(186003)(22452003)(86362001)(68736007)(305945005)(54906003)(102836004)(486006)(110136005)(316002)(6506007)(446003)(107886003)(53936002)(4326008)(105586002)(6306002)(6436002)(6486002)(476003)(6512007)(5660300001)(5250100002)(25786009)(3846002)(6116002)(1076002)(97736004)(3280700002)(2501003)(2906002)(81156014)(8676002)(10090500001)(81166006)(8936002)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bsmsL3TK9gdI6bUotMnRsdZOCYYQJKS1xt68k6QSkraDwX2UDbBwKe586vRjhmKl/k0MhY7f+iiVszFGYZQJ8t9wpPN8C+Pj05EBYHOPjObBL8Zv0P2galX9Q2b3yq3OIboyYDyX+tk3hfZixY4TffnGI+DGDv1FgDyaieQT8+Wa/7D0q8tCbsTTvvgmlpX/NgEK0RQ+l2pLKg8NAVpQ/gCd20KKLiPCD+TdkwRxqYmAnt7Hmq3Ic9tzIxVb6EP47YI04/88nFlAC+dnJCNKux0aHYrpgzS+6wV+86KlH94gRJY6k8UW9rWOb9T0horTyMUqd3gkrT0zEkX6URGmQD7oeNiw+miG+cVd24jaVOJsSNmMH5F4ex8zOxpaeulayha6w9cGFgPoY1yOKVsXuWty/juDKII1ZJFfBimB5g4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6750a2c3-9414-4f21-c380-08d59db205dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:48.5209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63464
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
