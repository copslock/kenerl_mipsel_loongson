Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Aug 2010 15:15:27 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:60124 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491766Ab0HZNPU convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Aug 2010 15:15:20 +0200
Received: by wyb38 with SMTP id 38so556860wyb.36
        for <multiple recipients>; Thu, 26 Aug 2010 06:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zoX8MdZ/so0VKsB3Jcl2bnsX3hxT8ku6pPTYucE5yiY=;
        b=R2lMRz6FdyH2Udyo1n89LILWg3tYU9iX4S/y6YD49liZYh/8Fbem8O71wcXMxjtuni
         T+nM7p/M/0bIuw0ibgku9nFz2S7W//8GEJ5LPatrJQCS9z1Sjd+f6parPuQy8mwWh35A
         wngus+83QXGim4TacyfGtBZ2pVc2RQe5DRgco=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Lga4Kgptqq5xIJNa/RTwJAkiC+qBIFUGcMwU4blixHn9lVf63YADaxJqF3x7HtQ6JE
         t5CWog7SSEOhLhozwoa7bgzOqOntNmS8cy1/HJvRZDc8QRnLaixypqZ4Y3w2ijLa/WEv
         shenuGqLlHWYzbbqzRFNRvpUo59RYP2lS68oA=
MIME-Version: 1.0
Received: by 10.227.138.76 with SMTP id z12mr9013603wbt.60.1282828509701; Thu,
 26 Aug 2010 06:15:09 -0700 (PDT)
Received: by 10.227.133.194 with HTTP; Thu, 26 Aug 2010 06:15:09 -0700 (PDT)
In-Reply-To: <4C762572.4070509@mvista.com>
References: <linux-kernel@vger.kernel.org>
        <1282794933-20639-1-git-send-email-jiang.adam@gmail.com>
        <4C762572.4070509@mvista.com>
Date:   Thu, 26 Aug 2010 22:15:09 +0900
Message-ID: <AANLkTim+RgOZY2PHQa=Ukp+bHSrHrEyF=Nfa4NU_J7K7@mail.gmail.com>
Subject: Re: [PATCH 3/3] mips: irq: add stackoverflow detection
From:   Adam Jiang <jiang.adam@gmail.com>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     ralf@linux-mips.org, dmitri.vorobiev@movial.com,
        wuzhangjin@gmail.com, ddaney@caviumnetworks.com,
        peterz@infradead.org, fweisbec@gmail.com, tj@kernel.org,
        tglx@linutronix.de, mingo@elte.hu, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <jiang.adam@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27673
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiang.adam@gmail.com
Precedence: bulk
X-list: linux-mips

2010/8/26 Sergei Shtylyov <sshtylyov@mvista.com>:
> Hello.
>
> Adam Jiang wrote:
>
>> Add stackoverflow detection to mips arch
>
> [...]
>
>> diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
>> index c6345f5..75c584d 100644
>> --- a/arch/mips/kernel/irq.c
>> +++ b/arch/mips/kernel/irq.c
>> @@ -151,6 +151,25 @@ void __init init_IRQ(void)
>>  #endif
>>  }
>>  +#ifdef CONFIG_DEBUG_STACKOVERFLOW
>> +static inline void check_stack_overflow(void)
>> +{
>> +       long sp;
>> +
>> +       asm volatile("move %0, $sp" : "=r" (sp));
>> +       sp = sp & (THREAD_SIZE-1);
>> +
>> +       /* check for stack overflow: is there less than 2KB free? */
>> +       if (unlikely(sp < (sizeof(struct thread_info) + 2048))) {
>> +               printk("do_IRQ: stack overflow: %ld\n",
>> +                      sp - sizeof(struct thread_info));
>> +               dump_stack();
>> +       }
>> +}
>> +#else
>> +static inline void check_stack_overflow(void)
>
>   You didn't even try to compile with the option disabled -- you've missed
> {}.

Thank your, Sergei.

This is my first patch. I realized I have to learn much to summit a
good patch. And yes, I have to pay more attention on my code. Anyway,
I will try to get a good patch and send it here again.

/Adam

>
>> +#endif
>> +
>>  /*
>>  * do_IRQ handles all normal device IRQ's (the special
>>  * SMP cross-CPU interrupts have their own specific
>
> WBR, Sergei
>
