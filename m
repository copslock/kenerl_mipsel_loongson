Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Nov 2014 22:31:31 +0100 (CET)
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.232]:28125 "EHLO
        cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27014220AbaKUVb3Ka1kk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Nov 2014 22:31:29 +0100
Received: from [67.246.153.56] ([67.246.153.56:51644] helo=gandalf.local.home)
        by cdptpa-oedge02 (envelope-from <rostedt@goodmis.org>)
        (ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
        id 88/81-25152-A2FAF645; Fri, 21 Nov 2014 21:31:23 +0000
Date:   Fri, 21 Nov 2014 16:31:16 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        <mingo@redhat.com>
Subject: Re: ftrace function graph with static ftrace does not work on MIPS
Message-ID: <20141121163116.523cb394@gandalf.local.home>
In-Reply-To: <546F06F8.4070500@imgtec.com>
References: <546478A1.5040306@imgtec.com>
        <20141120110942.0bbc70a1@gandalf.local.home>
        <546F06F8.4070500@imgtec.com>
X-Mailer: Claws Mail 3.10.1 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-RR-Connecting-IP: 107.14.168.130:25
X-Cloudmark-Score: 0
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44346
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

On Fri, 21 Nov 2014 09:33:44 +0000
Markos Chandras <Markos.Chandras@imgtec.com> wrote:
 
> Hi Steven,
> 
> I had a look on
> 
> https://www.kernel.org/doc/Documentation/trace/ftrace-design.txt
> 
> and section "HAVE_FUNCTION_GRAPH_TRACER"
> 
> According to the sample code, first we check "ftrace_trace_function !=
> ftrace_stub" and if that's true, then we never check the ftrace_graph_*
> functions which is exactly what MIPS does. So the graph functions are
> not always checked. x86 seems to do something similar in mcount_64.S
> 

Thanks, I need to update that file.

I don't test static tracing much as I feel it's overhead makes it
almost not worth keeping. I've been even thinking of nuking it, but I
keep it in because it's good for archs adding function tracing to get a
basic test working, as dynamic function tracing is a bit more difficult
to implement.

But yeah, don't go too much by that document. It is out of date, and
when I get time, I'll have to update it. I'll probably do that when I
bring powerpc up to speed with x86 (except for the fentry part).

I want dynamic trampolines for powerpc and such, and when I do that, it
will make all the changes fresh in my mind to go back and tackle the
design documentation.

-- Steve
