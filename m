Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Feb 2003 03:00:16 +0000 (GMT)
Received: from sonicwall.montavista.co.jp ([IPv6:::ffff:202.232.97.131]:47134
	"EHLO yuubin.montavista.co.jp") by linux-mips.org with ESMTP
	id <S8225207AbTBZDAP>; Wed, 26 Feb 2003 03:00:15 +0000
Received: from pudding.montavista.co.jp ([10.200.0.40])
	by yuubin.montavista.co.jp (8.12.5/8.12.5) with SMTP id h1Q36G44016051;
	Wed, 26 Feb 2003 12:06:17 +0900
Date: Wed, 26 Feb 2003 11:54:05 +0900
From: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: yoichi_yuasa@montavista.co.jp, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: Change -mcpu option for VR41xx
Message-Id: <20030226115405.057a61b9.yoichi_yuasa@montavista.co.jp>
In-Reply-To: <Pine.GSO.3.96.1030225135016.14659C-100000@delta.ds2.pg.gda.pl>
References: <20030225124850.32cfa6f5.yoichi_yuasa@montavista.co.jp>
	<Pine.GSO.3.96.1030225135016.14659C-100000@delta.ds2.pg.gda.pl>
Organization: MontaVista Software Japan, Inc.
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@montavista.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1562
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@montavista.co.jp
Precedence: bulk
X-list: linux-mips

On Tue, 25 Feb 2003 14:18:38 +0100 (MET)
"Maciej W. Rozycki" <macro@ds2.pg.gda.pl> wrote:

> On Tue, 25 Feb 2003, Yoichi Yuasa wrote:
> 
> > binutils -mcpu option for VR4100 series
> > 
> > 2.10:
> >         * VR4100
> >         * vr4100
> >         * 4100
> >         * mips64vr4100
> >         * r4100
> > 
> > 2.11:
> > 2.12:
> > 2.13:
> >         * VR4100
> >         * 4100
> >         * mips64vr4100
> >         * r4100
> 
>  They are case insensitive, which is why the redundancy was removed.
> 
> > In addition for the VR4100 series, there is an -m4100 option.
> 
>  Which is deprecated and scheduled for removal in the future.
> 
> > As for us, it is best to use the following option.
> > 
> > GCCFLAGS        += -mcpu=r4100 -mips2 -Wa,-m4100,--trap
> > 
> > Would you apply this patch to CVS?
> 
>  The trunk version of gas only supports "-m4100" and "vr4100" (but leading
> letters are dropped if no exact match happens) for "-mcpu=" (which is also
> deprecated), "-march=" and "-mtune=".  Additionally it supports "vr4111",
> "vr4111", "vr4120", "vr4130" and "vr4181".  I suggest you go for: 
> 
> GCCFLAGS	+= -mcpu=vr4100 -mips2 -Wa,--trap
> 
> for now as other options may trigger an error depending on the version of
> tools used ("-mcpu=" is passed down to gas).

With the following versions.
I cannot compile with an instruction peculiar to VR4100, if there is no -m4100.

GNU ld version 2.12.90.0.1 20020307
GNU ld version 2.12.1

We need to add -m4100 option.

GCCFLAGS	+= -mcpu=vr4100 -mips2 -Wa,-m4100,--trap

>  I think we'll soon have to cook up a run-time gcc check for what is
> accepted and use the "-march=" and "-mtune=" options preferably and
> failing that, revert to legacy options like above.

Thanks,

Yoichi
