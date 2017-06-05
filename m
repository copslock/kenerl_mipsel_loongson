Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jun 2017 13:16:32 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:19607 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991061AbdFELQZcQOpd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Jun 2017 13:16:25 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id BEDBEC0A3CADC;
        Mon,  5 Jun 2017 12:16:15 +0100 (IST)
Received: from [10.80.2.5] (10.80.2.5) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 5 Jun
 2017 12:16:18 +0100
Subject: Re: [PATCH] MIPS: ftrace: fix init functions tracing
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
References: <1495537003-1013-1-git-send-email-marcin.nowakowski@imgtec.com>
 <20170523153240.72a8ecd5@vmware.local.home>
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Message-ID: <19a41533-d203-f87b-603a-fcb311c2060f@imgtec.com>
Date:   Mon, 5 Jun 2017 13:16:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170523153240.72a8ecd5@vmware.local.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58209
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

Hi Steven,

On 23.05.2017 21:32, Steven Rostedt wrote:
> On Tue, 23 May 2017 12:56:43 +0200
> Marcin Nowakowski <marcin.nowakowski@imgtec.com> wrote:
> 
>> Since introduction of tracing for init functions the in_kernel_space()
>> check is no longer correct, as it ignores the init sections. As a
>> result, when probes are inserted (and disabled) in the init functions,
>> a branch instruction is inserted instead of a nop, which is likely to
>> result in random crashes during boot.
>>
>> Remove the MIPS-specific in_kernel_space() method and replace it with
>> a generic core_kernel_text() that also checks for init sections during
>> system boot stage.
>>
>> Fixes: 42c269c88dc1 ("ftrace: Allow for function tracing to record
>> init functions on boot up") Signed-off-by: Marcin Nowakowski
>> <marcin.nowakowski@imgtec.com> ---
>>   arch/mips/kernel/ftrace.c | 24 +++++-------------------
>>   1 file changed, 5 insertions(+), 19 deletions(-)
>>
>>
> 
> Thanks for doing this.

There's one issue with this patch that I haven't noticed initially - 
while this fixes the MIPS boot issue, it introduces a problem due to use 
of core_kernel_text in the function graph trace path ... as the 
core_kernel_text function is traced as well, we end up with a recursive 
call to core_kernel_text from its function graph handler, something that 
shows up in a backtrace as:

[    2.972075] Call Trace:
[    2.972111]
[    2.976731] [<80506584>] ftrace_return_to_handler+0x50/0x128
[    2.983379] [<8045478c>] core_kernel_text+0x10/0x1b8
[    2.989146] [<804119b8>] prepare_ftrace_return+0x6c/0x114
[    2.995402] [<80411b2c>] ftrace_graph_caller+0x20/0x44
[    3.001362] [<80411b60>] return_to_handler+0x10/0x30
[    3.007159] [<80411b50>] return_to_handler+0x0/0x30
[    3.012827] [<80411b50>] return_to_handler+0x0/0x30
[    3.018621] [<804e589c>] ftrace_ops_no_ops+0x114/0x1bc
[    3.024602] [<8045478c>] core_kernel_text+0x10/0x1b8
[    3.030377] [<8045478c>] core_kernel_text+0x10/0x1b8
[    3.036140] [<8045478c>] core_kernel_text+0x10/0x1b8
[    3.041915] [<804e589c>] ftrace_ops_no_ops+0x114/0x1bc
[    3.047923] [<8045478c>] core_kernel_text+0x10/0x1b8
[    3.053682] [<804119b8>] prepare_ftrace_return+0x6c/0x114
[    3.059938] [<80411b2c>] ftrace_graph_caller+0x20/0x44
(and many many more repetitions before we run out of stack)

Would a simple patch like:

--- a/kernel/extable.c
+++ b/kernel/extable.c
@@ -69,7 +69,7 @@ static inline int init_kernel_text(unsigned long addr)
         return 0;
  }

-int core_kernel_text(unsigned long addr)
+int notrace core_kernel_text(unsigned long addr)
  {
         if (addr >= (unsigned long)_stext &&
             addr < (unsigned long)_etext)


be acceptable here to solve this problem? It needs to modify the generic 
kernel code due to a dependency that is specific to MIPS only, so it 
might not be the best solution, but an alternative is to add restore a 
copy of that method in arch/mips - which doesn't seem very nice either.
The core_kernel_text function is not something that is extremely 
valuable to be traced IMO anyway, so it shouldn't be a big loss.

What's your opinion?
If this change is OK I'll send out a patch

thanks
Marcin
