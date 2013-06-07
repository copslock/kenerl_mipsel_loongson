Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jun 2013 01:08:54 +0200 (CEST)
Received: from mail-ie0-f173.google.com ([209.85.223.173]:61622 "EHLO
        mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835165Ab3FGXD4489Jk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jun 2013 01:03:56 +0200
Received: by mail-ie0-f173.google.com with SMTP id k5so5432004iea.32
        for <multiple recipients>; Fri, 07 Jun 2013 16:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=BntkHyEbyQCmrkicJ89FrUBh+C3g07Qj7X/Q4sgELCA=;
        b=TFjb66et0AlHV7Vf442BrPjFvX/xXHCDepwC643wwKmAk1oQ5fCQ9ia04dIgGL2VAD
         QBgFh16cBsxgDY2PvIvTsWhkgPz7pj9F2eqq9cYUwU2uGTtDFM8+08m6xopNNYIky+VU
         7TzDDTosL6zQwO3AFMIdOs6RulJTWCDfWhc/O+XBeL5oubSrsfS7DceQ0DUMEQ8VvMdp
         /kPXRZSY0kvnmbU2tTRRKC4qtWe68CaVAee1L5FQ1nNMwBvhSK8c1TYAl8Eilu7wxmFU
         bHz01GWpFIXgZnv2bpPkgAbULrEZwXh8QhcFRarXT0m/uMxiPpgVteKRtGahPY2GWfFA
         hmyw==
X-Received: by 10.50.28.78 with SMTP id z14mr446675igg.26.1370646230837;
        Fri, 07 Jun 2013 16:03:50 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id lr5sm225428igb.1.2013.06.07.16.03.48
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 16:03:49 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r57N3lLb006666;
        Fri, 7 Jun 2013 16:03:47 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r57N3lud006665;
        Fri, 7 Jun 2013 16:03:47 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 14/31] mips/kvm: Add thread_info flag to indicate operation in MIPS VZ Guest Mode.
Date:   Fri,  7 Jun 2013 16:03:18 -0700
Message-Id: <1370646215-6543-15-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36732
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/thread_info.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
index 895320e..a7a894a 100644
--- a/arch/mips/include/asm/thread_info.h
+++ b/arch/mips/include/asm/thread_info.h
@@ -109,6 +109,7 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_RESTORE_SIGMASK	9	/* restore signal mask in do_signal() */
 #define TIF_USEDFPU		16	/* FPU was used by this task this quantum (SMP) */
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
+#define TIF_GUESTMODE		19	/* If set, running in VZ Guest mode. */
 #define TIF_FIXADE		20	/* Fix address errors in software */
 #define TIF_LOGADE		21	/* Log address errors to syslog */
 #define TIF_32BIT_REGS		22	/* also implies 16/32 fprs */
@@ -124,6 +125,7 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_SECCOMP		(1<<TIF_SECCOMP)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
 #define _TIF_USEDFPU		(1<<TIF_USEDFPU)
+#define _TIF_GUESTMODE		(1<<TIF_GUESTMODE)
 #define _TIF_FIXADE		(1<<TIF_FIXADE)
 #define _TIF_LOGADE		(1<<TIF_LOGADE)
 #define _TIF_32BIT_REGS		(1<<TIF_32BIT_REGS)
-- 
1.7.11.7
