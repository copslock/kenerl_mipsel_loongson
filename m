Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g27IvB212952
	for linux-mips-outgoing; Thu, 7 Mar 2002 10:57:11 -0800
Received: from mail.matriplex.com (ns1.matriplex.com [208.131.42.8])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g27Iux912944;
	Thu, 7 Mar 2002 10:56:59 -0800
Received: from mail.matriplex.com (mail.matriplex.com [208.131.42.9])
	by mail.matriplex.com (8.9.2/8.9.2) with ESMTP id JAA00578;
	Thu, 7 Mar 2002 09:56:58 -0800 (PST)
	(envelope-from rh@matriplex.com)
Date: Thu, 7 Mar 2002 09:56:58 -0800 (PST)
From: Richard Hodges <rh@matriplex.com>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Linux MIPS <linux-mips@oss.sgi.com>
Subject: Re: Questions?
In-Reply-To: <20020307140754.A1817@dea.linux-mips.net>
Message-ID: <Pine.BSF.4.10.10203070928100.351-100000@mail.matriplex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 7 Mar 2002, Ralf Baechle wrote:

> The MIPS ABI only covers big endian systems - every "real" MIPS UNIX
> system is big endian.  Everything else is a GNU extension.  There is
> hardly any reason to choose a particular byteorder as usually endianess
> swapping takes so little CPU time that it isn't even meassurable but so
> I'm told there are exceptions.

To me, byte swapping on MIPS actually seems rather expensive.  The code
for htonl (linux/byteorder/swab.h) ends up something like this:

        srl     $5,$4,8
        andi    $5,$5,0xff00
        srl     $2,$4,24
        andi    $3,$4,0xff00
        or      $2,$2,$5
        sll     $3,$3,8
        or      $2,$2,$3
        sll     $4,$4,24

This may not be an issue if it is only needed a few times per packet, but
my system must byte-swap (LE to BE) about 500KB (or 4mb) per second.
Actually, I save a bit of work by combining the byte swapping with the
memory move, just after copy_from_user, and looks something like:

    unsigned char a, b, c, d, *mptr;
	a = mptr[0];
	b = mptr[1];
	c = mptr[2];
	d = mptr[3];
	mptr[0] = d;
	mptr[1] = c;
	mptr[2] = b;
	mptr[3] = a;

This method works, but it is still 8 instructions per word.  Yuck!  Does
anyone know of a _decent_ way to handle this on MIPS?

All the best,

-Richard
