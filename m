Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2018 02:32:09 +0200 (CEST)
Received: from mail-by2nam03on0724.outbound.protection.outlook.com ([IPv6:2a01:111:f400:fe4a::724]:10945
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994662AbeDIAbXpYgaV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2018 02:31:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=7qJW/yIGwcHOK1kweyKsSfSaYEvSs9k2OsCOVArFgSE=;
 b=Ks/VXuLRPCums441bPZ/ofDjTNZiDkLqXFyF9KtIe/l2dYodg8YlKe5qRnf/ZyhloSXMNeq5ELu94ZGshKvIzIyIFvWcCfrzDGtAVxXbOV/KU53oN8kTLr4jYhrL85tGOTGqrzYtE461SgPvecF3bTlMWlXItO9L1aIJaEY0I5I=
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com (52.132.128.13) by
 DM5PR2101MB0917.namprd21.prod.outlook.com (52.132.132.162) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Mon, 9 Apr 2018 00:31:18 +0000
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059]) by DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059%2]) with mapi id 15.20.0696.003; Mon, 9 Apr 2018
 00:31:18 +0000
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
Subject: [PATCH AUTOSEL for 4.9 170/293] MIPS: VDSO: Fix conversions in
 do_monotonic()/do_monotonic_coarse()
Thread-Topic: [PATCH AUTOSEL for 4.9 170/293] MIPS: VDSO: Fix conversions in
 do_monotonic()/do_monotonic_coarse()
Thread-Index: AQHTz5k2g3dlmx/obkGf4P3vgVx6iA==
Date:   Mon, 9 Apr 2018 00:25:07 +0000
Message-ID: <20180409002239.163177-170-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;7:iJrw/uzEDRZp3QFSBWFaIJAV0lYCRkq+h75zHBxdpHvKRVK8c/yXClRXY6EIoU13dQQI5mkOVu+BZLYbsVKXdE8/0aME3EeoJmuabKenpYoxEOhqk39noEsEC/aUf8LziE6SfIivLNYCslOEdru1Uo2/+7mgBVgt1GW//x02m8b33KqFVdV+nSFALM1/PUq3f2SCweGhdeddp0c3sy/B9udEW4eqXTfQEgvz2H5d21FjdxJam0ig8Wggex1yyraE;20:tYsyjx0nVzr7F4Z5IE5oQYMWh0QjxWgvVOpID8brNTv19w5oYrGiCS0xth32pJE4AuwNEIQ3ETIH195uYm/OUncWJX6kbXsMrrDoGZk7kXafpiBjKGHVJ1SiEMKCjdxUkrMplQ/MCYMdQW6KqdMW+YZ9zk52CChXL+12TrAfX18=
X-MS-Office365-Filtering-Correlation-Id: bdc530d9-5ce0-429f-640c-08d59db135d9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB091709B14C9D64AF5FAD2A2CFBBF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(189003)(199004)(377424004)(99286004)(22452003)(106356001)(26005)(110136005)(478600001)(54906003)(10290500003)(316002)(1076002)(72206003)(186003)(4326008)(97736004)(66066001)(11346002)(25786009)(86362001)(476003)(446003)(2906002)(6666003)(6486002)(105586002)(86612001)(3280700002)(3660700001)(6512007)(3846002)(6306002)(6116002)(6436002)(2616005)(486006)(53936002)(7736002)(8676002)(81166006)(81156014)(8936002)(68736007)(7416002)(305945005)(10090500001)(76176011)(6506007)(102836004)(36756003)(107886003)(59450400001)(2900100001)(2501003)(14454004)(966005)(5660300001)(5250100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4LyqyktUShAfOfdmJNlghWMcjryR1PgUUY+IZs6Ce3/vuyaaFt9GdYsDaUDX2ejPyVc1RXdTcRzr0nYSXyn58Cfk4q4U8IZbVgI2yN4VfVN1JvV5cjmYOB3XeiscLgVSd2A7d67IxZjIHXJoEnlGCHJMXiE/xhM19OxmiUYOkPcUb0vYlsA33VMKMLTjGNRmWilcaA5Cyz1p9ibW5ZR5Sk+BWa5KsO11hRIiSiBtRSch0jVHpbphTEBLkozXqa671lIqKGV3DCloSm+BA7YYW2E0+wBk4PCyBgw5mfp9hQiGi7WbwvmVQXf7K9HKI8IQjpQJNn5+9B/PzUkHKYeW6NFpgXf1Va55708chbEns1DqlG4M0n0MY1vJJAkTU0cmf+O6VoowDfRBaEcOye13hESnGB2kOhg4L8bYDTgMbEo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc530d9-5ce0-429f-640c-08d59db135d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:07.6126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63449
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

[ Upstream commit 8ec7f15b8cca4f790df5cdf33f26e2926d4ee2fd ]

Fix incorrect calculation in do_monotonic() and do_monotonic_coarse()
function that in turn caused incorrect values returned by the vdso
version of system call clock_gettime() on mips64 if its system clock
ID parameter was CLOCK_MONOTONIC or CLOCK_MONOTONIC_COARSE.

Consider these variables and their types on mips32 and mips64:

tk->wall_to_monotonic.tv_sec  s64, s64   (kernel/vdso.c)
vdso_data.wall_to_mono_sec    u32, u32   (kernel/vdso.c)
to_mono_sec                   u32, u32   (vdso/gettimeofday.c)
ts->tv_sec                    s32, s64   (vdso/gettimeofday.c)

For mips64 case, u32 vdso_data.wall_to_mono_sec variable is updated
from the 64-bit signed variable tk->wall_to_monotonic.tv_sec
(kernel/vdso.c:76) which is a negative number holding the time passed
from 1970-01-01 to the time boot started. This 64-bit signed value is
currently around 47+ years, in seconds. For instance, let this value
be:

-1489757461

or

11111111111111111111111111111111 10100111001101000001101011101011

By updating 32-bit vdso_data.wall_to_mono_sec variable, we lose upper
32 bits (signed 1's).

to_mono_sec variable is a parameter of do_monotonic() and
do_monotonic_coarse() functions which holds vdso_data.wall_to_mono_sec
value. Its value needs to be added (or subtracted considering it holds
negative value from the tk->wall_to_monotonic.tv_sec) to the current
time passed from 1970-01-01 (ts->tv_sec), which is again something like
47+ years, but increased by the time passed from the boot to the
current time. ts->tv_sec is 32-bit long in case of 32-bit architecture
and 64-bit long in case of 64-bit architecture. Consider the update of
ts->tv_sec (vdso/gettimeofday.c:55 & 167):

ts->tv_sec += to_mono_sec;

mips32 case: This update will be performed correctly, since both
ts->tv_sec and to_mono_sec are 32-bit long and the sign in to_mono_sec
is preserved. Implicit conversion from u32 to s32 will be done
correctly.

mips64 case: This update will be wrong, since the implicit conversion
will not be done correctly. The reason is that the conversion will be
from u32 to s64. This is because to_mono_sec is 32-bit long for both
mips32 and mips64 cases and s64..33 bits of converted to_mono_sec
variable will be zeros.

So, in order to make MIPS64 implementation work properly for
MONOTONIC and MONOTONIC_COARSE clock ids on mips64, the size of
wall_to_mono_sec variable in mips_vdso_data union and respective
parameters in do_monotonic() and do_monotonic_coarse() functions
should be changed from u32 to u64. Because of consistency, this
size change from u32 and u64 is also done for wall_to_mono_nsec
variable and corresponding function parameters.

As far as similar situations for other architectures are concerned,
let's take a look at arm. Arm has two distinct vdso_data structures
for 32-bit & 64-bit cases, and arm's wall_to_mono_sec and
wall_to_mono_nsec are u32 for 32-bit and u64 for 64-bit cases.
On the other hand, MIPS has only one structure (mips_vdso_data),
hence the need for changing the size of above mentioned parameters.

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
Patchwork: https://patchwork.linux-mips.org/patch/16638/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/include/asm/vdso.h  | 4 ++--
 arch/mips/vdso/gettimeofday.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/vdso.h b/arch/mips/include/asm/vdso.h
index 8f4ca5dd992b..b7cd6cf77b83 100644
--- a/arch/mips/include/asm/vdso.h
+++ b/arch/mips/include/asm/vdso.h
@@ -79,8 +79,8 @@ union mips_vdso_data {
 	struct {
 		u64 xtime_sec;
 		u64 xtime_nsec;
-		u32 wall_to_mono_sec;
-		u32 wall_to_mono_nsec;
+		u64 wall_to_mono_sec;
+		u64 wall_to_mono_nsec;
 		u32 seq_count;
 		u32 cs_shift;
 		u8 clock_mode;
diff --git a/arch/mips/vdso/gettimeofday.c b/arch/mips/vdso/gettimeofday.c
index ce89c9e294f9..fd7d433970bf 100644
--- a/arch/mips/vdso/gettimeofday.c
+++ b/arch/mips/vdso/gettimeofday.c
@@ -39,8 +39,8 @@ static __always_inline int do_monotonic_coarse(struct timespec *ts,
 					       const union mips_vdso_data *data)
 {
 	u32 start_seq;
-	u32 to_mono_sec;
-	u32 to_mono_nsec;
+	u64 to_mono_sec;
+	u64 to_mono_nsec;
 
 	do {
 		start_seq = vdso_data_read_begin(data);
@@ -148,8 +148,8 @@ static __always_inline int do_monotonic(struct timespec *ts,
 {
 	u32 start_seq;
 	u64 ns;
-	u32 to_mono_sec;
-	u32 to_mono_nsec;
+	u64 to_mono_sec;
+	u64 to_mono_nsec;
 
 	do {
 		start_seq = vdso_data_read_begin(data);
-- 
2.15.1
