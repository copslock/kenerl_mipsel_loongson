Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2012 17:20:53 +0200 (CEST)
Received: from mail-ee0-f49.google.com ([74.125.83.49]:51888 "EHLO
        mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903616Ab2HUPUt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2012 17:20:49 +0200
Received: by eekc13 with SMTP id c13so1882453eek.36
        for <multiple recipients>; Tue, 21 Aug 2012 08:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xsFcsyq6UYpLfeIqmBZsDj4SxSvK4QL5aRNPpkQvz6o=;
        b=d4Xg7b6L1OLaarsJpIpFzbKnIIzgq6ElQlOAdcjaL0PlCUurCWedRS18RKWUFoYtjR
         D53PTGC3pwKj2GLAlp3BfjH6MjQ1FFCj7/HoEBWxo9agX9tPtw98AhW0lyDCIIjn/zwD
         tBPjP3BrHc6h86/kRNkPMAlruC50H/sRGQTkbyR6Ionf0uCY+L8nLdNMA2AxDWKWkoIf
         80AjjVV573aP+0/bQblH8KtwiLIcK9tZpanKpsRo5LaPonBdgmoCJ90GlJYCmDFdhZ0y
         vQP+OzIfY3AlE55RWBO6oWGXRJzxr8CQbF+6Ck+QLfDI20x0gCHtiqYQtFmza0CIlxBg
         MCmw==
MIME-Version: 1.0
Received: by 10.14.4.198 with SMTP id 46mr13882433eej.11.1345562443842; Tue,
 21 Aug 2012 08:20:43 -0700 (PDT)
Received: by 10.14.179.71 with HTTP; Tue, 21 Aug 2012 08:20:43 -0700 (PDT)
In-Reply-To: <20120821120418.GE10347@arwen.pp.htv.fi>
References: <97cb21b8063a02a9664baf8b749ae200@localhost>
        <20120820074041.GH17455@arwen.pp.htv.fi>
        <CAJiQ=7CB2w=aNwtU4f3di6c31tD-EWO9YLejESY5HsUaHY6s1A@mail.gmail.com>
        <20120821120418.GE10347@arwen.pp.htv.fi>
Date:   Tue, 21 Aug 2012 08:20:43 -0700
Message-ID: <CAJiQ=7BQz18s03du_Q33z45W+QrkVaPqgZSuUTU-x9v=48CGbA@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: bcm63xx UDC driver
From:   Kevin Cernekee <cernekee@gmail.com>
To:     balbi@ti.com
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 34303
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Tue, Aug 21, 2012 at 5:04 AM, Felipe Balbi <balbi@ti.com> wrote:
> On Mon, Aug 20, 2012 at 08:48:11PM -0700, Kevin Cernekee wrote:
>> On Mon, Aug 20, 2012 at 12:40 AM, Felipe Balbi <balbi@ti.com> wrote:
>> > no workqueues, please either handle the IRQ here or use threaded_irqs.
>> >
>> > again, no workqueues.
>>
>> Felipe,
>>
>> I am seeing all sorts of deadlocks now, after removing the workqueue
>> (patch V2).  Some have easy fixes, but for others it is not as
>> obvious.  The code was much simpler when I could just trigger a
>> deferred worker function.
>>
>> Workqueues are used in at91_udc, lpc32xx_udc, mv_udc_core, and
>> pch_udc.  Could you please clarify why it is not OK to use one in
>> bcm63xx_udc?
>
> Because threaded_irqs were added in order to drop such workqueues.
> threaded_irqs also have the highest priority possible (only lower than
> hardirq handlers), so you'll get scheduled much sooner.
>
> Could it be that most of your deadlocks is because you're not setting
> IRQF_ONESHOT ?

The deadlocks involve ep0 processing that is triggered through
bcm63xx_udc_queue().  e.g. gadget driver queues a new request, it's a
reply to a spoofed SET_CONFIGURATION / SET_INTERFACE transaction, and
the UDC driver calls the completion immediately.

So, not all of the ep0 work is being done in response to an IRQ from
the controller HW, and I think that is where this driver diverges from
most of the others.

Would it be OK to use a workqueue, or maybe a tasklet, given these
circumstances?

Thanks.
