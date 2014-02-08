Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Feb 2014 05:40:04 +0100 (CET)
Received: from mail-pb0-f41.google.com ([209.85.160.41]:37177 "EHLO
        mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823014AbaBHEjsMPJDu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Feb 2014 05:39:48 +0100
Received: by mail-pb0-f41.google.com with SMTP id up15so4119980pbc.0
        for <multiple recipients>; Fri, 07 Feb 2014 20:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O0RJlHRMCz2YtEsxJN5BMOWY+HBpibMIPe7fz7PdxLw=;
        b=V5HtcCaqKS77wKR7STHw9ogC8KQ2ZD4w9KQvLMebNXK4CYh4v4tvmKSWl3ljesz1Fx
         RN8Y0AmeeN9zu5M6+WcoyoMogsALw1boiLKSxs3RBGeWRkX5Q/V6/uNTvs4Vin1se8WA
         KihOwFZBPGyyQ4dPFuj1oWs6s15z4cv/tGXZlWOXmPszZOig7Dhs9gJUrla6L3BX67rV
         NxhOwu+mx3xNzRpeLbIGrMuNSU0dASQWyOdRmSB8veQfPt+rvXbxNjaEsjiJ4hYsmuQO
         MKKWD9QizBLpAnJZW1J+2DUI87JpE7SPf5YBQ2LgfLKPNfc6vqpqi9p987m4TxxTjq0p
         VTNA==
X-Received: by 10.66.220.198 with SMTP id py6mr12188585pac.21.1391834381675;
        Fri, 07 Feb 2014 20:39:41 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id qq5sm19189505pbb.24.2014.02.07.20.39.34
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Feb 2014 20:39:40 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V17 01/13] MIPS: Loongson: Rename PRID_IMP_LOONGSON1 and PRID_IMP_LOONGSON2
Date:   Sat,  8 Feb 2014 12:38:50 +0800
Message-Id: <1391834342-8177-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1391834342-8177-1-git-send-email-chenhc@lemote.com>
References: <1391834342-8177-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39238
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

Loongson-1 is a 32-bit MIPS CPU and Loongson-2/3 are 64-bit MIPS CPUs,
and both Loongson-2/3 has the same PRID IMP filed (0x6300). As a
result, renaming PRID_IMP_LOONGSON1 and PRID_IMP_LOONGSON2 to
PRID_IMP_LOONGSON_32 and PRID_IMP_LOONGSON_64 will make more sense.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/cpu.h  |    4 ++--
 arch/mips/kernel/cpu-probe.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 76411df..0792c4e 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -82,10 +82,10 @@
 #define PRID_IMP_RM7000		0x2700
 #define PRID_IMP_NEVADA		0x2800		/* RM5260 ??? */
 #define PRID_IMP_RM9000		0x3400
-#define PRID_IMP_LOONGSON1	0x4200
+#define PRID_IMP_LOONGSON_32	0x4200  /* Loongson-1 */
 #define PRID_IMP_R5432		0x5400
 #define PRID_IMP_R5500		0x5500
-#define PRID_IMP_LOONGSON2	0x6300
+#define PRID_IMP_LOONGSON_64	0x6300  /* Loongson-2/3 */
 
 #define PRID_IMP_UNKNOWN	0xff00
 
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 530f832..ad776a1 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -710,7 +710,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 			     MIPS_CPU_LLSC;
 		c->tlbsize = 64;
 		break;
-	case PRID_IMP_LOONGSON2:
+	case PRID_IMP_LOONGSON_64:  /* Loongson-2/3 */
 		c->cputype = CPU_LOONGSON2;
 		__cpu_name[cpu] = "ICT Loongson-2";
 
@@ -729,7 +729,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 			     MIPS_CPU_32FPR;
 		c->tlbsize = 64;
 		break;
-	case PRID_IMP_LOONGSON1:
+	case PRID_IMP_LOONGSON_32:  /* Loongson-1 */
 		decode_configs(c);
 
 		c->cputype = CPU_LOONGSON1;
-- 
1.7.7.3
