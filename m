Received:  by oss.sgi.com id <S554100AbRBESnR>;
	Mon, 5 Feb 2001 10:43:17 -0800
Received: from stereotomy.lineo.com ([64.50.107.151]:32527 "HELO
        stereotomy.lineo.com") by oss.sgi.com with SMTP id <S554081AbRBESnA>;
	Mon, 5 Feb 2001 10:43:00 -0800
Received: from Lineo.COM (localhost.localdomain [127.0.0.1])
	by stereotomy.lineo.com (Postfix) with ESMTP
	id 2C01E4CC5F; Mon,  5 Feb 2001 11:42:58 -0700 (MST)
Message-ID: <3A7EF431.2060903@Lineo.COM>
Date:   Mon, 05 Feb 2001 11:42:57 -0700
From:   Quinn Jensen <jensenq@Lineo.COM>
Organization: Lineo, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-9mdk i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To:     jsun@hermes.mvista.com
Cc:     Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: NFS root with cache on
References: <3A79C869.2040001@Lineo.COM> <20010204194451.A26868@bacchus.dhis.org> <3A7ED9EB.6080801@Lineo.COM> <3A7EEBD6.F4743A97@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


jsun@hermes.mvista.com wrote:

> Quinn Jensen wrote:
> 
>>>> Is anyone else having trouble with NFS root on
>>>> the 2.4.0 kernel?  It won't come up with the
>>>> KSEG0 cache on unless I pepper the network driver
>>>> with flush calls.
>>> 
>>> 
>>> That's expected for most old network drivers that don't yet use tye
he
>>> new PCI DMA API documented in Documentation/DMA-mapping.txt.
>>> 
>>> What driver is this?
>> 
>> Both the stock 2.4.0 tulip and eepro100 drivers.  The
>> problem doesn't happen when I go back to 2.3.99pre8.
>> 
> 
> Did you set rx_copybreak to 1518?  I sent patches long time ago to the driver
> authors for MIPS, but I am not sure they are not there.

Jun,

I have tried that in this case but it didn't help,
because the receive skb data pointers all point to
the KSEG0 view of the data anyway.  But the maddening
thing is, when I force them to KSEG1 I still see the
NFS timeout problem.  So I'm starting to wonder if
the problem is higher up in the stack.  But I do know
that the behavior does not occur on a similarly configured
x86 build of the same kernel.

Quinn
