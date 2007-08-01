Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2007 17:00:17 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:48480 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20021918AbXHAQAN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 1 Aug 2007 17:00:13 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 9BBE53EC9; Wed,  1 Aug 2007 08:59:40 -0700 (PDT)
Message-ID: <46B0AE64.7060004@ru.mvista.com>
Date:	Wed, 01 Aug 2007 20:01:40 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Modpost warning on Alchemy
References: <20070801115231.GA20323@linux-mips.org>	<46B07B36.1000501@ru.mvista.com>	<Pine.LNX.4.64N.0708011337390.20314@blysk.ds.pg.gda.pl>	<46B086EB.2030101@ru.mvista.com>	<20070801163926.038c48db@the-village.bc.nu>	<Pine.LNX.4.64N.0708011639030.20314@blysk.ds.pg.gda.pl> <20070801165812.3bdb269f@the-village.bc.nu>
In-Reply-To: <20070801165812.3bdb269f@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15991
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Alan Cox wrote:

>>>>    Even on a CPU with 36-bit physical address? ;-)

>>>Nope. This is one problem for example with ioremap on a Pentium Pro.

>> Well, but we only consider MIPS processors here which do not have such 
>>odd restrictions resulting from bad design decisions in the past. ;-)  
>>The 32-bit TLB entry format allows for up to 36 bits of the physical 
>>address space (34 bits if support for the page size of 1kB has been 

> So does the Pentium Pro. We can map 36bit physical addresses.

>>enabled).  For anything beyond that you need a 64-bit MIPS processor using 
>>the 64-bit TLB entry format.

> Your problem is a little higher up the stack. ioremap takes an unsigned
> long, which on a 32bit system usually means you can't give it a 36bit bus
> address to remap.

    It takes phys_t, which is 'unsigned long long' for this platform that has 
CONFIG_64BUIT_PHYS_ADDR=y. The reall issue is the size.

> Alan

WBR, Sergei
