Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2014 06:31:04 +0200 (CEST)
Received: from mail-pa0-f43.google.com ([209.85.220.43]:58570 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011992AbaJUE2x3nBSF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Oct 2014 06:28:53 +0200
Received: by mail-pa0-f43.google.com with SMTP id lf10so532007pab.2
        for <multiple recipients>; Mon, 20 Oct 2014 21:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xpEYJ0cqWlYAuESCbOsDKaN5sVbdViaQDnA18cdbX7s=;
        b=Pg1w2M6JrsucO6ce9dDwxgovPpvi+gCbSAeH7nfc3zEiM5Zvt5dL5LPZYLjy/q5ygr
         K3eL+4KJrkdfLdRUlQ+FiJFkWG5pc44qnsRJHYg6bg1dDvoHe1tugeRhxO3OqVcjNLbS
         OUxLvvE/4A4+7fvakvPEcm/426INsZdeyP1m5eKh6aovpHjp6VRY+8SLaWN0y3MbQ070
         tO5YgM4ckKD3vFtorDrMFLgr+Pa2Wh92UkOmezlg/GwfV7irPuQ8+f0wetgh57+3j7dL
         FCbkLUcaG1HU4znX4QYygjmbZ6xw8knDgI2bKZyp2+klENnmJmSdfp1D7JZHwCpW1Ovy
         GaAw==
X-Received: by 10.70.102.77 with SMTP id fm13mr29776177pdb.62.1413865727207;
        Mon, 20 Oct 2014 21:28:47 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id b2sm10498181pbu.42.2014.10.20.21.28.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 20 Oct 2014 21:28:46 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org,
        jfraser@broadcom.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
Subject: [PATCH/RFC 09/17] MIPS: BMIPS: Let each platform customize the CPU1 IRQ mask
Date:   Mon, 20 Oct 2014 21:27:59 -0700
Message-Id: <1413865687-15255-10-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413865687-15255-1-git-send-email-cernekee@gmail.com>
References: <1413865687-15255-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43406
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

On some chips like bcm3384, "other stuff" gets wired up to CPU1's IE_IRQ1
input, generating spurious IRQs.  In this case we want the platform code
to be able to mask it off.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/include/asm/bmips.h | 1 +
 arch/mips/kernel/smp-bmips.c  | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/bmips.h b/arch/mips/include/asm/bmips.h
index cbacceb..30939b0 100644
--- a/arch/mips/include/asm/bmips.h
+++ b/arch/mips/include/asm/bmips.h
@@ -84,6 +84,7 @@ extern char bmips_smp_int_vec_end;
 extern int bmips_smp_enabled;
 extern int bmips_cpu_offset;
 extern cpumask_t bmips_booted_mask;
+extern unsigned long bmips_tp1_irqs;
 
 extern void bmips_ebase_setup(void);
 extern asmlinkage void plat_wired_tlb_setup(void);
diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index 162391d..b8bd934 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -43,6 +43,7 @@ static int __maybe_unused max_cpus = 1;
 int bmips_smp_enabled = 1;
 int bmips_cpu_offset;
 cpumask_t bmips_booted_mask;
+unsigned long bmips_tp1_irqs = IE_IRQ1;
 
 #define RESET_FROM_KSEG0		0x80080800
 #define RESET_FROM_KSEG1		0xa0080800
@@ -257,7 +258,7 @@ static void bmips_smp_finish(void)
 	write_c0_compare(read_c0_count() + mips_hpt_frequency / HZ);
 
 	irq_enable_hazard();
-	set_c0_status(IE_SW0 | IE_SW1 | IE_IRQ1 | IE_IRQ5 | ST0_IE);
+	set_c0_status(IE_SW0 | IE_SW1 | bmips_tp1_irqs | IE_IRQ5 | ST0_IE);
 	irq_enable_hazard();
 }
 
@@ -387,7 +388,8 @@ void __ref play_dead(void)
 	 * IRQ handlers; this clears ST0_IE and returns immediately.
 	 */
 	clear_c0_cause(CAUSEF_IV | C_SW0 | C_SW1);
-	change_c0_status(IE_IRQ5 | IE_IRQ1 | IE_SW0 | IE_SW1 | ST0_IE | ST0_BEV,
+	change_c0_status(
+		IE_IRQ5 | bmips_tp1_irqs | IE_SW0 | IE_SW1 | ST0_IE | ST0_BEV,
 		IE_SW0 | IE_SW1 | ST0_IE | ST0_BEV);
 	irq_disable_hazard();
 
-- 
2.1.1
