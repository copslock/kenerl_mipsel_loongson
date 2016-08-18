Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2016 16:08:50 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:53625 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993375AbcHROHuW3cNI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Aug 2016 16:07:50 +0200
Received: from localhost (pes75-3-78-192-101-3.fbxo.proxad.net [78.192.101.3])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5F13C9F2;
        Thu, 18 Aug 2016 14:07:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@caviumnetworks.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.4 129/138] MIPS: Dont register r4k sched clock when CPUFREQ enabled
Date:   Thu, 18 Aug 2016 15:58:59 +0200
Message-Id: <20160818135612.704054393@linuxfoundation.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160818135553.377018690@linuxfoundation.org>
References: <20160818135553.377018690@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54646
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhc@lemote.com>

commit 07d69579e7fec27e371296d8ca9d6076fc401b5c upstream.

Don't register r4k sched clock when CPUFREQ enabled because sched clock
need a constant frequency.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Cc: John Crispin <john@phrozen.org>
Cc: Steven J . Hill <Steven.Hill@caviumnetworks.com>
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/13820/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/csrc-r4k.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/mips/kernel/csrc-r4k.c
+++ b/arch/mips/kernel/csrc-r4k.c
@@ -23,7 +23,7 @@ static struct clocksource clocksource_mi
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-static u64 notrace r4k_read_sched_clock(void)
+static u64 __maybe_unused notrace r4k_read_sched_clock(void)
 {
 	return read_c0_count();
 }
@@ -82,7 +82,9 @@ int __init init_r4k_clocksource(void)
 
 	clocksource_register_hz(&clocksource_mips, mips_hpt_frequency);
 
+#ifndef CONFIG_CPU_FREQ
 	sched_clock_register(r4k_read_sched_clock, 32, mips_hpt_frequency);
+#endif
 
 	return 0;
 }
