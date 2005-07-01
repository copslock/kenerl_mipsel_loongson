Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2005 20:56:16 +0100 (BST)
Received: from clock-tower.bc.nu ([IPv6:::ffff:81.2.110.250]:29577 "EHLO
	lxorguk.ukuu.org.uk") by linux-mips.org with ESMTP
	id <S8226173AbVGATz7>; Fri, 1 Jul 2005 20:55:59 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.12.11/8.12.11) with ESMTP id j61JrGjG016309;
	Fri, 1 Jul 2005 20:53:17 +0100
Received: (from alan@localhost)
	by localhost.localdomain (8.12.11/8.12.11/Submit) id j61JrGSg016308;
	Fri, 1 Jul 2005 20:53:16 +0100
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: RFH:  What are the semantics of writeb() and friends?
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	David Daney <ddaney@avtrex.com>, linux-mips@linux-mips.org
In-Reply-To: <Pine.LNX.4.61L.0507011513320.30138@blysk.ds.pg.gda.pl>
References: <01049E563C8ECC43AD6B53A5AF419B38098BD2@avtrex-server2.hq2.avtrex.com>
	 <Pine.LNX.4.61L.0507011002520.30138@blysk.ds.pg.gda.pl>
	 <1120218385.12446.16.camel@localhost.localdomain>
	 <Pine.LNX.4.61L.0507011303190.30138@blysk.ds.pg.gda.pl>
	 <1120224708.12446.26.camel@localhost.localdomain>
	 <Pine.LNX.4.61L.0507011513320.30138@blysk.ds.pg.gda.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1120247593.12462.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date:	Fri, 01 Jul 2005 20:53:15 +0100
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8318
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Gwe, 2005-07-01 at 15:43, Maciej W. Rozycki wrote:
>  But that mentions compiler only, not CPU ordering!  I understand the BIU 
> of the issuing CPU and any external hardware is still permitted to 
> merge/reorder these accesses unless separated by wmb()/rmb()/mb() as 

I think the practical situation is that this implies ordering to the bus
interface. It might be interesting to ask the powerpc people their
experience but looking at most PCI drivers they assume this and it would
be expensive not to do so on x86.

>  We have that iob() macro/call as well, so that you can push cycles out of 
> the CPU domain immediately as well, which is equivalent to:

> 	mb(); 
> 	make_host_complete_writes();

My feeling is the default readb etc are __readb + mb + make_hos...
>  So far I've been able to get away with that iob() function, but if the 
> bus and buffering hierarchy gets even more complicated, there may be more 
> barriers like this needed.

Agreed - and we now have the device model so we can actually do that by
passing a device pointer.
