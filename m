Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2007 13:48:05 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:61329 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20022115AbXHBMsD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Aug 2007 13:48:03 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id CA6303EC9; Thu,  2 Aug 2007 05:47:59 -0700 (PDT)
Message-ID: <46B1D2F7.8000002@ru.mvista.com>
Date:	Thu, 02 Aug 2007 16:49:59 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Modpost warning on Alchemy
References: <20070801115231.GA20323@linux-mips.org> <46B07B36.1000501@ru.mvista.com> <Pine.LNX.4.64N.0708011337390.20314@blysk.ds.pg.gda.pl> <46B086EB.2030101@ru.mvista.com> <46B0880B.2000009@ru.mvista.com> <Pine.LNX.4.64N.0708011629010.20314@blysk.ds.pg.gda.pl> <46B0AA74.7040100@ru.mvista.com> <Pine.LNX.4.64N.0708011708250.20314@blysk.ds.pg.gda.pl> <46B0B6B4.5090103@ru.mvista.com> <Pine.LNX.4.64N.0708011737170.20314@blysk.ds.pg.gda.pl> <46B0BD99.6070901@ru.mvista.com> <Pine.LNX.4.64N.0708020945020.22591@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0708020945020.22591@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16023
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Maciej W. Rozycki wrote:

>>>So what is the issue with the size then?  How big is the area?

>>   I've already said: 4 gigs! At least in theory, actually it's 2 gigs due to

>  Oh, I mistook it for the base physical address, sorry.

    That's 24 gigs. :-)

>>a device # being limited to 0 thru 19 (address bits 11 thru 30 are used as
>>IDSELx).

>  It does not help too much with a 32-bit virtual address space indeed.  
> Though I gather it has to be very sparsely populated as 16MiB is enough to 
> cover the whole configuration space of a single PCI bus tree.  Thus it has 

    Hm, maybe 16 MiB would be enough indeed, as the Alchemy CPUs are known to 
not support bus masters behind PCI bridges...

> to be another example where the chip designer "forgot" to talk to software 
> people.  Or a shifter was traded for software performance and complexity. 
> ;-)

    I certainly agree here. :-)

>>   There was no need to tell me about how KSEG0/1/2 work -- that's why I
>>cosidered it wasting time. :-)

>  As I say -- the key is how you look at it.  There are other readers on 
> the list who may benefit; it is archived too.  In this sense I can hardly 
> consider it a waste of time.  And it was fun to explain and no fun shall 
> be ever considered of no use. :-)

    Depends on the source of fun. :-)

>   Maciej

WBR, Sergei
