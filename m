Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2M7oGb21456
	for linux-mips-outgoing; Wed, 21 Mar 2001 23:50:16 -0800
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2M7oEM21453
	for <linux-mips@oss.sgi.com>; Wed, 21 Mar 2001 23:50:14 -0800
Received: from escobaria.sonytel.be (escobaria.sonytel.be [10.34.80.3])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id IAA26967;
	Thu, 22 Mar 2001 08:49:32 +0100 (MET)
Date: Thu, 22 Mar 2001 08:49:31 +0100 (MET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Phil Thompson <Phil.Thompson@pace.co.uk>
cc: "'Erik Mullinix'" <Hesp@rainworks.org>, linux-mips@oss.sgi.com
Subject: RE: Recommended toolchain
In-Reply-To: <1402C4C025C4D311B50D00508B8B74E281B151@exchange1>
Message-ID: <Pine.GSO.4.10.10103220848500.18066-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 21 Mar 2001, Phil Thompson wrote:
> I had to patch va-mips.h to #include <asm/sgidefs.h> rather than
> <sgidefs.h>.
> 
> The current errors are:
> 
> - warnings about struct flock64 not being declared (it's defined in
> asm-mips64/fcntl.h but not asm-mips/fcntl.h)
> 
> - compilation stops because loops_per_sec is undeclared as far as
> asm-mips/delay.h is concerned (although it seems fine in
> asm-mips64/delay.h).
> 
> This seems to imply that the mips architecture (as opposed to mips64) isn't
> being maintained. Is this the case? Should I be using mips64 - but what
> would be the point on an embedded CPU?

You're definitely not using the Linux/MIPS CVS tree, since these things were
fixed there some months ago.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
