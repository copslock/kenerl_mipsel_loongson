Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Mar 2015 18:26:15 +0100 (CET)
Received: from mail-pd0-f202.google.com ([209.85.192.202]:34620 "EHLO
        mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014620AbbCYRZ6WQ0sE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Mar 2015 18:25:58 +0100
Received: by pdjy10 with SMTP id y10so2402922pdj.1
        for <linux-mips@linux-mips.org>; Wed, 25 Mar 2015 10:25:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gAR2Du0+fploG+yKw2JGMQBnBjFhUPdtXOmMXhTeW7g=;
        b=gD3Ys7tgcQ0FRgmMCj1YAmXObzswGeZOD3/xu5zZ0jqla0SxSQGQQx3k0AtCQBQXmR
         49TqLms3D1Fr3/KDyytj3tjxFUzAOnMCyVxOkkCzulcxI/hkJIJf7hS/ch19PExb/YrE
         xcdQlNOm1ztpz4gehquXMQzEkQlgA+nUBdglVDmws5SBSKQoO1sEvqzukZUG5Y7JsGWi
         11bQgXPGZHDFFV47iDFu5+PdmoZoUGelWUCLE+tNJNJWhFDQAWeaj4O5XIu3Rpb9i+vS
         sHaQ1Dk0BUhE/j+fGCdwqz0kRAAg8Eurwr5vBfzfj6DIcGcOOAVYVa6rRwExQQLtiyph
         eVAg==
X-Gm-Message-State: ALoCoQmnJ3lVv+m95IkjweioStoaMGB4rmX7Ci4zoLHvMtHHCrVuiCZmEpfM8QaShIK4dXZU48Qq
X-Received: by 10.66.153.6 with SMTP id vc6mr11720495pab.37.1427304353195;
        Wed, 25 Mar 2015 10:25:53 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id oc12si389094pdb.1.2015.03.25.10.25.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2015 10:25:53 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id OZ2huqQp.1; Wed, 25 Mar 2015 10:25:52 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id D89022206EA; Wed, 25 Mar 2015 10:25:45 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hogan <james.hogan@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: [PATCH V2 1/2] MIPS: smp: Make stop_this_cpu() actually stop the CPU
Date:   Wed, 25 Mar 2015 10:25:43 -0700
Message-Id: <1427304344-24739-1-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46526
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

Since cpu_wait() enables interrupts upon return, CPUs which have
entered stop_this_cpu() may still end up handling interrupts.
This can lead to the softlockup detector firing on a panic or
restart/poweroff/halt.  Just disable interrupts and spin to ensure
nothing else runs on the CPU once it has entered stop_this_cpu().

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Maciej W. Rozycki <macro@linux-mips.org>
---
New for v2.
---
 arch/mips/kernel/smp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 1c0d8c5..5b020bd 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -176,10 +176,8 @@ static void stop_this_cpu(void *dummy)
 	 * Remove this CPU:
 	 */
 	set_cpu_online(smp_processor_id(), false);
-	for (;;) {
-		if (cpu_wait)
-			(*cpu_wait)();		/* Wait if available. */
-	}
+	local_irq_disable();
+	while (1);
 }
 
 void smp_send_stop(void)
-- 
2.2.0.rc0.207.ga3a616c
