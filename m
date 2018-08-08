Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2018 00:57:24 +0200 (CEST)
Received: from mail-cys01nam02on0104.outbound.protection.outlook.com ([104.47.37.104]:45072
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994746AbeHHW5ExOpSA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Aug 2018 00:57:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bvVAwqvwjANIAnN7TsafMOwWp1v0W664RlnYnjrn4A=;
 b=fp+16FUdl1W2PHK3XUXaz01kukHkljmBnB//00qoFOQY2QHKcDPjkB45m8oCqBi6fdUV+lwmtbaUYzBgwEzyj1gg7X9ebm4K2UEBBoSMcdcOgH5F+lADuQK2m47i7urQKKy1apbcSUMn5PYyat0kW24kiv3jUflLtG3bs+0OxD0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 SN6PR08MB4942.namprd08.prod.outlook.com (2603:10b6:805:69::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Wed, 8 Aug 2018 22:56:53 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     linux-mips@linux-mips.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-alpha@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-arch@vger.kernel.org, Paul Burton <paul.burton@mips.com>
Subject: [PATCH v5 1/4] alpha: Use OPTIMIZE_INLINING instead of asm/compiler.h
Date:   Wed,  8 Aug 2018 15:52:22 -0700
Message-Id: <20180808225225.24450-2-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808225225.24450-1-paul.burton@mips.com>
References: <20180808225225.24450-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR2001CA0004.namprd20.prod.outlook.com
 (2603:10b6:301:15::14) To SN6PR08MB4942.namprd08.prod.outlook.com
 (2603:10b6:805:69::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91f920b9-108b-4bf0-7db5-08d5fd823c9f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN6PR08MB4942;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;3:nNGkvEviC15fjD5v0YUzkwH5OsoyA7hgKRXT1hXQ3rdBVnC674uheGaYitwo0O9fOKmSeJJE/Iv0X8OFpyhRx1tbDbZtb+kjJBNUX+vwzgLa4lmW/+tAZ4gp8W/lnXyNNmTG9NS4cvT/H9YzxiL02BGGJ7fdrD6U0fXVZ/3zSeF1/3N9Ohnws2aO61kgw1T0pL0iANQ2ey5uvQ33xYgVE7ziRePSu0QDWu3nLIxRUGmnUo91nsLENXa5TALFm0v+;25:Df2Z4Wrwu+KJgooXd/d8ytitVif4lrPfVcqXH9jfN8oGUHpkE93xYc5psbZi4MfkmbVIbhXtUcL6TF8MbMdUzOXSMALaiu5AY7djyV8ELAqV2yLyDCRynA9xeT8dH5fKBghmuNg+fdVpvtv/1n0Dm9iJzTpq3rwjCVJYX8aWXBsgq57eqdWS8rF3Iiov+Nno5S256jGfgcxcejBLMlSQcSHCtTAIY75KVLRnBFO4OEp6//dXHHKYmYKLmbSBJr99JW0EqbeC+0VrxW/5sfLXxraIdcnya/URLvM9JkGwU/Yul69Cl7ChrkJYEZvZENuiGY8Nu/0BceqA7G3pzfySvg==;31:87L1+zz4z2njvuLOwdX0v+bjhlvQgglvcpJ/WD2OXr+jIz7VlaOpodBFyVKOTSXG4AfEaibxoJYmMfKqavHynlNY+biPDsK5e2CZFNSWvqvCagqI8qS3gUIKa5TMaTK8jkvSRKjWSI2Zj6zwCxiia28f4ogMHega6PofgOR6HAF7Wo7p5mKu1iDZlDy2Oce3o1tc+7Pi8xGVJ0k76xEJkYneh7RijzBX9i8B4ZbZh60=
X-MS-TrafficTypeDiagnostic: SN6PR08MB4942:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;20:xgkqpj7LOyO3rI2m+r4F3nI5m+TtxXBCzdXgym5LGeSXjvSysfBvSmCOOgo1yOdo9GVFpo/N/UpbAZ4tgC21WMIm5oMgSE568LHA6jlMWxwQ4zAXlZFGc9Qc57d4K9W4cDmSTiZ6gX0LE/T5CdVfZWkoWDJzLm+dVOnFkQnSN6cOvWiJfKYg5VOPnRYlvpNs5kk5Dv8W8y/lpqUyfuOyPK/SYjT+AieGiMj96E6IZ6GshWqSM+2hZwi3wXzpQWZm;4:+CCpf81VEnarvBUbWh5dgRu+N3vIelsLh5DFu7mqENHrHUVpDG9vFAZMeV2FOa9pmj+VvyNT5jlKqCA68SA7J0zr+G2uLXffzAoVkEXwkjKlAYCabmdVh5kCxgEXWdaXz8ZtsPoxIsSE96dDjAogcCZZ8lI1CyjlcsJcIYHiU0paSHYnjPvU359hIhSgABen1D0ht6lkBndjFzdg9u3OaqZOrJ8/HLmPq/cHak69pcXvgso+1z3P2wU2DXIIrc/HTOr2RXyfztKU3czhPsvBSCpf/ldGublXu441TCdbnNjGJEWus/OlHv3gYRBpkrFrKV1afo3FIYVfBW5MrpjWZw==
X-Microsoft-Antispam-PRVS: <SN6PR08MB4942C8DC5A55035196745FEDC1260@SN6PR08MB4942.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN6PR08MB4942;BCL:0;PCL:0;RULEID:;SRVR:SN6PR08MB4942;
X-Forefront-PRVS: 07584EDBCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39840400004)(376002)(346002)(136003)(366004)(199004)(189003)(6486002)(25786009)(44832011)(66066001)(47776003)(42882007)(476003)(2616005)(16586007)(4477795004)(446003)(11346002)(53936002)(107886003)(956004)(486006)(39060400002)(316002)(6512007)(54906003)(2906002)(4326008)(386003)(1076002)(69596002)(3846002)(305945005)(6116002)(36756003)(2361001)(478600001)(50466002)(7416002)(48376002)(97736004)(7736002)(76176011)(186003)(16526019)(2351001)(8936002)(6506007)(50226002)(53416004)(8676002)(106356001)(68736007)(51416003)(81156014)(81166006)(6916009)(105586002)(26005)(52116002)(6666003)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR08MB4942;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR08MB4942;23:wrPGzzcxz4XitOW0B+Zo6qwAmC78mACnYbO9esRhL?=
 =?us-ascii?Q?wq4Yx/LZCUR9xfx5ws0TrSBbDoYdZrkrFEiJQUETmQmP4hUVg0bl2fjYGFY3?=
 =?us-ascii?Q?bhh9+NgS80bbeZd974fzd455IFoIKMdJxW2plHlX+bcs8yfukEtbGLI1Omkb?=
 =?us-ascii?Q?H9iY6Ud2QdrZnTyD/zXhWjfx8y321krl1P47CXm4YrtUwlPDoRKjC4CwoUCZ?=
 =?us-ascii?Q?6MN3uzUx3iiroUCaam1g9Cs5om9YzGwMlkpFDymfIGy3Qt5eVsysyVPcpEu+?=
 =?us-ascii?Q?EbLjVYBPlhPdcWVKmikInBHutWy5ahaitzAvhod9PAfiYny3CjhND4sK/ntR?=
 =?us-ascii?Q?5r+f576HJToVkN0ZYl5WO/fODcN4QMPPI9WiQWR+5K/i/toIFpc4jptWap3g?=
 =?us-ascii?Q?O4okkYy4il39yjfA65cxOcN4yMJSi+lL/7DD/VaV6kMCYPrr6EoPgKuiWa6s?=
 =?us-ascii?Q?L3iWW8OvdqSiu11vKZJyHUo10Jq0A9FhgD3Z9XgrC2gKI8D/cGGbSxLLezV7?=
 =?us-ascii?Q?9wxUqkq6K7X8AHZeNJyXTIbHiWaCH52qVUyVOWdQOsFbBxaeLouiPLrnVLx7?=
 =?us-ascii?Q?xuficOzTOGAbTgzP96jTgmeVaEEILdLF+nKMC+Kx3TqU/3VlQdBghqyHfbHX?=
 =?us-ascii?Q?RYvjJ5uTdvq6xz25G0fx6FzwRdg5+l1eW19n6La7pNR7coi241T8cR462qlk?=
 =?us-ascii?Q?WNhD1gB1wDY4wOghEdmynSaOE2IdmMS888ldmq2tZzc2nSpe8bZ4uY/7JSPo?=
 =?us-ascii?Q?O8M3uwtGnI/+UHy3mty5+ElY1FVzjzLaG54Vh5gWbIBacyT4l5SetACz/CdQ?=
 =?us-ascii?Q?JlhDi+2I8fE0HjS3IioqJTWtH+hJQuknDGzschSKn+iRKqkjlO5ob1odZIBA?=
 =?us-ascii?Q?3TqkYSvzqXrw20fswcA5NKPLbFU6bpXsw44B3NFSl+0UP+5MVQlg6WMlWF+K?=
 =?us-ascii?Q?XPX21HNHucGbcj5hvi7J3lr8uahQnz0U9ru39BO/IoiL6zmsgJCCCiijcDmm?=
 =?us-ascii?Q?fJ9+0ZAyS9NoFtioX0+auDXhhQeQlkQgRbg4O0K+wdSimw0VF3maLjemczQW?=
 =?us-ascii?Q?oPamI1bquwsTdCN5XMhBH7xgdy+AFr0DzBfuUTbcrjpVnq2yuJgImtJ6JduH?=
 =?us-ascii?Q?qDXPe/NG9drz0OX4sm7lHDV1VoIWRzoUXOTFwNWxjMrvFgWw7hLGALlirJKu?=
 =?us-ascii?Q?ORXxPWYVQ0OgpqvqNgUD9sCc12AfpWa0fuWAULC9uQVCurIfTUa+evW/Kfud?=
 =?us-ascii?Q?9gB3fix0qzpHdGh/uxnqwqHsUNl18HIn+XHE7NyUA34ZZRRTbPVw3hjRjO2Y?=
 =?us-ascii?Q?PtOI9FMk7v1isKxcPE2fXPpkdGIx7aUQCuhKl1V9jKvsl9R66vRojVZKCnHs?=
 =?us-ascii?Q?YiJkzWcwnmORKWu8s0O5xpZwzIW6sFk22oOcRNMbbpuEQX2?=
X-Microsoft-Antispam-Message-Info: DpmptTG/E/lYLZ3/kqq7gj5vU1zmCTpoccVvZ5VQmQ4tcjrQLNwfaLnO1ifpJMlHluNjRZJr0+whyqFtA13yVjOpAiTj65EH3jWIOdzIMY794iJl1nEpuEy7ybpbC6W1f/kGxcuTAAK4Q7KxRVDRyzszGcaDpXXIY/9DFQi0HHoZxlhusPx8NG6dIwGh9W6pCKoNQgzl610aJhpV0m8mmlrF8v/P99y1bD2mEtQ5V4m9SaGaLwBWcOEBIS4cAMNEUZ2sZmo5L0a7xjv/1S1Ad21oK/m0OQLF7aTCY+XICwzgGA7tz0jRfILycjyNAhMMxC+67kzEoPudSFzFkQOBK8E5dUUdNTWoP/B1lufQ81k=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;6:FlINsTUCgcIKfwoHUb+I46v2yU8wB2VleGLL3QofWpyIJkoXeAAlon5dntv10mGjF2is+s6LhWPcXBtuqy/gpAMlZAPUnL6si/C0agfjcsWXruz+WVZdGV+tuWgfQCampx5N2O04ArrCR5BM56t68vevB/Ei3F3xNPc0sjYkjlW/sgiQAYzdWd/2vZqshjTOusfW/3ZpI22p5VQRp14611EH0E4mWbO+RnNAAOQGM0lJWXZUWInPTZmWvyXAxmunFu1mqoUd4zTrLL1gxxodRFXMjQrbNhw9Ogz7EsFhrGlT//A0/WlMlDcGLYI6d1rz5qUX2IZ7csfLgkkAACggT1Ub88z7p/cIqLqbcBCfVxZOM3kPo3mHTPqsYCkCO7wbcwkM/enNkw0Aa5xA684y/8M0IigGYzyY+wBuicb22dNlG9l/GxxGgeLg7LdW9m1O5UQDzcADMtARQiIuz1JJSA==;5:stLkrA8Lk5FACRl4ILsZnLEolWfa3vjOF4H6q1Sh1VArJe5sUV0384bRjqgfzjPFNgCmzsco7dV5YUHd9/XbMtjcZ2XKqsTpReyMxtjmNGBzKJU/IChN1gAaYsLyZTsgeWXZfFGYWUxHfENxiFY4Z5/IBPlpxq8MB0LE8fJA5n8=;7:PmIvN04fvMFp6krW0joSoI5AuukPc0soUdKA2m7dGU/MgNxaXdS9Lql5wfOZ/LkMMjL0WBZLIgboOHo5vH/7NtCZnyAgEQqe7mYrlGc9SqLT7qF78U2hRw3RAeseuMB7w76Ax3xPSazNHZtTxvFrmgSD+R+vu+20uj+ygxuwxs+tiCSXGtCmEMNJ/rXLQaPUAkrOFawn/HgC3tgLoae1fG3m6TPKFVDywKxTqjZDWgwzETxeI11iZU0V3G0s/+Nr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2018 22:56:53.7247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f920b9-108b-4bf0-7db5-08d5fd823c9f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4942
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65482
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

From: James Hogan <jhogan@kernel.org>

Use CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING and CONFIG_OPTIMIZE_INLINING
instead of undefining the inline macros in the alpha specific
asm/compiler.h. This is to allow asm/compiler.h to become a general
header that can be used for overriding linux/compiler*.h.

A build of alpha's defconfig on GCC 7.3 before and after this series
(i.e. this commit and "compiler.h: Allow arch-specific overrides" which
includes asm/compiler.h from linux/compiler_types.h) results in the
following size differences, which appear harmless to me:

$ ./scripts/bloat-o-meter vmlinux.1 vmlinux.2
add/remove: 1/1 grow/shrink: 3/0 up/down: 264/-348 (-84)
Function                                     old     new   delta
cap_bprm_set_creds                          1496    1664    +168
cap_issubset                                   -      68     +68
flex_array_put                               328     344     +16
cap_capset                                   488     500     +12
nonroot_raised_pE.constprop                  348       -    -348
Total: Before=5823709, After=5823625, chg -0.00%

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Acked-by: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-alpha@vger.kernel.org
---

Changes in v5: None
Changes in v4: None
Changes in v3:
- New patch in v3.

 arch/alpha/Kconfig                |  6 ++++++
 arch/alpha/include/asm/compiler.h | 11 -----------
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 04a4a138ed13..649b41621520 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -74,6 +74,12 @@ config PGTABLE_LEVELS
 	int
 	default 3
 
+config ARCH_SUPPORTS_OPTIMIZED_INLINING
+	def_bool y
+
+config OPTIMIZE_INLINING
+	def_bool y
+
 source "init/Kconfig"
 source "kernel/Kconfig.freezer"
 
diff --git a/arch/alpha/include/asm/compiler.h b/arch/alpha/include/asm/compiler.h
index 5159ba259d65..ae645959018a 100644
--- a/arch/alpha/include/asm/compiler.h
+++ b/arch/alpha/include/asm/compiler.h
@@ -4,15 +4,4 @@
 
 #include <uapi/asm/compiler.h>
 
-/* Some idiots over in <linux/compiler.h> thought inline should imply
-   always_inline.  This breaks stuff.  We'll include this file whenever
-   we run into such problems.  */
-
-#include <linux/compiler.h>
-#undef inline
-#undef __inline__
-#undef __inline
-#undef __always_inline
-#define __always_inline		inline __attribute__((always_inline))
-
 #endif /* __ALPHA_COMPILER_H */
-- 
2.18.0
