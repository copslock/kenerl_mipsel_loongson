Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Feb 2003 01:47:22 +0000 (GMT)
Received: from sonicwall.montavista.co.jp ([IPv6:::ffff:202.232.97.131]:14435
	"EHLO yuubin.montavista.co.jp") by linux-mips.org with ESMTP
	id <S8225213AbTB0BrV>; Thu, 27 Feb 2003 01:47:21 +0000
Received: from pudding.montavista.co.jp ([10.200.0.40])
	by yuubin.montavista.co.jp (8.12.5/8.12.5) with SMTP id h1R1rn44000730;
	Thu, 27 Feb 2003 10:53:49 +0900
Date: Thu, 27 Feb 2003 10:41:19 +0900
From: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: yoichi_yuasa@montavista.co.jp, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: Change -mcpu option for VR41xx
Message-Id: <20030227104119.4fb8b07e.yoichi_yuasa@montavista.co.jp>
In-Reply-To: <Pine.GSO.3.96.1030226125853.1222B-100000@delta.ds2.pg.gda.pl>
References: <20030226115405.057a61b9.yoichi_yuasa@montavista.co.jp>
	<Pine.GSO.3.96.1030226125853.1222B-100000@delta.ds2.pg.gda.pl>
Organization: MontaVista Software Japan, Inc.
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@montavista.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1568
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@montavista.co.jp
Precedence: bulk
X-list: linux-mips

On Wed, 26 Feb 2003 13:18:40 +0100 (MET)
"Maciej W. Rozycki" <macro@ds2.pg.gda.pl> wrote:

> On Wed, 26 Feb 2003, Yoichi Yuasa wrote:
> 
> > >  The trunk version of gas only supports "-m4100" and "vr4100" (but leading
> > > letters are dropped if no exact match happens) for "-mcpu=" (which is also
> > > deprecated), "-march=" and "-mtune=".  Additionally it supports "vr4111",
> > > "vr4111", "vr4120", "vr4130" and "vr4181".  I suggest you go for: 
> > > 
> > > GCCFLAGS	+= -mcpu=vr4100 -mips2 -Wa,--trap
> > > 
> > > for now as other options may trigger an error depending on the version of
> > > tools used ("-mcpu=" is passed down to gas).
> > 
> > With the following versions.
> > I cannot compile with an instruction peculiar to VR4100, if there is no -m4100.
> > 
> > GNU ld version 2.12.90.0.1 20020307
> > GNU ld version 2.12.1
> > 
> > We need to add -m4100 option.
> > 
> > GCCFLAGS	+= -mcpu=vr4100 -mips2 -Wa,-m4100,--trap
> 
>  Strange, what does `gcc -v -mcpu=vr4100 -mips2 -Wa,--trap -xassembler -c
> /dev/null -o /dev/null' say to you? 

$ mipsel-linux-gcc -v -mcpu=vr4100 -mips2 -Wa,--trap -xassembler -c /dev/null -o /dev/null
Reading specs from /usr/local/lib/gcc-lib/mipsel-linux/2.95.4/specs
gcc version 2.95.4 20011002 (Debian prerelease)
 /usr/local/mipsel-linux/bin/as -EL -mips2 -mcpu=vr4100 -v -KPIC --trap -o /dev/null /dev/null
GNU assembler version 2.12.90.0.1 (mipsel-linux) using BFD version 2.12.90.0.1 20020307 Debian/GNU Linux

Yoichi
