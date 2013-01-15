Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jan 2013 04:40:15 +0100 (CET)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:27909 "EHLO
        hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816511Ab3AODkOejDsz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Jan 2013 04:40:14 +0100
X-Authority-Analysis: v=2.0 cv=O9a7TWBW c=1 sm=0 a=rXTBtCOcEpjy1lPqhTCpEQ==:17 a=mNMOxpOpBa8A:10 a=wom5GMh1gUkA:10 a=79wlbEtt-9EA:10 a=5SG0PmZfjMsA:10 a=kj9zAlcOel0A:10 a=meVymXHHAAAA:8 a=pX4miy-IAAsA:10 a=zIuCNmsNwhn0J9T5-rMA:9 a=CjuIK1q_8ugA:10 a=rXTBtCOcEpjy1lPqhTCpEQ==:117
X-Cloudmark-Score: 0
X-Authenticated-User: 
X-Originating-IP: 74.67.115.198
Received: from [74.67.115.198] ([74.67.115.198:52742] helo=goliath)
        by hrndva-oedge04.mail.rr.com (envelope-from <rostedt@home.goodmis.org>)
        (ecelerity 2.2.3.46 r()) with ESMTP
        id 6C/2F-01424-79FC4F05; Tue, 15 Jan 2013 03:40:07 +0000
Received: by goliath (Postfix, from userid 5657)
        id CAE1E3E0AD; Mon, 14 Jan 2013 22:40:06 -0500 (EST)
Date:   Mon, 14 Jan 2013 22:40:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Al Cooper <alcooperx@gmail.com>, ralf@linux-mips.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: function tracer: Fix broken function tracing
Message-ID: <20130115034006.GA3854@home.goodmis.org>
References: <y>
 <1357914810-20656-1-git-send-email-alcooperx@gmail.com>
 <50F0454D.5060109@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50F0454D.5060109@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35437
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

On Fri, Jan 11, 2013 at 09:01:01AM -0800, David Daney wrote:
> 
> I thought all CPUs were in stop_machine() when the modifications
> were done, so that there is no issue with multi-word instruction
> patching.
> 
> Am I wrong about this?
> 
> So really I think you can do two NOP just as easily.

The problem with double NOPs is that it can only work if there's no
problem executing one nop and a non NOP. Which I think is an issue here.


If you have something like:

	bl	_mcount
	addiu	sp,sp,-8

And you convert that to:

	nop
	nop

Now if you convert that back to:

	bl	ftrace_caller
	addiu	sp,sp,-8

then you can have an issue if the task was preempted after that first
nop. Because stop_machine() doesn't wait for tasks to exit kernel space.
If you have a CONFIG_PREEMPT kernel, a task can be sleeping anywhere.
Thus you have a task execute the first nop, get preempted. You update
the code to be:

	bl	ftrace_caller
	addiu	sp,sp,-8

When that task gets scheduled back in, it will act like it just
executed:

	nop
	addiu	sp,sp,-8

Which is the problem you're trying to solve in the first place.

Now that said, There's no reason we need that addiu sp,sp,-8 there.
That's just what the mips defined mcount requires. But as you can see
above, with dynamic ftrace, the defined mcount is only called at boot
up, and never again. That means at boot up you can convert to:

	nop
	nop

and then when you enable tracing just convert it to:

	bl	ftrace_caller
	nop

There's nothing that states what the ftrace caller must be. We can have
it do a proper stack update. That is, only at boot up do we need to
handle the defined mcount. After that, those instructions are just place
holders for our own algorithms. If the addiu was needed for the defined
mcount, there's no reason to keep it for our own ftrace_caller.

Would that work?

-- Steve
