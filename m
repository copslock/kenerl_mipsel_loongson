Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2004 14:51:58 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:43214 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8224915AbUAUOv5>;
	Wed, 21 Jan 2004 14:51:57 +0000
Received: from teasel.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i0LEpMw1010434;
	Wed, 21 Jan 2004 15:51:22 +0100 (MET)
Received: (from dimitri@localhost)
	by teasel.sonytel.be (8.9.3+Sun/8.9.3) id PAA14329;
	Wed, 21 Jan 2004 15:51:20 +0100 (MET)
Date: Wed, 21 Jan 2004 15:51:20 +0100
From: Dimitri Torfs <dimitri@sonycom.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: Support for newer gcc/gas options
Message-ID: <20040121145120.GA14288@sonycom.com>
References: <20031223114644.GA5458@sonycom.com> <Pine.LNX.4.55.0312231303030.27594@jurand.ds.pg.gda.pl> <Pine.LNX.4.55.0401201332080.12841@jurand.ds.pg.gda.pl> <20040120204026.GA9470@sonycom.com> <Pine.LNX.4.55.0401211449170.11137@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0401211449170.11137@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <dimitri@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4079
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dimitri@sonycom.com
Precedence: bulk
X-list: linux-mips

On Wed, Jan 21, 2004 at 03:09:12PM +0100, Maciej W. Rozycki wrote:
> On Tue, 20 Jan 2004, Dimitri Torfs wrote:
> 
> > >  It took a bit longer than I planned, sorry.  Anyway, here are two
> > > functionally equivalent patches, for 2.4 and the head, that remove an ISA
> > > specification if a tool supports "-march=" and "-mabi=" at the same time.  
> > > Please try the appropriate one.
> > 
> > Tried the head one, it had some typos (patch follows). Unfortunately, as I wrote
> 
>  Oops, thanks for the correction -- as I still have only gcc 2.95.4, I
> wasn't able to see the typos immediately.
> 
> > earlier, gcc-3.2 doesn't set the ISA correctly when using -march=, so
> > it doesn't work for 3.2. 
> 
>  But do we care of the ISA?  I don't think so -- it's just a leftover from
> the days the MIPS world was less complicated.  If gcc 3.2 correctly emits
> code for the selected processor and obeys the selected ABI, then
> everything is fine.  Are the binaries correct?  If so, I'd like to apply
> the patch.

I actually had problems compiling when the -mips3 was not set. The
compiler choked on compiling some empty file, if I remember correctly.
I will try again later to see what exactly went wrong.

Dimitri



-- 
Dimitri Torfs       |  NSCE 
dimitri@sonycom.com |  The Corporate Village
tel: +32 2 7008541  |  Da Vincilaan 7 - D1 
fax: +32 2 7008622  |  B-1935 Zaventem - Belgium
