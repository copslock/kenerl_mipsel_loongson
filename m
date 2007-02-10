Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Feb 2007 17:30:46 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:15089 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20037424AbXBJRal (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 10 Feb 2007 17:30:41 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 74BBF3EC9; Sat, 10 Feb 2007 09:30:05 -0800 (PST)
Message-ID: <45CE0119.9060401@ru.mvista.com>
Date:	Sat, 10 Feb 2007 20:30:01 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
Cc:	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] serial driver PMC MSP71xx, kernel linux-mips.git mast
 er
References: <45CCCDD4.7030104@pmc-sierra.com>
In-Reply-To: <45CCCDD4.7030104@pmc-sierra.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14028
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Marc St-Jean wrote:

>> > Fourth attempt at the serial driver patch for the PMC-Sierra MSP71xx 
>>device.

>> > There are three different fixes:
>> > 1. Fix for DesignWare THRE errata
>> > - Dropped our fix since the "8250-uart-backup-timer.patch" in the "mm"
>> > tree also fixes it. This patch needs to be applied on top of "mm" patch.

    I think you need to submit your patch to Andrew Morton since it requires a 
patch from his tree.

>> > @@ -1383,6 +1399,19 @@ static irqreturn_t serial8250_interrupt(
>> >                       handled = 1;
>> >
>> >                       end = NULL;
>> > +             } else if (up->port.iotype == UPIO_DWAPB &&
>> > +                             (iir & UART_IIR_BUSY) == UART_IIR_BUSY) {

>>     Worth aligning this line with the opening paren of if... but's that's
>>nitpicking. :-)

> No problem I'll change it. I just usually align to the closest tab stop to
> the opening parenthesis.

    It haven't really changed in the last patch. :-)

>> > +                     /* The DesignWare APB UART has an Busy Detect 
>>(0x07)
>> > +                      * interrupt meaning an LCR write attempt 
>>occured while the
>> > +                      * UART was busy. The interrupt must be cleared 
>>by reading
>> > +                      * the UART status register (USR) and the LCR 
>>re-written. */
>> > +                     unsigned int status;
>> > +                     status = *(volatile u32 *)up->port.private_data;
>> > +                     serial_out(up, UART_LCR, up->lcr);
>> > +
>> > +                     handled = 1;
>> > +
>> > +                     end = NULL;
>> >               } else if (end == NULL)
>> >                       end = l;
>> >
>> >       return 0;

>>    Still, shouldn't you be doing this in serial8250_timeout()

> No, the serial8250_timeout is for issue 1 at the top, this is for
> issue 2.

    It's for lost interrupts, IIUC. They use anothe timeout handler for the 
workaround...

>>also?
>>What IRQ numbers this UART is using, BTW?

> For the ports on the device they are 27 and 42. Is there any significance
> that I'm not aware of?

    Yeah, IRQ0 is treated as no IRQ by 8250, and in this case it falls back to 
using serial8250_timeout() to handle "interrupts".

>> > diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
>> > index cf23813..bd9711a 100644
>> > --- a/include/linux/serial_core.h
>> > +++ b/include/linux/serial_core.h
>> > @@ -276,6 +277,7 @@ #define UPF_USR_MASK              ((__force upf_t) (
>> >       struct device           *dev;                   /* parent 
>>device */
>> >       unsigned char           hub6;                   /* this should 
>>be in the 8250 driver */
>> >       unsigned char           unused[3];
>> > +     void                            *private_data;          /* 
>>generic platform data pointer */

>>    One tab to many before *private_data...

> In my editor using 4 columns per tab it lines up with everything. Is there
> some convention that patches should be made assuming 8 columns?

    Documentation/CodingStyle, chapter 1. :-)

>>    Oops, your mailer went and did it again. :-)

> I'm completely giving up on Thunderbird,unless someone can point out

    Ypu should have long ago. :-)

> the specific internal configuration items which needs a kick!

    Only the attachments will work in the Mozilla kind mailer, AFAIK.
The last patch looked OK at last. :-)

> Thanks,
> Marc

WBR, Sergei
