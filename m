Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Nov 2017 14:02:37 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:53374 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993420AbdKMNCMiVEeS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Nov 2017 14:02:12 +0100
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 65EE8AAE;
        Mon, 13 Nov 2017 13:02:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.9 68/87] MIPS: Fix race on setting and getting cpu_online_mask
Date:   Mon, 13 Nov 2017 13:56:25 +0100
Message-Id: <20171113125621.475541426@linuxfoundation.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171113125615.304035578@linuxfoundation.org>
References: <20171113125615.304035578@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60861
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>

commit 6f542ebeaee0ee552a902ce3892220fc22c7ec8e upstream.

While testing cpu hoptlug (cpu down and up in loops) on kernel 4.4, it was
observed that occasionally check for cpu online will fail in kernel/cpu.c,
_cpu_up:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/tree/kernel/cpu.c?h=v4.4.79#n485
 518        /* Arch-specific enabling code. */
 519        ret = __cpu_up(cpu, idle);
 520
 521        if (ret != 0)
 522                goto out_notify;
 523        BUG_ON(!cpu_online(cpu));

Reason is race between start_secondary and _cpu_up. cpu_callin_map is set
before cpu_online_mask. In __cpu_up, cpu_callin_map is waited for, but cpu
online mask is not, resulting in race in which secondary processor started
and set cpu_callin_map, but not yet set the online mask,resulting in above
BUG being hit.

Upstream differs in the area. cpu_online check is in bringup_wait_for_ap,
which is after cpu reached AP_ONLINE_IDLE,where secondary passed its start
function. Nonetheless, fix makes start_secondary safe and not depending on
other locks throughout the code. It protects as well against cpu_online
checks put in between sometimes in the future.

Fix this by moving completion after all flags are set.

Signed-off-by: Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>
Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/16925/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/smp.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -371,9 +371,6 @@ asmlinkage void start_secondary(void)
 	cpumask_set_cpu(cpu, &cpu_coherent_mask);
 	notify_cpu_starting(cpu);
 
-	complete(&cpu_running);
-	synchronise_count_slave(cpu);
-
 	set_cpu_online(cpu, true);
 
 	set_cpu_sibling_map(cpu);
@@ -381,6 +378,9 @@ asmlinkage void start_secondary(void)
 
 	calculate_cpu_foreign_map();
 
+	complete(&cpu_running);
+	synchronise_count_slave(cpu);
+
 	/*
 	 * irq will be enabled in ->smp_finish(), enabling it too early
 	 * is dangerous.
