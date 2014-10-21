Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2014 06:29:17 +0200 (CEST)
Received: from mail-pa0-f53.google.com ([209.85.220.53]:50460 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011984AbaJUE2oKQH42 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Oct 2014 06:28:44 +0200
Received: by mail-pa0-f53.google.com with SMTP id kq14so512425pab.26
        for <multiple recipients>; Mon, 20 Oct 2014 21:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ijs4Morocr+cn4Wzl+0CFx1vVKltsVnwIo6DvM81bhA=;
        b=pkp8sA+q8E+yzCSvpa5/O8dgtgvtVaF7EBsqoKa5KcCOc/3Eo62mmQWzKLuv1aQLJW
         vLTz2QhCaA4n/3PT65oc1v8pgbxJRzN5cEMTRtaLlpeDRGjHu0vt49Vlta1/aEjS8VFO
         F08biFVU+xiLJz2r8+5bx5aYGMfVTN2pbMArira0McNvVr9AxS3kPUq46MrD4cy7wy/D
         +QGF6x3w/IA6Ney8bu+NTjU3zEMIXVe0dGPTo/VSbiMunOsbLIFxo6H3aK0LVF/qV+w+
         yFr8isYu1YJaHAR527rZ2fYVrUHZ+0s0bg3M8A+gsliUy6SFGGBgvgpi6IWPA4hXChaK
         CZJQ==
X-Received: by 10.68.191.33 with SMTP id gv1mr30983658pbc.33.1413865717993;
        Mon, 20 Oct 2014 21:28:37 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id b2sm10498181pbu.42.2014.10.20.21.28.36
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 20 Oct 2014 21:28:37 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org,
        jfraser@broadcom.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
Subject: [PATCH/RFC 02/17] MIPS: BMIPS: Align secondary boot sequence with latest firmware releases
Date:   Mon, 20 Oct 2014 21:27:52 -0700
Message-Id: <1413865687-15255-3-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413865687-15255-1-git-send-email-cernekee@gmail.com>
References: <1413865687-15255-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43400
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
