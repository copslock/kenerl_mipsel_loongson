Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Dec 2007 11:41:36 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:64650 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022989AbXLFLle (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Dec 2007 11:41:34 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lB6Bf4GE006748;
	Thu, 6 Dec 2007 11:41:05 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lB6Bf3FU006747;
	Thu, 6 Dec 2007 11:41:03 GMT
Date:	Thu, 6 Dec 2007 11:41:03 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	peter fuerst <pf@pfrst.de>
Cc:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Kumba <kumba@gentoo.org>, linux-mips@linux-mips.org
Subject: Re: [UPDATED PATCH] IP28 support
Message-ID: <20071206114103.GA6498@linux-mips.org>
References: <20071205093938.GA6848@alpha.franken.de> <Pine.LNX.4.21.0712051841520.1354@Opal.Peter>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0712051841520.1354@Opal.Peter>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17716
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 05, 2007 at 08:49:53PM +0100, peter fuerst wrote:

> > there seems to be a missing understanding, why the cache
> > barriers are needed. I guess the patch could be improved
> > by pointing directly to the errata section of the R10k
> > user manual. Or even better copy the text out of the user
> > manual. That should make clear why this patch is needed.
> 
> Better copy, i guess. (Assuming copying whole paragraphs is still proper
> citation ;-) Along with the initial patch (.../2006-03.msg00090.html) as
> well as in the last letter so far (.../2006-05/msg01446.html) i pointed
> to the corresponding chapter in the R10k User's Manual and to the entry
> in the NetBSD eMail archive. In the last letter i tried to augment these
> by a summarizing explanation, but it seems i'm not very good at that...

I'm not sure how far "fair use" of the R10000 manual text can be stretched.
But afair Bill Earl (wje@sgi.com) posted a reasonable explanation which
also for the purposes of the gcc manual is much easier to understand.

  Ralf
