Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3K93Jqf008144
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 20 Apr 2002 02:03:19 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3K93Ihg008143
	for linux-mips-outgoing; Sat, 20 Apr 2002 02:03:18 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3K93Dqf008140
	for <linux-mips@oss.sgi.com>; Sat, 20 Apr 2002 02:03:14 -0700
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id LAA25676;
	Sat, 20 Apr 2002 11:03:27 +0200 (MET DST)
Date: Sat, 20 Apr 2002 11:03:26 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Wayne Gowcher <wgowcher@yahoo.com>
cc: Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: Equivalent of ioperm / iopl in linux mips ?
In-Reply-To: <20020419170605.41020.qmail@web11906.mail.yahoo.com>
Message-ID: <Pine.GSO.4.21.0204201102260.16742-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 19 Apr 2002, Wayne Gowcher wrote:
> I would like to access Io ports from a user land
> application. I found a MINI HOWTO giving an exmaple
> using ioperm / iopl and then outb, inb. Searching the
> mips source code I see that sys_ioperm returns
> "ENOSYS" function not implemented.
> 
> Does anyone know how to implement ioperm / iopl type
> functionality on a mips system. Any example code would
> be appreciated.

Like on most architectures that use memory mapped I/O: mmap() the relevant
portion of /dev/mem and read/write to/from the mapped area.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
