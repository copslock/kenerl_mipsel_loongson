Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Feb 2014 17:09:57 +0100 (CET)
Received: from relais.videotron.ca ([24.201.245.36]:46230 "EHLO
        relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6869252AbaBQQJzTatDh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Feb 2014 17:09:55 +0100
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: TEXT/PLAIN; CHARSET=US-ASCII
Received: from xanadu.home ([66.130.143.177]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0N1500CYVE89B0B0@VL-VM-MR006.ip.videotron.ca> for
 linux-mips@linux-mips.org; Mon, 17 Feb 2014 11:09:46 -0500 (EST)
Date:   Mon, 17 Feb 2014 11:09:45 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH] cpuidle/mips: remove redundant cpuidle_idle_call()
Message-id: <alpine.LFD.2.11.1402171101060.17677@knanqh.ubzr>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
Return-Path: <nico@fluxnic.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39334
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nico@fluxnic.net
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


The core idle loop now takes care of it.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---

I noticed commit c0b5d598aefda in linux-next adds a call to 
cpuidle_idle_call().  At the same time we're rationalizing the idle 
handling code in order to integrate it with the scheduler proper.  
Please note that a similar patch to the one below will be necessary once 
everything gets merged together.

diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
index 4b1554b3f5..2d753de5dc 100644
--- a/arch/mips/kernel/idle.c
+++ b/arch/mips/kernel/idle.c
@@ -253,8 +253,7 @@ static void mips_cpu_idle(void)
 
 void arch_cpu_idle(void)
 {
-	if (cpuidle_idle_call())
-		mips_cpu_idle();
+	mips_cpu_idle();
 }
 
 #ifdef CONFIG_CPU_IDLE
