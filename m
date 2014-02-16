Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Feb 2014 09:03:10 +0100 (CET)
Received: from mail-pd0-f170.google.com ([209.85.192.170]:45457 "EHLO
        mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822682AbaBPIC1vQDAo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Feb 2014 09:02:27 +0100
Received: by mail-pd0-f170.google.com with SMTP id p10so13660050pdj.15
        for <multiple recipients>; Sun, 16 Feb 2014 00:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RxDVAN1n1j6F6X0xYE0Rf7ECUeUhvwLjjOCqjT/k44c=;
        b=Y2N7z15ZzvofFk63z4S5WtWyaoRGiS8eBkrW+kK4MA5/dk5UQ5Wf6HtHdFTDxu/d3j
         HXSd7KHLdwmVwD04HpTGgoIoQWxufaMTKyefiLRT9Ec3M21Q8IkDMZPZKWp5ENHs641x
         iKqYF2El5BLn16akOJ6VAv2BypQWiCIaPMTe6BTcjZrpQVpwZ/ZcGA6kZmjDfSouu1uy
         XauI0fvHEjItkdLCJA1Pz3+gIPFREe09aU6quIz1clpzN2QRMnpCxf9rRMsztw6ApXNW
         67WmJRG7T/B38onW056tinmeHS2CVXfCLdnZOW3vnWiVkMQsspBgg6SqC2n3zw2fWian
         tg6g==
X-Received: by 10.68.241.198 with SMTP id wk6mr19423848pbc.11.1392537741389;
        Sun, 16 Feb 2014 00:02:21 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id ei4sm33661111pbb.42.2014.02.16.00.02.05
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 16 Feb 2014 00:02:20 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V19 01/13] MIPS: Loongson: Rename PRID_IMP_LOONGSON1 and PRID_IMP_LOONGSON2
Date:   Sun, 16 Feb 2014 16:01:18 +0800
Message-Id: <1392537690-5961-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1392537690-5961-1-git-send-email-chenhc@lemote.com>
References: <1392537690-5961-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39312
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
Tested-by: Alex Smith <alex.smith@imgtec.com>
Reviewed-by: Alex Smith <alex.smith@imgtec.com>
---
 arch/mips/include/asm/cpu.h  |    4 ++--
 arch/mips/kernel/cpu-probe.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index c12d997..e195de5 100644
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
index e225b0d..5e92b4d 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -734,7 +734,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 			     MIPS_CPU_LLSC;
 		c->tlbsize = 64;
 		break;
-	case PRID_IMP_LOONGSON2:
+	case PRID_IMP_LOONGSON_64:  /* Loongson-2/3 */
 		c->cputype = CPU_LOONGSON2;
 		__cpu_name[cpu] = "ICT Loongson-2";
 
@@ -753,7 +753,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 			     MIPS_CPU_32FPR;
 		c->tlbsize = 64;
 		break;
-	case PRID_IMP_LOONGSON1:
+	case PRID_IMP_LOONGSON_32:  /* Loongson-1 */
 		decode_configs(c);
 
 		c->cputype = CPU_LOONGSON1;
-- 
1.7.7.3
