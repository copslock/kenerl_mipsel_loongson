Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2007 18:04:39 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:37986 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20021961AbXHAREf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 1 Aug 2007 18:04:35 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id CD2683EC9; Wed,  1 Aug 2007 10:04:32 -0700 (PDT)
Message-ID: <46B0BD99.6070901@ru.mvista.com>
Date:	Wed, 01 Aug 2007 21:06:33 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Modpost warning on Alchemy
References: <20070801115231.GA20323@linux-mips.org> <46B07B36.1000501@ru.mvista.com> <Pine.LNX.4.64N.0708011337390.20314@blysk.ds.pg.gda.pl> <46B086EB.2030101@ru.mvista.com> <46B0880B.2000009@ru.mvista.com> <Pine.LNX.4.64N.0708011629010.20314@blysk.ds.pg.gda.pl> <46B0AA74.7040100@ru.mvista.com> <Pine.LNX.4.64N.0708011708250.20314@blysk.ds.pg.gda.pl> <46B0B6B4.5090103@ru.mvista.com> <Pine.LNX.4.64N.0708011737170.20314@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0708011737170.20314@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15999
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:

>>>And regarding what you have written above and the size issue you mentioned
>>>in another e-mail (do you map the whole PCI config space linearly in the
>>>physical address space of the CPU or suchlike?) -- PCI 

>>   No, I don't.  But that was why the original code preferred the wired entry
>>approach over ioremap() -- not to map a whole range...

>  So what is the issue with the size then?  How big is the area?

    I've already said: 4 gigs! At least in theory, actually it's 2 gigs due to 
a device # being limited to 0 thru 19 (address bits 11 thru 30 are used as 
IDSELx).

>>>performance is a non-issue and it should be absolutely fine for you to call
>>>ioremap() and iounmap() in code specific for your PCI host bridge for the
>>>required fragment upon every access.  There is no need for a permanent 

>>   That's an idea -- however, as the currecnt code uses a cached mapping, this
>>part would certainly need to be saved in the new implementaion -- if someone
>>will go and fix it eventually. :-)

>  Well, cached mapping does not seem particularly wise with PCI 
> configuration registers, but you have got the ioremap_cachable() call if 
> you insist. ;-)

    I meant that the implementation "caches" the 8 KiB mapping used for the 
last config. access.

>>>Well, more about Linux perhaps than MIPS in general. :-)

>>   Let's say that was about Linux/MIPS.  But the key word was "wasting". ;-)

>  I reckon the key is how you look at it. ;-)

    There was no need to tell me about how KSEG0/1/2 work -- that's why I 
cosidered it wasting time. :-)

>   Maciej

WBR, Sergei
