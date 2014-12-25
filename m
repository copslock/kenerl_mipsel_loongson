Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Dec 2014 18:57:23 +0100 (CET)
Received: from mail-pd0-f180.google.com ([209.85.192.180]:56111 "EHLO
        mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009170AbaLYR5Gf-Gph (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Dec 2014 18:57:06 +0100
Received: by mail-pd0-f180.google.com with SMTP id w10so11877082pde.11;
        Thu, 25 Dec 2014 09:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qdwZ6ciJX87nN2XSN97ZD8P8DJxG3BofJA17nKAP8is=;
        b=NWNJvF9oRl33+dWMsjPzy3XN8O+1oWOggt1gYv58ZRRAbW8SpRtHf7MVeoWaAhWp/3
         0wf+vy/4Jb3DEqtURm5YbnlnniaUO7NOeDDEe7TFQ/ZitYvtMzZNScaK5is4mzKeVOAI
         dhdEbvP56MivoCJeoRa+dqELPkNeQQ1KVMxR9yU9sdSMq5d92HL9cdK1qrzbspnQRodZ
         Gk62bKFZ73L2dYWRW3chUdMXONzylD7oNQV1fTL5z+xx+ig/mqWtydixah+LlGHO1yG8
         1EAKKLwJPz1iwhc40D2N4Py0pVYCOVk3uoReRmFEVVBUA/dZufGOj201s1/jUi7uF8G4
         IfTA==
X-Received: by 10.66.250.225 with SMTP id zf1mr24029556pac.31.1419530220617;
        Thu, 25 Dec 2014 09:57:00 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id e9sm25964046pdp.59.2014.12.25.09.56.59
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 25 Dec 2014 09:57:00 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jaedon.shin@gmail.com, abrestic@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net, jogo@openwrt.org,
        arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V6 01/25] MIPS: bcm3384: Fix outdated use of mips_cpu_intc_init()
Date:   Thu, 25 Dec 2014 09:48:56 -0800
Message-Id: <1419529760-9520-2-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1419529760-9520-1-git-send-email-cernekee@gmail.com>
References: <1419529760-9520-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44911
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
