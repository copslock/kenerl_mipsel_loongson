Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6J9QUh08810
	for linux-mips-outgoing; Thu, 19 Jul 2001 02:26:30 -0700
Received: from dea.waldorf-gmbh.de (u-243-10.karlsruhe.ipdial.viaginterkom.de [62.180.10.243])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6J9QRV08806
	for <linux-mips@oss.sgi.com>; Thu, 19 Jul 2001 02:26:27 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6J0IJX02419;
	Thu, 19 Jul 2001 02:18:19 +0200
Date: Thu, 19 Jul 2001 02:18:19 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-mips@oss.sgi.com,
   linux-mips@fnet.fr
Subject: Re: ll/sc emulation patch
Message-ID: <20010719021819.D1888@bacchus.dhis.org>
References: <20010714125312.A6713@bacchus.dhis.org> <Pine.GSO.3.96.1010716133926.12988B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010716133926.12988B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Jul 16, 2001 at 02:03:30PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jul 16, 2001 at 02:03:30PM +0200, Maciej W. Rozycki wrote:

>  I didn't profile it very extensively, yet when stracing `ls /usr/lib'
> (fileutils 4.1 linked against glibc 2.2.3) on my system once I yielded
> ~4500 syscalls of which ~4000 were _test_and_set() (or MIPS_ATOMIC_SET,
> depending on my kernel/glibc configuration) invocations.  Yes, libpthread
> appears to assume atomic operations are cheap, which is justifiable as
> they are indeed, for almost every other CPU type. 

On a fast Indy those 4000 syscalls would cost about 3.2ms of CPU which is
a noticable fraction of the total execution time.

>  Also I feel having ll and sc opcodes in a pure MIPS I binary is somewhat
> ugly (e.g. `objdump' won't disassemble them unless a MIPS II+ CPU is
> specified), but I could probably live with it if performance was not
> worse. 

This behaviour of objdump sucks rocks anyway.  There are MIPS I CPUs which
have ll but no branch likely and many other MIPS ISA perversions.  Objdump
also will only hexdump anything that hasn't been marked as code with
.type.  Seems objdump's behaviour was choosen to be the most annoying
possible.

  Ralf
