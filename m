Received:  by oss.sgi.com id <S42291AbQGTCwj>;
	Wed, 19 Jul 2000 19:52:39 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:43834 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42280AbQGTCv7>;
	Wed, 19 Jul 2000 19:51:59 -0700
Received: from thor ([207.246.91.243]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via SMTP id TAA20224
	for <linux-mips@oss.sgi.com>; Wed, 19 Jul 2000 19:44:05 -0700 (PDT)
	mail_from (jsk@tetracon-eng.net)
Received: from localhost (localhost [127.0.0.1]) by thor (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id WAA07573; Wed, 19 Jul 2000 22:43:35 -0300
Date:   Wed, 19 Jul 2000 22:43:35 -0300
From:   "J. Scott Kasten" <jsk@tetracon-eng.net>
To:     Keith M Wesolowski <wesolows@chem.unr.edu>
cc:     linux-mips@oss.sgi.com
Subject: Re: Simple Linux/MIPS 0.2b
In-Reply-To: <20000719185153.B24731@chem.unr.edu>
Message-ID: <Pine.SGI.4.10.10007192223030.7510-100000@thor.tetracon-eng.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


On Wed, 19 Jul 2000, Keith M Wesolowski wrote:

> On Wed, Jul 19, 2000 at 07:56:25PM -0300, J. Scott Kasten wrote:
> 
> > There is one thing at this point that would really really help.  I need to
> > establish a reference point and follow someone elses procedures exactly to
> > determine what the source of my problem is and why some of you are not
> > seeing this to the extent that I am.  In this way, we can verify whether
> > or not there is a bonified problem, and if it is with the tools, maybe get
> > it fixed.
> 
> Before you get carried away with this, I should point out that I've
> been looking at this problem in more detail. Many of my X programs
> don't work either; they get SEGV, never bus errors. I suspect this is
> a glibc bug. I can run a few programs, such as xhost and the server
> itself. I did have a full X setup, including a working server, under
> 0.1. That was built exactly the same way I've done it under 0.2b. You
> may wish to try both and see which works better.

Alright, that's starting to sound more like what I'm seeing.  Some things
work, some don't.  Some SEGV, some bus error.  The bugs float from one
place to another depending on what tools I used to build.  My litimus test
has been to launch an xterm over the network, xeyes, and xwininfo.  If
those work, then I proceed to building lesstif against that set.
Unfortunately, only libraries that others have built have gotten me to the
lesstif stage.

In fact, I've even had difficulty trying to build the compiler itself
natively.  With egcs-1.03a (patched) it would not natively build using the
egcs-1.1.2, or gcc-2.7.2.  Basicly at the point where the build starts
launching those "genXXXXX" functions, they start segv or bus erroring.
The ones that break depend on which compiler was used.  Thus I was forced
to try that one as a cross compiler, although I just found an rpm for it
so I can finally give it a whirl natively.

> If you like, I will return to 0.1 and duplicate my previous efforts. I
> can then describe the exact procedure to you.

Thanks, but not necessary just yet.  I'll try using the X sources and
patch you mentioned on both Simple 0.1 and Simple 0.2b and see what
happens.  We can then compare notes to see what workes, what doesn't.  At
that point I'm confident that we can rule out a lot of the variables and
get down to demonstrating specific problems with the tools themselves.
Also at that point, I can start stuffing the broken binaries into one of
our eval boards and have our hardware people run it against a logic
analyser so we can get to the bottom of some of these things quickly if
they'll let me have the resources.  We're having a staff meeting in the
morning about exactly that. ;-)
