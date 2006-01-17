Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 13:26:20 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:35100 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465587AbWAQN0D (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Jan 2006 13:26:03 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0HDTWsP015605;
	Tue, 17 Jan 2006 13:29:32 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0HDTVVP015604;
	Tue, 17 Jan 2006 13:29:31 GMT
Date:	Tue, 17 Jan 2006 13:29:31 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	Peter Horton <pdh@colonel-panic.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH Cobalt 1/1] 64-bit fix
Message-ID: <20060117132931.GB3336@linux-mips.org>
References: <20050414185949.GA5578@skeleton-jack> <20060116154543.GA26771@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060116154543.GA26771@deprecation.cyrius.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9929
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 16, 2006 at 03:45:43PM +0000, Martin Michlmayr wrote:

> * Peter Horton <pdh@colonel-panic.org> [2005-04-14 19:59]:
> > This patch adds detection of broken 64-bit mode LL/SC on Cobalt units.
> > With this patch my Qube2700 boots a 64-bit build fine. The later units
> > have some problems with the Tulip driver.
> 
> Ralf, is this patch appropriate?  Can you please apply it or provide
> some feedback.

Runtime testing for that bug is fairly expensive as it adds a branch to
every instance of every type of atomic operation.  So we really want
cpu_has_llsc to be a constant so the compiler can optimize that.

So I suggest something like this in cpu-feature-overrides.h:

[...]
/*
 * R5000 has an interesting "restriction":  ll(d)/sc(d)
 * instructions to XKPHYS region simply do uncached bus
 * requests. This breaks all the atomic bitops functions.
 * so, for 64bit IP32 kernel we just don't use ll/sc.
 * This does not affect luserland.
 */
#ifdef CONFIG_64BIT
#define cpu_has_llsc            0
#else
#define cpu_has_llsc            1
#endif
[...]

The probe would upset the IP27 cache coherency logic and crash them btw.

  Ralf
