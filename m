Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Jan 2004 01:19:47 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:6747
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225276AbUAJBTp>; Sat, 10 Jan 2004 01:19:45 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1Af7md-0008KS-00; Sat, 10 Jan 2004 02:19:23 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1Af7mc-0006LS-00; Sat, 10 Jan 2004 02:19:22 +0100
Date: Sat, 10 Jan 2004 02:19:22 +0100
To: Dimitri Torfs <dimitri@sonycom.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	linux-mips@linux-mips.org
Subject: Re: Support for newer gcc/gas options
Message-ID: <20040110011922.GA14930@rembrandt.csv.ica.uni-stuttgart.de>
References: <20031223114644.GA5458@sonycom.com> <Pine.LNX.4.55.0312231303030.27594@jurand.ds.pg.gda.pl> <20040109220148.GA3314@sonycom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040109220148.GA3314@sonycom.com>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3894
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Dimitri Torfs wrote:
[snip]
> >  Thanks for the report -- I suppose we can remove "-mips" whenever
> > "-mabi=" is supported by gcc.  I'll do an update in January after I am 
> > back from vacation.
> 
> Tried removing the -mips3 gcc option => -D_MIPS_ISA=_MIPS_ISA_MIPS1 is
> set. I think it might be better to use "-mtune=<cpu> -mipsN". That
> seems to set the correct options, without any warnings (using gcc
> 3.2.2). After having carefully read the gcc documentation (again)
> regarding the MIPS options, I think that's the way to go for newer
> gcc's as well. If anyone has already tried ?

The supposed way is to use -mabi=FOO -march=BAR, where BAR can also be
e.g. "mips3". This will choose the proper (probably generic) architecture
as well as the ISA defines. Btw, the ISA defines aren't used in the
kernel anymore.


Thiemo
