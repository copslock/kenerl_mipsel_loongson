Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2006 05:11:24 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:30480 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8127231AbWCTFLN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Mar 2006 05:11:13 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 3C99164D3D; Mon, 20 Mar 2006 05:20:48 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id CFBA266ED5; Mon, 20 Mar 2006 05:20:27 +0000 (GMT)
Date:	Mon, 20 Mar 2006 05:20:27 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Andrew Morton <akpm@osdl.org>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: Bring linux-mips in sync with Linus' tree
Message-ID: <20060320052027.GE16906@deprecation.cyrius.com>
References: <20060320043445.GA20171@deprecation.cyrius.com> <20060319210617.744338e1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060319210617.744338e1.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10872
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Andrew Morton <akpm@osdl.org> [2006-03-19 21:06]:
> > The following is a series of six patches to bring the linux-mips tree
> >  in sync with Linus' tree.  These are changes that have to be made
> >  on the linux-mips side.
> Confused.  Isn't all this stuff in Ralf's git tree?  It should be.

I CCed you on this series not because you have to do anything about
it, but just as a reference since I mentioned this series in the
series that is for you (the 12 patches, for which I put you in the To:
line).

The point is that these six patches are missing from Ralf's tree, even
though they're in mainline, or that random changes were made in Ralf's
tree that no longer apply and should be reverted.

> That way, it all gets merged when Ralf does his next Linus merge.

Well, in theory, yes.  In practice, they have always fallen through
the cracks so far when Ralf did a merge... or, rather, most of these
changes are changes that were made on the linux-mips at same time but
need to be reverted because they no longer apply.

I'm not sure I'm expressing myself very clear, so please ask if none
of this makes sense.

Okay, let me summarize:

[PATCH 1/6] [CHAR] Remove obsolete IBM z50 (vr41xx) keyboard map
 -> got applied to linux-mips, never made it into mainline.  There's
    no keyboard support anyway, so this should just be removed.

[PATCH 2/6] [VIDEO] Remove trailing whitespace from drivers/video/Kconfig
 -> I suppose the trailing whitespace got dropped when those patches
    made it into mainline, but for some reason the whitespace changes
    never got merged back into linux-mips when Ralf synced.

[PATCH 3/6] Remove bogus blank lines - sync with Linus' tree
 -> These were introduced while doctoring around some bogus changes
    instead of pulling from mainline.

[PATCH 4/6] [NET] Fix NET_SB1250_MAC Kconfig order to match Linus' tree
 -> no idea why we differ here, but we shouldn't.

[PATCH 5/6] [MIPS] vr41xx: remove timex.h
 -> mips-linux specific addition that no longer applies

[PATCH 6/6] [MTD] Remove typecast from drivers/mtd/maps/lasat.c
 -> no idea why this never got synced from mainline

Clearer now?
-- 
Martin Michlmayr
http://www.cyrius.com/
