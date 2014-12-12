Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Dec 2014 23:08:39 +0100 (CET)
Received: from mail-pa0-f50.google.com ([209.85.220.50]:37818 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008135AbaLLWIUoF-gD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Dec 2014 23:08:20 +0100
Received: by mail-pa0-f50.google.com with SMTP id bj1so7985714pad.23
        for <multiple recipients>; Fri, 12 Dec 2014 14:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qdwZ6ciJX87nN2XSN97ZD8P8DJxG3BofJA17nKAP8is=;
        b=slgu+4AXcR90N/3K5uTRWHNoLvxSNF4FfZ8d6bFy7QduAdA5CrKtOEyhPR+FoGWFzX
         g3z2T29xOnmW+7lcbEEkPZpRwrJkD6XxZo1jpfBALp47WJ8HxOPcHjdg0sGwHI4kC27W
         FPnsY3NlIlS+ZYn5gF+i9ElZ3nfKNWynfd4y0qOsr4ZenUEK6+/40GrNzIqBGHF0ljiv
         KBqbi4hNfjrsOOWPSZJnO8pe6d02nAN5Pjk4cv+BWIrJdQBqae9fZmWtIt7bggAAzV2x
         mw6qrITh/q8hUo6StDqFUPgBwb8kA+zyrNjXc9reV+rugdZNN4U16FBd+otMGf0odjjs
         gvuw==
X-Received: by 10.69.20.74 with SMTP id ha10mr30455021pbd.122.1418422094768;
        Fri, 12 Dec 2014 14:08:14 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id tm3sm2425841pac.12.2014.12.12.14.08.13
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Dec 2014 14:08:14 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, tglx@linutronix.de, jason@lakedaemon.net,
        jogo@openwrt.org, arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 01/23] MIPS: bcm3384: Fix outdated use of mips_cpu_intc_init()
Date:   Fri, 12 Dec 2014 14:06:52 -0800
Message-Id: <1418422034-17099-2-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1418422034-17099-1-git-send-email-cernekee@gmail.com>
References: <1418422034-17099-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44639
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

This function was renamed to mips_cpu_irq_of_init(), so fix it to avoid
a compile error.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/bcm3384/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/bcm3384/irq.c b/arch/mips/bcm3384/irq.c
index 0fb5134..fd94fe8 100644
--- a/arch/mips/bcm3384/irq.c
+++ b/arch/mips/bcm3384/irq.c
@@ -180,7 +180,7 @@ static int __init intc_of_init(struct device_node *node,
 
 static struct of_device_id of_irq_ids[] __initdata = {
 	{ .compatible = "mti,cpu-interrupt-controller",
-	  .data = mips_cpu_intc_init },
+	  .data = mips_cpu_irq_of_init },
 	{ .compatible = "brcm,bcm3384-intc",
 	  .data = intc_of_init },
 	{},
-- 
2.1.1
