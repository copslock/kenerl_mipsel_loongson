Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8381x719491
	for linux-mips-outgoing; Mon, 3 Sep 2001 01:01:59 -0700
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8381vd19487
	for <linux-mips@oss.sgi.com>; Mon, 3 Sep 2001 01:01:57 -0700
Received: from agx by gandalf.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 15dog8-0005zD-00; Mon, 03 Sep 2001 10:01:56 +0200
Date: Mon, 3 Sep 2001 10:01:56 +0200
From: Guido Guenther <guido.guenther@gmx.net>
To: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: segfaults with 2.4.8
Message-ID: <20010903100155.A5219@gandalf.physik.uni-konstanz.de>
Mail-Followup-To: linux-mips <linux-mips@oss.sgi.com>
References: <3B91089E.5050900@csh.rit.edu> <20010902202810.A14288@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010902202810.A14288@paradigm.rfc822.org>; from flo@rfc822.org on Sun, Sep 02, 2001 at 08:28:10PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Sep 02, 2001 at 08:28:10PM +0200, Florian Lohoff wrote:
> On Sat, Sep 01, 2001 at 12:11:10PM -0400, George Gensure wrote:
> > I'm running an r5000 indy with the latest (as of 8/31/01) cvs kernel and 
> > the fast-sysmips patch, and I'm having segfaults and strange errors in 
> > building tools like gcc and in building X.  The sysmips is correcting 
> > things like find, but I can't have these other errors (meant for lab 
> > machines).  Any takers?
Which toolchain did you use?
> 
> That is definitly a cache issue - The 2nd level Boardcache of
> the R5000 indy is still unfixed.
Not 100% sure about that. 2.4.5 handles this stuff fine while 2.4.8
segfaults(it might be that we just trigger this caching issues
occasionaly though). I will run this stuff on an R4k and see what
happens ... at least it's good to see that other people see this too - I
tended to blame it on my binutils experiments. Can you explain the
R5k Indys' caching issues?
 -- Guido
