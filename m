Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f336Bxq22236
	for linux-mips-outgoing; Mon, 2 Apr 2001 23:11:59 -0700
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f336BwM22233
	for <linux-mips@oss.sgi.com>; Mon, 2 Apr 2001 23:11:58 -0700
Received: from escobaria.sonytel.be (escobaria.sonytel.be [10.34.80.3])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id IAA06193;
	Tue, 3 Apr 2001 08:11:27 +0200 (MET DST)
Date: Tue, 3 Apr 2001 08:11:19 +0200 (MET DST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Florian Lohoff <flo@rfc822.org>
cc: "Kevin D. Kissell" <kevink@mips.com>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: Dumb Question on Cross-Development
In-Reply-To: <20010403003059.E25228@paradigm.rfc822.org>
Message-ID: <Pine.GSO.4.10.10104030810220.11969-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 3 Apr 2001, Florian Lohoff wrote:
> On Tue, Apr 03, 2001 at 12:22:48AM +0200, Kevin D. Kissell wrote:
> > would consider doing cross-development?   What part of it 
> > seems to you to be a show-stopper?
> 
> A major problem get the thing in which the configure try to 
> begin to build executables and guess on the behaviour of the
> OS to run on. This ends to be a hack and reminds me on
> "pre gnu configure" times where one had to deal
> with hundrets of "config.h" or "os.h" files. 
> 
> If you are going to use anything like a package format
> might it be "rpm" or "deb" the dependencies tend to be
> utterly broken as the dependcies are guessed by stuff like
> "ldd" output and friends.

So if you would have a `cross ldd', things would be better?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
