Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6LFNIp22578
	for linux-mips-outgoing; Sat, 21 Jul 2001 08:23:18 -0700
Received: from dea.waldorf-gmbh.de (u-154-19.karlsruhe.ipdial.viaginterkom.de [62.180.19.154])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6LFNFV22575
	for <linux-mips@oss.sgi.com>; Sat, 21 Jul 2001 08:23:16 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6LFN9L25832;
	Sat, 21 Jul 2001 17:23:09 +0200
Date: Sat, 21 Jul 2001 17:23:09 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Lars Munch Christensen <c948114@student.dtu.dk>
Cc: linux-mips@oss.sgi.com
Subject: Re: mips64 linker bug?
Message-ID: <20010721172309.A25467@bacchus.dhis.org>
References: <20010721112715.C2335@tuxedo.skovlyporten.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010721112715.C2335@tuxedo.skovlyporten.dk>; from c948114@student.dtu.dk on Sat, Jul 21, 2001 at 11:27:15AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Jul 21, 2001 at 11:27:15AM +0200, Lars Munch Christensen wrote:

> 0000000010000110 <$LM7>:
>         return 1;
>     10000110:   dfbf0000        0xdfbf0000
>     10000114:   24020001        li      $v0,1
>     10000118:   03e00008        jr      $ra
>     1000011c:   67bd0010        0x67bd0010
> 
> 
> When removing the static I get the correct address 100000f8 ?!?
> 
> Am I missing something.

Gas and ld of the published 64-bit binutils are entirely useless for 64-bit
code.  Various people are working on fixing that but that takes time,
especially the non-pic case is a bit hairy.

> btw why isn't everything disassembled?

Executive summary: because binutils is a stupid.  Technical answer, objdump
only disassembles MIPS I instructions by default.

  Ralf
