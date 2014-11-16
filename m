Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Nov 2014 01:24:17 +0100 (CET)
Received: from mail-pa0-f48.google.com ([209.85.220.48]:56854 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013775AbaKPATwEuOsk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Nov 2014 01:19:52 +0100
Received: by mail-pa0-f48.google.com with SMTP id rd3so6261592pab.35
        for <multiple recipients>; Sat, 15 Nov 2014 16:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5V+Pl944O5hYJOWrcex0EyyqKGTOVYl/WEa60xUnd58=;
        b=tLuDOm5Rc+2vzTOkKFPXLWOog7aRZnYUJ57DklLQD2mCd1RKdduQlVinXLxVpBV4cQ
         LyJNYOWtfJ/aQNm2TjN3k/MrazWA0hseniwuBJaJmcOJi0Y9+RaFK99O8mx/tDCWawoM
         cKog+SbKU4GDMQs+LtEkFqKUZnn4aYiCZM2SnnJQZyHXIDL+mBtZK/5MbZX5ymMoQ9TP
         i0RD105IeEuPTr4Lv3QwqoDngXMg9aPVY7MlaI/I1v6d/kW+Yel/ZDCMLpuoRgfw8I6/
         ZHFXuNK7riKspQrSjAfqeyj63DKBEuVjo9Q8PTf3jIWfB7AzzpH5TDPZcl2eIe25tlsS
         KO4A==
X-Received: by 10.70.92.169 with SMTP id cn9mr67011pdb.117.1416097186459;
        Sat, 15 Nov 2014 16:19:46 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id xn4sm11099440pab.9.2014.11.15.16.19.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Nov 2014 16:19:45 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jfraser@broadcom.com, dtor@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 17/22] MIPS: BMIPS: Add PRId for BMIPS5200 (Whirlwind)
Date:   Sat, 15 Nov 2014 16:17:41 -0800
Message-Id: <1416097066-20452-18-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
References: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44208
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
