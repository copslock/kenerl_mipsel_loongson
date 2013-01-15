Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jan 2013 18:53:08 +0100 (CET)
Received: from mail-qa0-f41.google.com ([209.85.216.41]:36018 "EHLO
        mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6832207Ab3AORxHmngS3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Jan 2013 18:53:07 +0100
Received: by mail-qa0-f41.google.com with SMTP id o19so2612570qap.14
        for <multiple recipients>; Tue, 15 Jan 2013 09:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=eXVA+JLHeye3fE9u6QNZg4QFfKFxF2EGYouEeKF5RaE=;
        b=NV8VW1h081Oq5/TfrQNuDB3/Cupyc3bjzumQgND5ajZG+q0Y6blMpTARZHZJAUNAVn
         1vQjz9ErgshmccBMiHWPqiaOxmaHE7Jtsp5zKBV+fUhgEbwBrfBmPugtZZthSnnwDzQX
         0w/CORnLUCnNjX47j0P7rdwo6Wr466bUCRicazkcXaYKrDSPPjUijIAEUKzNI2sMRNxd
         l8mbx7oObeQdrldYxWuEErZfDdrvbfoxAAmb/sij9GQjyF63UH2RsjDGBGcTl5uvs/cn
         /gz0ozuQ50bFIE42pQkZjcRR94gzUjVpHyOq1ztK6aZFPX48cmYz3NeG7W4Bywx5IDNG
         MWhQ==
MIME-Version: 1.0
Received: by 10.224.59.135 with SMTP id l7mr74488205qah.25.1358272381177; Tue,
 15 Jan 2013 09:53:01 -0800 (PST)
Received: by 10.49.117.161 with HTTP; Tue, 15 Jan 2013 09:53:00 -0800 (PST)
In-Reply-To: <20130115034006.GA3854@home.goodmis.org>
References: <1357914810-20656-1-git-send-email-alcooperx@gmail.com>
        <50F0454D.5060109@gmail.com>
        <20130115034006.GA3854@home.goodmis.org>
Date:   Tue, 15 Jan 2013 12:53:00 -0500
Message-ID: <CAOGqxeUSAikiRpVY=Lsu71DzBU6Mmt7C319NqLOv1WscESq=tw@mail.gmail.com>
Subject: Re: [PATCH] mips: function tracer: Fix broken function tracing
From:   Alan Cooper <alcooperx@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     David Daney <ddaney.cavm@gmail.com>, ralf@linux-mips.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 35446
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alcooperx@gmail.com
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

On Mon, Jan 14, 2013 at 10:40 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
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
>         bl      _mcount
>         addiu   sp,sp,-8
>
> And you convert that to:
>
>         nop
>         nop
>
> Now if you convert that back to:
>
>         bl      ftrace_caller
>         addiu   sp,sp,-8
>
> then you can have an issue if the task was preempted after that first
> nop. Because stop_machine() doesn't wait for tasks to exit kernel space.
> If you have a CONFIG_PREEMPT kernel, a task can be sleeping anywhere.
> Thus you have a task execute the first nop, get preempted. You update
> the code to be:
>
>         bl      ftrace_caller
>         addiu   sp,sp,-8
>
> When that task gets scheduled back in, it will act like it just
> executed:
>
>         nop
>         addiu   sp,sp,-8
>
> Which is the problem you're trying to solve in the first place.
>
> Now that said, There's no reason we need that addiu sp,sp,-8 there.
> That's just what the mips defined mcount requires. But as you can see
> above, with dynamic ftrace, the defined mcount is only called at boot
> up, and never again. That means at boot up you can convert to:
>
>         nop
>         nop
>
> and then when you enable tracing just convert it to:
>
>         bl      ftrace_caller
>         nop
>
> There's nothing that states what the ftrace caller must be. We can have
> it do a proper stack update. That is, only at boot up do we need to
> handle the defined mcount. After that, those instructions are just place
> holders for our own algorithms. If the addiu was needed for the defined
> mcount, there's no reason to keep it for our own ftrace_caller.
>
> Would that work?
>
> -- Steve
>
