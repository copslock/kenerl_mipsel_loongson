Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Nov 2008 17:26:53 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:23568 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S23819042AbYKUR0r (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Nov 2008 17:26:47 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id EC7323ECA; Fri, 21 Nov 2008 09:26:42 -0800 (PST)
Message-ID: <4926EF55.7080004@ru.mvista.com>
Date:	Fri, 21 Nov 2008 20:26:45 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] ide: New libata driver for OCTEON SOC Compact Flash interface.
References: <49261BE5.2010406@caviumnetworks.com> <20081121102137.634616c5@lxorguk.ukuu.org.uk> <4926EA6A.7040704@caviumnetworks.com>
In-Reply-To: <4926EA6A.7040704@caviumnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21365
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

David Daney wrote:

>>> +    use_iordy = 1;

>> This depends on the device as well and gets quite complicated. We have
>> ata_pio_need_iordy() to do the work for you.
>>
>>> +    t1 = (t1 * clocks_us) / 1000 / 2;
>>> +    if (t1)
>>> +        t1--;

>> Even if you wanted to do it this way you could just use arrays and lookup
>> tables as many other drivers do - ie

>>     pio = dev->pio_mode - XFER_PIO_0;
>>     t1 = data[pio];

> The timing calculations are based on the CPU clock rate, It is difficult 
> to encapsulate that in a table.

    Nobody suggests that. You surely can put the timings in ns in a 
structure/table.

> [...]

>>> +    /*
>>> +     * Odd lengths are not supported. We should always be a
>>> +     * multiple of 512.
>>> +     */
>>> +    BUG_ON(buflen & 1);

>> If you get a request for an odd length you should write an extra word
>> containing the last byte and one other. See how the standard methods
>> handle this.

> OK.

    I don't think you need to bother doing that with CF.

>>> +            while (words--) {
>>> +                *(uint16_t *)buffer = ioread16(data_addr);
>>> +                buffer += sizeof(uint16_t);

>> By definition tht is 2. Do you have an ioread16_rep ?

> It appears to be broken.  One would expect ioread16 and ioread16_rep to 
> do endian swapping in the same manner.  On MIPS they do not.

    And that's actually good.

> Perhaps it would be better to fix the problem at the source.

    I don't think there's a problem there. The string versions of the 
functions treat memory as a string of bytes.

>>> +static void octeon_cf_delayed_irq(unsigned long data)
>>> +{

>> What stops the following occuring

>>     ATA irq
>>         BUSY still set
>>         Queue tasklet

>>     Other irq on same line
>>     ATA busy clear
>>         Handle command

    Is CF interrupt indeed shared with anything?

>>     Tasklet runs but command was sorted out

>> (or a reset of the ata controller in the gap)

> Probably nothing.  I will try to sort it out.

    It's the need for the tasklet that seems doubtful to me...

> Thanks,
> David Daney

MBR, Sergei
