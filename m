Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Nov 2014 01:22:35 +0100 (CET)
Received: from mail-pa0-f54.google.com ([209.85.220.54]:47871 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013769AbaKPATmse57y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Nov 2014 01:19:42 +0100
Received: by mail-pa0-f54.google.com with SMTP id hz1so8746011pad.27
        for <multiple recipients>; Sat, 15 Nov 2014 16:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VJjyHDvslQkXAABGDH4ZQ4fSqozpVdoJxIp1ODVpKMk=;
        b=zAOb3GiQv7lzWNkSg42QZBH7mqi0nF/cPUei4oVmSzs+dZ+tjkFvo4qPwT0cM1T9tU
         ika8cfYHmZAbgyHD83auzr8pkL39hEjVCnK9R2VZfrnQCa487bQkARUIoLVBFU1yYdmQ
         a1fz93lE+6xosymbsE8uBrvJMu34WpmtGw8BRg3cOS35P0BYVD49P29H4MLY8BfvRKFB
         +/cjps7tYmvniYcWKQJ4YpOCDfGLGIqlB++vQlgybIVFZIlr2numHuYm5QZYkSO5FhoD
         FT0NrD8w9f1+T5ZGKa1hq3DMOBNba+VJ1oJK3Ehr7TkmqZb7zduoHD8pMRVG52x3AHws
         xKLg==
X-Received: by 10.66.66.2 with SMTP id b2mr50589pat.113.1416097177158;
        Sat, 15 Nov 2014 16:19:37 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id xn4sm11099440pab.9.2014.11.15.16.19.35
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Nov 2014 16:19:36 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jfraser@broadcom.com, dtor@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 11/22] MIPS: BMIPS: Mask off timer IRQs when hot-unplugging a CPU
Date:   Sat, 15 Nov 2014 16:17:35 -0800
Message-Id: <1416097066-20452-12-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
References: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44202
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

From: Jon Fraser <jfraser@broadcom.com>

CPU interrupts need to be disabled on a cpu being taken down.
When a cpu is hot-plugged out of the system the following sequence occurs.

On the CPU where the hotplug sequence was initiated:
    cpu_down
        _cpu_down {
            __cpu_notify(CPU_DOWN_PREPARE
            __stop_machine(take_cpu_down
                wait for cpu to run disable code.
            __cpu_die
        }

On the CPU  being disabled:
    take_cpu_down
        __cpu_disable {
            mp_ops->cpu_disable
                bmips_cpu_disable
                    clear_c0_status(IE_IRQ5) (added)
            cpu_notify(CPU_DYING...
        }

Before the cpu_notifier is called with CPU_DYING, all interrupts on the
dying cpu must be disabled.  This guarantees that before tick_notify is
called with the CPU_DYING event and sets the clock device pointer to
NULL, there can not be any more clock interrupts.

When this wasn't done, an unfortunately-timed timer interrupt sometimes
caused hangs immediately prior to system suspend:

    Debug PM is not enabled. To enable partial suspend, rebuild kernel with CONFIG_PM_DEBUG
    Pass 1 out of 1,PM: Syncing filesystems ... mode=none, tp1=done.
    1, flags=5, cycle_tp=, sleep=
    Freezing user space processes ... (elapsed 0.01 seconds) done.
    Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
    PM: suspend of devices complete after 54.199 msecs
    PM: late suspend of devices complete after 0.172 msecs
    Disabling non-boot CPUs ...
    SMP: CPU1 is offline
    INFO: rcu_sched detected stalls on CPUs/tasks: { 3} (detected by 0, t=62537 jiffies)
    Call Trace:
    [<804baa78>] dump_stack+0x8/0x34
    [<8008a2d8>] __rcu_pending+0x4b8/0x55c
    [<8008adf4>] rcu_check_callbacks+0x78/0x180
    [<80037830>] update_process_times+0x40/0x6c
    [<80072fe4>] tick_sched_timer+0x74/0xe4
    [<80050180>] __run_hrtimer.clone.30+0x64/0x140
    [<80051150>] hrtimer_interrupt+0x19c/0x4bc
    [<8000cdb8>] c0_compare_interrupt+0x50/0x88
    [<80081b18>] handle_irq_event_percpu+0x5c/0x2f4
    [<80086490>] handle_percpu_irq+0x8c/0xc0
    [<800811b4>] generic_handle_irq+0x34/0x54
    [<800067dc>] do_IRQ+0x18/0x2c
    [<8000375c>] plat_irq_dispatch+0xd0/0x128
    [<80004a04>] ret_from_irq+0x0/0x4
    [<80004c40>] r4k_wait+0x20/0x40
    [<80006b6c>] cpu_idle+0x98/0xf0
    [<805d3988>] start_kernel+0x424/0x440

Signed-off-by: Jon Fraser <jfraser@broadcom.com>
Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/kernel/smp-bmips.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index 887c3ea..f7b1bee 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -375,6 +375,7 @@ static int bmips_cpu_disable(void)
 
 	set_cpu_online(cpu, false);
 	cpu_clear(cpu, cpu_callin_map);
+	clear_c0_status(IE_IRQ5);
 
 	local_flush_tlb_all();
 	local_flush_icache_range(0, ~0);
-- 
2.1.1
