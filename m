Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9P7xCF18980
	for linux-mips-outgoing; Thu, 25 Oct 2001 00:59:12 -0700
Received: from mail.sonytel.be (main.sonytel.be [195.0.45.167])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9P7x8D18977
	for <linux-mips@oss.sgi.com>; Thu, 25 Oct 2001 00:59:08 -0700
Received: from mullein.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id JAA24990;
	Thu, 25 Oct 2001 09:58:11 +0200 (MET DST)
Date: Thu, 25 Oct 2001 09:57:46 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "J. Scott Kasten" <jsk@tetracon-eng.net>
cc: "H . J . Lu" <hjl@lucon.org>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: I am looking for a mips machine
In-Reply-To: <Pine.SGI.4.33.0110241637200.11721-100000@thor.tetracon-eng.net>
Message-ID: <Pine.GSO.4.21.0110250956240.7986-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 24 Oct 2001, J. Scott Kasten wrote:
> My general impression is that your looking for a "FAST" board, and a
> little endian board make for mutually exclusive requirements.  Not that
> little endian couldn't be fast, but just about every piece of hardware
> I've seen running little endian has used one of the lesser mips chips in
> it where they've cut corners multiplexing address and data over the same
> pins and so forth.  Someone correct me if I'm wrong, but of all the ones
> I've looked at, the little endian boards had the less capable hardware to
> boot.  I think that's because the market was being driven by these little
> Win CE things, and CE only supports little endian.

You can try a NEC DDBxxxx evaluation board with VR5000. They have jumpers to
select endianness, but I never got them to work in big-endian mode.

> On Wed, 24 Oct 2001, H . J . Lu wrote:
> > On Wed, Oct 24, 2001 at 11:19:27AM -0700, James Simmons wrote:
> > > I use a Cobalt Qube for alot of my developement. It works fine. I know it
> > > is not in Ralph's tree yet but I plan to send him my work soon.
> >
> > I think Cobalt Qube is slow and is hard to expand the memory. I need at
> > least 128MB RAM. Also the current mips kernel doesn't support it.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
