Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2007 16:42:59 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:13664 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20021857AbXHAPmz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 1 Aug 2007 16:42:55 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 9419C3EC9; Wed,  1 Aug 2007 08:42:52 -0700 (PDT)
Message-ID: <46B0AA74.7040100@ru.mvista.com>
Date:	Wed, 01 Aug 2007 19:44:52 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Modpost warning on Alchemy
References: <20070801115231.GA20323@linux-mips.org> <46B07B36.1000501@ru.mvista.com> <Pine.LNX.4.64N.0708011337390.20314@blysk.ds.pg.gda.pl> <46B086EB.2030101@ru.mvista.com> <46B0880B.2000009@ru.mvista.com> <Pine.LNX.4.64N.0708011629010.20314@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0708011629010.20314@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15987
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:

>>>>Of course it will.  It shall work with whatever physical address space is
>>>>supported by your MMU.  As long as the MMU is handled correctly that is,
>>>>but I guess I may have omitted this clarification as obvious.

>>>   Even on a CPU with 36-bit physical address? ;-)

>>   WTF... I know I've typed "32-bit CPU"! :-/

>  It does not matter.  The physical address of an I/O resource can be 

    Believe me, it does in *this* case. :-)

> treated as a cookie that is converted, typically though an MMU, to another 
> cookie that can be used with {read,write}{b,w,l}().  Of course you may 
> have troubles ioremap()ping say 4GB of I/O space on a processor with a
> 32-bit virtual address space, but that is a corner case and typically your 
> I/O space will be sparsely occupied.

    It is exactly this case.

>  On a MIPS32 processor you have 512MB of KSEG0/1 unmapped virtual address 
> space available for I/O devices located within the first 512MB of the 

    PCI config. space is mapped at 0x600000000, well beyond KGSEG0/1.

> physical address space plus 1GB of KSEG2 mapped virtual address space 
> available for I/O devices located anywhere in the physical address space.  
> That gives you from 1GB to 1.5GB of virtual address space for I/O which is 
> enough for all the usual cases.

    This case is not usual. :-)

>   Maciej

    Thanks for wasting time on my education about MIPS. ;-)

WBR, Sergei
