Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2CILxD15547
	for linux-mips-outgoing; Tue, 12 Mar 2002 10:21:59 -0800
Received: from [64.152.86.3] (unknown.Level3.net [64.152.86.3] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2CILs915544
	for <linux-mips@oss.sgi.com>; Tue, 12 Mar 2002 10:21:54 -0800
Received: from mail.esstech.com by [64.152.86.3]
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 12 Mar 2002 17:25:46 UT
Received: from venus (venus.esstech.com [193.5.205.5])
	by mail.esstech.com (8.11.6/8.11.6) with SMTP id g2CHJU524860;
	Tue, 12 Mar 2002 09:19:30 -0800 (PST)
Received: from bud.austin.esstech.com by venus (SMI-8.6/SMI-SVR4)
	id JAA24507; Tue, 12 Mar 2002 09:21:03 -0800
Received: from esstech.com by bud.austin.esstech.com (SMI-8.6/SMI-SVR4)
	id LAA29504; Tue, 12 Mar 2002 11:12:51 -0600
Message-ID: <3C8E3A5E.6020709@esstech.com>
Date: Tue, 12 Mar 2002 11:26:54 -0600
From: Gerald Champagne <gerald.champagne@esstech.com>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Jun Sun <jsun@mvista.com>, Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: pci config cycles on VRC-5477
References: <Pine.GSO.4.21.0203121013530.23527-100000@vervain.sonytel.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


>>>
>>>Did I miss something, or is this a bug?
>>>
>>Your understanding is correct.  I think this is a bug.
>>
>>Do you actually see the bug happening?  So far it has never hit me, but maybe 
>>due to the drivers that are loaded on my configuration.
>>
> 
> (IIRC) When I wrote the Vrc-5074 support, I thought about this as well.
> But then I noticed that this was already done by the upper PCI layer. Is this
> still true?
> 
> Gr{oetje,eeting}s,
> 
> 						Geert

You're right.  It's not a problem.  The code that disables interrupts right
here in drivers/pci/pci.c:

#define PCI_OP(rw,size,type) \
int pci_##rw##_config_##size (struct pci_dev *dev, int pos, type value) \
{                                                                       \
         int res;                                                        \
         unsigned long flags;                                            \
         if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;       \
         spin_lock_irqsave(&pci_lock, flags);                            \
         res = dev->bus->ops->rw##_##size(dev, pos, value);              \
         spin_unlock_irqrestore(&pci_lock, flags);                       \
         return res;                                                     \
}

I don't know why I missed that...

Thanks for the reply!

Gerald
