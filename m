Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6NKJwRw011551
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 23 Jul 2002 13:19:59 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6NKJw6x011550
	for linux-mips-outgoing; Tue, 23 Jul 2002 13:19:58 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft17-f235.dialo.tiscali.de [62.246.17.235])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6NKJqRw011540
	for <linux-mips@oss.sgi.com>; Tue, 23 Jul 2002 13:19:54 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6NKKiC15662;
	Tue, 23 Jul 2002 22:20:44 +0200
Date: Tue, 23 Jul 2002 22:20:44 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Marc Zyngier <mzyngier@freesurf.fr>
Cc: linux-mips@oss.sgi.com
Subject: Re: [PATCH] EISA bus support on Indigo-2
Message-ID: <20020723222044.A15421@dea.linux-mips.net>
References: <wrpofd3y7f1.fsf@hina.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <wrpofd3y7f1.fsf@hina.wild-wind.fr.eu.org>; from mzyngier@freesurf.fr on Fri, Jul 19, 2002 at 07:05:54PM +0200
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Jul 19, 2002 at 07:05:54PM +0200, Marc Zyngier wrote:

> I found some time to update my basic EISA support for the Indigo-2
> patch, so here it is (only works in PIO mode).
> 
> Performance is much better that what it was two months ago, and is
> stable for my very basic usage (Indigo-2 as a router... yeah right).

Applied with changes.  I ran ip22-eisa.c through indent and applied some
of the changes to the 64-bit kernel as well.

  Ralf
