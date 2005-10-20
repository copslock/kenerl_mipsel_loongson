Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2005 12:17:36 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:45583 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465689AbVJTLRT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Oct 2005 12:17:19 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j9KBHCRl011117;
	Thu, 20 Oct 2005 12:17:12 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j9KBHBLE011116;
	Thu, 20 Oct 2005 12:17:11 +0100
Date:	Thu, 20 Oct 2005 12:17:11 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dominic Sweetman <dom@mips.com>
Cc:	Andrew Isaacson <adi@broadcom.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 8/12]  cerr-printk-not-prom-printf
Message-ID: <20051020111711.GM2616@linux-mips.org>
References: <20051020065320.GA23857@broadcom.com> <20051020065757.GH23899@broadcom.com> <20051020104902.GA9491@linux-mips.org> <17239.31049.107570.828550@arsenal.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17239.31049.107570.828550@arsenal.mips.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9305
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 20, 2005 at 12:02:33PM +0100, Dominic Sweetman wrote:

> > The reason for this old commit was that this code is running
> > uncached, so the operation of ll/sc in the spinlocks is undefined
> > according to the MIPS64 spec...
> 
> The answer is more complicated.  MIPS64 (elsewhere) requires that the
> ll/sc "link" is broken on an exceptin - in fact on an 'eret'
> instruction.

But in case of the code in question no eret will be executed between taking
the cache error exception and printk trying to take the lock.

> So ll/sc on an uncached location works just fine in a uniprocessor.  
> However, it's unlikely that any cache-coherent mulitprocessor system
> will snoop uncached reads and writes, so it won't work in an SMP
> system.

Fine - but at that point we could have two processors messing with the
same buffers.  Bad Thing (TM).

  Ralf
