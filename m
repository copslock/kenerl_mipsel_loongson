Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g27EC5q28612
	for linux-mips-outgoing; Thu, 7 Mar 2002 06:12:05 -0800
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g27EBw928609;
	Thu, 7 Mar 2002 06:11:58 -0800
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id OAA19271;
	Thu, 7 Mar 2002 14:11:50 +0100 (MET)
Date: Thu, 7 Mar 2002 14:11:50 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Marc Karasek <marc_karasek@ivivity.com>,
   Linux MIPS <linux-mips@oss.sgi.com>
Subject: Re: Questions?
In-Reply-To: <20020307140754.A1817@dea.linux-mips.net>
Message-ID: <Pine.GSO.4.21.0203071410460.11036-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 7 Mar 2002, Ralf Baechle wrote:
> On Wed, Mar 06, 2002 at 12:25:11PM -0500, Marc Karasek wrote:
> > How many of you are involved with embedded linux development using a
> > MIPS processor? 
> > 
> > What endianess have you chosen for your project and why? 
> > 
> > If you have not guessed it, I am involved with a MIPS/Linux embedded
> > project and we are trying to determine if there are any pros or cons in
> > one endianess over the other.  
> 
> The MIPS ABI only covers big endian systems - every "real" MIPS UNIX
> system is big endian.  Everything else is a GNU extension.  There is
> hardly any reason to choose a particular byteorder as usually endianess
> swapping takes so little CPU time that it isn't even meassurable but so
> I'm told there are exceptions.  If portability of software you're
> going to write wrt. external data representation (disk or network) is
> of any importance then I suggest you use a system of the opposite
> endianess which trip problems much faster.

I really like the last part! ;-)

BTW, you forgot to mention to go for a full 64-bit port, to trip even more
problems faster :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
