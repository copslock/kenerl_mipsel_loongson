Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2014 11:18:21 +0200 (CEST)
Received: from mail-lb0-f176.google.com ([209.85.217.176]:46086 "EHLO
        mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010214AbaJXJSUfs3LW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Oct 2014 11:18:20 +0200
Received: by mail-lb0-f176.google.com with SMTP id p9so2192464lbv.21
        for <linux-mips@linux-mips.org>; Fri, 24 Oct 2014 02:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7k9HCJQ8IQ9LbK0+h2epupIRwWa6vbv42QCMxfRXFos=;
        b=sMWjk9+u+8pXmyYCCgeuFogXsO+IKmOmZw3hZIdh6i8Hf1xlYWgNgyVcb/ohkf1mnN
         ctxcU/2RpE1AePspdZ4kFr/cc31xI/VA1kpfIpsC1nVh3l4eAmCauHEESF1vFU/LZXZG
         FeGTSAn0b/JWlQXAri8Vfm7i9pCoHiZoAkFZnbELjY74s0uSgNV8hmL/XpB6sED0l3Y6
         jV9BglZuRxdN/xUPmImioTsuRKPVSNvNjttHey24J2u6yof1CfXSR0ZotVH1ZzJMbJnj
         gd0x6avbP9vYA3oxR9WHLUkEj3rd7zfqLMcUD7xGuouvpeLNRuJTcr4k52oHj0zol304
         CDVQ==
MIME-Version: 1.0
X-Received: by 10.153.5.33 with SMTP id cj1mr3152938lad.36.1414142294996; Fri,
 24 Oct 2014 02:18:14 -0700 (PDT)
Received: by 10.152.105.196 with HTTP; Fri, 24 Oct 2014 02:18:14 -0700 (PDT)
In-Reply-To: <1414086028.5231.3.camel@marge.simpson.net>
References: <CAFxy--b+j86kn6Ttc+qTTi4chDkKbrmSAxEsS7_CnzuabJAZfQ@mail.gmail.com>
        <CAFxy--Z4FpWJbqr8OMoxgpMXa2WMSuCOA_pvtokcwcq6C-uaFg@mail.gmail.com>
        <1414086028.5231.3.camel@marge.simpson.net>
Date:   Fri, 24 Oct 2014 14:48:14 +0530
Message-ID: <CAFxy--Zc+262_GzmxQTLkH4Z=G1xvqe8GWF6ov_hbd=ZKBwiQA@mail.gmail.com>
Subject: Re: threadirqs and kthreadd_task
From:   ajay kanala <ajaykanala321@gmail.com>
To:     Mike Galbraith <umgwanakikbuti@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <ajaykanala321@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43551
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

thanks Mike for info.
I add mips list in CC now.

In general, the problem does not look like arch specific. Arch code is
calling setup_irq. This code calls generic  __setup_irq. And then
threads are created by this line in kernel/irq/manage.c:
t = kthread_create(irq_thread, new, "irq/%d-%s", irq,
                                   new->name);

and kthreadd_task is uninitialized till this point.

The code looks similar for x86_64 so i am missing something obvious.

Nevertheless, I am hoping someone from mips-list can throw some light
if this feature works well on mips.

Thanks
-- Ajay

On Thu, Oct 23, 2014 at 11:10 PM, Mike Galbraith
<umgwanakikbuti@gmail.com> wrote:
> On Thu, 2014-10-23 at 22:48 +0530, ajay kanala wrote:
>> Hi,
>> any help?
>
> You should CC the MIPS folks methinks, works fine in x86_64 at least.
>
> -Mike
>
>
>
