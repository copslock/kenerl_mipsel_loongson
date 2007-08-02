Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2007 15:13:58 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:36243 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20022141AbXHBONw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Aug 2007 15:13:52 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 97C5C3EC9; Thu,  2 Aug 2007 07:13:50 -0700 (PDT)
Message-ID: <46B1E716.6070807@ru.mvista.com>
Date:	Thu, 02 Aug 2007 18:15:50 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Modpost warning on Alchemy
References: <20070801115231.GA20323@linux-mips.org> <46B07B36.1000501@ru.mvista.com> <Pine.LNX.4.64N.0708011337390.20314@blysk.ds.pg.gda.pl> <46B086EB.2030101@ru.mvista.com> <46B0880B.2000009@ru.mvista.com> <Pine.LNX.4.64N.0708011629010.20314@blysk.ds.pg.gda.pl> <46B0AA74.7040100@ru.mvista.com> <Pine.LNX.4.64N.0708011708250.20314@blysk.ds.pg.gda.pl> <46B0B6B4.5090103@ru.mvista.com> <Pine.LNX.4.64N.0708011737170.20314@blysk.ds.pg.gda.pl> <46B0BD99.6070901@ru.mvista.com> <Pine.LNX.4.64N.0708020945020.22591@blysk.ds.pg.gda.pl> <46B1D2F7.8000002@ru.mvista.com> <Pine.LNX.4.64N.0708021349040.22591@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0708021349040.22591@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16030
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:

>>>It does not help too much with a 32-bit virtual address space indeed.
>>>Though I gather it has to be very sparsely populated as 16MiB is enough to
>>>cover the whole configuration space of a single PCI bus tree.  Thus it has 

>>   Hm, maybe 16 MiB would be enough indeed, as the Alchemy CPUs are known to
>>not support bus masters behind PCI bridges...

>  That is unrelated -- for configuration accesses (assuming the basic 

    I mean who needs crippled subordinate busses? ;-)

> configuration space) you need: 8 bits for the bus number + 5 bits for the 
> device number + 3 bits for the function number + 8 bits for the register 
> number.  The total is 24 bits.

    Yeah, that the format of type 1 cycles.

>  It is up to hardware to sort it out and put the right bits on the bus.

    Unfortunately, Alchemy designers were too lazy to implement a simple 
translation scheme for type 0 cycles. They probably though that with 36-bit 
bus the may not limit themselves... :-)

>   Maciej

WBR, Sergei
