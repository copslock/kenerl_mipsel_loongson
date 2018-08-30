Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Aug 2018 20:02:47 +0200 (CEST)
Received: from mail-co1nam05on0705.outbound.protection.outlook.com ([IPv6:2a01:111:f400:fe50::705]:60933
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994002AbeH3SCm640zS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 30 Aug 2018 20:02:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwOAO0r1bjrIUypCl8H6GMl1MMfAMb4FtU7lNswfkSQ=;
 b=Ud1EV8Sib9sWgqo3SSEHFkR7ip0asaN0j9P0DiZKBQ9YSfuFeOWzzZRoIr4FSkntqv2+o+PjGyXWn6NSjZfLFvB+IDihoLPOFctSqhyND+zWf+blk9voXCrpDSKtKFV51oiU1+SAdihXZpG0rrSmyAIntE76Zukl6iykI3pkVXw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 BYAPR08MB4934.namprd08.prod.outlook.com (2603:10b6:a03:6a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Thu, 30 Aug 2018 18:01:58 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rene Nielsen <rene.nielsen@microsemi.com>,
        Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linux-mips@linux-mips.org, Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, stable@vger.kernel.org
Subject: [PATCH] MIPS: VDSO: Match data page cache colouring when D$ aliases
Date:   Thu, 30 Aug 2018 11:01:21 -0700
Message-Id: <20180830180121.25363-1-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828160254.GC16561@piout.net>
References: <20180828160254.GC16561@piout.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR1201CA0017.namprd12.prod.outlook.com
 (2603:10b6:301:4a::27) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8968fba-6b5b-4190-61ec-08d60ea2ae2c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4934;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;3:64oR05rnd9jrTD/DNFAL9EfTKdaBJJ5aa2H5rc+/UuyNgwWpcFiV2NS+5lBBF7YkTgsHTJSmFBJ1lxpKRuhTt1KErO4shfw5YbglAHbxGHsIfrNuyKKspt8xb7atJPvzcN/ZME5qs7+QwA0oMNeiYoAL5BP1GtyYJXVV3gXY3eDb+xlDLaQMV9iEjSsGpvqtaFx6n4K05D+JBPfPdSPD1f0D3/rX0FWKUzfgTrgbi8END17MxAJQbdPAs2QFNh5x;25:zcWMxObq+U7Uz67/XxPfeEG2rZOk+J6OdHNXWCYQpXG3BhrcunEFi4v/zBKy6mvUF/uDE25jqHP6kG8fH2drzv7WATjd46A0F9SXxuDew0MvkLjsbGDsn057jfoqrUNJjCX+AmTCJoHOpjckukkrmvr9udmTHdAJjHJ/7NDgwZtlR7oCX3sruth6QmMFV2/DiaZVQq9BKK55xN/WVQtgr75GHawxiYNXYgb3Kcy0cn4VQEbymgHqO/Fv7/GmvKt7a/7Tl6A9p7D+sCgKmfgAcd8VygORIlylQsX4rAh6ohC8Vv/ECCgREbtzMzudB6UT+rEWSJ7AS9sxJT61LTcvGg==;31:LV0HGnOFXrdUJl1cO3vu+paWE0hUhGNXbCql+pKVdf3OTGFAzXyZgf6V5tlVZgmYJcloavVgO6U1wjKSs88hsT7nSazS1dAxR1Y6lbQTm3lFQGFNYo/K4gV3+jdCsN5ojgroQ5dBwc1bJd+bOoeFojBumtfLdIxsTOCDElElgrObsZysagvLgQ3TWkdsmOroEtprI6xwOD3cIjZYLqXOqJoqMetYNy3e+ENPUzGDhsw=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4934:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;20:hVecd1nwKjKYBJI6Zq5ggDfggABSCesgopBo8WumGvB3qjQXIG3gspBeUO22dCX1Z4NnX+YN1ef3ZxpJCYZLsmkpX5X2F4MtLF+gmMv4oV2tXP5HxWPKoAW9CvTi7aKwCoz/Qonmv/DNJBlTApGZr+cbMp4tKZmK/pjr6roVKFvtBm/tpqmBtg1E2h1lPtBJ2JfKlaDMlrc3fxtup5RAXaXXpAC5lCutw4uYdvA4ldXe2BL+UBUtpET7MNGKPnmL;4:036P0O+u1mTVnoFCOg15cBOJstVv+F1KTTknYbhh2FggV85HZPB2Avq+TQDlfg5p1qg4lTz5UgPipG2GhXOhgXc8zWIEEwG/Wgi46NCovohX8Zx0LAuTIZZNcLSJDfZ4zrakSRYsfIQueDGhk3CiqvZSwvodLNybYrff+tXgRD0mYfozY0j0iZtIvnWmq3hq9Ruv9/GR8WwNiJeVz2+92ePVrn9VXoZdcORSL4ezEn5bFb/gsHuu1eDKAhj0ew0j8/LS7m1HpOTJ6J2mcDJaC4815AqxxZf4lEgflWC8lzfMtr2Ssgv23EGV2SfTQjlkQT99Wr5ghAkgA/0+xWovTW2oGSRevHp4Va6uQqIqqtFIL62vP9J9e6w8D2eghcAc
X-Microsoft-Antispam-PRVS: <BYAPR08MB49346F231E31FC412605ACE3C1080@BYAPR08MB4934.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(190756311086443)(9452136761055)(72170198267865);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:BYAPR08MB4934;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4934;
X-Forefront-PRVS: 07807C55DC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39850400004)(346002)(376002)(396003)(199004)(189003)(81166006)(8676002)(44832011)(25786009)(4326008)(6512007)(305945005)(110136005)(446003)(54906003)(11346002)(316002)(486006)(42882007)(2616005)(956004)(476003)(478600001)(48376002)(51416003)(76176011)(52116002)(14444005)(6486002)(8936002)(81156014)(6116002)(3846002)(7736002)(1076002)(16586007)(50226002)(53936002)(26005)(97736004)(53416004)(47776003)(16526019)(105586002)(36756003)(386003)(5660300001)(106356001)(68736007)(66066001)(50466002)(69596002)(2906002)(1857600001)(6506007)(186003)(6666003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4934;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4934;23:7lsq7E5T+dXKFuDB2/gqcDl84QsobgOXohJxrUPht?=
 =?us-ascii?Q?DwrN+hdjCWxMEKKdYF/+onJmF5+dmCfbNeptKkhZwvozh8uAT6bXVCCc2ejW?=
 =?us-ascii?Q?Mbscl/q8mXYkIyuL1VFwd7Eu8Om7A1nmYK0/SlofrGOMQpXoqi2PkXGc78/h?=
 =?us-ascii?Q?bYp+IXa68L5JU8XVyvoaiRAaKRM4Hk/o7pqnDWT6OlWTIXbNO60v7IVDbIWW?=
 =?us-ascii?Q?CyU81TIlMCG6RYjemv/9ejqM57Fe4O6usyoQlMYG89okcx5JlyNv8AvvX1cQ?=
 =?us-ascii?Q?y0VvB0sM6T/i7eT8BbctvAEWA4d2TQ1umu38K+ob/PZVSFIXLnNNv39qZ9wY?=
 =?us-ascii?Q?ExTvond8j6Ui1E42ychYv+/yIEXcGcwcRtNk34KdF0d3mi8RshMmSF0w0dDn?=
 =?us-ascii?Q?RyZkaLZVuVYp4HGuvs1ZbztUwVmZ5tG5NH4rnnfgESJnsoSkSNdOPIDdPMee?=
 =?us-ascii?Q?MGiJdJtJQQ4HpTigwylSzhVMceVT73Q10UD+YGrSoRSLNEaNAOetGE0Oh27b?=
 =?us-ascii?Q?SRRk2ZkD25xgQYHRyaj4joKUgWofGyOOGn29osM1/XXv7UCepVeSBxICiFRu?=
 =?us-ascii?Q?7JAzuBr4yj3v+LFQrzWNiSfJdylsTtt3oE9AsMmb8vf7jP2V0DAVRZnKnWIT?=
 =?us-ascii?Q?s+z40OGiZ9Z6a/cZshUQVP0sqwY/OsMfutPwFFFAopFoYzFNMdDJon2rJkeK?=
 =?us-ascii?Q?LhOEJ6JXJi6ZoE0RMulvDuxWjrKhF5EFjZxLSRthUXYJWYDJGn4hFA5Dsof6?=
 =?us-ascii?Q?k7Y4LLWQ6Ey33Oj94964EzEOWdDXhEKuWP3EaHjW/pgmG3Q+ui099zKv8TN+?=
 =?us-ascii?Q?aIqtIrG14BJLJ0OP3kYBg5hflMjjSvSBavk80t0Cjdeb0Z+O7MPrBpgpJnCI?=
 =?us-ascii?Q?qaYyPQo6TVtbBW2w7CUCnqrl9ZxVuJiUjRqLedQ2F6tMi1dgdy3JNYzhmNpv?=
 =?us-ascii?Q?VHZaflRdzd4eXvkMbyP8rwK6uTfdWZs/7+nM1cwMPfciZyYnuI67aos987bD?=
 =?us-ascii?Q?6g7gh7POf333BR4UIe0VO54pyR4TpJUoCL172WwOpWiUxE0NTKLDSi5WIXBo?=
 =?us-ascii?Q?x24CiNHjPn3s8Nc9Y6+20oW2sV6paH64HkcLc0wIPzzuCkuTX3rLYIEXISP4?=
 =?us-ascii?Q?5oZ3Qnxh8KOehHVvY/UJy2XXj+y0YiDBqIY3xj51f0qfvAI3WsLUQGrLFgwd?=
 =?us-ascii?Q?gAHkGUI0z2R+0siSI5Zoux1BMC2NisTJVbAl9PmWbm8wykI5LZvuTzPL8rUe?=
 =?us-ascii?Q?htAxWNRxtDribz9P7gSnp+lxDolK4XlMVWJJF5G2Sw12znPQaFbGV4XUa+dU?=
 =?us-ascii?Q?uYv3RodBbW9VVtJbmpGknU=3D?=
X-Microsoft-Antispam-Message-Info: rQNqExH4XpNUnE6ECkCD68z/zlAa4KunWV2WLNFmNvIDmClkXh59CXeKv0edZuIjDHrAZgHOIcjRFnTXDPqCj6lhulkuTy4v5D5UrFvkd+6uE97SrnYADo4SVMK80H718JrSCMWg8+JTu0nQUHX+4zw+wy+u+njXbdfLEYrTXlNSmzTV/2u1APzxnmm9sAjSMS79RCDXxb15TQ/9PLaxThhkqtxmET9sLUihD9YJoAvyOhPBPAUNyr40TICeHGODB67/Xa2O5JmAUK48g7NjWBSYAqs4dHhXdaNxlS/aGgGRrJk4ZdJBQ54+H4UXV8OG6g5gHHx1vNyJcOnGXmQ9j32h0sldHzX6EbfqlZlAOeY=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;6:tSKpc9F8yaIOcNAF4aeOtHFAM/50K0AGpMOMi/yF5xKpNVxTZcEtUcAtNZyoraAdUwYeWNQwrvxtc1lTjbJaJl+I9pDOqWUiqTUIdbSoGRGxxEKTtxDG9lLiTqhsRh6fZ3S+R1d+wPHiQmyAAcHXxDGPuQ/b7fF0ZeXbaOBiTK4jhfGrkdLsto5vWkLkNjxXzYr446AVZANy/Dg8ZjuqtRqLwmAZrVSAitbwNpc8IgkDL6nTrr6rIJGR7YzolZean3QFqEtE/csK+Nr/WO8TY1HluPL+IlwUsOl8LbKGWlBDgiPhi54hipIia6U64phsxSRpGzz0Wq1639RIIbvVhZ0DwrpMeFsnSFZMzjBp8UoArw2BveZdgm6S9uVAYnA+2uu3J+LlGBKyvHf8qZo8Iw0wNr+zknf5E+1M3LZFe5t75EUtvBMu5uu1OkNp4MHgQTh2kkwaNAYDR7E9wRAScA==;5:YCVwwivmn+XWjwPD/ZueBTEwPvIctVFI7/r7xBQIzKA9lAUh4XYTf0mcv9c+/Bp2vO4A7cXUFL7CqcVTyNDl/PH2lhhp44Vv9SZTLqUbpW6HYm72Or/Yxfy1qGnfKjESGO+tBBubwYVSWttux3BiPYnWFPQN0SUh1/GXNV+uj0w=;7:xLfHrYKF3ki1yE5TzEozhFVcGW8SVNWzQcFwfWylBI9NfCb/UmN0CtdoaXnZhAwTxXoEfVF0yuNeD9KwDcnzkvgo8/Rd04mHst28PqbzeEGd5hLRkBMtm3OaCTC3RNSAuNmsWhBznF7a9o1fGBAhkukLERMZmnm3LL9g2lTLFzc39XnYbVqhWKbmENBNM05+uFCfMY9vMnMArF4NIB8VD7QyYbWNlO3ox83RP0mijrD4BIWjf6fEl2lHanTvsSd0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2018 18:01:58.4995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8968fba-6b5b-4190-61ec-08d60ea2ae2c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4934
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65803
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

When a system suffers from dcache aliasing a user program may observe
stale VDSO data from an aliased cache line. Notably this can break the
expectation that clock_gettime(CLOCK_MONOTONIC, ...) is, as its name
suggests, monotonic.

In order to ensure that users observe updates to the VDSO data page as
intended, align the user mappings of the VDSO data page such that their
cache colouring matches that of the virtual address range which the
kernel will use to update the data page - typically its unmapped address
within kseg0.

This ensures that we don't introduce aliasing cache lines for the VDSO
data page, and therefore that userland will observe updates without
requiring cache invalidation.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Reported-by: Hauke Mehrtens <hauke@hauke-m.de>
Reported-by: Rene Nielsen <rene.nielsen@microsemi.com>
Reported-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Fixes: ebb5e78cc634 ("MIPS: Initial implementation of a VDSO")
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org # v4.4+
---
Hi Alexandre,

Could you try this out on your Ocelot system? Hopefully it'll solve the
problem just as well as James' patch but doesn't need the questionable
change to arch_get_unmapped_area_common().

Thanks,
    Paul
---
 arch/mips/kernel/vdso.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
index 019035d7225c..5fb617a42335 100644
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -13,6 +13,7 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
+#include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
@@ -20,6 +21,7 @@
 
 #include <asm/abi.h>
 #include <asm/mips-cps.h>
+#include <asm/page.h>
 #include <asm/vdso.h>
 
 /* Kernel-provided data used by the VDSO. */
@@ -128,12 +130,30 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	vvar_size = gic_size + PAGE_SIZE;
 	size = vvar_size + image->size;
 
+	/*
+	 * Find a region that's large enough for us to perform the
+	 * colour-matching alignment below.
+	 */
+	if (cpu_has_dc_aliases)
+		size += shm_align_mask + 1;
+
 	base = get_unmapped_area(NULL, 0, size, 0, 0);
 	if (IS_ERR_VALUE(base)) {
 		ret = base;
 		goto out;
 	}
 
+	/*
+	 * If we suffer from dcache aliasing, ensure that the VDSO data page is
+	 * coloured the same as the kernel's mapping of that memory. This
+	 * ensures that when the kernel updates the VDSO data userland will see
+	 * it without requiring cache invalidations.
+	 */
+	if (cpu_has_dc_aliases) {
+		base = __ALIGN_MASK(base, shm_align_mask);
+		base += ((unsigned long)&vdso_data - gic_size) & shm_align_mask;
+	}
+
 	data_addr = base + gic_size;
 	vdso_addr = data_addr + PAGE_SIZE;
 
-- 
2.18.0
