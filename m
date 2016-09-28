Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Sep 2016 11:13:09 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:46707 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992990AbcI1JMYyw53G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Sep 2016 11:12:24 +0200
Received: from localhost (unknown [89.202.203.52])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 87B5D8D4;
        Wed, 28 Sep 2016 09:12:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matt Redfearn <matt.redfearn@imgtec.com>,
        Justin Chen <justinpopo6@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.7 45/69] MIPS: SMP: Fix possibility of deadlock when bringing CPUs online
Date:   Wed, 28 Sep 2016 11:05:27 +0200
Message-Id: <20160928090446.998680892@linuxfoundation.org>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160928090445.054716307@linuxfoundation.org>
References: <20160928090445.054716307@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55281
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

From: Matt Redfearn <matt.redfearn@imgtec.com>

commit 8f46cca1e6c06a058374816887059bcc017b382f upstream.

This patch fixes the possibility of a deadlock when bringing up
secondary CPUs.
The deadlock occurs because the set_cpu_online() is called before
synchronise_count_slave(). This can cause a deadlock if the boot CPU,
having scheduled another thread, attempts to send an IPI to the
secondary CPU, which it sees has been marked online. The secondary is
blocked in synchronise_count_slave() waiting for the boot CPU to enter
synchronise_count_master(), but the boot cpu is blocked in
smp_call_function_many() waiting for the secondary to respond to it's
IPI request.

Fix this by marking the CPU online in cpu_callin_map and synchronising
counters before declaring the CPU online and calculating the maps for
IPIs.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Reported-by: Justin Chen <justinpopo6@gmail.com>
Tested-by: Justin Chen <justinpopo6@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14302/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/smp.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -320,6 +320,9 @@ asmlinkage void start_secondary(void)
 	cpumask_set_cpu(cpu, &cpu_coherent_mask);
 	notify_cpu_starting(cpu);
 
+	cpumask_set_cpu(cpu, &cpu_callin_map);
+	synchronise_count_slave(cpu);
+
 	set_cpu_online(cpu, true);
 
 	set_cpu_sibling_map(cpu);
@@ -327,10 +330,6 @@ asmlinkage void start_secondary(void)
 
 	calculate_cpu_foreign_map();
 
-	cpumask_set_cpu(cpu, &cpu_callin_map);
-
-	synchronise_count_slave(cpu);
-
 	/*
 	 * irq will be enabled in ->smp_finish(), enabling it too early
 	 * is dangerous.
