Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Dec 2006 19:55:05 +0000 (GMT)
Received: from az33egw01.freescale.net ([192.88.158.102]:39871 "EHLO
	az33egw01.freescale.net") by ftp.linux-mips.org with ESMTP
	id S20038907AbWLDTzB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 4 Dec 2006 19:55:01 +0000
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id kB4JspL1005635;
	Mon, 4 Dec 2006 12:54:51 -0700 (MST)
Received: from [10.82.17.56] ([10.82.17.56])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id kB4Jsnjp027934;
	Mon, 4 Dec 2006 13:54:49 -0600 (CST)
In-Reply-To: <Pine.LNX.4.64N.0611301757200.1757@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0610031509380.4642@blysk.ds.pg.gda.pl> <E2ACBAE3-B0E1-4D90-BF25-6981543090C4@freescale.com> <Pine.LNX.4.64N.0610231752440.4426@blysk.ds.pg.gda.pl> <Pine.LNX.4.64N.0611301757200.1757@blysk.ds.pg.gda.pl>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BE651D76-77D9-4CC0-85E1-F586C24F9012@freescale.com>
Cc:	Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
	Ralf Baechle <ralf@linux-mips.org>, netdev@vger.kernel.org,
	linux-mips@linux-mips.org
Content-Transfer-Encoding: 7bit
From:	Andy Fleming <afleming@freescale.com>
Subject: Re: [patch 3/6] 2.6.18: sb1250-mac: Phylib IRQ handling fixes
Date:	Mon, 4 Dec 2006 13:54:45 -0600
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
X-Mailer: Apple Mail (2.752.2)
Return-Path: <afleming@freescale.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13340
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: afleming@freescale.com
Precedence: bulk
X-list: linux-mips


On Nov 30, 2006, at 12:07, Maciej W. Rozycki wrote:

> On Mon, 23 Oct 2006, Maciej W. Rozycki wrote:
>
>>> I'm not too enthusiastic about requiring the ethernet drivers to  
>>> call
>>> phy_disconnect in a separate thread after "close" is called.   
>>> Assuming there's
>>> not some sort of "squash work queue" function that can be invoked  
>>> with
>>> rtnl_lock held, I think phy_disconnect should schedule itself to  
>>> flush the
>>> queue.  This would also require that mdiobus_unregister hold off  
>>> on freeing
>>> phydevs if any of the phys were still waiting for pending  
>>> flush_pending calls
>>> to finish.  Which would, in turn, require mdiobus_unregister to  
>>> schedule
>>> cleaning up memory for some later time.
>>
>>  This could work, indeed.
>>
>>> I'm not enthusiastic about that implementation, either, but it  
>>> maintains the
>>> abstractions I consider important for this code.  The ethernet  
>>> driver should
>>> not need to know what structures the PHY lib uses to implement  
>>> its interrupt
>>> handling, and how to work around their failings, IMHO.
>>
>>  Agreed.
>
>  So what's the plan?
>
>  Here's a new version of the patch that addresses your other concerns.


So I think the problem is we still don't understand the problem, and  
the solution to the problem, except that it's causing your driver to  
lock up.  Most of the changes below are fine with me.  The confusing  
one is still the check for current_is_keventd().  This is related in  
some way to why the driver code invokes phy_disconnect from a  
work_queue.  I admit, though, I'm not familiar enough with the work  
queue infrastructure to understand the problem.  But I'm very certain  
that creating a work queue for the sole purpose of disconnecting from  
the PHY is crufty.

Can you try again to convey how this solves your problem, so we can  
try to figure out if there's a better way?

Andy
