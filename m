Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Sep 2014 18:36:15 +0200 (CEST)
Received: from mail-vc0-f175.google.com ([209.85.220.175]:38283 "EHLO
        mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009155AbaIQQgMqt8Kl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Sep 2014 18:36:12 +0200
Received: by mail-vc0-f175.google.com with SMTP id hq11so1527949vcb.34
        for <linux-mips@linux-mips.org>; Wed, 17 Sep 2014 09:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=+y0vi6+yQ2eBWmaH9M3UGyKsAWqaobd4c9KkWcI6ebA=;
        b=PMNAEhfJBlsavQOZD6S7da/p+M6FLW9B4C4FjrUg03g2jYYExnVUcxHY+xzIGqCiqJ
         +FXM+MpcJQ2jZ+jXR7GyCDdosy+7rhboXnUsRciNor39QQmvDOY7H6TFuqytwZUpBrcB
         IVhdjRAs8qNEnPS3Xm0bBz28wq9Nkt82wzjhN9qE75oS7fdmqrh5brZYMjW93BF2ysG4
         MkchuY4ON6L5qt9E7LPe+smUrqqRt5QE8upV5TLICFO0+SSHJvvQ35v8FUlpt6IfRXN+
         QpZ2sNE1fW9mSHFwVsc9eyYmckgD2wb3vo7ZAZgSRZRghx9RoDqYzzeniBCZ0SHZahhv
         ivqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=+y0vi6+yQ2eBWmaH9M3UGyKsAWqaobd4c9KkWcI6ebA=;
        b=Mxo8ExlUsVgoMgjTrQEUO4CiXsTgwb9b4vucpWdmUO0E6Wsb70uFhq1tQ1QkZraJcs
         3K6xsaHcJudYA1cjaqlpNqlO81cjqB0iDH3/P8iQ84IP9fxIfBDwowItZ/uoPrMgutwt
         Wa306N7320kiMhBMx+vR1T7JRrSmjbDZluTvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=+y0vi6+yQ2eBWmaH9M3UGyKsAWqaobd4c9KkWcI6ebA=;
        b=kk7e904AgGx+LsM6mrY0uR02sFUSTecLlgyQ5ooz8d6M2hiWKlOJ6Cndkif9XXKzND
         fMZkRQbEfcNtBTIRAp+HxGlA7AWP+/l1vkxmW1oGyVFi97mBwKTgWDAuMnKlL5e31W9l
         cFUAyfx3obgnlhEiu49v17TDTuIARHRX3XPWXdlSvNqNJ6o8AQSYUaKQatxLZqaXxCjV
         wwcz43zttlHW1b1iNe1tzp6DK5LwnxectcO9/9lL89AOSzLBTA8Uwt4EH2lKSsd4B1ZK
         rk7k7vO1t8x1MPPXlMnUkLEz3c/iAQBEjtn/VNDWfntJp9W/ojMPYKWCiIozAd8r8wa9
         1f4w==
X-Gm-Message-State: ALoCoQmdc19t+Px8PEczJLyJd8iMCkdJ61iJA6GrrZ9uf5TcKSaV0p7mn4nYE9QPox5pW5vcD9wP
MIME-Version: 1.0
X-Received: by 10.220.161.136 with SMTP id r8mr4857381vcx.21.1410971766570;
 Wed, 17 Sep 2014 09:36:06 -0700 (PDT)
Received: by 10.52.168.200 with HTTP; Wed, 17 Sep 2014 09:36:06 -0700 (PDT)
In-Reply-To: <54194CB9.4010200@imgtec.com>
References: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
        <1410825087-5497-4-git-send-email-abrestic@chromium.org>
        <54194CB9.4010200@imgtec.com>
Date:   Wed, 17 Sep 2014 09:36:06 -0700
X-Google-Sender-Auth: l9jw2oDJEcwK8g8o3aSJ81TQt28
Message-ID: <CAL1qeaGNF_8XNTQiWomiJjbuN0mVgayFNKWfMVzrd=bBtwEY7g@mail.gmail.com>
Subject: Re: [PATCH 03/24] MIPS: Provide a generic plat_irq_dispatch
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Qais Yousef <qais.yousef@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Jonas Gorski <jogo@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42664
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

On Wed, Sep 17, 2014 at 1:56 AM, Qais Yousef <qais.yousef@imgtec.com> wrote:
> Hi Andrew,
>
>
> On 09/16/2014 12:51 AM, Andrew Bresticker wrote:
>>
>> For platforms which boot with device-tree or have correctly chained
>> all external interrupt controllers, a generic plat_irq_dispatch() can
>> be used.  Implement a plat_irq_dispatch() which simply handles all the
>> pending interrupts as reported by C0_Cause.
>>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> ---
>>   arch/mips/kernel/irq_cpu.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/arch/mips/kernel/irq_cpu.c b/arch/mips/kernel/irq_cpu.c
>> index ca98a9f..f17bd08 100644
>> --- a/arch/mips/kernel/irq_cpu.c
>> +++ b/arch/mips/kernel/irq_cpu.c
>> @@ -94,6 +94,21 @@ static struct irq_chip mips_mt_cpu_irq_controller = {
>>         .irq_eoi        = unmask_mips_irq,
>>   };
>>   +asmlinkage void __weak plat_irq_dispatch(void)
>> +{
>> +       unsigned long pending = read_c0_cause() & read_c0_status() &
>> ST0_IM;
>> +       int irq;
>> +
>> +       if (!pending) {
>> +               spurious_interrupt();
>> +               return;
>> +       }
>> +
>> +       pending >>= CAUSEB_IP;
>> +       for_each_set_bit(irq, &pending, 8)
>> +               do_IRQ(MIPS_CPU_IRQ_BASE + irq);
>> +}
>> +
>
>
> If I read the for_each_set_bit() macro correctly it'll iterate through the
> bits from least to most significant ones which is the reversed priority
> expected. Some platforms set timer interrupt to bit 7 which is should be the
> highest priority interrupt. Also when cpu_has_vint is set the hardware
> prioritirise from most significant to least significant bits so if
> plat_irq_dispatch() is used with set_vi_handler() it'll cause interrupts to
> be serviced in the wrong order.

Ah, right.  I'll flip the order here.
