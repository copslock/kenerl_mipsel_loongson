Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Mar 2017 15:40:01 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:34110 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993891AbdCPOevIYKG0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Mar 2017 15:34:51 +0100
Received: from localhost (unknown [183.98.136.252])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E3199B2F;
        Thu, 16 Mar 2017 14:34:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Arnd Bergmann <arnd@arndb.de>, John Crispin <john@phrozen.org>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.10 14/48] MIPS: ralink: Remove unused timer functions
Date:   Thu, 16 Mar 2017 23:29:58 +0900
Message-Id: <20170316142921.505355129@linuxfoundation.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20170316142920.761502205@linuxfoundation.org>
References: <20170316142920.761502205@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57354
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit d92240d12a9c010e0094bbc9280aae4a6be9a2d5 upstream.

The functions were originally used for the module unload path,
but are not referenced any more and just cause warnings:

arch/mips/ralink/timer.c:104:13: error: 'rt_timer_disable' defined but not used [-Werror=unused-function]
arch/mips/ralink/timer.c:74:13: error: 'rt_timer_free' defined but not used [-Werror=unused-function]

Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Fixes: 62ee73d284e7 ("MIPS: ralink: Make timer explicitly non-modular")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: John Crispin <john@phrozen.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/15041/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/ralink/timer.c |   14 --------------
 1 file changed, 14 deletions(-)

--- a/arch/mips/ralink/timer.c
+++ b/arch/mips/ralink/timer.c
@@ -71,11 +71,6 @@ static int rt_timer_request(struct rt_ti
 	return err;
 }
 
-static void rt_timer_free(struct rt_timer *rt)
-{
-	free_irq(rt->irq, rt);
-}
-
 static int rt_timer_config(struct rt_timer *rt, unsigned long divisor)
 {
 	if (rt->timer_freq < divisor)
@@ -101,15 +96,6 @@ static int rt_timer_enable(struct rt_tim
 	return 0;
 }
 
-static void rt_timer_disable(struct rt_timer *rt)
-{
-	u32 t;
-
-	t = rt_timer_r32(rt, TIMER_REG_TMR0CTL);
-	t &= ~TMR0CTL_ENABLE;
-	rt_timer_w32(rt, TIMER_REG_TMR0CTL, t);
-}
-
 static int rt_timer_probe(struct platform_device *pdev)
 {
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
