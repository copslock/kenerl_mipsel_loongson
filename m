Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Nov 2014 01:21:47 +0100 (CET)
Received: from mail-pa0-f41.google.com ([209.85.220.41]:50781 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013763AbaKPAThwTiNs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Nov 2014 01:19:37 +0100
Received: by mail-pa0-f41.google.com with SMTP id rd3so5335495pab.0
        for <multiple recipients>; Sat, 15 Nov 2014 16:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ijs4Morocr+cn4Wzl+0CFx1vVKltsVnwIo6DvM81bhA=;
        b=q/u+eQ+EK+ChysNuyP7kpYDjtA9qco4SqaKuqJCE9tDBnKOdfbrGv73sbfkGr65Ajw
         /Ll2KNTRgMqqqIoD2mic25RmvpWbgG0/E1Dmb0hsANI6KhW8dusv+HCOYEQ2r4NL10IK
         zcuGxxNYq9fQ1GlzLvnUnQfne93u06OzB7axH/0d9gsaBxdOgXIS2sHgbSkZts5p2Tsd
         mCB8cwq8V+GrUMEwh3QNptwEXHePrRNZ8DHM5B+flPecbddxBproHAtEbUfeRhvh0ZWM
         F8qWEhJIBH16E1PyrFlm1gfQZyfgNfBIzILvsdmZT7V8dkEGb8LyGxByftAuGhzxfExN
         +qcQ==
X-Received: by 10.66.182.130 with SMTP id ee2mr19970979pac.22.1416097172109;
        Sat, 15 Nov 2014 16:19:32 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id xn4sm11099440pab.9.2014.11.15.16.19.30
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Nov 2014 16:19:31 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jfraser@broadcom.com, dtor@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 08/22] MIPS: BMIPS: Align secondary boot sequence with latest firmware releases
Date:   Sat, 15 Nov 2014 16:17:32 -0800
Message-Id: <1416097066-20452-9-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
References: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44199
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

On some older BMIPS5200 (dual core / quad thread) platforms, the
PROM code set up CPU2/CPU3 so they would be started through an NMI
instead of through the ACTION register.  But this was incompatible with
some power management features that were later added, so the scheme was
changed so that Linux is fully responsible for booting CPU2/CPU3.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/kernel/smp-bmips.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index 06bb5ed..4e56911 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -213,17 +213,7 @@ static void bmips_boot_secondary(int cpu, struct task_struct *idle)
 				set_c0_brcm_cmt_ctrl(0x01);
 			break;
 		case CPU_BMIPS5000:
-			if (cpu & 0x01)
-				write_c0_brcm_action(ACTION_BOOT_THREAD(cpu));
-			else {
-				/*
-				 * core N thread 0 was already booted; just
-				 * pulse the NMI line
-				 */
-				bmips_write_zscm_reg(0x210, 0xc0000000);
-				udelay(10);
-				bmips_write_zscm_reg(0x210, 0x00);
-			}
+			write_c0_brcm_action(ACTION_BOOT_THREAD(cpu));
 			break;
 		}
 		cpumask_set_cpu(cpu, &bmips_booted_mask);
-- 
2.1.1
