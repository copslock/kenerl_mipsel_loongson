Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Apr 2011 18:59:07 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:63482 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491795Ab1DEQ7D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Apr 2011 18:59:03 +0200
Received: by pvh11 with SMTP id 11so258513pvh.36
        for <multiple recipients>; Tue, 05 Apr 2011 09:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=rcQzw8sKjrHSYVVWGrrtPVfC7iL7Yna0LT5K768Kx7I=;
        b=kVGoRQ26zKAy242lWSkgHTZYIA0BWdppQPwOj/w+KgRJBn8nQYwBvqiK4a0fwWxRtM
         pj5n0Zec+VhKpuSzyrmz3xttqayvTJmCVz8ODVmDubcO7pUV8ZKBr/P0yVeFMjgIz8av
         mc5Vm19p6BWTXp3Zr4RLtmGMCSMlis3EgnA/I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QUgE/9dGlklhDfPsbjFndiUjGXIcLQVnjAXUVAaM1hZTWdTwRuf15Bf0Dk2bGDPl+L
         p33TtVKV4vnjKhNfoyZoPwu78p6k3tBBD24Mujl+00fCiigFzNIdv6akbbGUiwAc8gcg
         hFHl34Qy0OMwj5yxLf2avHVTi+HuVZkoZPTzM=
Received: by 10.142.203.18 with SMTP id a18mr7599205wfg.397.1302022736972;
        Tue, 05 Apr 2011 09:58:56 -0700 (PDT)
Received: from localhost.localdomain ([64.134.235.77])
        by mx.google.com with ESMTPS id m10sm9213015wfl.23.2011.04.05.09.58.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Apr 2011 09:58:55 -0700 (PDT)
From:   "Justin P. Mattock" <justinmattock@gmail.com>
To:     trivial@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Justin P. Mattock" <justinmattock@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [RFC 3/5]arch:mips:pmc-sierra:msp71xx:Makefile Remove unused config in the Makefile.
Date:   Tue,  5 Apr 2011 09:58:20 -0700
Message-Id: <1302022702-24541-3-git-send-email-justinmattock@gmail.com>
X-Mailer: git-send-email 1.7.4.2
In-Reply-To: <1302022702-24541-1-git-send-email-justinmattock@gmail.com>
References: <1302022702-24541-1-git-send-email-justinmattock@gmail.com>
Return-Path: <justinmattock@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29698
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: justinmattock@gmail.com
Precedence: bulk
X-list: linux-mips

The patch below removes an unused config variable found by using a kernel
cleanup script.
Note: I did try to cross compile these but hit erros while doing so..
(gcc is not setup to cross compile) and am unsure if anymore needs to be done.
Please have a look if/when anybody has free time.

Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>
CC: Ralf Baechle <ralf@linux-mips.org>
CC: linux-mips@linux-mips.org

---
 arch/mips/pmc-sierra/msp71xx/Makefile |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/mips/pmc-sierra/msp71xx/Makefile b/arch/mips/pmc-sierra/msp71xx/Makefile
index cefba77..9201c8b 100644
--- a/arch/mips/pmc-sierra/msp71xx/Makefile
+++ b/arch/mips/pmc-sierra/msp71xx/Makefile
@@ -3,7 +3,6 @@
 #
 obj-y += msp_prom.o msp_setup.o msp_irq.o \
 	 msp_time.o msp_serial.o msp_elb.o
-obj-$(CONFIG_HAVE_GPIO_LIB) += gpio.o gpio_extended.o
 obj-$(CONFIG_PMC_MSP7120_GW) += msp_hwbutton.o
 obj-$(CONFIG_IRQ_MSP_SLP) += msp_irq_slp.o
 obj-$(CONFIG_IRQ_MSP_CIC) += msp_irq_cic.o msp_irq_per.o
-- 
1.7.4.2
