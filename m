Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Oct 2004 19:31:21 +0100 (BST)
Received: from p508B7611.dip.t-dialin.net ([IPv6:::ffff:80.139.118.17]:3878
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225242AbUJSSbP>; Tue, 19 Oct 2004 19:31:15 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i9JIV66q013830;
	Tue, 19 Oct 2004 20:31:06 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i9JIV5ps013829;
	Tue, 19 Oct 2004 20:31:05 +0200
Date: Tue, 19 Oct 2004 20:31:05 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Thomas Koeller <thomas.koeller@baslerweb.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-mips@linux-mips.org
Subject: Re: ioremap() and CONFIG_SWAP_IO_SPACE
Message-ID: <20041019183105.GB9379@linux-mips.org>
References: <200408251130.53865.thomas.koeller@baslerweb.com> <Pine.GSO.4.58.0408251131020.18759@waterleaf.sonytel.be> <200410191245.59878.thomas.koeller@baslerweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410191245.59878.thomas.koeller@baslerweb.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6108
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 19, 2004 at 12:45:59PM +0200, Thomas Koeller wrote:

> Well, the ioremap() man page uses the term 'bus memory';
> there is no reference to PCI at all. I guess there could
> be multiple buses on one machine with different byte swapping
> requirements? There is also an article written by alan cox
> (http://www.kernelnewbies.org/documents/kdoc/deviceiobook.pdf)
> that describes ioremap() as a general mechanism of accessing
> memory-mapped io devices, with no reference to PCI at all.
> 
> Anyway, if ioremap() and readx()/writex() are for PCI memory
> access only, how am I supposed to access memory-mapped io
> devices that are not on a PCI bus?

If the standard readX() / writeX() functions don't suffice for some reason
then a bus specific versions in a separate header file are needed.

An example are the ISA versions.  For compatibility with super old
versions from before ioremap or where things on i386 at least seemed to
work without ioremap a special isa_readX() / isa_writeX() is supplied.
Again for compatibility reasons these macros are defined in <asm/io.h>,
not in a separate header file.

> Basler Vision Technologies
> An der Strusbek 60-62
> 22926 Ahrensburg
> Germany

Oh, not in Basel :-)

  Ralf
