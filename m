Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Nov 2014 10:33:52 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40526 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006590AbaKUJdv1SaG3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Nov 2014 10:33:51 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 986153502975D;
        Fri, 21 Nov 2014 09:33:43 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 21 Nov 2014 09:33:45 +0000
Received: from [192.168.154.149] (192.168.154.149) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 21 Nov
 2014 09:33:44 +0000
Message-ID: <546F06F8.4070500@imgtec.com>
Date:   Fri, 21 Nov 2014 09:33:44 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        <mingo@redhat.com>
Subject: Re: ftrace function graph with static ftrace does not work on MIPS
References: <546478A1.5040306@imgtec.com> <20141120110942.0bbc70a1@gandalf.local.home>
In-Reply-To: <20141120110942.0bbc70a1@gandalf.local.home>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.149]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44338
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

On 11/20/2014 04:09 PM, Steven Rostedt wrote:
> On Thu, 13 Nov 2014 09:23:45 +0000
> Markos Chandras <Markos.Chandras@imgtec.com> wrote:
> 
>> Hi,
>>
>> I am trying to understand why ftrace function graph doesn't work when
>> using static ftrace on MIPS. So, what happens when I do 'echo
>> function_graph > current_tracer' is that the ftrace_graph_caller from
>> mcount.S is executed once. The function that called it is
>> 'core_kernel_data()' from __register_ftrace_function in
>> kernel/trace/ftrace.c
>>
>> However, this is the only function that is reported in the trace file
>>
>> # cat trace
>> # tracer: function_graph
>> #
>> # CPU  DURATION                  FUNCTION CALLS
>> # |     |   |                     |   |   |   |
>>  0)               |  core_kernel_data() {
>>  0)   0.000 us    |  } /* core_kernel_data */
>>
>> The reason that the ftrace_graph_caller is never executed after that is
>> that the following as far as I understand:
>>
>> NESTED(_mcount, PT_SIZE, ra)
>>         PTR_LA  t1, ftrace_stub
>>         PTR_L   t2, ftrace_trace_function /* Prepare t2 for (1) */
>>         bne     t1, t2, static_trace
>>          nop
>>
>> #ifdef  CONFIG_FUNCTION_GRAPH_TRACER
>>         PTR_L   t3, ftrace_graph_return
>>         bne     t1, t3, ftrace_graph_caller
>>          nop
>>         PTR_LA  t1, ftrace_graph_entry_stub
>>         PTR_L   t3, ftrace_graph_entry
>>         bne     t1, t3, ftrace_graph_caller
>>          nop
>> #endif
>>
>> The previous 3 conditionals exists in arch/mips/kernel/mcount.S.
>> Originally, ftrace_trace_function == ftrace_stub, so the first
>> conditional is not taken and we end up executed the ftrace_graph_caller.
>> All good.
>> However, later on, ftrace_trace_function is set to 'ftrace_ops_no_ops',
>> so the first 'bne' is taken and the ftrace_graph_caller is never
>> executed after that. It is not clear to me if this behaviour is expected
>> so I used QEMU to get a backtrace when ftrace_trace_function is set to
>> ftrace_ops_no_ops.
> 
> Looks like the static tracing code in wrong. The function graph code
> should be tested every time.
> 
> -- Steve
> 

Hi Steven,

I had a look on

https://www.kernel.org/doc/Documentation/trace/ftrace-design.txt

and section "HAVE_FUNCTION_GRAPH_TRACER"

According to the sample code, first we check "ftrace_trace_function !=
ftrace_stub" and if that's true, then we never check the ftrace_graph_*
functions which is exactly what MIPS does. So the graph functions are
not always checked. x86 seems to do something similar in mcount_64.S

-- 
markos
