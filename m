Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1BN7IN17808
	for linux-mips-outgoing; Mon, 11 Feb 2002 15:07:18 -0800
Received: from dea.linux-mips.net (a1as09-p62.stg.tli.de [195.252.189.62])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1BN7E917805
	for <linux-mips@oss.sgi.com>; Mon, 11 Feb 2002 15:07:14 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1BM4RA05134;
	Mon, 11 Feb 2002 23:04:27 +0100
Date: Mon, 11 Feb 2002 23:04:27 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
Subject: Re: gcc include strangeness
Message-ID: <20020211230427.D4623@dea.linux-mips.net>
References: <20020209150155.GA853@paradigm.rfc822.org> <Pine.GSO.3.96.1020211134516.18917A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1020211134516.18917A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Feb 11, 2002 at 01:51:47PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Feb 11, 2002 at 01:51:47PM +0100, Maciej W. Rozycki wrote:

> > i just stumbled when i tried to compile a program (bootloader) with
> > gcc which uses varargs. I got the error that "sgidefs.h" was missing.
> > sgidefs.h is contained in the glibc which gets included by va-mips.h
> > from stdarg.h - I dont think this is correct as i should be able
> > to compile programs without glibc.
> 
>  Hmm, in 2.95.3 in va-mips.h I see: 
> 
> /* Get definitions for _MIPS_SIM_ABI64 etc.  */
> #ifdef _MIPS_SIM
> #include <sgidefs.h>
> #endif
> 
> so you shouldn't need sgidefs.h normally.  Or did something get broken for
> 3.x?

Gcc is supposed to define _MIPS_SIM.

  Ralf
