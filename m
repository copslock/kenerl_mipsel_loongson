Received:  by oss.sgi.com id <S42199AbQGGPfV>;
	Fri, 7 Jul 2000 08:35:21 -0700
Received: from rotor.chem.unr.edu ([134.197.32.176]:9480 "EHLO
        rotor.chem.unr.edu") by oss.sgi.com with ESMTP id <S42185AbQGGPez>;
	Fri, 7 Jul 2000 08:34:55 -0700
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id IAA10087;
	Fri, 7 Jul 2000 08:34:52 -0700
Date:   Fri, 7 Jul 2000 08:34:52 -0700
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     "J. Scott Kasten" <jsk@tetracon-eng.net>
Cc:     linux-mips@oss.sgi.com
Subject: Re: GDB question.
Message-ID: <20000707083452.A9987@chem.unr.edu>
References: <NAENLMKGGBDKLPONCDDOCEHFCPAA.mailinglist@ichilton.co.uk> <Pine.SGI.4.10.10007070944180.6663-100000@thor.tetracon-eng.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.SGI.4.10.10007070944180.6663-100000@thor.tetracon-eng.net>; from jsk@tetracon-eng.net on Fri, Jul 07, 2000 at 09:52:09AM -0300
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Jul 07, 2000 at 09:52:09AM -0300, J. Scott Kasten wrote:

> I've noticed in the Hard Hat 5.1 and the Simple Linux distros that GDB is
> lacking.  Is there a reason for that?  This is not a complaint, but more
> an iquiry to find out if there's known problems before I go banging my
> head against the wall trying to build something that won't for some
> reason or the other.
> 
> I'm presently using egcs-1.1.2, binutils 2.9.5, BFD 000425, and
> glibc-2.0.6 from Simple Linux 0.1 on an Indy.
> 
> Would appreciate any tips/tricks/caveats beforehand.

There is gdb 5.0 in the experimental Simple 0.2a set. You can try it
at ftp://oss.sgi.com/pub/linux/mips/mips-linux/simple/userland-0.2a/.
Note that this is glibc 2.2 based and may be highly unstable.
Nevertheless, it's what I'm currently using and I can verify that gdb
works. You may also be able to build gdb 4.17 or so from CVS on your
glibc 2.0 system; I don't know.

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
University of Nevada			http://www.chem.unr.edu
Chemistry Department Systems and Network Administrator
