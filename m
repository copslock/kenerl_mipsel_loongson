Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Apr 2003 17:48:06 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:58097 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225205AbTDIQsF>;
	Wed, 9 Apr 2003 17:48:05 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h39GlbN32016;
	Wed, 9 Apr 2003 09:47:37 -0700
Date: Wed, 9 Apr 2003 09:47:37 -0700
From: Jun Sun <jsun@mvista.com>
To: ashish anand <ashish_ibm@rediffmail.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: Problem in pci-bridge or NIC driver..?
Message-ID: <20030409094737.B31925@mvista.com>
References: <20030409145228.6142.qmail@webmail16.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030409145228.6142.qmail@webmail16.rediffmail.com>; from ashish_ibm@rediffmail.com on Wed, Apr 09, 2003 at 02:52:28PM -0000
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1960
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, Apr 09, 2003 at 02:52:28PM -0000, ashish  anand wrote:
> Hello,
> 
> I am not able to conclude whether my problem belongs to pci-bridge 
> side or towards my NIC drivers.
> 
> 1> I am using thee network cards in my BSP process ..Intel 82557 , 
> RealTek 8139 and 3COM
> 3c905b ..all these three card works fine on different machine.
> 
> 2>I have great difficulty in having serial eeprom and mdio 
> interface both working and responding correctly to pci 
> transactions.
> 
> 3>in pci io space i can't use 82557 and RTL8139 cards as simply i 
> amn't able to read serial eeprom and hence their MAC addresss 
> remains undetected  while on other machine same two card's serial 
> eeprom responds fine in pci io space as well.
> serial eeprom response in pci mem space is fine but other nasty 
> problems.
> 
> However my 3com card serial eeprom responds perfectly fine on my 
> developement system.
>

Is 3com's serial eeprom in IO space or MEM space?  If it is in 
MEM space, it probably means that your IO space is not setup 
right.  You need to use substractive decoding to translate
PCI IO address when you memory-map PCI IO space.

Which board/controller chip are you using?

If you use pci_auto to assign PCI resource, you should be able
to see the IO/MEM resources assigned to those cards.  They
are very useful for probing the problem.

Jun
