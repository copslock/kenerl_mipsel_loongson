Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Sep 2017 19:39:15 +0200 (CEST)
Received: from mail-by2nam01on0041.outbound.protection.outlook.com ([104.47.34.41]:13376
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994231AbdIORfPu0jNM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Sep 2017 19:35:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=7ahVtwI66NnF23ND/I/jpJDDkY3ooquWjGbCbOsQiCE=;
 b=HFrD7whPUYHqtSgPuwHivnTP/HLDElu6hnjQnwYpB6/ZwEwwJr0bTUl15XghVbndqz3RaQeVJuxhLKFosREPowRtFfRr9rEJ6zrT0fhytqsvQMsoGpUELOHQaoWaVaBgOKL8KgAWBltro3kwYtGb4KmYRHB0rKTP7oqxLUNVIms=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 SN4PR0701MB3805.namprd07.prod.outlook.com (2603:10b6:803:4e::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.56.11; Fri, 15
 Sep 2017 17:35:04 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH] MIPS: Add nudges to writes for bit unlocks.
Date:   Fri, 15 Sep 2017 12:31:28 -0500
Message-Id: <1505496688-27949-1-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: CY1PR07CA0011.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::21) To SN4PR0701MB3805.namprd07.prod.outlook.com
 (2603:10b6:803:4e::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb497828-8207-41e5-dcae-08d4fc601a28
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:SN4PR0701MB3805;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3805;3:CqX6kOD64CzrCd8XHk7Vq208SmZjodIym0h27CS9sIQt0siYK/ff7AztrN4N/YZ3vRgidMixDW2SpfZxufKkWIaFmF/Dln7sdYbc7cdVKHJ43a+R2fYEY4NqkGmD/CZ/7oRTuiGIDF5crjXONNvrH+ZC5E4H3ATPHgYAVU73OP3LnBpOCV6Cbh0qoJ2IxZkNPIQ+rF94h2Md/jekyf1b0ARIoeEbnQQUZmRV8v/TfX08PWdfX+BlLL/1lRwKHugH;25:OKVxJiZt0FAf7Y4Ka1mQ8Q23G7e+QV9bAQUowXPObVcxAgQynwlZCN/V9JrIoLG4bl014VNVX/lXbZTiDbLVPRGJ267IcZ5UJd6QiIsVV3pxXDch7cyEr6tQR9Mf0gW1HwrrYpbM4dMpFYKXDEI0KnTr45aO+zvIqJPYriUsi6tREkbwtijii9oJTgIVByGsl4fYC/qfW68KgdFGjId5+9TwW5xn3N72nBR235tVHN497Lb9+PoWxGRMS5YqApTApikZNcOSHbqlgKTllbswXIuxONJPmsMsQ9Yi4hXS4cDQofBgdBp0gMYXkwiZcSo31ORYSwDinAC2z6RwUf/0yQ==;31:vY9YOo50XtEQibPW7FYOw+pJUMYoqdEKraL207a+F00Mugk4S7ke7FwaZIQkuilsKxkI14iWJiqVZx6glY5flJxyPQQCHockaNOnPCIZbNML6YdGwqs2k3VxmNgnxHrQSP+tMUXf2zPyEU6l4TnDNNN7byfi7g+9SYRauF1EThvJYk/HF67FPDQIUjI2XlYJF0cfHW6ZBaoj1MDUjiyJxSq6wipOTAE+ucED8nL0Hqw=
X-MS-TrafficTypeDiagnostic: SN4PR0701MB3805:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3805;20:gmQ3OO4iHCNUX/LFxvf4teVTSB9Fa8OMtGIcB18hm7qwUEreNR/N8fNCjIpaVpqOnF81C/MBxsCDMjW7hKMiIGQwfRRPqNpbwHqjvD8rCzF+LSUzfHm5Rw3/BvnZc6Aq30Pqbi5K47VNH7+88hfy3lyGKfgVr7SVDCpIvvxpggeaV0xtD0O1BbagR3PJp8ryvQ2fyEePC8GW150ssGA3bY84D09EKwm/BknGUINFuuORBs8dolXURavted5f+rGwiHLBKEvE6Rowm3TunRpyOiYbvblD6pVahGsD0R+n76y2CJRU0Lavm9iwcIQ7/kv/u45pNeIATF0814J/jUbHdWFeMKx3yytqEiYi+Wj6SImbzgyqcwQXSzaGBcEj8/h/viizkTsa/QMCmC4DDDJbyyWBByzjxPJzrSTpFGVmAiEjQKSba+yPdHPuhjnKODhQxnUYn+i9JZpA6R/ahJhSBI8/wcEke165IHfXyQmTaT2naHGtzA6tbJYMIIOHOEVK;4:lVS4lfgvjyS0tBhGSK2ffscZGXWAHkKkeKSwyYE0tfizlj7c4yzoIsyJtyNo6+7Bh4hcrvgWDhyTMApXl4kywrZm8URu3JksqROAetHC3i1HLp6Eosevyc5008RWmUNOZ/tZquH555eo3e1PJQd0iTk+SJLILanKrF0I4x15lWZf0fAUIQIYRJgVkAUgTsUOj0VRMI5UGcHWDer3RgPK32ydkXqmebP2XZ7fsAjio+TuA97V4/cMMASDdvCWMXNv
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <SN4PR0701MB3805A90B0AB00C7CB7FD3558806C0@SN4PR0701MB3805.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(3002001)(6041248)(20161123560025)(20161123555025)(20161123564025)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123558100)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN4PR0701MB3805;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN4PR0701MB3805;
X-Forefront-PRVS: 0431F981D8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(199003)(189002)(2906002)(97736004)(69596002)(316002)(16586007)(47776003)(25786009)(16526017)(66066001)(72206003)(36756003)(478600001)(86362001)(6506006)(6486002)(81156014)(50226002)(81166006)(8936002)(305945005)(5660300001)(7736002)(53936002)(8676002)(48376002)(6116002)(450100002)(6512007)(50466002)(50986999)(3846002)(2361001)(53416004)(110136004)(6666003)(68736007)(6916009)(101416001)(106356001)(2351001)(189998001)(33646002)(4326008)(105586002)(5003940100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0701MB3805;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0701MB3805;23:x91IQ+Z0jLUNOv5q9HS6g9fzhDZmM7LkhzyKgNk?=
 =?us-ascii?Q?BEI4SEpWES40LYmoUU1nFfA5IdOyUludr0L9AXWVx0qtLTvkMFY1EcrXSgOp?=
 =?us-ascii?Q?QphWNTIoZItsklPhnxcyUredmiAuAEufqEaqJji/YTu/HvCL73IQERgaT56P?=
 =?us-ascii?Q?Yb7Zd71xis9EXgcoi2LYHTGiE9h5VLDEn1TwCEtY717tVuFciNHM2+8Afblh?=
 =?us-ascii?Q?K41X6XvT6f9hN671471Kqoo0EPZEVGvRdq5vSh81NMvUucrWoYSS005BJL8j?=
 =?us-ascii?Q?TmwwPdOQeJ7BUEATBlDyLR18PG5mYVMV7th9telGQhDTF8ABnZZW2W3sTUT8?=
 =?us-ascii?Q?OwsZxO1KSSnqVi5hy0R8qW1CjW/Z0lC6c3xMHUfiaBGTKaIZPBuqhb1wu6Z6?=
 =?us-ascii?Q?lVBVTy6VssM9oHAkFIRSouOgbzIzsM+KUlovT76AhZBCt0utpqSttQAEi+mO?=
 =?us-ascii?Q?r5i/xUzbKZOxuudp/WYJvi6jKJe7gnqaDJ/gKaZsVGx+5Ew/8ODD8zmg206V?=
 =?us-ascii?Q?56cbk48EVKYuTmMMCVbsSLJx0Nqptvfsc7QS8PwqFoX7FN3Q7jdOY7Mmy4Hp?=
 =?us-ascii?Q?1rbELlq3xo4YL9uMrx3/nsEnYlfXG7e8ix7J0L8xoxFu372aX68YH5iIpRMa?=
 =?us-ascii?Q?AG4vXsSZrhJzS2myYLMHXU3xakHxsYEhxx8sFzJ83UGfaANYA5EA9nsFadUt?=
 =?us-ascii?Q?BkOJ66P5yo5VnhIhuKJUZmnaRroBbmir6pqR7unLN8fT+nS6bdwcOMpPqAWE?=
 =?us-ascii?Q?UTfhlbZXLQXeyJv5dnrTJiEeD9Exuldi16WUpNrXW2AK8P0fuUHTNa+NqnLd?=
 =?us-ascii?Q?93mUQm94kkX0/6qmHag854yVaq/xdohYpXuExeRzQjmI25HsosD5j3jiW1qv?=
 =?us-ascii?Q?moN6rVf3k0zg42CYKdO8QV4AsGjurQNfnp3jy03e2StJPKxdQFh4o+teYOj+?=
 =?us-ascii?Q?UGR3p/eLJrC3mOxPRYo5DabfO2/54uSTVWMoIeNm9BGYio+tqv59KPKqYUn8?=
 =?us-ascii?Q?2XMQz8XIPUv5dBYKjlDvBpVxigSacMOgB78LBBrynAGt9ch7GjM4icANKzYT?=
 =?us-ascii?Q?hi4estkmEHXtxRJ6djSFYLy9Nm8azcWdk3GvN3XJk7Pk1ODyGP7UtgbxIhGz?=
 =?us-ascii?Q?5KGNVmYqeBjh4uwrUTIgbvjQzTptrsEBoCxUgUgt3sweTXt4Ob5r0Gg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3805;6:o9c/NK9hHVPjYKp+m68t7C2W8deQwS7PdPZc2UC2NZHFkj29/qrjIJUWUQ6Az/mKzBwUUUaKtpHB6s0rP+mOS4rNMTVR5WATWpK/Om7XgUh7vGpDTQ4nBGUr1p83h5Gf7zur/cdAmbk1f63l5tnIGrT3j5vhstUTlBTcQ56aINCGVZAaoLQr8JcrNT68ofUPBYDRvSHyIhXchdO1r5vAPzL3Anbf+h2hgjsDTE1ZJy1D5kdEUtydjnd5rIb/4lZ5nXIXorOGKzbiUhr3/F5VlyfK6mGwMEYyVbObzTeYvp0NlWH3bEHL0R5RixEoI3QaMmje3Wrjs2FVTA2mnsJznw==;5:JKR4Av5Kl6BpE0UWkEiXqnMtVO6RFne5XeO/VFEOVohOGJQep/piLiJAV2GfnvObDlj7K4cHMgJ/tBQlnRgUm3yoIpWFrs0/wreX8M3nkBw9qpdeUwEHjcrJiwsApDrtCdmB5Ocnmd1uPL5yE3GdUA==;24:QbDbrpg6+RqFsPLuFLZ1QD2fSyOFx/RrD3+zAyIMAbPgDzn3sISoR54izcniSreDdmZh+T3Xh7YR3XNKreDzsyw/kuCZf9ZVTCMGYKIDpq4=;7:Bvg0LdezqwTwf4IEn2BzREilnN9W6H2F1qNdrbwhN8ezrA5+YI3gdvmbHVrCrUG7jfx38hxYeLwTz2yJeh4WjKy+F8W0uHiFtjdMAfnNf75lojQAOQUcjlZYq4b0bdxQDD5+VKiLTapm2hIy+vthmgiz3GHa8aTb3oBvMP3DOCA92okv9qisVEACXVyjT/XTu/3sSA2PmwwiVcx8qDr/34Za8cdhnozylKzZ+yyGo08=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2017 17:35:04.9059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3805
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60025
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: steven.hill@cavium.com
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

From: Chad Reese <kreese@caviumnetworks.com>

Flushing the writes lets other CPUs waiting for the lock to get it
sooner.

Signed-off-by: Chad Reese <kreese@caviumnetworks.com>
Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/bitops.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
index fa57cef..da1b871 100644
--- a/arch/mips/include/asm/bitops.h
+++ b/arch/mips/include/asm/bitops.h
@@ -456,6 +456,7 @@ static inline void __clear_bit_unlock(unsigned long nr, volatile unsigned long *
 {
 	smp_mb__before_llsc();
 	__clear_bit(nr, addr);
+	nudge_writes();
 }
 
 /*
-- 
2.1.4
