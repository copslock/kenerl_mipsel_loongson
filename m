Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f34Ik6L28210
	for linux-mips-outgoing; Wed, 4 Apr 2001 11:46:06 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f34Ik5M28206
	for <linux-mips@oss.sgi.com>; Wed, 4 Apr 2001 11:46:05 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 730107FA; Wed,  4 Apr 2001 20:46:03 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 9754DEE85; Wed,  4 Apr 2001 20:45:50 +0200 (CEST)
Date: Wed, 4 Apr 2001 20:45:50 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Jun Sun <jsun@mvista.com>
Cc: "Kevin D. Kissell" <kevink@mips.com>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: Dumb Question on Cross-Development
Message-ID: <20010404204549.C1221@paradigm.rfc822.org>
References: <00a901c0bb6f$d3e77820$0deca8c0@Ulysses> <20010402151425.A8471@bacchus.dhis.org> <00fa01c0bbaa$0bd7cb60$0deca8c0@Ulysses> <20010402234850.B25228@paradigm.rfc822.org> <017801c0bbc3$78c706a0$0deca8c0@Ulysses> <20010403003059.E25228@paradigm.rfc822.org> <3ACA09BF.C8EF0D6C@mvista.com> <20010404120211.C11161@paradigm.rfc822.org> <3ACB62A4.90B5630@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3ACB62A4.90B5630@mvista.com>; from jsun@mvista.com on Wed, Apr 04, 2001 at 11:06:28AM -0700
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Apr 04, 2001 at 11:06:28AM -0700, Jun Sun wrote:
> BTW, we actually do have native compiling as well - probably for something
> like mp3 player.  
> 
> (Flo, you really cannot beat the argument of having both. :-0)

I dont want to argue very much - I think both ways do have advantages.
I am coming the distribution way and i am used to something
like rpm --rebuild although i am going the debian way.

There is stuff like autobuilder, autoconf, dependencies etc which
give a major headache on cross-compiling. For all the embedded archs
i do think there is a way of having a "workstation" like machine
available for compiling native and having a distribution.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
