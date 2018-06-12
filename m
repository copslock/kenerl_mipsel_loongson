Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jun 2018 11:50:37 +0200 (CEST)
Received: from mail-pl0-x244.google.com ([IPv6:2607:f8b0:400e:c01::244]:39163
        "EHLO mail-pl0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992497AbeFLJuZp11Of (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Jun 2018 11:50:25 +0200
Received: by mail-pl0-x244.google.com with SMTP id f1-v6so14079327plt.6;
        Tue, 12 Jun 2018 02:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0mOnMs2BjK65i3sx4aQyomsWdirSXf5uwWpKmel7wvM=;
        b=KVut6Gdoc8T9eo2/L2G2P0D5lV3ITmPobzu3q7bM5xV/Fglb+deaQCw4Gli3EXhStM
         oDKqOFTQR7zEXBjU3aqyZOX+ySD8+k1jCK13JdhP0yPhzsn+TLMUy6sZ3zCP01CTDuOR
         wcTSnaOlXdgg+jiDRh6Q6zK53o0+ZghhSOtrcqHq0xaPeif3gG2pz32X0DsakmtRxmQa
         farVsGCS3583oO/oFrg7qCeW5TdL5533woZ8y4IeU4xrsSk+MFfQda3mNw88HuOvWOQS
         LndRiT3o8d54ZtkOKVFwVLbcJFKlmbPbPuUlSngqHXK2m2J63DDY2mkR39cJJa6yLudg
         +s+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=0mOnMs2BjK65i3sx4aQyomsWdirSXf5uwWpKmel7wvM=;
        b=rhTbn1dh15Dbm25sYjImVcajSTKGuDZubT1Ym6TVjiZhR3qt/L6Tb/W6R1qiRWelf8
         9mrQL5orDQTo664jmlVUBTa1b/hmuOHcwdZwcXzHnnZ4yp2WvrP/ign/yPmdUzXWGCLA
         QGuSQPXeUfkZg+PyjESihEWeg4MMDYQRYekRo7MdD6Ljgoj0Ii+sexhxuayPMwWJx/5/
         nSuCIgDTq32RsoQN45C1bVjxhNryemqJJeeh9z9mvUhbs7HYa1cOC/1CwJ1Ye8Ho8B2w
         QAzHTeGi0Tuaqr+nyf+E+RAnBCFBPMy9+wUhT5/MWHh65HHvvhlAbBg/MgOKpqRe/+iE
         LH/g==
X-Gm-Message-State: APt69E03E9pwadwPgozzosu0dyiKYKH/OmUy3XlfThVdsY6QCY7jovn+
        6PTl03oxoccji8nXHrNR7pnBTw==
X-Google-Smtp-Source: ADUXVKK44pt9WVz8+Q/yddUNfrtcccbWscfEmwDGla+Zpm988X/LKO6uAtv3/k8auK5fl6NzJj5/vg==
X-Received: by 2002:a17:902:8a82:: with SMTP id p2-v6mr3387380plo.244.1528797019388;
        Tue, 12 Jun 2018 02:50:19 -0700 (PDT)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id o66-v6sm1881485pfi.157.2018.06.12.02.50.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Jun 2018 02:50:18 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <james.hogan@mips.com>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH Resend 2/2] MIPS: mcs lock: implement arch_mcs_spin_lock_contended() for Loongson-3
Date:   Tue, 12 Jun 2018 17:54:43 +0800
Message-Id: <1528797283-16577-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1528797283-16577-1-git-send-email-chenhc@lemote.com>
References: <1528797283-16577-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64240
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

After commit 7f56b58a92aaf2c ("locking/mcs: Use smp_cond_load_acquire()
in MCS spin loop") Loongson-3 fails to boot. This is because Loongson-3
has SFB (Store Fill Buffer) and need a mb() after every READ_ONCE().

This patch introduce a MIPS-specific mcs_spinlock.h and revert to the
old implementation of arch_mcs_spin_lock_contended() for Loongson-3.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/Kbuild         |  1 -
 arch/mips/include/asm/mcs_spinlock.h | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/include/asm/mcs_spinlock.h

diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index 45d541b..7076627 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -6,7 +6,6 @@ generic-y += emergency-restart.h
 generic-y += export.h
 generic-y += irq_work.h
 generic-y += local64.h
-generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
 generic-y += parport.h
 generic-y += percpu.h
diff --git a/arch/mips/include/asm/mcs_spinlock.h b/arch/mips/include/asm/mcs_spinlock.h
new file mode 100644
index 0000000..063df4e
--- /dev/null
+++ b/arch/mips/include/asm/mcs_spinlock.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_MCS_LOCK_H
+#define __ASM_MCS_LOCK_H
+
+/* Loongson-3 need a mb() after every READ_ONCE() */
+#if defined(CONFIG_CPU_LOONGSON3) && defined(CONFIG_SMP)
+#define arch_mcs_spin_lock_contended(l)					\
+do {									\
+	while (!(smp_load_acquire(l)))					\
+		cpu_relax();						\
+} while (0)
+#endif	/* CONFIG_CPU_LOONGSON3 && CONFIG_SMP */
+
+#endif	/* __ASM_MCS_LOCK_H */
-- 
2.7.0
