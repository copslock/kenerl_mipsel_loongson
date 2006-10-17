Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Oct 2006 13:18:20 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:61201 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20039415AbWJQMSS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Oct 2006 13:18:18 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 7B3E5E1C65;
	Tue, 17 Oct 2006 14:18:07 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bPwPqcO-zgWR; Tue, 17 Oct 2006 14:18:07 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 1F554E1C8B;
	Tue, 17 Oct 2006 14:18:07 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.1) with ESMTP id k9HCIFAk000402;
	Tue, 17 Oct 2006 14:18:15 +0200
Date:	Tue, 17 Oct 2006 13:18:12 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Morton <akpm@osdl.org>
cc:	Jeff Garzik <jgarzik@pobox.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Andy Fleming <afleming@freescale.com>, netdev@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [patch 3/6] 2.6.18: sb1250-mac: Phylib IRQ handling fixes
In-Reply-To: <20061016120653.9a70135d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64N.0610171306560.27348@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0610031509380.4642@blysk.ds.pg.gda.pl>
 <20061005234310.6c8042b5.akpm@osdl.org> <Pine.LNX.4.64N.0610061152340.22053@blysk.ds.pg.gda.pl>
 <20061006080323.185f2b58.akpm@osdl.org> <Pine.LNX.4.64N.0610161442010.28780@blysk.ds.pg.gda.pl>
 <20061016120653.9a70135d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.5/2038/Tue Oct 17 00:48:19 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 16 Oct 2006, Andrew Morton wrote:

> Vaguely.  Why doesn't it deadlock if !current_is_keventd()?  I mean,
> whether or not the caller is keventd, the flush_scheduled_work() caller
> will still be dependent upon rtnl_lock() being acquirable.

 This !current_is_keventd() condition is just what it is, i.e. a check 
whether phy_stop_interrupts() has been scheduled through keventd or not.  
If it has, then flush_scheduled_work() cannot be called; it is not needed 
anyway.  Otherwise phy_stop_interrupts() has to make sure no deferred 
calls to phy_change() will be made once it has finished.

 In all cases the assumption is the caller has made sure rtnl_lock() is 
not held at the time phy_stop_interrupts() is called.  That's the very 
reason for scheduling phy_disconnect() (and hence phy_stop_interrupts()) 
through keventd.

  Maciej
