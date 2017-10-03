Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Oct 2017 14:32:09 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:37096 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993301AbdJCMb7HbqGR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Oct 2017 14:31:59 +0200
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C36199AF;
        Tue,  3 Oct 2017 12:31:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.13 049/110] MIPS: Fix perf event init
Date:   Tue,  3 Oct 2017 14:29:11 +0200
Message-Id: <20171003114243.323925682@linuxfoundation.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171003114241.408583531@linuxfoundation.org>
References: <20171003114241.408583531@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60237
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

4.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>

commit fd0b19ed5389187829b854900511c9195875bb42 upstream.

Commit c311c797998c ("cpumask: make "nr_cpumask_bits" unsigned")
modified mipspmu_event_init() to cast the struct perf_event cpu field to
an unsigned integer before it is compared with nr_cpumask_bits (and
*ahem* did so without copying the linux-mips mailing list or any MIPS
developers...). This is broken because the cpu field may be -1 for
events which follow a process rather than being affine to a particular
CPU. When this is the case the cast to an unsigned int results in a
value equal to ULONG_MAX, which is always greater than nr_cpumask_bits
so we always fail mipspmu_event_init() and return -ENODEV.

The check against nr_cpumask_bits seems nonsensical anyway, so this
patch simply removes it. The cpu field is going to either be -1 or a
valid CPU number. Comparing it with nr_cpumask_bits is effectively
checking that it's a valid cpu number, but it seems safe to rely on the
core perf events code to ensure that's the case.

The end result is that this fixes use of perf on MIPS when not
constraining events to a particular CPU, and fixes the "perf list hw"
command which fails to list any events without this.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: c311c797998c ("cpumask: make "nr_cpumask_bits" unsigned")
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/17323/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/perf_event_mipsxx.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -618,8 +618,7 @@ static int mipspmu_event_init(struct per
 		return -ENOENT;
 	}
 
-	if ((unsigned int)event->cpu >= nr_cpumask_bits ||
-	    (event->cpu >= 0 && !cpu_online(event->cpu)))
+	if (event->cpu >= 0 && !cpu_online(event->cpu))
 		return -ENODEV;
 
 	if (!atomic_inc_not_zero(&active_events)) {
