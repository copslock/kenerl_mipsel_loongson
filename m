Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jun 2013 01:12:38 +0200 (CEST)
Received: from mail-ie0-f182.google.com ([209.85.223.182]:43004 "EHLO
        mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835175Ab3FGXD7udCtk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jun 2013 01:03:59 +0200
Received: by mail-ie0-f182.google.com with SMTP id 9so12101396iec.13
        for <multiple recipients>; Fri, 07 Jun 2013 16:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=StQaX6e1pWjJQ/0Stg2SvHNvDHAERV6u5Uy43XvmoZQ=;
        b=L5EZi12ilIs8fBSLiI/lAg43IwJSxA+nk094jFfYCQmQtmwKjXRX2K0N2tlSRqeTnp
         OZ7j2DER3JSdej+ZlKuyhPIGjmHPIbU05WMCfwpA3b4UJdOVVG698Ax3wXvJMXLjTirA
         zdZUZ7OFUvGXHgaSvW3WrSn/m7jH4soeF9T8371pn7FMebW0HoL+bSaeCIvETB+Xa75H
         0ICcJLTvgJtZGvuwzc+ZbkTZO3kckKAufQcWfL18KxP6lVjmm79kUkbbakkCncFYqqyB
         1uFT6xU2QhFKxNDdRuEkUdgG31Tg8OfVho6vwniwglZZtL89QkLukFF9vAKAZ0V3F7Z2
         RLkg==
X-Received: by 10.50.153.113 with SMTP id vf17mr2204121igb.101.1370646233700;
        Fri, 07 Jun 2013 16:03:53 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id wn10sm215452igb.2.2013.06.07.16.03.52
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 16:03:52 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r57N3oJQ006702;
        Fri, 7 Jun 2013 16:03:50 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r57N3oN9006701;
        Fri, 7 Jun 2013 16:03:50 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 23/31] mips/kvm: Hook into CP unusable exception handler.
Date:   Fri,  7 Jun 2013 16:03:27 -0700
Message-Id: <1370646215-6543-24-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36741
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

The MIPS VZ KVM code needs this to be able to manage the FPU.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/kernel/traps.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index fca0a2f..2bdeb32 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -56,6 +56,7 @@
 #include <asm/types.h>
 #include <asm/stacktrace.h>
 #include <asm/uasm.h>
+#include <asm/kvm_mips_vz.h>
 
 extern void check_wait(void);
 extern asmlinkage void rollback_handle_int(void);
@@ -1045,6 +1046,13 @@ asmlinkage void do_cpu(struct pt_regs *regs)
 	int status;
 	unsigned long __maybe_unused flags;
 
+#ifdef CONFIG_KVM_MIPSVZ
+	if (test_tsk_thread_flag(current, TIF_GUESTMODE)) {
+		if (mipsvz_cp_unusable(regs))
+			return;
+	}
+#endif
+
 	die_if_kernel("do_cpu invoked from kernel context!", regs);
 
 	cpid = (regs->cp0_cause >> CAUSEB_CE) & 3;
-- 
1.7.11.7
