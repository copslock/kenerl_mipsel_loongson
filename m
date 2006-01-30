Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jan 2006 12:47:53 +0000 (GMT)
Received: from no-dns-yet.demon.co.uk ([80.176.203.50]:33673 "EHLO
	pangolin.localnet") by ftp.linux-mips.org with ESMTP
	id S8133503AbWA3Mr3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 30 Jan 2006 12:47:29 +0000
Received: from sprocket.localnet ([192.168.1.27])
	by pangolin.localnet with esmtp (Exim 3.35 #1 (Debian))
	id 1F3YW2-0007Dn-00; Mon, 30 Jan 2006 12:52:18 +0000
Message-ID: <43DE0BF5.4000506@bitbox.co.uk>
Date:	Mon, 30 Jan 2006 12:52:05 +0000
From:	Peter Horton <phorton@bitbox.co.uk>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Peter Horton <pdh@colonel-panic.org>, linux-mips@linux-mips.org
Subject: Re: help ... Galileo PCI bridge
References: <20060129094409.GA1495@colonel-panic.org> <20060130121932.GA3816@linux-mips.org>
In-Reply-To: <20060130121932.GA3816@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <phorton@bitbox.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10229
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: phorton@bitbox.co.uk
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Sun, Jan 29, 2006 at 09:44:09AM +0000, Peter Horton wrote:
> 
>> I'm currently struggling with a hard hang on the Cobalt hardware which
>> uses the Galileo GT64111 PCI bridge.
>>
>> I've got the rev 11 data sheet for the bridge, I was wondering if anyone
>> knows whether there is an errata sheet for this chip, and if so whether
>> anyone has a copy ?
> 
> I recall PCI device 31 on bus 0 was magic on all Galileo.  Touching it
> results in a system hang.  Could that be what is hitting you?
> 

Don't think so. Sometines, after a lot of bus master activity from the 
Tulip NIC we get a Galileo interrupt (probably timer tick) and the first 
time we touch a Galileo register in the interrupt handler the system 
hangs hard :-(. It looks like some nasty interaction between the NIC and 
the bridge.

P.
