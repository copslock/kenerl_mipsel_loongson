Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Feb 2003 13:18:20 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:22219 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224939AbTBYNSU>; Tue, 25 Feb 2003 13:18:20 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA15579;
	Tue, 25 Feb 2003 14:18:39 +0100 (MET)
Date: Tue, 25 Feb 2003 14:18:38 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>
cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Change -mcpu option for VR41xx
In-Reply-To: <20030225124850.32cfa6f5.yoichi_yuasa@montavista.co.jp>
Message-ID: <Pine.GSO.3.96.1030225135016.14659C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1551
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 25 Feb 2003, Yoichi Yuasa wrote:

> binutils -mcpu option for VR4100 series
> 
> 2.10:
>         * VR4100
>         * vr4100
>         * 4100
>         * mips64vr4100
>         * r4100
> 
> 2.11:
> 2.12:
> 2.13:
>         * VR4100
>         * 4100
>         * mips64vr4100
>         * r4100

 They are case insensitive, which is why the redundancy was removed.

> In addition for the VR4100 series, there is an -m4100 option.

 Which is deprecated and scheduled for removal in the future.

> As for us, it is best to use the following option.
> 
> GCCFLAGS        += -mcpu=r4100 -mips2 -Wa,-m4100,--trap
> 
> Would you apply this patch to CVS?

 The trunk version of gas only supports "-m4100" and "vr4100" (but leading
letters are dropped if no exact match happens) for "-mcpu=" (which is also
deprecated), "-march=" and "-mtune=".  Additionally it supports "vr4111",
"vr4111", "vr4120", "vr4130" and "vr4181".  I suggest you go for: 

GCCFLAGS	+= -mcpu=vr4100 -mips2 -Wa,--trap

for now as other options may trigger an error depending on the version of
tools used ("-mcpu=" is passed down to gas).

 I think we'll soon have to cook up a run-time gcc check for what is
accepted and use the "-march=" and "-mtune=" options preferably and
failing that, revert to legacy options like above.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
