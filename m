Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f34AGVY09142
	for linux-mips-outgoing; Wed, 4 Apr 2001 03:16:31 -0700
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f34AGUM09138
	for <linux-mips@oss.sgi.com>; Wed, 4 Apr 2001 03:16:30 -0700
Received: from escobaria.sonytel.be (escobaria.sonytel.be [10.34.80.3])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id MAA07625;
	Wed, 4 Apr 2001 12:16:07 +0200 (MET DST)
Date: Wed, 4 Apr 2001 12:15:59 +0200 (MET DST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Florian Lohoff <flo@rfc822.org>
cc: Jun Sun <jsun@mvista.com>, "Kevin D. Kissell" <kevink@mips.com>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: Dumb Question on Cross-Development
In-Reply-To: <20010404120211.C11161@paradigm.rfc822.org>
Message-ID: <Pine.GSO.4.10.10104041213260.17324-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 4 Apr 2001, Florian Lohoff wrote:
> On Tue, Apr 03, 2001 at 10:34:55AM -0700, Jun Sun wrote:
> > > A major problem get the thing in which the configure try to
> > > begin to build executables and guess on the behaviour of the
> > > OS to run on. This ends to be a hack and reminds me on
> > > "pre gnu configure" times where one had to deal
> > > with hundrets of "config.h" or "os.h" files.
> > 
> > While it is a pain for some packages, it is actually not too bad for
> > most of them.  I think we (mvista) are rolling out cross-compiled 250+
> > packages for 5 major CPU architectures and 21 sub-architectures - where
> > most of them are based on debian sources. :-)
> 
> We already had the discussion on parts of that implementation. Honestly - 
> I dont like the stuff - Rolling out mips packages as "noarch" is
> simply broken - And the argument that one would want to install
> it on a i386 nfs root is simply an excuse for a broken rpm or missing
> installer.

What about modifying dpkg so it can install the lib and include parts of
non-native packages for arch $ARCH in /usr/$ARCH-linux/? Thay way you can
easily install *-dev packages for cross-development.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
