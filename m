Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2007 17:35:15 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:40545 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20021961AbXHAQfL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 1 Aug 2007 17:35:11 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 8DB2B3EC9; Wed,  1 Aug 2007 09:35:08 -0700 (PDT)
Message-ID: <46B0B6B4.5090103@ru.mvista.com>
Date:	Wed, 01 Aug 2007 20:37:08 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Modpost warning on Alchemy
References: <20070801115231.GA20323@linux-mips.org> <46B07B36.1000501@ru.mvista.com> <Pine.LNX.4.64N.0708011337390.20314@blysk.ds.pg.gda.pl> <46B086EB.2030101@ru.mvista.com> <46B0880B.2000009@ru.mvista.com> <Pine.LNX.4.64N.0708011629010.20314@blysk.ds.pg.gda.pl> <46B0AA74.7040100@ru.mvista.com> <Pine.LNX.4.64N.0708011708250.20314@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0708011708250.20314@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15996
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:

>>   PCI config. space is mapped at 0x600000000, well beyond KGSEG0/1.

>  It is still just fine with ioremap() -- it will simply use KSEG2 in this 
> case.  You cannot bypass the TLB here with a 32-bit processor no matter 
> what.

>  And regarding what you have written above and the size issue you 
> mentioned in another e-mail (do you map the whole PCI config space 
> linearly in the physical address space of the CPU or suchlike?) -- PCI 

    No, I don't.  But that was why the original code preferred the wired entry 
approach over ioremap() -- not to map a whole range...

> config space accesses are rare (by design rather than chance), so 

    That depends on the drivers used (some IDE drivers access it really often).

> performance is a non-issue and it should be absolutely fine for you to 
> call ioremap() and iounmap() in code specific for your PCI host bridge for 
> the required fragment upon every access.  There is no need for a permanent 

    That's an idea -- however, as the currecnt code uses a cached mapping, 
this part would certainly need to be saved in the new implementaion -- if 
someone will go and fix it eventually. :-)

> map here.  You probably waste more performance by taking away a TLB entry 
> to wire it anyway.

    No, I didn't write that code. :-)

>>   Thanks for wasting time on my education about MIPS. ;-)

>  Well, more about Linux perhaps than MIPS in general. :-)

    Let's say that was about Linux/MIPS.  But the key word was "wasting". ;-)

>   Maciej

WBR, Sergei
