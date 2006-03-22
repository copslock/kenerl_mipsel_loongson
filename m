Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Mar 2006 11:02:06 +0000 (GMT)
Received: from webmail.ict.ac.cn ([159.226.39.7]:63703 "HELO ict.ac.cn")
	by ftp.linux-mips.org with SMTP id S8133698AbWCVLBx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 22 Mar 2006 11:01:53 +0000
Received: (qmail 26468 invoked by uid 507); 22 Mar 2006 10:25:52 -0000
Received: from unknown (HELO ?192.168.2.202?) (fxzhang@222.92.8.142)
  by ict.ac.cn with SMTP; 22 Mar 2006 10:25:52 -0000
Message-ID: <442130DA.8060407@ict.ac.cn>
Date:	Wed, 22 Mar 2006 19:11:22 +0800
From:	Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Srinivas Kommu <kommu@hotmail.com>, linux-mips@linux-mips.org
Subject: Re: how to get a process backtrace from kernel gdb?
References: <4420940B.9030605@hotmail.com> <20060322105026.GA3129@linux-mips.org>
In-Reply-To: <20060322105026.GA3129@linux-mips.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips

Are there any existing method/code to get a reliable back trace dump for
oops? Kgdb is not usable here because I have no serial port. Do I need
to copy gdb code to analysis the stack?

If I am not wrong, dump_stack() just print out any stack address falled
in the text section, and that will make the result hard to understand.
For example, I often find some interrupt functions mixed with normal
function names and repeated functions, e.g.
   8e1c7968: redzone 1: 0x0, redzone 2: 0x170fc2a5.
slab error in cache_free_debugcheck(): cache `dentry_cache': double
free, or memory nCall Trace:
 [<8035de48>] cache_free_debugcheck+0x1dc/0x2d4
 [<8035de1c>] cache_free_debugcheck+0x1b0/0x2d4
 [<8035f35c>] kmem_cache_free+0x60/0x248
 [<8033f7e4>] __rcu_process_callbacks+0xdc/0x360  /* between
kmem_cache_free? */
 [<8035f35c>] kmem_cache_free+0x60/0x248
 [<80300e10>] ll_cputimer_irq+0xc/0x14
 [<8033f7e4>] __rcu_process_callbacks+0xdc/0x360
 [<804c1480>] int_timer_do+0x1c/0x30
 [<8033fa8c>] rcu_process_callbacks+0x24/0x48
 [<803338d8>] run_timer_softirq+0x128/0x244
 [<804c1480>] int_timer_do+0x1c/0x30
 [<8032ee50>] tasklet_action+0xd4/0x1b8
 [<8032e7e4>] __do_softirq+0x94/0x15c
 [<8032e93c>] do_softirq+0x90/0xbc
 [<80303814>] do_IRQ+0x24/0x34
 [<8035e220>] cache_alloc_debugcheck_after+0x17c/0x1b4 /* do_IRQ happens
inside debugcheck? */
 [<8035e220>] cache_alloc_debugcheck_after+0x17c/0x1b4
 [<80300e10>] ll_cputimer_irq+0xc/0x14
 [<803a961c>] d_alloc+0x34/0x22c
 [<8035e5e8>] kmem_cache_alloc+0x128/0x220
 [<803a961c>] d_alloc+0x34/0x22c                     /* where is the
ROOT of current trace... ?? */
 [<80478660>] memset_partial+0x44/0x6c
 [<8039a808>] __link_path_walk+0x790/0x1a38
 [<8039a870>] __link_path_walk+0x7f8/0x1a38
 [<8035d8a0>] check_poison_obj+0x40/0x238
 [<8039bb90>] link_path_walk+0xe0/0x438
 [<8035e174>] cache_alloc_debugcheck_after+0xd0/0x1b4
 [<80380114>] get_unused_fd+0x158/0x20c
 [<8039bfc8>] path_lookup+0xe0/0x3e8
 [<8038235c>] get_empty_filp+0x5c/0x110
 [<8038235c>] get_empty_filp+0x5c/0x110
 [<8039d2f8>] open_namei+0xa4/0xdf4
 [<8038235c>] get_empty_filp+0x5c/0x110
 [<8037fee4>] filp_open+0x74/0xe0
 [<80398bdc>] getname+0x2c/0x13c
 [<80380114>] get_unused_fd+0x158/0x20c
 [<803802e0>] do_sys_open+0x84/0x144
 [<80303814>] do_IRQ+0x24/0x34
 [<8030c5a4>] stack_done+0x20/0x3c
 [<80478670>] memset_partial+0x54/0x6c

8e1c78d4: redzone 1: 0x170fc2a5, redzone 2: 0x10.
IOPortBase = 2af34000



Ralf Baechle 写道:
> On Tue, Mar 21, 2006 at 04:02:19PM -0800, Srinivas Kommu wrote:
> 
>> I'm running gdb on vmlinux connected to a remote target (2.4 kernel). I 
>> have the task_struct address of 'current' and other processes. Is it 
>> possible to get a symbolic stack trace of the kernel stack? Where is the 
>> kernel stack located? I tried to print (task_struct->reg29)[13]. Is this 
>> the PC?
> 
> I assume you meant task_struct->reg29)[31] which is the address at which
> the process is going to resume execution when it's time has arrived.  But
> in most cases this address isn't terribly interesting.  So we have two
> cases here:
> 
>  o $31 pointing to ret_from_fork
>    This is a new born process which will begin it's active life of
>    execution on a CPU at ret_from_fork.  This is where the resume function
>    will jump to which may well be not the scheduler function.
>  o Otherwise:
>    The thread is regaining the CPU and the resume() call is going to return
>    straight to it's caller, kernel/sched.c:context_switch() which inlined
>    into schedule() and what we actually want is schedule's caller, so we
>    dig through the scheduler's stack frame.  To make things more
>    entertaining the stack frame will change with configuration options and
>    compiler used, so we basically have to disassemble the stackframe.
> 
>    For get_wchan We repeat that exercise in the cases we one of the other
>    scheduler functions may have called schedule() until we reach a
>    non-schedule function.  So now we have a pointer that actually points to
>    something interesting, a driver or other kernel subsystem.
> 
> The whole thing is a bit of a mindbender.  Why?  The scheduler is designed
> to deliver best possible performance and we've not compromized on
> performance to make the job of backtracing any easier.
> 
>> PS. I broke into gdb using a hotkey on the serial console; so the gdb 
>> backtrace shows the serial driver.
> 
> In which you need to be extra careful about the validity of any pointer
> you might encounter.
> 
>   Ralf
> 
> 
> 
