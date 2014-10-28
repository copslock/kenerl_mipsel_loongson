Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2014 11:56:11 +0100 (CET)
Received: from mail-lb0-f180.google.com ([209.85.217.180]:56575 "EHLO
        mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011577AbaJ1K4KWYwVK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Oct 2014 11:56:10 +0100
Received: by mail-lb0-f180.google.com with SMTP id z12so351405lbi.11
        for <linux-mips@linux-mips.org>; Tue, 28 Oct 2014 03:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tcv05u7F0Wyxeg2w1tzYJaBWCl7g6VIVUitOpRqnG90=;
        b=STDWC3r+GEvHhSdXlwPYezgw2O7bdgrio7PJZbz7esq2kCd8lwVzEbvoLXw754TqbV
         rIaVvQDer3ztxn+UiBPr350pZ7/wv0KLBt5dbvPiD5vvr56ixXZ4gbj6Uif9VSONdtSW
         uORFXwXRbc+aEFbDeZ2z1tvQo42+qP5gytCcQfkT8BkKCJs6ph/eoKdgZO/OGy+4MHfz
         /TVSr2wfg4bu4Q/bgWMVNfG60gyqcWShSUAj3G8PCHJQqbQNWBwGvcDQtVG5kyemyXbd
         znD8rBaJ2XRuaDHy7Fld6SEdu60B0oegQqObv31wjgbwIiPsiAg6EBDzhlwfkshVsIkC
         H/Jg==
MIME-Version: 1.0
X-Received: by 10.152.10.99 with SMTP id h3mr2575073lab.94.1414493764701; Tue,
 28 Oct 2014 03:56:04 -0700 (PDT)
Received: by 10.152.105.196 with HTTP; Tue, 28 Oct 2014 03:56:04 -0700 (PDT)
In-Reply-To: <CAFxy--Zc+262_GzmxQTLkH4Z=G1xvqe8GWF6ov_hbd=ZKBwiQA@mail.gmail.com>
References: <CAFxy--b+j86kn6Ttc+qTTi4chDkKbrmSAxEsS7_CnzuabJAZfQ@mail.gmail.com>
        <CAFxy--Z4FpWJbqr8OMoxgpMXa2WMSuCOA_pvtokcwcq6C-uaFg@mail.gmail.com>
        <1414086028.5231.3.camel@marge.simpson.net>
        <CAFxy--Zc+262_GzmxQTLkH4Z=G1xvqe8GWF6ov_hbd=ZKBwiQA@mail.gmail.com>
Date:   Tue, 28 Oct 2014 16:26:04 +0530
Message-ID: <CAFxy--azsv1sFyemn+gUwocAo6vCQJHVEL4TfUGqqwOHDVGcLQ@mail.gmail.com>
Subject: Re: threadirqs and kthreadd_task
From:   ajay kanala <ajaykanala321@gmail.com>
To:     Mike Galbraith <umgwanakikbuti@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <ajaykanala321@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43620
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ajaykanala321@gmail.com
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
Any pointers from mips list?  Was the option working on any mips arch?

Thanks for the help.
-- Ajay

On Fri, Oct 24, 2014 at 2:48 PM, ajay kanala <ajaykanala321@gmail.com> wrote:
> thanks Mike for info.
> I add mips list in CC now.
>
> In general, the problem does not look like arch specific. Arch code is
> calling setup_irq. This code calls generic  __setup_irq. And then
> threads are created by this line in kernel/irq/manage.c:
> t = kthread_create(irq_thread, new, "irq/%d-%s", irq,
>                                    new->name);
>
> and kthreadd_task is uninitialized till this point.
>
> The code looks similar for x86_64 so i am missing something obvious.
>
> Nevertheless, I am hoping someone from mips-list can throw some light
> if this feature works well on mips.
>
> Thanks
> -- Ajay
>
> On Thu, Oct 23, 2014 at 11:10 PM, Mike Galbraith
> <umgwanakikbuti@gmail.com> wrote:
>> On Thu, 2014-10-23 at 22:48 +0530, ajay kanala wrote:
>>> Hi,
>>> any help?
>>
>> You should CC the MIPS folks methinks, works fine in x86_64 at least.
>>
>> -Mike
>>
>>
>>
