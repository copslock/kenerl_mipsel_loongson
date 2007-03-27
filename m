Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2007 19:47:57 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:23792 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20022025AbXC0Sry (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Mar 2007 19:47:54 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 1B4A33ECA; Tue, 27 Mar 2007 11:47:21 -0700 (PDT)
Message-ID: <460966E5.10109@ru.mvista.com>
Date:	Tue, 27 Mar 2007 22:48:05 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 6/12] drivers: PMC MSP71xx serial driver
References: <460963FB.9090101@pmc-sierra.com>
In-Reply-To: <460963FB.9090101@pmc-sierra.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14739
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Marc St-Jean wrote:

>> > diff --git a/arch/mips/pmc-sierra/msp71xx/msp_serial.c 
>>b/arch/mips/pmc-sierra/msp71xx/msp_serial.c
>> > new file mode 100644
>> > index 0000000..3b956e9
>> > --- /dev/null
>> > +++ b/arch/mips/pmc-sierra/msp71xx/msp_serial.c
>> > @@ -0,0 +1,185 @@
>>[...]
>> > +#ifdef CONFIG_KGDB
>> > +/*
>> > + * kgdb uses serial port 1 so the console can remain on port 0.
>> > + * To use port 0 change the definition to read as follows:
>> > + * #define DEBUG_PORT_BASE KSEG1ADDR(MSP_UART0_BASE)
>> > + */
>> > +#define DEBUG_PORT_BASE KSEG1ADDR(MSP_UART1_BASE)
>> > +
>> > +int putDebugChar(char c)
>> > +{
>> > +     volatile uint32_t *uart = (volatile uint32_t *)DEBUG_PORT_BASE;
>> > +     uint32_t val = (uint32_t)c;
>> > +
>> > +     local_irq_disable();
>> > +     while (!(uart[5] & 0x20)); /* Wait for TXRDY */
>> > +     uart[0] = val;
>> > +     while (!(uart[5] & 0x20)); /* Wait for TXRDY */
>> > +     local_irq_enable();

>>    Gah, why you decided to put local_irq_enable() there?!  KGDB expects
>>interrupts to be *disabled* while it has control, else some subtle state
>>corruptions will ensue, and it will eventually lock up. Please remove 
>>these 2 calls completely.

> Hmmm, this has been working for several months. I'll remove, retest and
> resubmit.

    I should probably have said "may".  From my experience with KGDBoE though 
(well, it's somewhat different KGDB implementation :-) it locks up pretty 
quickly because of local_irq_enable() or spin_unlock_irq().  Nevertheless, 
enabling interrupts while KGDB has control is undesirable.  And look at the 
other KGDB serial code inarch/mips/ -- nobody else does this.

> Are you aware if this is the case for the "putchar" used by early_printk
> as well?

    No idea, ask Ralf. ;-)

> Thanks,
> Marc

WBR, Sergei
