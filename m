Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 May 2009 14:20:52 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:39132 "EHLO elvis.franken.de"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20023446AbZENNUp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 14 May 2009 14:20:45 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1M4arb-0000RN-00; Thu, 14 May 2009 15:20:43 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 942DDC21C7; Thu, 14 May 2009 15:20:30 +0200 (CEST)
Date:	Thu, 14 May 2009 15:20:30 +0200
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] SIBYTE: fix locking in set_irq_affinity
Message-ID: <20090514132030.GA7926@alpha.franken.de>
References: <20090504215155.461B2E31C1@solo.franken.de> <20090512215556.GA4774@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090512215556.GA4774@deprecation.cyrius.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22715
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Tue, May 12, 2009 at 11:55:57PM +0200, Martin Michlmayr wrote:
> * Thomas Bogendoerfer <tsbogend@alpha.franken.de> [2009-05-04 23:51]:
> > Locking of irq_desc is now done in irq_set_affinity; Don't lock it
> > again in chip specific set_affinity function.
> 
> SWARM boots with this patch, but dmesg shows:
> 
> [17179570.260000] attempted to set irq affinity for irq 8 to multiple CPUs
> [17179570.484000] attempted to set irq affinity for irq 8 to multiple CPUs
> [17179570.500000] attempted to set irq affinity for irq 8 to multiple CPUs

I saw them as well, either the caller of set_irq_affinity does something
illegal or the API has changed and the message just should go away...

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
