Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 May 2004 12:58:07 +0100 (BST)
Received: from no-dns-yet.demon.co.uk ([IPv6:::ffff:80.176.203.50]:53148 "EHLO
	pangolin.localnet") by linux-mips.org with ESMTP
	id <S8225472AbUEQL6G>; Mon, 17 May 2004 12:58:06 +0100
Received: from sprocket.localnet ([192.168.1.27])
	by pangolin.localnet with esmtp (Exim 3.35 #1 (Debian))
	id 1BPgkp-0002yj-00; Mon, 17 May 2004 12:57:59 +0100
Message-ID: <40A8A8C5.1030908@bitbox.co.uk>
Date: Mon, 17 May 2004 12:57:57 +0100
From: Peter Horton <phorton@bitbox.co.uk>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kieran Fulke <kieran@pawsoff.org>
CC: linux-mips@linux-mips.org
Subject: Re: IRQ problem on cobalt / 2.6.6
References: <20040513183059.GA25743@getyour.pawsoff.org> <40A478B0.3070005@bitbox.co.uk> <20040516113622.GA14049@getyour.pawsoff.org> <20040516152113.GA9390@convergence.de> <20040516170445.GA4793@linux-mips.org> <40A87A81.5070100@bitbox.co.uk> <20040517114658.GA20884@getyour.pawsoff.org>
In-Reply-To: <20040517114658.GA20884@getyour.pawsoff.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <phorton@bitbox.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5041
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: phorton@bitbox.co.uk
Precedence: bulk
X-list: linux-mips

Kieran Fulke wrote:

>On Mon, May 17, 2004 at 09:40:33AM +0100, Peter Horton wrote:
>
>  
>
>>I've got no hardware here but the code looks roughly similiar
>>
>>As the Cobalt's use Galileo timer 0 for clock interrupts we could use 
>>Galileo rather than count/compare for the HPT.
>>
>>Precision would be 50MHz rather than 125MHz but that shouldn't be a 
>>problem :-)
>>
>>    
>>
>
>is there any (uncomplicated) way of forcing the machine to assign a 
>different IRQ to its single pci slot?
>
>  
>
It's hard wired.

P.
