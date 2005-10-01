Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Oct 2005 11:13:02 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:61707 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133445AbVJCKKM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 3 Oct 2005 11:10:12 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j93AA4MQ001842;
	Mon, 3 Oct 2005 11:10:06 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j91BvQf5014346;
	Sat, 1 Oct 2005 12:57:26 +0100
Date:	Sat, 1 Oct 2005 12:57:26 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andy Isaacson <adi@hexapodia.org>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [patch 4/5] SiByte fixes for 2.6.12
Message-ID: <20051001115725.GG14463@linux-mips.org>
References: <20050622230151.GA17970@broadcom.com> <Pine.LNX.4.61L.0506231208120.17155@blysk.ds.pg.gda.pl> <20050623144926.GA10216@hexapodia.org> <Pine.LNX.4.61L.0506231601270.17155@blysk.ds.pg.gda.pl> <20050623222709.GC26427@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050623222709.GC26427@hexapodia.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9113
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 23, 2005 at 03:27:09PM -0700, Andy Isaacson wrote:

> >  Well, I've had a look at the code and it's such a mess.  Obviously 
> > calling ld_mmu_r4xx0() (or any of the other variants) should not be 
> > compiled conditionally and more specific cases, i.e. based on PRId values 
> > should take precedence.  I'll see if I can make it better.
> 
> I certainly won't argue with a cleanup of arch/mips/mm/cache.c, that
> code has annoyed me from first laying eyes on it...

So just did that, cpu_cache_init is looking bearable now.

  Ralf
