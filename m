Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2018 19:46:09 +0200 (CEST)
Received: from mail-eopbgr730138.outbound.protection.outlook.com ([40.107.73.138]:44640
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994758AbeHIRptAv06m (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Aug 2018 19:45:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yR1wJo1OXRpqHGq42ayG+uQFibEp9AG9Jf6KY+WnG8U=;
 b=rpR3Wa+QPTB+N7/Swoba+9MZ6+HInbfnBt3WfgaAFCxxJ16vk+6MdWMu5QxS87cFSzIQ4bsYBAU2mWf+dR+hQggiOQvQJ+hiZWEq/DKXOoaWyDBVaTXo99D8ZgwK3USUfuCWYD2mzY6KVWTnlHaUGt6OkvjUOZX4bn52AwlV95Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 BN7PR08MB4929.namprd08.prod.outlook.com (2603:10b6:408:28::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.21; Thu, 9 Aug 2018 17:45:37 +0000
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
        linux-arch@vger.kernel.org, linux-um@lists.infradead.org,
        Paul Burton <paul.burton@mips.com>
Subject: [PATCH v6 1/4] alpha: Use OPTIMIZE_INLINING instead of asm/compiler.h
Date:   Thu,  9 Aug 2018 10:44:41 -0700
Message-Id: <20180809174444.31705-2-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809174444.31705-1-paul.burton@mips.com>
References: <20180809174444.31705-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BN6PR2001CA0025.namprd20.prod.outlook.com
 (2603:10b6:405:16::11) To BN7PR08MB4929.namprd08.prod.outlook.com
 (2603:10b6:408:28::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad5afe6f-7bb5-4e17-eab4-08d5fe1feb01
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4929;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;3:QSm8g2R6U0wLy2kTXZzplhO7vh6gnl9q/BIg4WOTPHR81kRwYwE2xvLTJW70BcEm+d7SYTUA2bNyYLDST3lyF+tteuCCVZUk/EFuIy/gsOklWqKp9XLn9rPGUD86bJs45PxfNdxI/OZCwLIQRo8hQCC9Fzz9PbuponS+iRUGGaMhxax/Gq5EwS3bDD32UIe6jlUsNGTJvhK9j60UtRCiNQZ9YzEMQ/GZmJT1NpGcQj1525XFSkAQTA2zL3+9YKVR;25:fM/7/laJoyVcujMtqo3b32w1zhJJBkvoM/nYmF/67yseE6jRUq9JKaWi9nFYNolkxHXk3BORsArv23Yg/9wasKeLXyYGbpa4uz180+AcB/ejBDS9eSIwzRasHrzYIRZUss5dWqBdC2trU0xgMhbE2aseekoA/Vp5sEapx2IdE5266XWGJzxApeExYIgIP7jOJx8YfMAHiUeiHQjKFaq0YFJPNbzaipepyJi7ynfSx/5KG9i8QrObgQ6NNcpQPwGIftElx+jevJjLjh8JB7V52Oc1nupZeHvam8A4YN5abilPtnEHs9ll0tLXaVa528OKqE5qhYtnhd0S++Jx/Qkpow==;31:OwuzEEmuktTrHRNMTHMASiWy4s6tacqx1c5RlKpDtZB5YvZdDRSRO3VTpMrJ9Gpo6l7OiUq+SMzhjM0/Gk/+yEfOfDhU3d7LmKdmM/6zhjw4Wlug0R/0miqfGAGh6H/0SVjD7R+5nK9eeuEghShOz+Hr2WudKf6bKmy7QejBMxlgAAVKKi6S1oQRh5iRAZSII6T5mSW1hwiRF5H+eQkapcRnofplqhYXNMryAtBP3vg=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4929:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;20:TTbn/ip4YeJMfTmWGpVWqctA7zefKNou4a7UfEtMaiw6IE6XJZOV8Q/9xNpeeutDMUrjJA09N7IypnW06eAwS5UoZg1otCRg/8arvw8LLd5hTxhpVqcfQtAly2H0/bjjS+UkY0Vw05v1FOHobsOMnP9YGjgMEm/bDo6nSHtDqC6xhLafAGu8JcPXtcJw4BBeP4mQxMr9zTQRcP1eVm5z9ULayifMeXH8vKM3pNq9H0PmaSB6FIYn5Fdox7Y7Mx6s;4:/VxmAatl9eOFMn7gv9LVB73JgMtOePQqi3lekK/4T+Bpcyq/hFyBnAs2NHc2KwzHU+xs6MjBjPcXc9Wi5Q0JWLltjEe90oC3WBXV3OX/lLEuUbI+z1AmT4sbCU30Cz9xp+DGefBdffdhclfkFQSXLWd0nDql95UQwbYLXgCBg+hHsiHeySqq2kUChljA/MfRQ+BYKOvitGKYSwELuNJ73fEaKE4BEslMeEvYJFLB/8W2t+jRJtA1gSPNXpEbXqoMzqNPndZEKD6cxVpkbAapty5XZUwtLwywvsPzmmkdwxifC+sfvUfnWHFzIak7PN4smIkNTNKvjsIjishMVNtdKJvLQBOk5fMt+JgEy+APMp8=
X-Microsoft-Antispam-PRVS: <BN7PR08MB4929472FAA6D70E4E39FD564C1250@BN7PR08MB4929.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BN7PR08MB4929;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4929;
X-Forefront-PRVS: 0759F7A50A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(39850400004)(396003)(366004)(199004)(189003)(47776003)(2351001)(7736002)(81166006)(81156014)(6116002)(3846002)(186003)(16526019)(6506007)(386003)(107886003)(5660300001)(39060400002)(25786009)(1076002)(26005)(8676002)(4477795004)(6666003)(53936002)(478600001)(6512007)(105586002)(106356001)(2361001)(66066001)(53416004)(6486002)(305945005)(6916009)(4326008)(11346002)(50226002)(8936002)(69596002)(476003)(486006)(97736004)(316002)(68736007)(51416003)(52116002)(44832011)(76176011)(16586007)(42882007)(54906003)(50466002)(446003)(2906002)(7416002)(48376002)(956004)(2616005)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4929;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4929;23:liFguk4igToeHImocoOX0kZZhJir+BTSUeBCk7qXn?=
 =?us-ascii?Q?2rmTCycjtO1tvcm8/NOF9xCnQL6bjKmmv8ib4AtM0x+5SnuIZOUUC+JD2XNg?=
 =?us-ascii?Q?Lfs7P2F9SQaZyy5qj9+1Mn6B3vDF/txKmKRK6kSH+UCJCVBf2+njgfV9zW1L?=
 =?us-ascii?Q?7rYeSvVoA9ryhE4AOW3E/Wa3JEgZiFc7LuMES98JVpreMU772aoa8q9hs3EH?=
 =?us-ascii?Q?PRVe6Be9ddyYZQ3jSiATNv+7pijjsCgOev20Or3xiREk1r/JGuPX40jjI2+n?=
 =?us-ascii?Q?IPfB+fRRjZqrqcrq6ESEbzNhbWb7+12n4GlWKeipUm1Tjjm/kI5R6hlNXplg?=
 =?us-ascii?Q?fQ/fOeGN2ewBMTfdPwwZna3NT4srbNGdoqdO6XwH4L+hZZaV/DN2KYV9m3LC?=
 =?us-ascii?Q?oYK/70hWzGs4xRuGYDFgp7sm3OXqKIHgVZOhL5TLPmrVZgSRhdDyTZ9PAK4F?=
 =?us-ascii?Q?jkQm2vxtxbYgtFq+uoCTLNKNyjmlxlpU7n1eX9M+L/1rx/Up6aDPhMvuY3EY?=
 =?us-ascii?Q?u1IGil7JR+rYHj1I6oH9AH0CrW6F6r4FebZOjGKO4VPFWzVcpbKg2ZWxN+r4?=
 =?us-ascii?Q?nuNjLxawBglblT8I5jlXmT0Rw98v05eOeUK49XteE/6i9So7F795peAD/vZt?=
 =?us-ascii?Q?xMdVGqVK8c11PCw8kK+ofb4o5HRHWkPsn3EoaKVNxKVIEDL2AEKG7dTtps6i?=
 =?us-ascii?Q?aHr87t6SfVomGewPY8nNno09Q63YFiLqPSLuRMTjanf7HKCjrKUVTeEwJgml?=
 =?us-ascii?Q?JxAOmFXVc0CyKz5A7GsdoQCzVFLnd0PgQNuHjLxjgmT2GsBG5cyELk70bHQX?=
 =?us-ascii?Q?cFkqukdThf3x0eUKDbJeEhS7Xv5SHocnnLGig+UoxFZ1VDYOAtFORhMeyvyw?=
 =?us-ascii?Q?domZXkT5Rk9oc5+sahOJTkjKvLqTF5SG3NhCVoRRpLviXLQQ+pNPzH5LQQbT?=
 =?us-ascii?Q?PFfEhh3C8hcAmQpkiZMnr//NG1qhoWmLPj41mxfqDmKG7LqFqKxyF/ENLt2x?=
 =?us-ascii?Q?WuRv/wyOPJFIXw9U9nBn2WI5RW74v6Ghwd1TnnCFLrbEjwpZ/jElccaNg+ax?=
 =?us-ascii?Q?dYzp+UTme/Pb4ojsbsg7gf6O97+/rb4SPx2tpEiVbeFEtWNIRr1IVwzvaRap?=
 =?us-ascii?Q?2z4mv+snBVfav8SoRz7Ez0IrM0xt3N/w4MEN9ANCDYDd3lsOA93lM/U8ifCe?=
 =?us-ascii?Q?RbrELfQX2WwZrHgRMAmU2XwCO7GcTGf6c5h3IJi1lRmi19N6ttMnBWVkxqxv?=
 =?us-ascii?Q?DgVes5Lp1VKzrqvfmCInekMmU5CFmk/ZUzaPQkC0lN1dEdr0xNiBm735nBlJ?=
 =?us-ascii?Q?OVLTNXvdC9ZF9zcmAdb9DL8JEq/b6Oenwafg3TKSLUxQcmZp2dZGxvVP28Ts?=
 =?us-ascii?Q?d8Df0tN6xs+apqkorGj3CZ2WiB2k4gwst73WhruediiYmXB?=
X-Microsoft-Antispam-Message-Info: 4hKrRZPSdRlroZBxzsTyqGgTKxXLbcd3iF5EJI7Ar8P9z4I0G9NE8RVA3mMy3Rabpj8d9hxwu+Zq70+/+whayMix7Lr1Cr8E9+HpU18/w5cXRZqaaTaLrx+Sh67qv0hvothLPd8N5BjbJS4meBe97gdGFPc3Xo05dO2dDkCy9G1Kd2FBipiRh9Gsfo7/lkUhEsL46CYrecjUSIYm43oQ07uKNAfXBMB+RIIK9ctpMR+8C+53x/DbZhWa0sjyvvWN28GDeyVcI2rDtQdrIztsDdqLg2+ALnsDGGRHFDoo6uONHFph4GIUZv6HxuxWIKNxWs8MQkB9nOi/FcUuNUqwjy5U3sneU9B2yt57AbGRta8=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;6:XBU6Zri5Y+milPG+q86WkADt4qNwjWn8a6aqeQutuVN4dKVnMAPEIDJ0pPGA31zip8sNzsSY2tDJzJ3HWjI06IfbUwipb9XX4AavkQStuXmyNBCYwb96kfWLe1N6lQexaMuhM8U2W2Ww2w2tZYlnFTNtaQARufjPwbzcE4bTWRlE5mcaiE+/OlWwGYYMy9OoXKRgVnxEh87P9KqQkH5uTUxEtwNy4t1UwTVzcOXd2vxkDSTuxt0zctNIfGmmykSW/JvFg8ILHqtP14l7S/ZytJZG0KN8f2i3/68ftDyd/hw477ZeJ5B/v98h17ojV5ThQUamlK9fcrCIT/8E8hSrA3J5sfOyX3dNNK5+rnvu3JNYkk6MO0dElb24T6mE9xQJ0U4lebmpXsBI0ZOOQexAhI+WNZ16E6rmf4cdNBD9GX3QrfRTFx1TYbFBKfCTbC6RYOrWy2qzVrR6qNe+uHNitA==;5:YhoYvNWsl5kX6yqhgkuBsNlmutKAcfOb3KLOtLNdyzTKn6lvTAU0b/OlL6SYYASbyHjxvM/xPxpQJ+1ITbxaUeCpFSaWAgWxdzE1M+iMD80Rk9Ij+bnwVy39ZbBcOOoyeR8XlJyfU8H5gi3MtOdDJbeeIV548DyN/ydt1HszsBQ=;7:CMrdhoFrnLd/0mcl95MShBqYOcsTajzPkSw4NyMeM3lfrQCVzvQt4paTN4pPs9rFTVlGm5Ywnu0dK0oGcKG1kbckXrTTFfa8yC0MtVl+gL7zoyZj0+UknuTfFX1+wPtQmdukid+NCoMtRzifVdlGbcYtUW0HzBC9e6kB8/mO8ERuxBR6+FadVtz2bQTB+Gm38XfaVFcDljMny5iNXXfs5WfkwaMC7Y00+CzucTqc/0CWHaBEaDZ3Pq+C16DxMjff
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2018 17:45:37.1557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5afe6f-7bb5-4e17-eab4-08d5fe1feb01
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4929
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65499
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
Acked-by: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-alpha@vger.kernel.org

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

Changes in v6: None
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
