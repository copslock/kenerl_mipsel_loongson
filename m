Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2005 21:52:19 +0100 (BST)
Received: from alg138.algor.co.uk ([IPv6:::ffff:62.254.210.138]:55530 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225745AbVFIUv4>; Thu, 9 Jun 2005 21:51:56 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j59Kndpp029474;
	Thu, 9 Jun 2005 21:49:39 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j59Kncjq029473;
	Thu, 9 Jun 2005 21:49:38 +0100
Date:	Thu, 9 Jun 2005 21:49:37 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Ton Truong <ttruong@broadcom.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Member sc_sigset gone in latest 2.6.12-rc5 breaks strace.
Message-ID: <20050609204937.GK4927@linux-mips.org>
References: <20050606121640.GB6651@linux-mips.org> <200506091737.KAA22310@mon-irva-10.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506091737.KAA22310@mon-irva-10.broadcom.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8062
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 09, 2005 at 10:37:49AM -0700, Ton Truong wrote:

> I see that in the rc5 update, MIPS codes have now dropped 
> sc_sigset[4] from struct sigcontext, defined in asm-mips/sigcontext.h.  I'd
> appreciate it if someone provide a brief summary of what needs to be changed
> for strace to compile or where I can find an strace port that work with the
> new MIPS codes?

sc_sigset and the other members that were changed have been unused by the
kernel since a very, very long time so whatever strace may have done with
that field was probably bogus.

Thanks for reporting, something I'm going to look at tomorrow.

  Ralf
