Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 May 2004 13:57:52 +0100 (BST)
Received: from no-dns-yet.demon.co.uk ([IPv6:::ffff:80.176.203.50]:8099 "EHLO
	pangolin.localnet") by linux-mips.org with ESMTP
	id <S8225249AbUESM5v>; Wed, 19 May 2004 13:57:51 +0100
Received: from sprocket.localnet ([192.168.1.27])
	by pangolin.localnet with esmtp (Exim 3.35 #1 (Debian))
	id 1BQQdQ-0004un-00; Wed, 19 May 2004 13:57:24 +0100
Message-ID: <40AB59B2.5090005@bitbox.co.uk>
Date: Wed, 19 May 2004 13:57:22 +0100
From: Peter Horton <phorton@bitbox.co.uk>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: linux-mips@linux-mips.org
Subject: Re: IRQ problem on cobalt / 2.6.6
References: <20040513183059.GA25743@getyour.pawsoff.org> <20040518073439.GA6818@skeleton-jack> <20040518205914.GA29574@getyour.pawsoff.org> <Pine.LNX.4.55.0405191318500.22609@jurand.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.55.0405191318500.22609@jurand.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <phorton@bitbox.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5084
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: phorton@bitbox.co.uk
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:

>On Tue, 18 May 2004, Kieran Fulke wrote:
>
>  
>
>>alas, no joy.
>>    
>>
>[...]
>  
>
>>VP_IDE: VIA vt82c586a (rev 27) IDE UDMA33 controller on pci0000:00:09.1
>>    ide0: BM-DMA at 0x1420-0x1427, BIOS settings: hda:pio, hdb:pio
>>    ide1: BM-DMA at 0x1428-0x142f, BIOS settings: hdc:pio, hdd:pio
>>spurious 8259A interrupt: IRQ9.
>>    
>>
>
> Hmm, interesting.  As the 8259A can only signal IRQ7 and possibly IRQ15
>as spurious interrupts, this smells like a bug in 8259A handlers,
>regardless of system-specific problems you have.
>
>  
>
We were getting interrupt 23 and calling do_IRQ() with a value of 9 (a 
bug, obviously). Interrupt 9 is masked so we get a "spurious 8259A 
interrupt" message.

P.
