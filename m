Received:  by oss.sgi.com id <S553791AbQLOW22>;
	Fri, 15 Dec 2000 14:28:28 -0800
Received: from chmls06.mediaone.net ([24.147.1.144]:52141 "EHLO
        chmls06.mediaone.net") by oss.sgi.com with ESMTP id <S553785AbQLOW15>;
	Fri, 15 Dec 2000 14:27:57 -0800
Received: from pianoman.cluster.toy (h00001c600ed5.ne.mediaone.net [24.147.29.131])
	by chmls06.mediaone.net (8.8.7/8.8.7) with ESMTP id RAA06289;
	Fri, 15 Dec 2000 17:27:48 -0500 (EST)
Date:   Fri, 15 Dec 2000 17:28:13 -0500 (EST)
From:   PianoMan <clemej@alum.rpi.edu>
X-Sender: clemej@pianoman.cluster.toy
To:     "Kevin D. Kissell" <kevink@mips.com>
cc:     Carsten Langgaard <carstenl@mips.com>, linux-mips@oss.sgi.com
Subject: Re: 64 bit build fails
In-Reply-To: <007001c06670$7345d2e0$0deca8c0@Ulysses>
Message-ID: <Pine.LNX.4.20.0012151700050.4896-100000@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


> > > Looks like an attempt to build a 64-bit Indy kernel.  Various people
> working
> > > on the Origin support have completly broken the support for anything
> else in
> > > their battle tank-style approach ...
> >
> > Ok, that explains why a lot of things are broken.
> > So who will be responsible for fixing all the broken pieces ?
> 
> In the absence of the SGI people being directed to do a
> clean job, I suppose the problem falls to those who have
> an interest in a clean and portable 64-bit MIPS kernel.
> That would include MIPS, of course.  But what about the
> rest of you - could we see a show of virtual hands?  I
> know that TI has both 4K and 5K licenses, and may
> want to be able to exploit the 64-bit capability of the 5K
> under Linux.  And the guys doing the Vr41xx ports may
> also be interested.  Anyone else?  Those of you with
> R4K-based DECstations, perhaps?  Software shops
> looking to support high-end embedded MIPS in set-tops?

I took a crack at this a while back trying the non-brute force
approach.  However, I'm only interested in it as a hobby (I have an I2
R4400, and I'd like to get into some embedded work with the SiByte chip
when it comes out).  I was trying to make the computer look like a single
node (assigning a NASID of 0, etc..), but i got bogged down in the page
vs. node stuff before i got to far into it.  I'd be willing to help and
test again, but i have limited time now, unfortunately.

I was going for functionality, not speed, obviously ;)

john.c

- --
John Clemens           BS, Computer Engineering, RPI 2000
clemej@alum.rpi.edu    at home - Parallel Computer Researcher/Hobbist
clemej@mclx.com        at work - Kernel Engineer 
