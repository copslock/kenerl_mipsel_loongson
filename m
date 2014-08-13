Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Aug 2014 00:09:57 +0200 (CEST)
Received: from mail-la0-f54.google.com ([209.85.215.54]:47714 "EHLO
        mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6898436AbaHMWJQkwvy9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Aug 2014 00:09:16 +0200
Received: by mail-la0-f54.google.com with SMTP id hz20so321455lab.13
        for <multiple recipients>; Wed, 13 Aug 2014 15:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O0IKxKIS9d9ZhJoFklashR5k3lSA5MjFpr+TwLO/beU=;
        b=A7RGkl3ze+RlapNkpHiKog8Kq8bb3qWsgadfOpadewscneYPymnFzDwIhWoSaxWkIU
         Tjc45+23IwzJK8wDRDHxHKTFIfJcf+/8aCdMCHuvvllvmwRTkHlHUZAggW6sVl8TYaug
         bZKvR+9vjBxOhSx+aco7kyDRN1teXUyajQSWRLU+2QwEMCWxU6es5SrN3TwtZCCRw9kQ
         9mA9poxOjZKcPo9rYjBiPStw/s1m+khtVL4OaPH/8KGAyQhmxgvWUeP0AQo3s/EAwgTc
         MDCHxanEpoYECf1lLHCJYsmv9HIkIW6KTUIXmN+0ejLNgYAJ0I3x3nXGIByVWbfjPj/H
         Ou0g==
X-Received: by 10.152.10.193 with SMTP id k1mr722659lab.79.1407967748956;
        Wed, 13 Aug 2014 15:09:08 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id x10sm1927137lal.13.2014.08.13.15.09.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Aug 2014 15:09:08 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Subject: [PATCH 1/2] MIPS: MSP71xx: remove unused plat_irq_dispatch() argument
Date:   Thu, 14 Aug 2014 02:09:35 +0400
Message-Id: <1407967776-7320-2-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1407967776-7320-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1407967776-7320-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42093
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

Remove unused argument to make the plat_irq_dispatch() function
declaration similar to the realization of other platforms.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---
 arch/mips/pmcs-msp71xx/msp_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/pmcs-msp71xx/msp_irq.c b/arch/mips/pmcs-msp71xx/msp_irq.c
index 941744a..f914c75 100644
--- a/arch/mips/pmcs-msp71xx/msp_irq.c
+++ b/arch/mips/pmcs-msp71xx/msp_irq.c
@@ -51,7 +51,7 @@ static inline void sec_int_dispatch(void)  { do_IRQ(MSP_INT_SEC);  }
  * the range 40-71.
  */
 
-asmlinkage void plat_irq_dispatch(struct pt_regs *regs)
+asmlinkage void plat_irq_dispatch(void)
 {
 	u32 pending;
 
-- 
1.8.1.5
