Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jul 2008 16:44:53 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:24489 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20133768AbYGCPoq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 3 Jul 2008 16:44:46 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m63FhTAL005721;
	Thu, 3 Jul 2008 17:43:54 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m63FhT4a005714;
	Thu, 3 Jul 2008 16:43:29 +0100
Date:	Thu, 3 Jul 2008 16:43:29 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] IP28: switch to "normal" mode after PROM no longer
	needed
Message-ID: <20080703154329.GA21642@linux-mips.org>
References: <20080318214756.D7E77C2816@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080318214756.D7E77C2816@solo.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 18, 2008 at 10:47:56PM +0100, Thomas Bogendoerfer wrote:

> SGI-IP28 is running in so called slow mode, when kernel is started
> from the PROM. PROM calls must be done in slow mode otherwise the
> PROM will issue an error. To get better memory performance we now
> switch to normal mode, when the PROM is no longer needed.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Ugly ...  but applied anyway.

Thanks,

  Ralf
