Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2014 07:14:10 +0100 (CET)
Received: from mail-pa0-f51.google.com ([209.85.220.51]:49488 "EHLO
        mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011008AbaKDGN4T1GCo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Nov 2014 07:13:56 +0100
Received: by mail-pa0-f51.google.com with SMTP id kq14so13671557pab.24
        for <multiple recipients>; Mon, 03 Nov 2014 22:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pyEtRbM0Lg69CiV1wdWMazx+ufPTVz8RxTlbDKaPxAw=;
        b=I4+oxAkKWV95BmlWSiTGmd0uHkFFKTCzOGTdGu0uF3HzvWBT2P81djpcxCRNfEF1sb
         S/fp1/ES8+VD6f9jz+ytr0ps2vwffUzhyYnyz2OJioCFIDThtKyeZDAn/puUsqPyW492
         IZVT1HJjGDtGVqo4Hsw4pPiG5mUEN9p0wrl9lw5rHRghs3QmymCkrnHw3Y5RmPBmNnu2
         AIB7z6hjU7hn8xi1BObnH22jp81MUvqmU+jMaUUlHuHSpszxjt3KOt9JrT3M9AgthSld
         gjQJNv3cGmflAAL2fFHSI/dyhQHS4Wfo+gLWMrkubub+7hiV7/ZHqttNtzkDU0Kdvkzl
         jYWA==
X-Received: by 10.68.132.225 with SMTP id ox1mr47654203pbb.85.1415081630062;
        Mon, 03 Nov 2014 22:13:50 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id cs9sm7712498pac.8.2014.11.03.22.13.46
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 03 Nov 2014 22:13:49 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2 01/12] MIPS: Loongson: Fix the write-combine CCA value setting
Date:   Tue,  4 Nov 2014 14:13:22 +0800
Message-Id: <1415081610-25639-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1415081610-25639-1-git-send-email-chenhc@lemote.com>
References: <1415081610-25639-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43850
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
index 25554f2..929e524 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -825,7 +825,6 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 			break;
 		case PRID_REV_LOONGSON3A:
 			c->cputype = CPU_LOONGSON3;
-			c->writecombine = _CACHE_UNCACHED_ACCELERATED;
 			__cpu_name[cpu] = "ICT Loongson-3";
 			set_elf_platform(cpu, "loongson3a");
 			break;
@@ -842,6 +841,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 			     MIPS_CPU_FPU | MIPS_CPU_LLSC |
 			     MIPS_CPU_32FPR;
 		c->tlbsize = 64;
+		c->writecombine = _CACHE_UNCACHED_ACCELERATED;
 		break;
 	case PRID_IMP_LOONGSON_32:  /* Loongson-1 */
 		decode_configs(c);
-- 
1.7.7.3
