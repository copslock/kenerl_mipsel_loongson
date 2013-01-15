Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jan 2013 18:55:39 +0100 (CET)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35400 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6832191Ab3AORzjAA-Z1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Jan 2013 18:55:39 +0100
Received: by mail-pa0-f46.google.com with SMTP id bh2so244782pad.19
        for <multiple recipients>; Tue, 15 Jan 2013 09:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=KNQPESryOR/5+HTe6k3e9yU7OVjnyuKDm8AW6vymrsc=;
        b=TWfsadgbSTW9zm3kUSR/Qibz1QpG05VuXJzD9cl52wAhk/hcZJYFK8YmV74pvpDTwg
         wJvKEicztDxXjWT65Rx/IvutOMG34YuahI17cLNqfaccbeukqatN6KMiGoK8OPQL0SQu
         p+yid/aDh+a40ilerM3Z6SmC+yPEkSQFboi0tCsDOQny0MCkEkzjcZRo3FbkmGtr364M
         bjdCH1IfZEZ+caLvZ7rAVPg6s8b5DHEs9law+Q4ai5dQbArk7OEtzERha4IxWcqCWkCn
         d/ro82eGnYFEm/lyzJLOjLtLkMwN4A/L2aVAn/jQ9aVsCe8lfq4dkd3dkOoyuP+H9rpz
         /bow==
X-Received: by 10.66.79.74 with SMTP id h10mr223227002pax.25.1358272531931;
        Tue, 15 Jan 2013 09:55:31 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id gv9sm10591737pbc.21.2013.01.15.09.55.30
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 15 Jan 2013 09:55:31 -0800 (PST)
Message-ID: <50F59812.6040806@gmail.com>
Date:   Tue, 15 Jan 2013 09:55:30 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Steven Rostedt <rostedt@goodmis.org>,
        Al Cooper <alcooperx@gmail.com>, ralf@linux-mips.org
CC:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: function tracer: Fix broken function tracing
References: <y> <1357914810-20656-1-git-send-email-alcooperx@gmail.com> <50F0454D.5060109@gmail.com> <20130115034006.GA3854@home.goodmis.org>
In-Reply-To: <20130115034006.GA3854@home.goodmis.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35447
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 01/14/2013 07:40 PM, Steven Rostedt wrote:
> On Fri, Jan 11, 2013 at 09:01:01AM -0800, David Daney wrote:
>>
>> I thought all CPUs were in stop_machine() when the modifications
>> were done, so that there is no issue with multi-word instruction
>> patching.
>>
>> Am I wrong about this?
>>
>> So really I think you can do two NOP just as easily.
>
> The problem with double NOPs is that it can only work if there's no
> problem executing one nop and a non NOP. Which I think is an issue here.
>
>
> If you have something like:
>
> 	bl	_mcount
> 	addiu	sp,sp,-8
>
> And you convert that to:
>
> 	nop
> 	nop
>
> Now if you convert that back to:
>
> 	bl	ftrace_caller
> 	addiu	sp,sp,-8
>
> then you can have an issue if the task was preempted after that first
> nop. Because stop_machine() doesn't wait for tasks to exit kernel space.
> If you have a CONFIG_PREEMPT kernel, a task can be sleeping anywhere.
> Thus you have a task execute the first nop, get preempted. You update
> the code to be:

Thanks for the explanation Steven.  This is the part I was missing.


Given all of this, I think the most expedient course for the short term 
is to use the branch-likely-false trick.  Although the performance will 
probably not be great, I think it is probably race free.

In the longer term...

>
> 	bl	ftrace_caller
> 	addiu	sp,sp,-8
>
> When that task gets scheduled back in, it will act like it just
> executed:
>
> 	nop
> 	addiu	sp,sp,-8
>
> Which is the problem you're trying to solve in the first place.
>
> Now that said, There's no reason we need that addiu sp,sp,-8 there.
> That's just what the mips defined mcount requires. But as you can see
> above, with dynamic ftrace, the defined mcount is only called at boot
> up, and never again. That means at boot up you can convert to:
>
> 	nop
> 	nop
>
> and then when you enable tracing just convert it to:
>
> 	bl	ftrace_caller
> 	nop
>
> There's nothing that states what the ftrace caller must be. We can have
> it do a proper stack update. That is, only at boot up do we need to
> handle the defined mcount. After that, those instructions are just place
> holders for our own algorithms. If the addiu was needed for the defined
> mcount, there's no reason to keep it for our own ftrace_caller.
>
> Would that work?

... either do as you suggest and dynamically change the ABI of the 
target function.

Or add support to GCC for a better tracing ABI (as I already said we did 
for mips64).


Thanks,
David Daney
