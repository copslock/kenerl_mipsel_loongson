Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB8HV4Y15683
	for linux-mips-outgoing; Sat, 8 Dec 2001 09:31:04 -0800
Received: from Cantor.suse.de (ns.suse.de [213.95.15.193])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB8HUwo15680
	for <linux-mips@oss.sgi.com>; Sat, 8 Dec 2001 09:30:58 -0800
Received: from Hermes.suse.de (Hermes.suse.de [213.95.15.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id C2F5C1E6D2; Sat,  8 Dec 2001 17:30:46 +0100 (MET)
Received: from gromit.moeb ([192.168.27.3] ident=postfix)
	by arthur.inka.de with esmtp (Exim 3.30 #1)
	id 16CjFe-0001Pb-00; Sat, 08 Dec 2001 16:18:54 +0100
Received: by gromit.moeb (Postfix, from userid 207)
	id 9BB4F1EA2F; Sat,  8 Dec 2001 16:18:53 +0100 (CET)
Mail-Copies-To: never
To: Guido Guenther <guido.guenther@gmx.net>
Cc: linux-mips@oss.sgi.com
Subject: Re: understanding elf_machine_load_address
References: <20011208141141.GA11437@bogon.ms20.nix>
From: Andreas Jaeger <aj@suse.de>
Date: Sat, 08 Dec 2001 16:18:53 +0100
In-Reply-To: <20011208141141.GA11437@bogon.ms20.nix> (Guido Guenther's
 message of "Sat, 8 Dec 2001 15:11:42 +0100")
Message-ID: <u8n10tg2oy.fsf@gromit.moeb>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.4 (Artificial
 Intelligence, i386-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Guido Guenther <guido.guenther@gmx.net> writes:

> Hi,
> I'm trying to understand to following snippet from glibc's
> sysdeps/mips/dl-machine.h:

That one is really a bit tricky but it should be correct.

You should add the comment in front:
/* Return the run-time load address of the shared object.  */

> elf_machine_load_address (void)
> {
>   ElfW(Addr) addr;
>   asm ("	.set noreorder\n"
>        "	la %0, here\n"

load address this object has at build time (that's the address objdump
prints) and which is different than the current address (a shared
library can be loaded to any address and elf_machine_load_address is
called before relocation).

>        "	bltzal $0, here\n"
>        "	nop\n"
>        "here:	subu %0, $31, %0\n"

Subtract shared address of "here" from address of "here" at build time
- and you know at which address byte 0 of the shared library is
  loaded.

>        "	.set reorder\n"
>        :	"=r" (addr)
>        :	/* No inputs */
>        :	"$31");
>   return addr;
> }
>
> As of my understanding addr is zero since $31-%0 is always
> zero(%0 stored (before the subu) the address of 'here', as does $31
> after the bltzal). Please beat me with a cluebat.

Enough cluebat?

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
