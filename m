Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBJJ9q609710
	for linux-mips-outgoing; Wed, 19 Dec 2001 11:09:52 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fBJJ9lo09705
	for <linux-mips@oss.sgi.com>; Wed, 19 Dec 2001 11:09:48 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fBJGll615413;
	Wed, 19 Dec 2001 14:47:47 -0200
Date: Wed, 19 Dec 2001 14:47:47 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jun Sun <jsun@mvista.com>, Jim Paris <jim@jtan.com>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: [ppopov@mvista.com: Re: [Linux-mips-kernel]ioremap & ISA]
Message-ID: <20011219144747.D1181@dea.linux-mips.net>
References: <3C1F9608.E4E32E18@mvista.com> <Pine.GSO.4.21.0112191031270.28694-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0112191031270.28694-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Wed, Dec 19, 2001 at 10:34:37AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Dec 19, 2001 at 10:34:37AM +0100, Geert Uytterhoeven wrote:

> > >         set_io_port_base(0xb4000000);
> > >         isa_slot_offset = 0xb0000000;
> > 
> > I see.  So isa_slot_offset is for isa_read/isa_write, although I still don't
> > see what kind of drivers would use isa_read/isa_write.
> 
> E.g. VGA and ISA NVRAM.

Correct.  And much much more, the whole PC insanity.  There are plenty of
MIPS systems that are essentially PCs with a MIPS CPU glued on so you get
all the fun, ISA, EISA, VLB etc.  Barf bag technology.

  Ralf
