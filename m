Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g13JcUj03259
	for linux-mips-outgoing; Sun, 3 Feb 2002 11:38:30 -0800
Received: from dea.linux-mips.net (a1as09-p51.stg.tli.de [195.252.189.51])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g13JcQA03256
	for <linux-mips@oss.sgi.com>; Sun, 3 Feb 2002 11:38:26 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g13IbHY06652;
	Sun, 3 Feb 2002 19:37:17 +0100
Date: Sun, 3 Feb 2002 19:37:17 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@oss.sgi.com
Subject: Re: CVS Update@oss.sgi.com: linux
Message-ID: <20020203193717.B6317@dea.linux-mips.net>
References: <200202022138.g12LcZU24388@oss.sgi.com> <Pine.GSO.3.96.1020203191613.20409B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1020203191613.20409B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Sun, Feb 03, 2002 at 07:18:01PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Feb 03, 2002 at 07:18:01PM +0100, Maciej W. Rozycki wrote:

> > Log message:
> > 	i8259.c assumes that i8259 are interrupt 0 to 15.  Change DDB5476
> > 	code accordingly.
> 
>  Hmm, the assumption might be justifiable for the i386 only?  Shouldn't
> i8259.c be fixed instead? 

These are the ISA interrupts; many drivers make assumptions about the
interrupts numbers, so we can't really change the numbers anyway.  For
any non-ISA interrupt it's number can be choosen freely.

  Ralf
