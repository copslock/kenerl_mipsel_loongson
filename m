Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Aug 2011 04:13:21 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:54564 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491913Ab1H0CNR convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 27 Aug 2011 04:13:17 +0200
Received: by wyh11 with SMTP id 11so3516739wyh.36
        for <linux-mips@linux-mips.org>; Fri, 26 Aug 2011 19:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5pHaPZAzmoukcP8W092MS/qkN2mvHZw3ootSH1hrvT8=;
        b=q6tAHWfnqL0J670FxeuD1r0ND7x5VHJQH0WVaGaylY+E6tkCg95uGXT6e0ylXuehRX
         gTk72kLM7wIyusoF6jhl2uiKtlwL2vXRMISF0Ab+eJy27fMC5EMvH7OgfG3jiD7cwZXX
         BMy/icfl6AuwiUDUEQ6hdTQnEa6rLqmiZ3VaE=
MIME-Version: 1.0
Received: by 10.216.9.70 with SMTP id 48mr990951wes.108.1314411191693; Fri, 26
 Aug 2011 19:13:11 -0700 (PDT)
Received: by 10.216.48.1 with HTTP; Fri, 26 Aug 2011 19:13:11 -0700 (PDT)
In-Reply-To: <74B0AE1BA53C37449DE49BB274F9A2DBC4D052@orion8.netlogicmicro.com>
References: <74B0AE1BA53C37449DE49BB274F9A2DBC4D052@orion8.netlogicmicro.com>
Date:   Sat, 27 Aug 2011 07:43:11 +0530
X-Google-Sender-Auth: 5Oc0IvT_A6zfk2Z2gQkIsK8QTRk
Message-ID: <CA+7sy7CSauuSAgF1Ai8dRbcVzVkdj7zWxVjOuyUJw2WSUwk5bg@mail.gmail.com>
Subject: Re: How to chip->startup() with IRQs disabled
From:   "Jayachandran C." <jayachandranc@netlogicmicro.com>
To:     Om Narasimhan <onarasimhan@netlogicmicro.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 31003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20450

On Sat, Aug 27, 2011 at 7:09 AM, Om Narasimhan
<onarasimhan@netlogicmicro.com> wrote:
> Hi,
> I am working on a chip with multiple cores. I have defined
> static struct irq_chip new_plat_chip = {
> ...
>        .startup = n_irq_startup,
>        .mask = n_irq_shutdown,
> ...
> };
>
> In n_irq_startup(), I have to make sure that all cores have set RVEC bit and corresponding EIMR bit. So, I try using on_each_cpu() (because EIMR can be set only by running code on that particular cpu) to run a function to set EIMR.
>
> n_irq_startup() is called as chip->startup() from __setup_irq() (from request_threaded_irq, in turn from request_irq() ) with a spin lock held (desc->lock, in kernel/irq/manage.c).  This causes a stack dump from on_each_cpu(). Since it is wrong to call on_each_cpu with interrupts disabled, I want to change this piece of code.
>
> I am wondering how other SMP mips system implement this. Any comments or pointers will be helpful.
>
> I am not in the mailing list, please CC me in replies.

In XLR code (http://git.linux-mips.org/?p=linux.git;a=blob;f=arch/mips/netlogic/xlr/smp.c)
we do the initialization of EIMR in nlm_init_secondary() which is
registered as .init_secondary method in smp_ops.  on_each_cpu() may
not be the right way to do this.

JC.
