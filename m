Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f339qXx28608
	for linux-mips-outgoing; Tue, 3 Apr 2001 02:52:33 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f339qQM28605
	for <linux-mips@oss.sgi.com>; Tue, 3 Apr 2001 02:52:28 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id LAA26603;
	Tue, 3 Apr 2001 11:50:48 +0200 (MET DST)
Date: Tue, 3 Apr 2001 11:50:48 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Florian Lohoff <flo@rfc822.org>
cc: "Kevin D. Kissell" <kevink@mips.com>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: Dumb Question on Cross-Development
In-Reply-To: <20010403003059.E25228@paradigm.rfc822.org>
Message-ID: <Pine.GSO.3.96.1010403112625.25523C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 3 Apr 2001, Florian Lohoff wrote:

> A major problem get the thing in which the configure try to 
> begin to build executables and guess on the behaviour of the
> OS to run on. This ends to be a hack and reminds me on
> "pre gnu configure" times where one had to deal
> with hundrets of "config.h" or "os.h" files. 

 But autoconf supports it properly.  It doesn't try to make and run an
executable in the case of cross-compiling and also prints a unambiguous
warning in the case no cross-compilation default (usually the worst case
assumption) was provided.

> If you are going to use anything like a package format
> might it be "rpm" or "deb" the dependencies tend to be
> utterly broken as the dependcies are guessed by stuff like
> "ldd" output and friends.

 Well, my rpm binaries find dependencies correctly (go, figure! -- all
binary packages I make available have correct dependencies).  Using ldd
for this purpose is broken, indeed.  What I do is using readelf, if
available, and falling back to objdump, if not (as in the case of old
binutils).  Readelf is better as it's host-independent.  Objdump might not
work if a host is of different "bitness" than a target.  It might even not
work at all if a host is non-ELF.  Ldd is used as well, I admit, but only
for a.out binaries -- I don't know of any other way for finding a.out
shared library dependencies.  It doesn't really matter here, though. 

 Check my rpm packages for a patch -- I haven't submitted it yet, because
rpm 3.0 was already obsolete when I created it.  I'll check if it applies
to 4.0 cleanly.  If so, I'll submit it ASAP, otherwise don't hold your
breath. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
