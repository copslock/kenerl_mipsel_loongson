Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jan 2014 08:17:17 +0100 (CET)
Received: from szxga02-in.huawei.com ([119.145.14.65]:26765 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825722AbaAWHRNvy3MV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Jan 2014 08:17:13 +0100
Received: from 172.24.2.119 (EHLO szxeml211-edg.china.huawei.com) ([172.24.2.119])
        by szxrg02-dlp.huawei.com (MOS 4.3.7-GA FastPath queued)
        with ESMTP id BOZ57184;
        Thu, 23 Jan 2014 15:14:02 +0800 (CST)
Received: from SZXEML413-HUB.china.huawei.com (10.82.67.152) by
 szxeml211-edg.china.huawei.com (172.24.2.182) with Microsoft SMTP Server
 (TLS) id 14.3.158.1; Thu, 23 Jan 2014 15:12:54 +0800
Received: from localhost (10.177.27.212) by szxeml413-hub.china.huawei.com
 (10.82.67.152) with Microsoft SMTP Server id 14.3.158.1; Thu, 23 Jan 2014
 15:12:46 +0800
From:   Yijing Wang <wangyijing@huawei.com>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@deeprootsystems.com>,
        Russell King <linux@arm.linux.org.uk>,
        David Brown <davidb@codeaurora.org>,
        Daniel Walker <dwalker@fifo99.com>,
        Bryan Huntsman <bryanh@codeaurora.org>,
        Tony Lindgren <tony@atomide.com>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Mike Frysinger <vapier@gentoo.org>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jonas Bonn <jonas@southpole.se>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        "Ingo Molnar" <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        <x86@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kukjin Kim <kgene.kim@samsung.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        Barry Song <baohua@kernel.org>,
        Tony Prisk <linux@prisktech.co.nz>,
        <davinci-linux-open-source@linux.davincidsp.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <uclinux-dist-devel@blackfin.uclinux.org>,
        <microblaze-uclinux@itee.uq.edu.au>, <linux-mips@linux-mips.org>,
        <linux@lists.openrisc.net>, <linuxppc-dev@lists.ozlabs.org>,
        <user-mode-linux-devel@lists.sourceforge.net>,
        <user-mode-linux-user@lists.sourceforge.net>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Yijing Wang" <wangyijing@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 1/2] clocksource: Remove outdated comments
Date:   Thu, 23 Jan 2014 15:12:27 +0800
Message-ID: <1390461147-36256-1-git-send-email-wangyijing@huawei.com>
X-Mailer: git-send-email 1.7.11.msysgit.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.27.212]
X-CFilter-Loop: Reflected
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39078
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wangyijing@huawei.com
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

clocksource_register() and __clocksource_register_scale()
always return 0, so the comment is just pointless, it's
outdated, remove it.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 kernel/time/clocksource.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index ba3e502..9951575 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -779,8 +779,6 @@ EXPORT_SYMBOL_GPL(__clocksource_updatefreq_scale);
  * @scale:	Scale factor multiplied against freq to get clocksource hz
  * @freq:	clocksource frequency (cycles per second) divided by scale
  *
- * Returns -EBUSY if registration fails, zero otherwise.
- *
  * This *SHOULD NOT* be called directly! Please use the
  * clocksource_register_hz() or clocksource_register_khz helper functions.
  */
@@ -805,7 +803,6 @@ EXPORT_SYMBOL_GPL(__clocksource_register_scale);
  * clocksource_register - Used to install new clocksources
  * @cs:		clocksource to be registered
  *
- * Returns -EBUSY if registration fails, zero otherwise.
  */
 int clocksource_register(struct clocksource *cs)
 {
-- 
1.7.1
