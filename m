Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 May 2004 09:40:44 +0100 (BST)
Received: from no-dns-yet.demon.co.uk ([IPv6:::ffff:80.176.203.50]:58011 "EHLO
	pangolin.localnet") by linux-mips.org with ESMTP
	id <S8225284AbUEQIkn>; Mon, 17 May 2004 09:40:43 +0100
Received: from sprocket.localnet ([192.168.1.27])
	by pangolin.localnet with esmtp (Exim 3.35 #1 (Debian))
	id 1BPdfp-0002be-00; Mon, 17 May 2004 09:40:37 +0100
Message-ID: <40A87A81.5070100@bitbox.co.uk>
Date: Mon, 17 May 2004 09:40:33 +0100
From: Peter Horton <phorton@bitbox.co.uk>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: Kieran Fulke <kieran@pawsoff.org>, linux-mips@linux-mips.org
Subject: Re: IRQ problem on cobalt / 2.6.6
References: <20040513183059.GA25743@getyour.pawsoff.org> <40A478B0.3070005@bitbox.co.uk> <20040516113622.GA14049@getyour.pawsoff.org> <20040516152113.GA9390@convergence.de> <20040516170445.GA4793@linux-mips.org>
In-Reply-To: <20040516170445.GA4793@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <phorton@bitbox.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5038
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: phorton@bitbox.co.uk
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

>On Sun, May 16, 2004 at 05:21:13PM +0200, Johannes Stezenbach wrote:
>
>  
>
>>In essence, I believe something other than the saa7146 must be asserting
>>irq 23.  Or is it possible that a bug in the PCI init stuff in
>>saa7146_core.c can
>>cause this? Any hints how we could debug this would be welcome.
>>    
>>
>
>arch/mips/cobalt/irq.c:cobalt_irq() looks pretty suspect.  It connects
>CAUSEF_IP7 and interrupt 23 - but the CPU's builtin count / compare
>interrupt already uses this bit.
>
>Sharing the timer interrupt with something else isn't impossible but seems
>a less than bright thing to do.  Somebody with production hw to test
>should compare this interrupt dispatch function with old working code
>from 2.2 or 2.4 ...
>
>  
>

I've got no hardware here but the code looks roughly similiar

As the Cobalt's use Galileo timer 0 for clock interrupts we could use 
Galileo rather than count/compare for the HPT.

Precision would be 50MHz rather than 125MHz but that shouldn't be a 
problem :-)

P.
