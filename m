Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jan 2013 16:35:56 +0100 (CET)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:29820 "EHLO
        hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6832832Ab3AQPfvF0Fbf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jan 2013 16:35:51 +0100
X-Authority-Analysis: v=2.0 cv=O9a7TWBW c=1 sm=0 a=rXTBtCOcEpjy1lPqhTCpEQ==:17 a=mNMOxpOpBa8A:10 a=RAYXirgi3N4A:10 a=5SG0PmZfjMsA:10 a=Q9fys5e9bTEA:10 a=meVymXHHAAAA:8 a=iAK3kXgEXMMA:10 a=9tU1zQue3W_4dtgYghAA:9 a=PUjeQqilurYA:10 a=rXTBtCOcEpjy1lPqhTCpEQ==:117
X-Cloudmark-Score: 0
X-Authenticated-User: 
X-Originating-IP: 74.67.115.198
Received: from [74.67.115.198] ([74.67.115.198:51200] helo=[192.168.23.10])
        by hrndva-oedge04.mail.rr.com (envelope-from <rostedt@goodmis.org>)
        (ecelerity 2.2.3.46 r()) with ESMTP
        id B6/BB-01424-15A18F05; Thu, 17 Jan 2013 15:35:46 +0000
Message-ID: <1358436945.23211.10.camel@gandalf.local.home>
Subject: Re: [PATCH V2] mips: function tracer: Fix broken function tracing
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alan Cooper <alcooperx@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>, ddaney.cavm@gmail.com,
        ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 17 Jan 2013 10:35:45 -0500
In-Reply-To: <CAOGqxeWNfknkq2Kad2sTWh9f9C8HpghdNBimsB9HFs8ze=LHHQ@mail.gmail.com>
References: <1358379808-16449-1-git-send-email-alcooperx@gmail.com>
         <CAMuHMdUSRM6dauiRtSs20YVfHmNrROrc4RpZL+dKA_e2t82J6A@mail.gmail.com>
         <CAOGqxeWNfknkq2Kad2sTWh9f9C8HpghdNBimsB9HFs8ze=LHHQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.4.4-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-archive-position: 35481
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, 2013-01-17 at 09:58 -0500, Alan Cooper wrote:
> When the kernel first boots we have to be able to handle the gcc
> generated jalr, addui sequence until ftrace_init gets a chance to run
> and change the sequence. At this point mcount just adjusts the stack
> and returns. When ftrace_init runs, we convert the jalr/addui to nops.
> Then whenever tracing is enabled we convert the first nop to a "jalr
> mcount+8". The mcount+8 entry point skips the stack adjust.
> 

I was confused by that too.

> 
> On Thu, Jan 17, 2013 at 1:27 AM, Geert Uytterhoeven

> >
> >> @@ -69,7 +68,7 @@ NESTED(ftrace_caller, PT_SIZE, ra)
> >>         .globl _mcount
> >>  _mcount:
> >>         b       ftrace_stub
> >> -        nop
> >> +       addiu sp,sp,8

Can you add a comment here:

	/* When tracing is activated, it calls ftrace_caller+8 (aka here) */

> >>         lw      t1, function_trace_stop
> >>         bnez    t1, ftrace_stub
> >>         nop
> >

-- Steve
