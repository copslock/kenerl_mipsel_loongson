Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5P8sVnC003118
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 25 Jun 2002 01:54:31 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5P8sVFH003117
	for linux-mips-outgoing; Tue, 25 Jun 2002 01:54:31 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (c-180-196-20.ka.dial.de.ignite.net [62.180.196.20])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5P8sMnC003112
	for <linux-mips@oss.sgi.com>; Tue, 25 Jun 2002 01:54:24 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g5P8saR16545;
	Tue, 25 Jun 2002 10:54:36 +0200
Date: Tue, 25 Jun 2002 10:54:36 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Guido Guenther <agx@sigxcpu.org>, linux-mips@oss.sgi.com
Subject: Re: 2.4.18: pgtable.h compile fix
Message-ID: <20020625105436.A16439@dea.linux-mips.net>
References: <20020624153330.C28145@dea.linux-mips.net> <Pine.GSO.3.96.1020624174346.22509N-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1020624174346.22509N-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Jun 24, 2002 at 05:54:28PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jun 24, 2002 at 05:54:28PM +0200, Maciej W. Rozycki wrote:

> > >  MIPS64 lags behind a bit due to less interest/testing.  Note that you
> > > should use "__ASSEMBLY__" to guard assembly-unsafe parts of headers.
> > 
> > _LANGUAGE_ASSEMBLY is the traditional MIPS cpp symbol to indicate assembler
> > source code.
> 
>  Well, but the rest of the kernel uses "__ASSEMBLY__", that's defined in
> the top-level Makefile.  What's the point in being different? 
> 
>  Also it doesn't seem to work for me -- the rules in specs look broken:
> 
> $ mipsel-linux-gcc -E -dM -xassembler-with-cpp /dev/null | grep LANGUAGE
> #define __LANGUAGE_C 1
> #define _LANGUAGE_C 1
> #define LANGUAGE_C 1
> 
> thus it cannot be considered reliable.

The machanism guesses the language based on the source file name extension:

[ralf@dea tmp]$ echo -n > c.c && mips-linux-gcc -E -dM -xassembler-with-cpp c.c | grep LANG
#define __LANGUAGE_C 1 
#define _LANGUAGE_C 1 
#define LANGUAGE_C 1 
[ralf@dea tmp]$ echo -n > c.S && mips-linux-gcc -E -dM c.S | grep LANG
#define LANGUAGE_ASSEMBLY 1 
#define _LANGUAGE_ASSEMBLY 1 
#define __LANGUAGE_ASSEMBLY 1 
[ralf@dea tmp]$

Buggy?  Yes ...

  Ralf
