Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Apr 2016 08:14:48 +0200 (CEST)
Received: from smtpbg202.qq.com ([184.105.206.29]:36539 "EHLO smtpbg202.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27026343AbcDTGOqbcMr4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Apr 2016 08:14:46 +0200
X-QQ-mid: bizesmtp14t1461132844t879t20
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 20 Apr 2016 14:13:47 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK60000A0000000
X-QQ-FEAT: u9yQq91qdYWzgs9tHbJ03QZJh8l2yBCzSrXNg/zEP3YLGvh5UI9wkuFMI0qWB
        5zuIrpVKqP5/QdaE7cIghdr+0/Hg9uf+IaXFh76m5y4WKIL5ZO6t24Kviqjya0FmWBg2MBN
        guIh1DT7wDsl/X6/FUVqdZUdrlaCCSWbOfyuZpTH0y34g5gbcqSt9B5BGxoakZwwrlJRdGB
        S7aZFJ8uggL44pGQthYenEOs4ps/NIcJhZw/+3PQscCahth76q8VABBnlM0kTqN02xvj7KY
        YU6/tY41WKhRSM0RxZONfTFJY=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH] MIPS: Loongson: Adjust cpu features for Loongson-3
Date:   Wed, 20 Apr 2016 14:14:42 +0800
Message-Id: <1461132882-23933-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53116
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Some Loongson-3 features (i.e., cpu_has_wsbh, cpu_has_ic_fills_f_dc and
cpu_hwrena_impl_bits) are different from Loongson-2, so we define them
in a single group. This also fixes 04a35922c1dac ("MIPS: Loongson: Add
Loongson-3A R2 basic support") which breaks Loongson-2E/2F's booting.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h b/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
index c3406db..89328a3d 100644
--- a/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
@@ -27,7 +27,6 @@
 #define cpu_has_dc_aliases	(PAGE_SIZE < 0x4000)
 #define cpu_has_divec		0
 #define cpu_has_ejtag		0
-#define cpu_has_ic_fills_f_dc	0
 #define cpu_has_inclusive_pcaches	1
 #define cpu_has_llsc		1
 #define cpu_has_mcheck		0
@@ -45,7 +44,10 @@
 #define cpu_has_watch		1
 #define cpu_has_local_ebase	0
 
-#define cpu_has_wsbh		IS_ENABLED(CONFIG_CPU_LOONGSON3)
+#ifdef CONFIG_CPU_LOONGSON3
+#define cpu_has_wsbh		1
+#define cpu_has_ic_fills_f_dc	1
 #define cpu_hwrena_impl_bits	0xc0000000
+#endif
 
 #endif /* __ASM_MACH_LOONGSON64_CPU_FEATURE_OVERRIDES_H */
-- 
2.7.0
