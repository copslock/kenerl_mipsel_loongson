Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 May 2003 15:30:01 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:37341 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225222AbTEPO35>; Fri, 16 May 2003 15:29:57 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA06741;
	Fri, 16 May 2003 16:30:36 +0200 (MET DST)
Date: Fri, 16 May 2003 16:30:36 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: linux-mips@linux-mips.org
Subject: Re: 2.5.x on Indy r4600
In-Reply-To: <20030516134611.GH27494@lug-owl.de>
Message-ID: <Pine.GSO.3.96.1030516161253.6533A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2401
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 16 May 2003, Jan-Benedict Glaw wrote:

> I'm currently tryin' to get 2.5.x running on MIPS (for background,
> please read http://www.lug-owl.de/~jbglaw/linux-ports/ ). I got current
> CVS HEAD to build (with minor tweaks), but my Indy doesn't completely
> load the kernel (via tftp). It starts loading the kernel, but TFTP
> packet #3810 (containing bytes 1950208..1950719 resp. 1dc200..1dc3ff
> from the kernel file) gets NACKed with error (5), code 3 (wrt. ethereal,
> this is "Disk full or allocation exceeded"). After this, the box seems to
> be completely dead: no serial break, no power button, no reset
> button...).
[...]
> Sections:
> Idx Name          Size      VMA       LMA       File off  Algn
[...]
>  14 .init.ramfs   00000080  881de000  881de000  001dc000  2**0
>                   CONTENTS, ALLOC, LOAD, DATA
>  15 .sbss         00000010  881df000  881df000  001dd000  2**3
>                   ALLOC
>  16 .bss          0003b620  881df020  881df020  001dd010  2**5
>                   ALLOC
>  17 .comment      00003e08  8821a640  8821a640  001dd010  2**0
>                   CONTENTS, READONLY
>  18 .pdr          0002b1e0  00000000  00000000  001e0e18  2**2
>                   CONTENTS, READONLY
>  19 .mdebug.abi32 00000000  00000000  00000000  0020bff8  2**0
>                   CONTENTS, READONLY

 Hmm, the NACK is reasonable as probably nothing beyond 1dc07f is loadable
-- `objdump -p' would determine it definitely.  Better yet, please try
`readelf -Sl', which reports additional data beyond what's obtainable with
`objdump'.  But why that unloadable data is requested at all? 

 There is something strange about the .comment section -- it's not
allocatable, yet it has addresses set.  Anyway, it need not be relevant
here as section headers are not interpreted by your boot loader.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
