Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 May 2012 08:02:32 +0200 (CEST)
Received: from mail-wi0-f169.google.com ([209.85.212.169]:48484 "EHLO
        mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903562Ab2EUGBb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 May 2012 08:01:31 +0200
Received: by wibhn14 with SMTP id hn14so2340064wib.0
        for <multiple recipients>; Sun, 20 May 2012 23:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=XujfYBaAQXl68ROFdNu4IA2+y4LMfv6/GNCKdTRAlWo=;
        b=hlk7z1H8OON/dN8Zsy06SuhoIvlDSCZlu8wrwMN6uQouscUnRGkjb/3XAiiGRU7S8q
         oleUozGpMZ7GRbohy/+XenNvrdqaBMn8Sdz7XQu09kbqgAec1EwBjYRFKfPYL8OyVTpk
         hREAaJ4kx9BtTJd+RPKgdN/+ujtCdAKXqXh8c/LcnRxSfwZk8E/+i21vQOqLXIWPWQPS
         YZ3xpvatQiyL8cjE2e2tuyjgObW0/mN/RSPS+/o0pWHOVxdcL2ppGRYzHjExG8sUkkfd
         zUhT4ks0QTpmir2ozrqlIo1NtjFAKn+3thGvKeUpIOnRWsXcK53M1rz2N1Ky30Rp5dXI
         Epzg==
Received: by 10.216.196.72 with SMTP id q50mr11864257wen.90.1337580086254;
        Sun, 20 May 2012 23:01:26 -0700 (PDT)
Received: from localhost ([61.148.56.138])
        by mx.google.com with ESMTPS id et10sm23593081wib.2.2012.05.20.23.01.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 May 2012 23:01:25 -0700 (PDT)
From:   Yong Zhang <yong.zhang0@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     ralf@linux-mips.org, sshtylyov@mvista.com, david.daney@cavium.com
Subject: [PATCH 4/8] MIPS: Yosemite: delay irq enable to ->smp_finish()
Date:   Mon, 21 May 2012 14:00:04 +0800
Message-Id: <1337580008-7280-5-git-send-email-yong.zhang0@gmail.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1337580008-7280-1-git-send-email-yong.zhang0@gmail.com>
References: <1337580008-7280-1-git-send-email-yong.zhang0@gmail.com>
X-archive-position: 33393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yong.zhang0@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Yong Zhang <yong.zhang@windriver.com>

To prepare for smoothing set_cpu_[active|online]() mess up

Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 arch/mips/pmc-sierra/yosemite/smp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/pmc-sierra/yosemite/smp.c b/arch/mips/pmc-sierra/yosemite/smp.c
index b71fae2..5edab2b 100644
--- a/arch/mips/pmc-sierra/yosemite/smp.c
+++ b/arch/mips/pmc-sierra/yosemite/smp.c
@@ -115,11 +115,11 @@ static void yos_send_ipi_mask(const struct cpumask *mask, unsigned int action)
  */
 static void __cpuinit yos_init_secondary(void)
 {
-	set_c0_status(ST0_CO | ST0_IE | ST0_IM);
 }
 
 static void __cpuinit yos_smp_finish(void)
 {
+	set_c0_status(ST0_CO | ST0_IM | ST0_IE);
 }
 
 /* Hook for after all CPUs are online */
-- 
1.7.5.4
