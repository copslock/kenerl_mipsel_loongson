Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA3616294 for <linux-archive@neteng.engr.sgi.com>; Mon, 4 May 1998 11:50:11 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA19859762
	for linux-list;
	Mon, 4 May 1998 11:48:23 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA20078156
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 4 May 1998 11:48:21 -0700 (PDT)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id LAA23362
	for <linux@cthulhu.engr.sgi.com>; Mon, 4 May 1998 11:48:19 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id OAA19433;
	Mon, 4 May 1998 14:48:01 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Mon, 4 May 1998 14:48:01 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: rpm-list@redhat.com
cc: SGI Linux <linux@cthulhu.engr.sgi.com>, support@cobaltmicro.com
Subject: CobaltMicro's Qube.
In-Reply-To: <Pine.LNX.3.96.980217120532.1214P-100000@mercury.redhat.com>
Message-ID: <Pine.LNX.3.95.980504141032.11760K-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


I just have to raise a red flag here.

Oh, man.  This is going to be a royal pain for somebody, and I'm not sure
who. In short, Qubes are shipping with architecture numbers that are
inconsistant with RPM's. 

The Qubes shipped by Cobalt Micro have RPM 2.4.10glibc shipping on them:

Name        : rpm                         Distribution: (none)
Version     : 2.4.10                            Vendor: (none)
Release     : 1glibc                        Build Date: Sun Dec 14
18:59:00 1997
Install date: Tue Feb 22 03:10:44 2000   Build Host: duplo.cobaltmicro.com
Group       : Utilities/System              Source RPM:
rpm-2.4.10-1glibc.src.rpm
Size        : 519375

The architecture of these is actually little endian (mipsel), but the
architecture of the packages installed and produced is #4 according to its
rpmrc. At that point 4 was called just plain 'mips', and didn't
diffrentiate the byte order.

A while back we produced the big endian mips (mipseb) architecture for
machines such as SGIs.  This was especially important because of the SGI
port actively releasing binaries only in RPM format.  

Because (we thought) there were more packages that were in fact more big
endian labelled as 'mips', we kept 4 as mipseb, and made a new mipsel
(#11). I suggested that because I thought the only mipseb/mipsel packages
were produced by specific people: Ralf, Alan and myself.  I just hadn't
thought about Cobalt, and nobody at Cobalt piped up to complain when we
were throwing the idea around.

The earlier we solve this problem, the better. The longer we wait, the
more mislabelled packages will be out there. As it is, there will be a
chunk of compiled RPMs for mipseb in /contrib tonight.

So, now we're faced with a dilemna.  We need to choose:

1. Rename all the mipseb packages to a new number, let the Cobalt folks
keep #4 as mipsel, and mark #11 as something like 'mips_obselete'.  I
don't mind doing this, but I'd like to know this before I start on the
next port of RH source RPMs.  There's a lot more Cobalt Micro Qubes out
there than SGI/Linux boxes. I would personally be a bit of an unhappy
camper if this were the case.

2. Get Cobalt Micro from now on to ship their Qube's with the correctly
labelled packages as #11. That would mean Cobalt would have to conform to
our standard.  The build date on that box is Dec. 14, before we set the
new standard. I'm surprised they didn't double check that they were using
the correct new architecture number.

3. Go through hell, with all 'rpm -i
ftp.redhat.com/pub/contrib/hurricane/mipseb/bleah.rpm' not reporting
errors on the Qube, despite the incorrect binaries being installed, and
rpm on the Qube building incorrectly labelled binaries.

It would be really good if someone from Qube could give a comment on this.
Anyone know who's doing distribution development stuff at Qube?

- Alex
