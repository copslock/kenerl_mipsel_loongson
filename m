Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f56GCsx03522
	for linux-mips-outgoing; Wed, 6 Jun 2001 09:12:54 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f56GCrh03519
	for <linux-mips@oss.sgi.com>; Wed, 6 Jun 2001 09:12:53 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA06045
	for <linux-mips@oss.sgi.com>; Wed, 6 Jun 2001 09:01:53 -0700 (PDT)
	mail_from (macro@ds2.pg.gda.pl)
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA05307;
	Wed, 6 Jun 2001 17:47:08 +0200 (MET DST)
Date: Wed, 6 Jun 2001 17:47:08 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "H . J . Lu" <hjl@lucon.org>
cc: linux-mips@oss.sgi.com
Subject: Re: New toolchain for Linux/mips
In-Reply-To: <20010606071525.A19423@lucon.org>
Message-ID: <Pine.GSO.3.96.1010606165138.2113A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 6 Jun 2001, H . J . Lu wrote:

> >  Gdb 5.0 works for me (and a few other people, I think).  Check
> > 'ftp://ftp.ds2.pg.gda.pl/pub/macro/SRPMS/gdb-5.0-6.src.rpm'.  Most of the
> > patches have been submitted.  The only remaining one is the port of 4.17
> 
> This is a very old gdb. Since gdb has changed a lot at the same
> time, if the patches haven't been installed, we may have to redo them.

 If things were easy the patches would already have been installed.  I
submitted the ones I wrote myself a year ago -- they were current then.  I
believe most, if not all of them got applied.  The oss one was not
submitted as I had troubles finding out who were all the authors (my
changes were rather cosmetic -- I tried to separate work into different
patches).  The patch is named "gdb-5.0-mips-linux.patch.gz" in my package. 

 Finally I found out Dave Miller was the author of most of the patch (his
name appears on a few files, but not all of them).  Unfortunately, this
was much, much later -- at the beginning of this year. The CVS of gdb
changed meanwhile and my time constraints didn't allow me to check what
needed to be updated.  Therefore there was no point to bother Dave about a
copyright assignment without updating the patch and making sure it'll get 
applied. 

 I believe it's still the best idea to port the patch instead of starting
from scratch.  I've already ported it from 4.17 to 5.0 and it took no more
than a few days.  Porting to current shouldn't be much more difficult or
time-consuming.  I'd be pleased to do this work, yet I'm not sure I can
afford doing it now.  If you look at my spec file, there is a somewhat
detailed change log, which explains the most significant changes.  The
"mips-linux" patch is quite small -- about 20kB and mostly adds new files,
so it should be quite trivial to port. 

> I'd like to see Linux/mips as a supported target in gdb. gdb in RedHat
> 7.1 is quite current. Also, my new toolchain uses stabs, not ecoff.
> It may need some work.

 Since I have a current gdb snapshot handy I checked all the patches I
have against it.  Here are the results: 

1. readline -- non-MIPS/Linux specific; a single hunk fails.  Unimportant
but linking against local readline statically is evil. 

2. ulfc-mips -- fails for a number of hunks but already present in the
current BFD; supposedly gdb shares it with binutils on sourceware. 

3. gdbserver -- non-MIPS/Linux specific; applies cleanly -- I'll submit
it, but it might need a semantics validity check. 

4. mips-linux -- important; two hunks fail and needs a semantics validity
check. 

5. sim-install -- applied. 

6. core-xregset -- necessary for core file analysis; one hunk fails.  It
might not be needed though, since I was told the generic core file
handling code was to be rewritten.

7. sim-mips-clean -- applied. 

8. so-lmstart -- crucial for shared library handling; fails completely --
maybe unneeded (there was a base address vs load address confusion in
gdb's generic shlib handling code). 

9. sign-extend -- crucial for shared library handling; fails partially. 

10. mips-branch-predict -- necessary for placing breakpoints after
branches; fails partially -- no idea why it wasn't applied as what is
already ther is completely broken. 

 So the success ratio is 1/4 and for two trivial patches only -- not much
encouraging for me for further work, especially as what I have now works
for me quite well.  Feel free to look at the stuff -- I might check it as
well, but I can't afford spending much time on it at the moment, sorry. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
