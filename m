Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Oct 2004 11:42:22 +0100 (BST)
Received: from [IPv6:::ffff:145.253.187.134] ([IPv6:::ffff:145.253.187.134]:44749
	"EHLO mail01.baslerweb.com") by linux-mips.org with ESMTP
	id <S8224897AbUJSKmQ>; Tue, 19 Oct 2004 11:42:16 +0100
Received: from mail01.baslerweb.com (localhost.localdomain [127.0.0.1])
	by localhost.domain.tld (Basler) with ESMTP
	id 937A6134091; Tue, 19 Oct 2004 12:41:30 +0200 (CEST)
Received: from comm1.baslerweb.com (unknown [172.16.13.2])
	by mail01.baslerweb.com (Basler) with ESMTP
	id 90EF7134090; Tue, 19 Oct 2004 12:41:30 +0200 (CEST)
Received: from vclinux-1.basler.corp (localhost [172.16.13.253]) by comm1.baslerweb.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id 4YRPLTSV; Tue, 19 Oct 2004 12:42:02 +0200
From: Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: ioremap() and CONFIG_SWAP_IO_SPACE
Date: Tue, 19 Oct 2004 12:45:59 +0200
User-Agent: KMail/1.6.2
Cc: linux-mips@linux-mips.org
References: <200408251130.53865.thomas.koeller@baslerweb.com> <Pine.GSO.4.58.0408251131020.18759@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.58.0408251131020.18759@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Disposition: inline
X-UID: 1330
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410191245.59878.thomas.koeller@baslerweb.com>
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6098
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

On Wednesday 25 August 2004 11:32, Geert Uytterhoeven wrote:
> On Wed, 25 Aug 2004, Thomas Koeller wrote:
> > my platform (PMC-Sierra Yosemite in big endian mode),
> > like many others, uses ioremap() to map device
> > registers, such as the RM9000's OCD registers.
> > To access those registers, the return value of
> > ioremap() is casted to a suitable pointer type and
> > dereferenced. This of course works, but the return
> > value of ioremap() is documented not to be a
> > directly dereferenceable pointer value, and accesses
> > to ioremapped addresses should be performed using
> > the readx/writex APIs.
>
> In theory, ioremap() and readb() and friends are meant for PCI memory space
> only. RM9000's OCD registers are not PCI memory space, so there's no strict
> guarantee readb() and friends will actually work.
>

Well, the ioremap() man page uses the term 'bus memory';
there is no reference to PCI at all. I guess there could
be multiple buses on one machine with different byte swapping
requirements? There is also an article written by alan cox
(http://www.kernelnewbies.org/documents/kdoc/deviceiobook.pdf)
that describes ioremap() as a general mechanism of accessing
memory-mapped io devices, with no reference to PCI at all.

Anyway, if ioremap() and readx()/writex() are for PCI memory
access only, how am I supposed to access memory-mapped io
devices that are not on a PCI bus?

Thomas
-- 
--------------------------------------------------

Thomas Koeller, Software Development

Basler Vision Technologies
An der Strusbek 60-62
22926 Ahrensburg
Germany

Tel +49 (4102) 463-390
Fax +49 (4102) 463-46390

mailto:thomas.koeller@baslerweb.com
http://www.baslerweb.com

==============================
