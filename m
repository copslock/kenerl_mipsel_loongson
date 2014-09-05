Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2014 19:31:25 +0200 (CEST)
Received: from mail-vc0-f202.google.com ([209.85.220.202]:47046 "EHLO
        mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008220AbaIERahFuNeP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Sep 2014 19:30:37 +0200
Received: by mail-vc0-f202.google.com with SMTP id id10so1284293vcb.3
        for <linux-mips@linux-mips.org>; Fri, 05 Sep 2014 10:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p6N4QAHIzmHeXvBFOsvDA/aj3dh7znsYJY6S5AVCz1o=;
        b=RM9o/nsq/DbSwejz6hCj8u6fmGU/Vw37EGMcXXp1ziszeCcmRtKE32lpgPqHSLICAm
         Z+3ypP00c86IaFKtxkS+RXIlQCuK21eWid5igth/8AMO5tUjKihWDEPj/gQUuTOO+MQs
         9yePn2sHfkk9Tdr5tnIu6x9FldQ+6yFfJG97NhTsYQyK5EariV1Ng+DIzxUBhfAO+fjs
         hIzIUqaAdGmYlXbxD1wBX6deuK4veJUa+FAdUu3zTsLp2YO4qZdV7lU7MWisOqKgyT78
         5ch4kHC+ijLkGFjrG0DN+OnH8BDK9eHhWTf9Nmm4sC1uvZD/czWqSMpQqT4SKsFoviBg
         dEBw==
X-Gm-Message-State: ALoCoQmv6K4xOPX6B4L/ga2Qd9T8RyOgjDGYiro/qBf4/iA3vMUD6vs/8q7dmVCZoryYZOqcFGpj
X-Received: by 10.236.41.102 with SMTP id g66mr7496480yhb.15.1409938230825;
        Fri, 05 Sep 2014 10:30:30 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id d7si508208yho.2.2014.09.05.10.30.30
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Sep 2014 10:30:30 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com (abrestic.mtv.corp.google.com [172.22.65.70])
        by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id A8AF45A427D;
        Fri,  5 Sep 2014 10:30:30 -0700 (PDT)
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 6D6C42209EA; Fri,  5 Sep 2014 10:30:30 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/16] MIPS: Export CPU IRQ domain
Date:   Fri,  5 Sep 2014 10:30:05 -0700
Message-Id: <1409938218-9026-4-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1409938218-9026-1-git-send-email-abrestic@chromium.org>
References: <1409938218-9026-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42432
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

The GIC driver will use it to create the GIC-to-CPU interrupt mappings.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
New for v2.
---
 arch/mips/include/asm/irq_cpu.h | 2 ++
 arch/mips/kernel/irq_cpu.c      | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/irq_cpu.h b/arch/mips/include/asm/irq_cpu.h
index 3f11fdb..0dac19a 100644
--- a/arch/mips/include/asm/irq_cpu.h
+++ b/arch/mips/include/asm/irq_cpu.h
@@ -19,6 +19,8 @@ extern void rm9k_cpu_irq_init(void);
 
 #ifdef CONFIG_IRQ_DOMAIN
 struct device_node;
+struct irq_domain;
+extern struct irq_domain *mips_intc_domain;
 extern int mips_cpu_intc_init(struct device_node *of_node,
 			      struct device_node *parent);
 #endif
diff --git a/arch/mips/kernel/irq_cpu.c b/arch/mips/kernel/irq_cpu.c
index 33a4385..d206c49 100644
--- a/arch/mips/kernel/irq_cpu.c
+++ b/arch/mips/kernel/irq_cpu.c
@@ -117,7 +117,7 @@ void __init mips_cpu_irq_init(void)
 }
 
 #ifdef CONFIG_IRQ_DOMAIN
-static struct irq_domain *mips_intc_domain;
+struct irq_domain *mips_intc_domain;
 
 asmlinkage void __weak plat_irq_dispatch(void)
 {
-- 
2.1.0.rc2.206.gedb03e5
