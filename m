Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f82IqBq07086
	for linux-mips-outgoing; Sun, 2 Sep 2001 11:52:11 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f82Iq9d07082
	for <linux-mips@oss.sgi.com>; Sun, 2 Sep 2001 11:52:09 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 613B9848; Sun,  2 Sep 2001 20:52:07 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 586F44637; Sun,  2 Sep 2001 20:28:10 +0200 (CEST)
Date: Sun, 2 Sep 2001 20:28:10 +0200
From: Florian Lohoff <flo@rfc822.org>
To: George Gensure <werkt@csh.rit.edu>
Cc: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: segfaults with 2.4.8
Message-ID: <20010902202810.A14288@paradigm.rfc822.org>
References: <3B91089E.5050900@csh.rit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B91089E.5050900@csh.rit.edu>
User-Agent: Mutt/1.3.20i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Sep 01, 2001 at 12:11:10PM -0400, George Gensure wrote:
> I'm running an r5000 indy with the latest (as of 8/31/01) cvs kernel and 
> the fast-sysmips patch, and I'm having segfaults and strange errors in 
> building tools like gcc and in building X.  The sysmips is correcting 
> things like find, but I can't have these other errors (meant for lab 
> machines).  Any takers?

That is definitly a cache issue - The 2nd level Boardcache of
the R5000 indy is still unfixed.


Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
