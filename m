Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5Q7utQ21873
	for linux-mips-outgoing; Tue, 26 Jun 2001 00:56:55 -0700
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5Q7uqV21867
	for <linux-mips@oss.sgi.com>; Tue, 26 Jun 2001 00:56:53 -0700
Received: from mullein.sonytel.be (mullein.sonytel.be [10.34.64.30])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id JAA24293;
	Tue, 26 Jun 2001 09:56:14 +0200 (MET DST)
Date: Tue, 26 Jun 2001 09:56:14 +0200 (MEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Florian Lohoff <flo@rfc822.org>
cc: Barry Wu <wqb123@yahoo.com>, linux-mips@oss.sgi.com
Subject: Re: about linux mips ext2fs
In-Reply-To: <20010625202030.B701@paradigm.rfc822.org>
Message-ID: <Pine.GSO.4.21.0106260955210.3943-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 25 Jun 2001, Florian Lohoff wrote:
> Linux/mips uses ext2 - Ext2 is per definition little endian and all
> big endian targets use byteswap mechanisms (All but very old Linux/m68k
> systems). So - yes - you can read i386 written ext2 on mips machines.

All but very old Linux/m68k and Linux/PPC systems.

If you insist on booting such old kernels, `man e2fsck' for the flag to change
the endianness.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
