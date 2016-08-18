Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2016 16:16:39 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:54585 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993438AbcHROQGWdUWI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Aug 2016 16:16:06 +0200
Received: from localhost (pes75-3-78-192-101-3.fbxo.proxad.net [78.192.101.3])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9B0FF98B;
        Thu, 18 Aug 2016 14:15:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiher <r@hev.cc>,
        Huacai Chen <chenhc@lemote.com>,
        John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.7 175/186] MIPS: Fix r4k clockevents registration
Date:   Thu, 18 Aug 2016 15:59:52 +0200
Message-Id: <20160818135939.704290797@linuxfoundation.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160818135932.219369981@linuxfoundation.org>
References: <20160818135932.219369981@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54653
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

4.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhc@lemote.com>

commit 6dabf2b7a597a9613f0b8a2fcbe01e2a0a05c896 upstream.

CPUFreq need min_delta_ticks/max_delta_ticks to be initialized, and
this can be done by clockevents_config_and_register().

Signed-off-by: Heiher <r@hev.cc>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
Cc: John Crispin <john@phrozen.org>
Cc: Steven J . Hill <Steven.Hill@imgtec.com>
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/13817/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/cevt-r4k.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -276,12 +276,7 @@ int r4k_clockevent_init(void)
 				  CLOCK_EVT_FEAT_C3STOP |
 				  CLOCK_EVT_FEAT_PERCPU;
 
-	clockevent_set_clock(cd, mips_hpt_frequency);
-
-	/* Calculate the min / max delta */
-	cd->max_delta_ns	= clockevent_delta2ns(0x7fffffff, cd);
 	min_delta		= calculate_min_delta();
-	cd->min_delta_ns	= clockevent_delta2ns(min_delta, cd);
 
 	cd->rating		= 300;
 	cd->irq			= irq;
@@ -289,7 +284,7 @@ int r4k_clockevent_init(void)
 	cd->set_next_event	= mips_next_event;
 	cd->event_handler	= mips_event_handler;
 
-	clockevents_register_device(cd);
+	clockevents_config_and_register(cd, mips_hpt_frequency, min_delta, 0x7fffffff);
 
 	if (cp0_timer_irq_installed)
 		return 0;
