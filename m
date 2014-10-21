Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2014 06:31:54 +0200 (CEST)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:53053 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011994AbaJUE2zxR3fT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Oct 2014 06:28:55 +0200
Received: by mail-pa0-f49.google.com with SMTP id hz1so520320pad.8
        for <multiple recipients>; Mon, 20 Oct 2014 21:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5V+Pl944O5hYJOWrcex0EyyqKGTOVYl/WEa60xUnd58=;
        b=XOE1pLMkcnu647cDAmxV0Ra6cpO7JjssDAz9ghHY9x6J9R3kWdU3lJ8ZUcyCy97nYX
         sStXgiCBm6m6OVimLQu9ONhZ1wH1y5xxJKacuh1+w+RcqJy6SEl2CVsGqVv6IcfGhyTK
         WJMTkv9baikzqW8NOrPJDhlaR7RNRAsCDdBFb0NGkLiwUOh31HzOg1AfGe4GoDc65BNx
         OIFcVEufhwVvs0dU1M6qZTsbJzBtaM12X2rqi9Z9QZtYGsDCKjMXmxghryNGue2F/CVO
         Z3dYm8DNsf4i0pGURLyU4Gkq1Ic4ruMN4UwwXi+D0Lu7zHlq4TbloVZLrLAs0t477JKB
         7mbA==
X-Received: by 10.66.222.100 with SMTP id ql4mr8164461pac.123.1413865729807;
        Mon, 20 Oct 2014 21:28:49 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id b2sm10498181pbu.42.2014.10.20.21.28.48
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 20 Oct 2014 21:28:49 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org,
        jfraser@broadcom.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
Subject: [PATCH/RFC 11/17] MIPS: BMIPS: Add PRId for BMIPS5200 (Whirlwind)
Date:   Mon, 20 Oct 2014 21:28:01 -0700
Message-Id: <1413865687-15255-12-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413865687-15255-1-git-send-email-cernekee@gmail.com>
References: <1413865687-15255-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43409
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

This is a dual core (quad thread) BMIPS5000.  It needs a little extra
code to boot the second core (CPU2/CPU3), but for now we can treat it the
same as a single core BMIPS5000.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/include/asm/cpu.h  | 1 +
 arch/mips/kernel/cpu-probe.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index dfdc77e..de9ca43 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -142,6 +142,7 @@
 #define PRID_IMP_BMIPS3300_BUG	0x0000
 #define PRID_IMP_BMIPS43XX	0xa000
 #define PRID_IMP_BMIPS5000	0x5a00
+#define PRID_IMP_BMIPS5200	0x5b00
 
 #define PRID_REV_BMIPS4380_LO	0x0040
 #define PRID_REV_BMIPS4380_HI	0x006f
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 94c4a0c..5477d91 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1024,6 +1024,7 @@ static inline void cpu_probe_broadcom(struct cpuinfo_mips *c, unsigned int cpu)
 		break;
 	}
 	case PRID_IMP_BMIPS5000:
+	case PRID_IMP_BMIPS5200:
 		c->cputype = CPU_BMIPS5000;
 		__cpu_name[cpu] = "Broadcom BMIPS5000";
 		set_elf_platform(cpu, "bmips5000");
-- 
2.1.1
