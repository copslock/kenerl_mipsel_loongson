Received:  by oss.sgi.com id <S42258AbQGRVsh>;
	Tue, 18 Jul 2000 14:48:37 -0700
Received: from u-87.karlsruhe.ipdial.viaginterkom.de ([62.180.21.87]:50949
        "EHLO u-87.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42257AbQGRVsU>; Tue, 18 Jul 2000 14:48:20 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S640296AbQGRDXJ>;
        Tue, 18 Jul 2000 05:23:09 +0200
Date:   Tue, 18 Jul 2000 05:23:09 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     wrasman@cs.utk.edu
Cc:     linux-mips@oss.sgi.com
Subject: Re: Okay, lost
Message-ID: <20000718052309.B12440@bacchus.dhis.org>
References: <20000717205303.A14220@enchanted.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000717205303.A14220@enchanted.net>; from awrasman@enchanted.net on Mon, Jul 17, 2000 at 08:53:03PM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Jul 17, 2000 at 08:53:03PM -0500, A. Wrasman wrote:

> Okay, I can't seem to get any of the pre-compiled linux kernels  after the 2.2.14 one on oss.sgi.com to boot on my Indy.
> 
> I get this type of error:
> Exception: <vector=Normal>
> Status register: 0x10044803<CU0,CH,IM7,IM4,IPL=???,MODE=KERNEL,EXL,IE>
> Cause register: 0x8034<CE=0,IP8,EXC=TRAP>
> Exception PC: 0x88240004, Exception RA: 0x8816d610
> Processor Trap exception at address 0xffffffff
> Local I/O interrupt register 1: 0x80 <VR/GIO2>
> 	Saved user regs in hex (&gpda 0xa8740e48, &_regs 0xa8741048):
> 	arg: a8740000 28 8847ff80 a
> 	tmp: a8740000 8480 88002000 8480 881932a0 1 fffffffc 47dfa8
> 	sve: a8740000 0 0 0 0 0 0 0
> 	t8 a8740000 t9 0 at 0 v0 0 v1 0 k1 88002000
> 	gp a8740000 fp 0 sp 0 ra 0
> 
> PANIC: unexpected exception

Now that looks like a kernel compiled by somebody who doesn't read
documentation, see http://oss.sgi.com/mips/mips-howto.html.  In short:
remove the -N linker flag from arch/mips/Makefile.

  Ralf
