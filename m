Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jan 2004 22:01:58 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:51102 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225269AbUAIWB5>;
	Fri, 9 Jan 2004 22:01:57 +0000
Received: from teasel.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i09M1mQF014512;
	Fri, 9 Jan 2004 23:01:48 +0100 (MET)
Received: (from dimitri@localhost)
	by teasel.sonytel.be (8.9.3+Sun/8.9.3) id XAA03360;
	Fri, 9 Jan 2004 23:01:49 +0100 (MET)
Date: Fri, 9 Jan 2004 23:01:48 +0100
From: Dimitri Torfs <dimitri@sonycom.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: Support for newer gcc/gas options
Message-ID: <20040109220148.GA3314@sonycom.com>
References: <20031223114644.GA5458@sonycom.com> <Pine.LNX.4.55.0312231303030.27594@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0312231303030.27594@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <dimitri@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3892
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dimitri@sonycom.com
Precedence: bulk
X-list: linux-mips

On Tue, Dec 23, 2003 at 01:05:29PM +0100, Maciej W. Rozycki wrote:
> On Tue, 23 Dec 2003, Dimitri Torfs wrote:
> 
> >   I just upgraded to the arch/mips/Makefile which adds support for newer
> >   gcc/gas options. I now get the warning
> > 
> >   "cc1: warning: The -march option is incompatible to -mipsN and therefore
> > +ignored."
> > 
> >   when compiling. I have the CONFIG_CPU_VR41XX option set, which sets
> >   the c-flags to:
> > 
> >   "-I /home/dimitri/work/linux/include/asm/gcc -G 0 -mno-abicalls
> >   -fno-pic -pipe  -finline-limit=100000 -mabi=32 -march=r4100 -mips3
> >   -Wa,-32 -Wa,-march=r4100 -Wa,-mips3 -Wa,--trap"
> > 
> >   I suppose that for the newer gcc versions only -march= should be
> >   set (I'm using gcc-3.2.2) ?
> 
>  Thanks for the report -- I suppose we can remove "-mips" whenever
> "-mabi=" is supported by gcc.  I'll do an update in January after I am 
> back from vacation.

Tried removing the -mips3 gcc option => -D_MIPS_ISA=_MIPS_ISA_MIPS1 is
set. I think it might be better to use "-mtune=<cpu> -mipsN". That
seems to set the correct options, without any warnings (using gcc
3.2.2). After having carefully read the gcc documentation (again)
regarding the MIPS options, I think that's the way to go for newer
gcc's as well. If anyone has already tried ?



Dimitri



-- 
Dimitri Torfs       |  NSCE 
dimitri@sonycom.com |  The Corporate Village
tel: +32 2 7008541  |  Da Vincilaan 7 - D1 
fax: +32 2 7008622  |  B-1935 Zaventem - Belgium
