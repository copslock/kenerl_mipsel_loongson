Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB8KkNh18072
	for linux-mips-outgoing; Sat, 8 Dec 2001 12:46:23 -0800
Received: from Cantor.suse.de (ns.suse.de [213.95.15.193])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB8KkJo18069
	for <linux-mips@oss.sgi.com>; Sat, 8 Dec 2001 12:46:19 -0800
Received: from Hermes.suse.de (Hermes.suse.de [213.95.15.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id 8FD221E71A; Sat,  8 Dec 2001 20:46:12 +0100 (MET)
Received: from gromit.moeb ([192.168.27.3] ident=postfix)
	by arthur.inka.de with esmtp (Exim 3.30 #1)
	id 16CnMn-0002Dp-00; Sat, 08 Dec 2001 20:42:33 +0100
Received: by gromit.moeb (Postfix, from userid 207)
	id 32C621EA2F; Sat,  8 Dec 2001 20:42:32 +0100 (CET)
Mail-Copies-To: never
To: Daniel Jacobowitz <dan@debian.org>
Cc: Guido Guenther <guido.guenther@gmx.net>, linux-mips@oss.sgi.com
Subject: Re: understanding elf_machine_load_address
References: <20011208141141.GA11437@bogon.ms20.nix>
	<u8n10tg2oy.fsf@gromit.moeb> <20011208114713.A20432@nevyn.them.org>
From: Andreas Jaeger <aj@suse.de>
Date: Sat, 08 Dec 2001 20:42:32 +0100
In-Reply-To: <20011208114713.A20432@nevyn.them.org> (Daniel Jacobowitz's
 message of "Sat, 8 Dec 2001 11:47:13 -0500")
Message-ID: <u8g06lfqhj.fsf@gromit.moeb>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.4 (Artificial
 Intelligence, i386-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Daniel Jacobowitz <dan@debian.org> writes:

> On Sat, Dec 08, 2001 at 04:18:53PM +0100, Andreas Jaeger wrote:
>> >        "	bltzal $0, here\n"
>> >        "	nop\n"
>> >        "here:	subu %0, $31, %0\n"
>> 
>> Subtract shared address of "here" from address of "here" at build time
>> - and you know at which address byte 0 of the shared library is
>>   loaded.
>
> Wait a second.  Does bltzal fill in $31 even on a not-taken branch? 
> Because bltzal $0 should never be taken.  My handy MIPS reference and
> SPIM seem to agree that it won't fill in $31.

That's what I've asked myself also when fixing the dynamic linker.
But Ralf convinced me that $31 will get filled in (and I verified that
it did) - otherwise the dynamic linker would not work on any system at
all.

But it might be worth checking if Guido notices a problem.

Btw. could anybody send me a patch documenting this instruction so
that next time everybody knows directly what's going on?

Thanks,
Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
