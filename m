Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Feb 2003 12:18:25 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:47594 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224851AbTBZMSY>; Wed, 26 Feb 2003 12:18:24 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA02064;
	Wed, 26 Feb 2003 13:18:40 +0100 (MET)
Date: Wed, 26 Feb 2003 13:18:40 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>
cc: ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: Change -mcpu option for VR41xx
In-Reply-To: <20030226115405.057a61b9.yoichi_yuasa@montavista.co.jp>
Message-ID: <Pine.GSO.3.96.1030226125853.1222B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1566
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 26 Feb 2003, Yoichi Yuasa wrote:

> >  The trunk version of gas only supports "-m4100" and "vr4100" (but leading
> > letters are dropped if no exact match happens) for "-mcpu=" (which is also
> > deprecated), "-march=" and "-mtune=".  Additionally it supports "vr4111",
> > "vr4111", "vr4120", "vr4130" and "vr4181".  I suggest you go for: 
> > 
> > GCCFLAGS	+= -mcpu=vr4100 -mips2 -Wa,--trap
> > 
> > for now as other options may trigger an error depending on the version of
> > tools used ("-mcpu=" is passed down to gas).
> 
> With the following versions.
> I cannot compile with an instruction peculiar to VR4100, if there is no -m4100.
> 
> GNU ld version 2.12.90.0.1 20020307
> GNU ld version 2.12.1
> 
> We need to add -m4100 option.
> 
> GCCFLAGS	+= -mcpu=vr4100 -mips2 -Wa,-m4100,--trap

 Strange, what does `gcc -v -mcpu=vr4100 -mips2 -Wa,--trap -xassembler -c
/dev/null -o /dev/null' say to you? 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
