Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f34A2qI08497
	for linux-mips-outgoing; Wed, 4 Apr 2001 03:02:52 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f34A2pM08494
	for <linux-mips@oss.sgi.com>; Wed, 4 Apr 2001 03:02:51 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 04AB07F7; Wed,  4 Apr 2001 12:02:50 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 2E386F035; Wed,  4 Apr 2001 12:02:11 +0200 (CEST)
Date: Wed, 4 Apr 2001 12:02:11 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Jun Sun <jsun@mvista.com>
Cc: "Kevin D. Kissell" <kevink@mips.com>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: Dumb Question on Cross-Development
Message-ID: <20010404120211.C11161@paradigm.rfc822.org>
References: <00a901c0bb6f$d3e77820$0deca8c0@Ulysses> <20010402151425.A8471@bacchus.dhis.org> <00fa01c0bbaa$0bd7cb60$0deca8c0@Ulysses> <20010402234850.B25228@paradigm.rfc822.org> <017801c0bbc3$78c706a0$0deca8c0@Ulysses> <20010403003059.E25228@paradigm.rfc822.org> <3ACA09BF.C8EF0D6C@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3ACA09BF.C8EF0D6C@mvista.com>; from jsun@mvista.com on Tue, Apr 03, 2001 at 10:34:55AM -0700
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Apr 03, 2001 at 10:34:55AM -0700, Jun Sun wrote:
> > A major problem get the thing in which the configure try to
> > begin to build executables and guess on the behaviour of the
> > OS to run on. This ends to be a hack and reminds me on
> > "pre gnu configure" times where one had to deal
> > with hundrets of "config.h" or "os.h" files.
> 
> While it is a pain for some packages, it is actually not too bad for
> most of them.  I think we (mvista) are rolling out cross-compiled 250+
> packages for 5 major CPU architectures and 21 sub-architectures - where
> most of them are based on debian sources. :-)

We already had the discussion on parts of that implementation. Honestly - 
I dont like the stuff - Rolling out mips packages as "noarch" is
simply broken - And the argument that one would want to install
it on a i386 nfs root is simply an excuse for a broken rpm or missing
installer.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
