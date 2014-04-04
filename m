Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Apr 2014 10:15:34 +0200 (CEST)
Received: from mail-pb0-f54.google.com ([209.85.160.54]:49000 "EHLO
        mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822336AbaDDINSGmYuA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Apr 2014 10:13:18 +0200
Received: by mail-pb0-f54.google.com with SMTP id ma3so3133789pbc.27
        for <multiple recipients>; Fri, 04 Apr 2014 01:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vRkkRwt0P56drT/Sjjcijvb9vOj5mHoojCnAgR09Wrg=;
        b=KQrRCE7YlMjpom1Gj40k34oO8jcgeP8bxMDK+3aXGx/s3IiJVO4KCKCb0EL30XFN7K
         wBz/o/RpoxSnCUkWqacvXUPNACUd4pgb/oZsiv3uiCMckEZLWRunprQJ/01WAwLcXfaR
         rrYA0aF/wy3F7WpPM47vemoIl7oK4PiRBhVBE703LNFibDv8CK6fzCOzhi6Uie+vw0eP
         pIJvxF56HS/YaRWSqK5B4VQYC3Lg4jsdIAMbhuWuplmWXB9PXWu1ozfiz+XpbFsUU7iD
         u6omTDNqt+WxkeEjav69x8irAbFiYZsDGh7xF2MqjRWGXrZkw02paEF4qFREsfmETVNq
         o83Q==
X-Received: by 10.68.100.1 with SMTP id eu1mr13466456pbb.36.1396599191840;
        Fri, 04 Apr 2014 01:13:11 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id pe3sm16066819pbc.23.2014.04.04.01.13.06
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 04 Apr 2014 01:13:11 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 7/9] MIPS: Loongson: Make CPU name more clear
Date:   Fri,  4 Apr 2014 16:11:42 +0800
Message-Id: <1396599104-24370-8-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1396599104-24370-1-git-send-email-chenhc@lemote.com>
References: <1396599104-24370-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39647
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

Make names in /proc/cpuinfo more human-readable, Since GCC support the
new-style names for a long time, this may not break -march=native any
more.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/kernel/cpu-probe.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 585f996..2576d53 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -742,23 +742,23 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		switch (c->processor_id & PRID_REV_MASK) {
 		case PRID_REV_LOONGSON2E:
 			c->cputype = CPU_LOONGSON2;
-			__cpu_name[cpu] = "ICT Loongson-2";
+			__cpu_name[cpu] = "ICT Loongson-2E";
 			set_elf_platform(cpu, "loongson2e");
 			break;
 		case PRID_REV_LOONGSON2F:
 			c->cputype = CPU_LOONGSON2;
-			__cpu_name[cpu] = "ICT Loongson-2";
+			__cpu_name[cpu] = "ICT Loongson-2F";
 			set_elf_platform(cpu, "loongson2f");
 			break;
 		case PRID_REV_LOONGSON3A:
 			c->cputype = CPU_LOONGSON3;
-			__cpu_name[cpu] = "ICT Loongson-3";
+			__cpu_name[cpu] = "ICT Loongson-3A";
 			set_elf_platform(cpu, "loongson3a");
 			break;
 		case PRID_REV_LOONGSON3B_R1:
 		case PRID_REV_LOONGSON3B_R2:
 			c->cputype = CPU_LOONGSON3;
-			__cpu_name[cpu] = "ICT Loongson-3";
+			__cpu_name[cpu] = "ICT Loongson-3B";
 			set_elf_platform(cpu, "loongson3b");
 			break;
 		}
-- 
1.7.7.3
