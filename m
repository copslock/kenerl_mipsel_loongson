Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2014 10:23:54 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41828 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013585AbaKMJXwe0U8D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Nov 2014 10:23:52 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 26E6C69DA1D4F;
        Thu, 13 Nov 2014 09:23:44 +0000 (GMT)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 13 Nov
 2014 09:23:46 +0000
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 13 Nov 2014 09:23:46 +0000
Received: from [192.168.154.149] (192.168.154.149) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 13 Nov
 2014 09:23:45 +0000
Message-ID: <546478A1.5040306@imgtec.com>
Date:   Thu, 13 Nov 2014 09:23:45 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     <rostedt@goodmis.org>, <mingo@redhat.com>
Subject: ftrace function graph with static ftrace does not work on MIPS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.149]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44107
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

Hi,

I am trying to understand why ftrace function graph doesn't work when
using static ftrace on MIPS. So, what happens when I do 'echo
function_graph > current_tracer' is that the ftrace_graph_caller from
mcount.S is executed once. The function that called it is
'core_kernel_data()' from __register_ftrace_function in
kernel/trace/ftrace.c

However, this is the only function that is reported in the trace file

# cat trace
# tracer: function_graph
#
# CPU  DURATION                  FUNCTION CALLS
# |     |   |                     |   |   |   |
 0)               |  core_kernel_data() {
 0)   0.000 us    |  } /* core_kernel_data */

The reason that the ftrace_graph_caller is never executed after that is
that the following as far as I understand:

NESTED(_mcount, PT_SIZE, ra)
        PTR_LA  t1, ftrace_stub
        PTR_L   t2, ftrace_trace_function /* Prepare t2 for (1) */
        bne     t1, t2, static_trace
         nop

#ifdef  CONFIG_FUNCTION_GRAPH_TRACER
        PTR_L   t3, ftrace_graph_return
        bne     t1, t3, ftrace_graph_caller
         nop
        PTR_LA  t1, ftrace_graph_entry_stub
        PTR_L   t3, ftrace_graph_entry
        bne     t1, t3, ftrace_graph_caller
         nop
#endif

The previous 3 conditionals exists in arch/mips/kernel/mcount.S.
Originally, ftrace_trace_function == ftrace_stub, so the first
conditional is not taken and we end up executed the ftrace_graph_caller.
All good.
However, later on, ftrace_trace_function is set to 'ftrace_ops_no_ops',
so the first 'bne' is taken and the ftrace_graph_caller is never
executed after that. It is not clear to me if this behaviour is expected
so I used QEMU to get a backtrace when ftrace_trace_function is set to
ftrace_ops_no_ops.

Old value = (ftrace_func_t) 0x8010fa90 <ftrace_stub>
New value = (ftrace_func_t) 0x801a32f0 <ftrace_ops_no_ops>
0x801a2578 in update_ftrace_function () at kernel/trace/ftrace.c:318
(gdb) bt
#0  0x801a2578 in update_ftrace_function () at kernel/trace/ftrace.c:318
#1  0x801a2ae8 in __register_ftrace_function (ops=0x806fbcb4 <global_ops>)
    at kernel/trace/ftrace.c:414
#2  0x801a39ec in register_ftrace_graph (retfunc=0x801b6ab8
<trace_graph_return>,
    entryfunc=0x801b67b4 <trace_graph_entry>) at kernel/trace/ftrace.c:5438
#3  0x801b63d0 in graph_trace_init (tr=<optimized out>)
    at kernel/trace/trace_functions_graph.c:463
#4  0x801b0b84 in tracer_init (tr=<optimized out>, t=<optimized out>)
    at kernel/trace/trace.c:3916
#5  tracing_set_tracer (tr=0x8093e1d8 <global_trace>,
    buf=0x8 <error: Cannot access memory at address 0x8>) at
kernel/trace/trace.c:4171
#6  0x801b103c in tracing_set_trace_write (filp=<optimized out>,
ubuf=<optimized out>,
    cnt=<optimized out>, ppos=0x82147f00) at kernel/trace/trace.c:4209
#7  0x80212944 in vfs_write (file=0x821fa100,
    buf=0x806fbc8c <graph_ops> "\220\372\020\200h0o\200", <incomplete
sequence \340>,
    count=<optimized out>, pos=0x82147f00) at fs/read_write.c:532
#8  0x80213164 in SYSC_write (count=<optimized out>, buf=<optimized out>,
    fd=<optimized out>) at fs/read_write.c:583
#9  SyS_write (fd=<optimized out>, buf=0x4bdf38, count=0xf) at
fs/read_write.c:575
#10 0x80112f48 in handle_sys () at arch/mips/kernel/scall32-o32.S:99

So, now that the ftrace_trace_function has been set to
'ftrace_ops_no_ops', the previous branch (as I explained before) is
taken and the function graph related functions are not being executed
anymore.

Dynamic tracing is working (or seems it does) because the code does a
'jal ftrace_call' and the returns back and does a 'j
ftrace_graph_caller'. In other words, it always executes the
ftrace_graph_caller no matter what the ftrace_trace_function is.

So any ideas? Do I do something wrong?

-- 
markos
