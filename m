Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0UJkTc18786
	for linux-mips-outgoing; Wed, 30 Jan 2002 11:46:29 -0800
Received: from ns1.ltc.com (vsat-148-63-243-254.c3.sb4.mrt.starband.net [148.63.243.254])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0UJkKd18782
	for <linux-mips@oss.sgi.com>; Wed, 30 Jan 2002 11:46:21 -0800
Received: from prefect (unknown [10.1.1.86])
	by ns1.ltc.com (Postfix) with SMTP
	id AB315590AB; Wed, 30 Jan 2002 13:38:48 -0500 (EST)
Message-ID: <082201c1a9be$81198be0$5601010a@prefect>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   "Geoffrey Espin" <espin@idiom.com>
Cc: "Steven J. Hill" <sjhill@cotw.com>, <linux-mips@oss.sgi.com>
References: <Pine.GSO.3.96.1020130193233.8443D-100000@delta.ds2.pg.gda.pl>
Subject: Re: [PATCH] Compiler warnings and remove unused code....
Date: Wed, 30 Jan 2002 13:46:58 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I think --noinhibit-exec worked for me as a temporary measure until I
upgraded the kernel.

Regards,
Brad

----- Original Message -----
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Geoffrey Espin" <espin@idiom.com>
Cc: "Steven J. Hill" <sjhill@cotw.com>; <linux-mips@oss.sgi.com>
Sent: Wednesday, January 30, 2002 1:35 PM
Subject: Re: [PATCH] Compiler warnings and remove unused code....


> On Wed, 30 Jan 2002, Geoffrey Espin wrote:
>
> > drivers/char/char.o(.data+0x3958): undefined reference to `local symbols
in discarded section .text.exit'
> > drivers/net/net.o(.data+0x17c): undefined reference to `local symbols in
discarded section .text.exit'
> > drivers/usb/usbdrv.o(.data+0x4b0): undefined reference to `local symbols
in discarded section .text.exit'
> > make: *** [vmlinux] Error 1
> >
> >
> > This is linux.2.4.16 + sourceforge/mipslinux (a few weeks old).
>
>  These errors are not MIPS-specific.  They were introduced by a stricter
> symbol checking in recent binutils.  Many of them (but possibly not all)
> are removed in Linux 2.4.17.  Please try the current version and see if
> they persist.
>
> --
> +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
> +--------------------------------------------------------------+
> +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
>
