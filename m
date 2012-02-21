Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Feb 2012 16:33:25 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:49288 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903723Ab2BUPdS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 21 Feb 2012 16:33:18 +0100
Message-ID: <4F43B932.9090103@phrozen.org>
Date:   Tue, 21 Feb 2012 16:33:06 +0100
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.20) Gecko/20110820 Icedove/3.1.12
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Mikael Starvik <mikael.starvik@axis.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: SMP MIPS and Linux 3.2
References: <4BEA3FF3CAA35E408EA55C7BE2E61D055C769FECBC@xmail3.se.axis.com> <20120221103455.GA13347@linux-mips.org>
In-Reply-To: <20120221103455.GA13347@linux-mips.org>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 32493
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi,

i am getting this. looks like ralf is right and the timer irqs get lost.

running with nosmp works like a charm.

John



CPU Clock: 333MHz
Calibrating delay loop... 221.18 BogoMIPS (lpj=442368)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU revision is: 0001954c (MIPS 34Kc)
Primary instruction cache 32kB, VIPT, 4-way, linesize 32 bytes.
Primary data cache 16kB, 4-way, VIPT, no aliases, linesize 32 bytes
Brought up 2 CPUs
INFO: rcu_sched detected stall on CPU 0 (t=15000 jiffies)
INFO: rcu_sched detected stall on CPU 1 (t=15000 jiffies)
Call Trace:
[<802c310c>] dump_stack+0x8/0x34
[<8007e280>] print_cpu_stall+0x40/0xf0
[<8007e630>] __rcu_pending+0x110/0x270
[<8007fa44>] rcu_check_callbacks+0x78/0x180
[<80035234>] update_process_times+0x40/0x6c
[<80069acc>] tick_handle_periodic+0x38/0x170
[<8000c8f4>] c0_compare_interrupt+0x78/0xbc
[<80077740>] handle_irq_event_percpu+0x78/0x294
[<8007ba08>] handle_percpu_irq+0x8c/0xc0
[<80076dd0>] generic_handle_irq+0x40/0x50
[<80006650>] do_IRQ+0x18/0x28
[<80004aec>] ret_from_irq+0x0/0x4
[<8002e3c0>] __do_softirq+0x84/0x1ac
[<8002e744>] do_softirq+0x78/0x80
[<8002e9f4>] irq_exit+0x80/0x8c
[<80004aec>] ret_from_irq+0x0/0x4
[<80004ce0>] r4k_wait+0x20/0x40
[<800069d8>] cpu_idle+0x7c/0xa4

Call Trace:
[<802c310c>] dump_stack+0x8/0x34
[<8007e280>] print_cpu_stall+0x40/0xf0
[<8007e630>] __rcu_pending+0x110/0x270
[<8007fae4>] rcu_check_callbacks+0x118/0x180
[<80035234>] update_process_times+0x40/0x6c
[<80069acc>] tick_handle_periodic+0x38/0x170
[<8000c8f4>] c0_compare_interrupt+0x78/0xbc
[<80077740>] handle_irq_event_percpu+0x78/0x294
[<8007ba08>] handle_percpu_irq+0x8c/0xc0
[<80076dd0>] generic_handle_irq+0x40/0x50
[<80006650>] do_IRQ+0x18/0x28
[<80004aec>] ret_from_irq+0x0/0x4
[<8006fcf0>] generic_exec_single+0x98/0xfc
[<8006ff3c>] smp_call_function_single+0x1e8/0x1f0
[<800704e0>] smp_call_function+0x28/0x38
[<80070510>] on_each_cpu+0x20/0x64
[<800bbdac>] do_tune_cpucache+0x130/0x238
[<800bc09c>] enable_cpucache+0x60/0xf8
[<800bc4a0>] kmem_cache_create+0x36c/0x554
[<803705e0>] shmem_init+0x60/0xf8
[<80366998>] kernel_init+0x94/0x154
[<80006954>] kernel_thread_helper+0x10/0x18
