Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBJAYvV05087
	for linux-mips-outgoing; Wed, 19 Dec 2001 02:34:57 -0800
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBJAYpo05083;
	Wed, 19 Dec 2001 02:34:51 -0800
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id KAA12276;
	Wed, 19 Dec 2001 10:34:37 +0100 (MET)
Date: Wed, 19 Dec 2001 10:34:37 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jun Sun <jsun@mvista.com>
cc: Ralf Baechle <ralf@oss.sgi.com>, Jim Paris <jim@jtan.com>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: [ppopov@mvista.com: Re: [Linux-mips-kernel]ioremap & ISA]
In-Reply-To: <3C1F9608.E4E32E18@mvista.com>
Message-ID: <Pine.GSO.4.21.0112191031270.28694-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 18 Dec 2001, Jun Sun wrote:
> Ralf Baechle wrote:
> > Therefore:
> > 
> >         set_io_port_base(0xb4000000);
> >         isa_slot_offset = 0xb0000000;
> > 
> 
> I see.  So isa_slot_offset is for isa_read/isa_write, although I still don't
> see what kind of drivers would use isa_read/isa_write.

E.g. VGA and ISA NVRAM.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
