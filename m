Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jan 2005 22:20:25 +0000 (GMT)
Received: from [IPv6:::ffff:68.145.108.97] ([IPv6:::ffff:68.145.108.97]:35952
	"EHLO mail.otii.com") by linux-mips.org with ESMTP
	id <S8225348AbVAFWUU> convert rfc822-to-8bit; Thu, 6 Jan 2005 22:20:20 +0000
Received: from [192.168.7.50] (unknown [68.145.108.98])
	by mail.otii.com (Postfix) with ESMTP id EC4A8B018
	for <linux-mips@linux-mips.org>; Thu,  6 Jan 2005 15:34:40 -0700 (MST)
Mime-Version: 1.0 (Apple Message framework v619)
In-Reply-To: <20041222104457.GR2460@lug-owl.de>
References: <41C947CC.20709@innova-card.com> <20041222101906.27137.qmail@web25109.mail.ukl.yahoo.com> <20041222104457.GR2460@lug-owl.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <11829755-6031-11D9-A1F1-000393DBC6BE@otii.com>
Content-Transfer-Encoding: 8BIT
From: =?ISO-8859-1?Q?S=E9bastien_Taylor?= <sebastient@otii.com>
Subject: Re: Problem registering interrupt
Date: Thu, 6 Jan 2005 15:19:44 -0700
To: linux-mips@linux-mips.org
X-Mailer: Apple Mail (2.619)
Return-Path: <sebastient@otii.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6826
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sebastient@otii.com
Precedence: bulk
X-list: linux-mips

So the crash is happening because the handler pointer is null in the 
irq_desc for interrupt 49.  Is there something that I was supposed to 
do to setup that handler before registering my interrupt?  This was 
working fine under 2.4, is it a change in 2.6 or just in the alchemy 
port specifically?

Thanks for the help and happy new years,
Sébastien


Le 04-12-22, à 03:44, Jan-Benedict Glaw a écrit :

> On Wed, 2004-12-22 11:19:06 +0100, moreau francis 
> <francis_moreau2000@yahoo.fr>
> wrote in message 
> <20041222101906.27137.qmail@web25109.mail.ukl.yahoo.com>:
>>
>>> CPU 0 Unable to handle kernel paging request at
>>> virtual address 00000004, epc =4
>>
>> Well it suggests me that your driver is trying to
>> access a really nasty pointer: 0x00000004...
>> How did you get this address ? From user space ?
>
> Accesses to nearly NULL are normally structure accesses where a pointer
> to a given struct was supplied as a NULL pointer.
>
> So an access to 0x00000004 is most probably an access to the second
> element of a struct, given/expected that all fields are usually 4-byte
> aligned.
>
>> From looking at ./kernel/irq/manage.c:setup_irq(), I guess that you
> supply NULL as the "struct irqaction *", which is the 2nd argument of
> setup_irq(). It's 2nd structure element is "flags" then... This is the
> first thing accessed by the "new" pointer in setup_irq().
>
> MfG, JBG
>
> -- 
> Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481         
>     _ O _
> "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen 
> Krieg  _ _ O
>  fuer einen Freien Staat voll Freier Bürger" | im Internet! |   im 
> Irak!   O O O
> ret = do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | 
> TCPA));
