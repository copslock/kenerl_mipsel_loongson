Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Dec 2007 19:56:37 +0000 (GMT)
Received: from mail1.pearl-online.net ([62.159.194.147]:28207 "EHLO
	mail1.pearl-online.net") by ftp.linux-mips.org with ESMTP
	id S20032469AbXLET41 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Dec 2007 19:56:27 +0000
Received: from SNaIlmail.Peter (unknown [77.47.48.214])
	by mail1.pearl-online.net (Postfix) with ESMTP id 64867AF82;
	Wed,  5 Dec 2007 20:56:55 +0100 (CET)
Received: from Indigo2.Peter (Indigo2.Peter [192.168.1.28])
	by SNaIlmail.Peter (8.12.6/8.12.6/Sendmail/Linux 2.0.32) with ESMTP id lB5JuDmP000707;
	Wed, 5 Dec 2007 20:56:14 +0100
Received: from Indigo2.Peter (localhost [127.0.0.1])
	by Indigo2.Peter (8.12.6/8.12.6/Sendmail/Linux 2.6.20-ip28) with ESMTP id lB5Jnri5000386;
	Wed, 5 Dec 2007 20:49:53 +0100
Received: from localhost (pf@localhost)
	by Indigo2.Peter (8.12.6/8.12.6/Submit) with ESMTP id lB5JnrS0000383;
	Wed, 5 Dec 2007 20:49:53 +0100
Date:	Wed, 5 Dec 2007 20:49:53 +0100 (CET)
From:	peter fuerst <pf@pfrst.de>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	Kumba <kumba@gentoo.org>, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [UPDATED PATCH] IP28 support
In-Reply-To: <20071205093938.GA6848@alpha.franken.de>
Message-ID: <Pine.LNX.4.21.0712051841520.1354@Opal.Peter>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <pf@pfrst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17712
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pf@pfrst.de
Precedence: bulk
X-list: linux-mips



On Wed, 5 Dec 2007, Thomas Bogendoerfer wrote:

> Date: Wed, 5 Dec 2007 10:39:38 +0100
> From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> To: Kumba <kumba@gentoo.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
> Subject: Re: [UPDATED PATCH] IP28 support
>
> On Wed, Dec 05, 2007 at 01:16:13AM -0500, Kumba wrote:
> > I've been out of it lately -- did the gcc side of things ever make it in,
> > or do we need to go push on that some more?
>
> We need push on that. ...

There was no answer to .../2006-05/msg01446.html. Perhaps i should just
put together an updated patch, that incorporates the changes proposed in
msg01446.html, and submit it (with the longer "Cc:" line and a hint to
the increasing demand for it ;-) to revive at least the discussion at
gcc-patches.
What could be changed beyond the proposed changes without either omitting
necessary cache-barriers or crippling the R10k, i can't see yet.

> We need push on that. Looking at
>
> http://gcc.gnu.org/ml/gcc-patches/2006-04/msg00291.html
>
> there seems to be a missing understanding, why the cache
> barriers are needed. I guess the patch could be improved
> by pointing directly to the errata section of the R10k
> user manual. Or even better copy the text out of the user
> manual. That should make clear why this patch is needed.

Better copy, i guess. (Assuming copying whole paragraphs is still proper
citation ;-) Along with the initial patch (.../2006-03.msg00090.html) as
well as in the last letter so far (.../2006-05/msg01446.html) i pointed
to the corresponding chapter in the R10k User's Manual and to the entry
in the NetBSD eMail archive. In the last letter i tried to augment these
by a summarizing explanation, but it seems i'm not very good at that...

>
> Peter did you do the copyright assigment ? That's probably
> the second part, which needs to be done.

Yes, the assignment process became complete on May 22 2006
(though apparently i missed to notify Richard Sandiford about it)

>
> Thomas.
>
> --
> Crap can work. Given enough thrust pigs will fly, but it's not necessary a
> good idea.                                                [ RFC1925, 2.3 ]
>
>
>

kind regards

peter
