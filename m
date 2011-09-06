Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Sep 2011 21:02:46 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:64283 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491846Ab1IFTCk convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Sep 2011 21:02:40 +0200
Received: by fxd20 with SMTP id 20so86236fxd.36
        for <linux-mips@linux-mips.org>; Tue, 06 Sep 2011 12:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=vYlgo6q3QCm1VtQZFfatT3+O2qszT0XoYx4Kwuv1JJo=;
        b=j/J+i5ABAvX9Fb3TMkxGCIYxFzeIyhQdb/E+ep89oUcrQHMeO4BTLbNBpQ46i3GQgn
         Je+VsRD/1/3eoDFajKHzGZY4SB8WO/0n8tN0IPMpnq8n0oEIruqAIn3ZveVxLf3OywYO
         4F8H5h5x21hwzsKxUdP4xQ/TUNnG3MPd1wWN0=
MIME-Version: 1.0
Received: by 10.223.63.8 with SMTP id z8mr346285fah.84.1315335755219; Tue, 06
 Sep 2011 12:02:35 -0700 (PDT)
Received: by 10.223.83.203 with HTTP; Tue, 6 Sep 2011 12:02:35 -0700 (PDT)
In-Reply-To: <4E6668A4.8010300@cavium.com>
References: <CAFsuBjW4XZy6x4gDL+0cw92jUbuEodF4vzCcCijQDize97wkNQ@mail.gmail.com>
        <4E6668A4.8010300@cavium.com>
Date:   Wed, 7 Sep 2011 00:32:35 +0530
Message-ID: <CAFsuBjU_VnUPL+hpQV=m1HNJ6Fis38hyToOHBgROmiYYTEQHyQ@mail.gmail.com>
Subject: Re: MIPS: Octeon: mailbox_interrupt is not registered as per cpu
From:   SAURABH MALPANI <saurabh140585@gmail.com>
To:     David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 31048
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: saurabh140585@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3411

Hi David,

Thanks a bunch for clarifying this. Just to complete, I have some code
which calls CHECK_IRQ_PER_CPU(desc->status) after every time a
descriptor is created for an irq. And based on it we create either per
cpu data structures or single data structure for that particular irq.

After your clarification, I can safely create exception for
OCTEON_IRQ_MBOX0 and OCTEON_IRQ_MBOX1 as you mention that missing the
flag is just cosmetic.

Thanks again
Saurabh


On Wed, Sep 7, 2011 at 12:08 AM, David Daney <david.daney@cavium.com> wrote:
> On 09/05/2011 03:23 AM, SAURABH MALPANI wrote:
>>
>> Hi,
>>
>> <Re sending this because last time I am afraid I didn't hit the
>> correct mail filters.>
>>
>> Query:
>>
>> mailbox_interrupt is not registered with IRQF_PERCPU but it is
>> supposed to be percpu interrupt. Is that on purpose or a miss?
>
> On Octeon the per-cpuness of a particular irq is a property of the irq
> itself rather than being controlled by IRQF_PERCPU.  So other than being
> perhaps stylistically in poor taste, no harm is done by omitting IRQF_PERCPU
> here.
>
>> I am
>> porting some code from x86 to octeon which requires special handling
>> for per cpu interrupts.
>>
>>  void octeon_prepare_cpus(unsigned int max_cpus)
>> {
>>          cvmx_write_csr(CVMX_CIU_MBOX_CLRX(cvmx_get_core_num()),
>> 0xffffffff);
>>          if (request_irq(OCTEON_IRQ_MBOX0, mailbox_interrupt,
>> IRQF_DISABLED,
>>                          "mailbox0", mailbox_interrupt)) {
>>                  panic("Cannot request_irq(OCTEON_IRQ_MBOX0)\n");
>>          }
>>          if (request_irq(OCTEON_IRQ_MBOX1, mailbox_interrupt,
>> IRQF_DISABLED,
>>                          "mailbox1", mailbox_interrupt)) {
>>                  panic("Cannot request_irq(OCTEON_IRQ_MBOX1)\n");
>>          }
>> }
>>
>> --
>> Saurabh
>>
>>
>
>



-- 
Saurabh
