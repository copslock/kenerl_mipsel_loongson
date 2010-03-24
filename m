Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Mar 2010 18:46:46 +0100 (CET)
Received: from mail-fx0-f217.google.com ([209.85.220.217]:50517 "EHLO
        mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492833Ab0CXRqk convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Mar 2010 18:46:40 +0100
Received: by fxm9 with SMTP id 9so6885600fxm.24
        for <linux-mips@linux-mips.org>; Wed, 24 Mar 2010 10:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7pgLRKAL4oPwNL4VOxm7xEWD/B687C4aYRnEA7+UCBs=;
        b=T4ArvqBqxY/eqpOT1zIh1ser/M+2sowkQdwNMuw+bwUGkQolRqacKi5/8MftVGAFPd
         fD+0STmJUFJ1Ge4tecZ6fxeQljsBgoM2Xz3ud9+HUrpz7y51axzyzyiFr9Dyo9seau0A
         FQ1pVMYshkxXXB4+8kUcaJG3wKBayxX8ZYhww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tlkhdTEHisnOwhlUWSHAKKmkhqNVgRCRksHbK/1mOYoWcCd1R36JotIHn+2kTxl1sC
         HixXHMb0m7Pfd6PzTw14J9JYJtgALv6AkXewCyfHPt4Pw8WXSGtQ3QlsFKHq5o5yBYts
         xbhj+eJKHTaeta+NVMasZS+mXeh6OB6oGby2U=
MIME-Version: 1.0
Received: by 10.223.16.66 with SMTP id n2mr3307787faa.83.1269452794566; Wed, 
        24 Mar 2010 10:46:34 -0700 (PDT)
In-Reply-To: <4BAA4E81.8070405@mvista.com>
References: <1269450986-3714-1-git-send-email-manuel.lauss@gmail.com>
         <1269450986-3714-3-git-send-email-manuel.lauss@gmail.com>
         <4BAA4E81.8070405@mvista.com>
Date:   Wed, 24 Mar 2010 18:46:34 +0100
Message-ID: <f861ec6f1003241046q200bdb4ey2d2439197e63e76e@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] Alchemy: UART PM through serial framework.
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, Manuel Lauss <manuel.lauss@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26309
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Wed, Mar 24, 2010 at 6:40 PM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> Hello.
>
> Manuel Lauss wrote:
>
>> Hook up the Alchemy on-chip uarts with the platform 8250 PM callback
>> and enable/disable the uart blocks as needed.
>>
>> Tested on Au1200.
>>
>> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
>> ---
>>  arch/mips/alchemy/common/platform.c |   17 +++++++++++++++++
>>  arch/mips/alchemy/common/power.c    |   32
>> --------------------------------
>>  2 files changed, 17 insertions(+), 32 deletions(-)
>>
>> diff --git a/arch/mips/alchemy/common/platform.c
>> b/arch/mips/alchemy/common/platform.c
>> index 2580e77..70f4abd 100644
>> --- a/arch/mips/alchemy/common/platform.c
>> +++ b/arch/mips/alchemy/common/platform.c
>> @@ -21,6 +21,22 @@
>>  #include <asm/mach-au1x00/au1100_mmc.h>
>>  #include <asm/mach-au1x00/au1xxx_eth.h>
>>  +static void alchemy_8250_pm(struct uart_port *port, unsigned int state,
>> +                           unsigned int old_state)
>> +{
>> +       if (state == 0) {               /* power on */
>> +               __raw_writel(0, port->membase + UART_MOD_CNTRL);
>> +               wmb();
>> +               __raw_writel(1, port->membase + UART_MOD_CNTRL);
>> +               wmb();
>> +               __raw_writel(3, port->membase + UART_MOD_CNTRL);
>> +               wmb();
>> +       } else if (state == 3) {        /* power off */
>> +               __raw_writel(0, port->membase + UART_MOD_CNTRL);
>> +               wmb();
>> +       }
>> +}
>
>  A *switch* statement seems more fitting here...

Well, those are the only 2 values defined anyway, but I'll change it.

Thanks!
       Manuel Lauss
