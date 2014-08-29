Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Aug 2014 05:37:19 +0200 (CEST)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:43079 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007124AbaH2DhQUrEfa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Aug 2014 05:37:16 +0200
Received: by mail-pa0-f42.google.com with SMTP id lf10so5235817pab.1
        for <multiple recipients>; Thu, 28 Aug 2014 20:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=rA20CEG/h5MCKQ+PE0uT6UBbfhdqLqKVpjzN5f/GCAw=;
        b=Lwr3vhrC7plxeYSIcjlQO8qPKSak8V14JAbjsEzL7RkInV4HvU8WbSpoNXb79DITXm
         FN9ek7RQ8QppWu0cJok640Ua66NcYI6Gn4ON7ohQvuE2JS22andyaI/OpS03CwM60tQH
         YwFK/BIf1bUdCQw08gWKRXq8xrwb665id1wrB/cfvzJSsxUk0T6qzAKcdz68P2Ft41G1
         keSRUh48Pl21iU6Gpo5qpnwHeMD2wuz5/eQlkg6R2RmDIpBmWSn99xqalPgDaryUQxRI
         4PjrTv6imt9bh1rOgXivVyqJhQd+1WMF1a5UHQoT2ZR0ntTHqeYgw0IAZziPYAvvx40y
         GpWg==
X-Received: by 10.68.171.101 with SMTP id at5mr11684843pbc.107.1409283429653;
        Thu, 28 Aug 2014 20:37:09 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id hc11sm5050899pbd.70.2014.08.28.20.37.05
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 28 Aug 2014 20:37:08 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH] MIPS: Loongson: Fix the write-combine CCA value setting
Date:   Fri, 29 Aug 2014 11:36:56 +0800
Message-Id: <1409283416-16926-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42315
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

All Loongson-2/3 processors support _CACHE_UNCACHED_ACCELERATED, not
only Loongson-3A.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/kernel/cpu-probe.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 94c4a0c..08dc945 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -765,7 +765,6 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 			break;
 		case PRID_REV_LOONGSON3A:
 			c->cputype = CPU_LOONGSON3;
-			c->writecombine = _CACHE_UNCACHED_ACCELERATED;
 			__cpu_name[cpu] = "ICT Loongson-3";
 			set_elf_platform(cpu, "loongson3a");
 			break;
@@ -782,6 +781,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 			     MIPS_CPU_FPU | MIPS_CPU_LLSC |
 			     MIPS_CPU_32FPR;
 		c->tlbsize = 64;
+		c->writecombine = _CACHE_UNCACHED_ACCELERATED;
 		break;
 	case PRID_IMP_LOONGSON_32:  /* Loongson-1 */
 		decode_configs(c);
-- 
1.7.7.3
