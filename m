Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2004 18:35:56 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:59523 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8224987AbUAUSf4>;
	Wed, 21 Jan 2004 18:35:56 +0000
Received: from teasel.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i0LIZrw1007880;
	Wed, 21 Jan 2004 19:35:53 +0100 (MET)
Received: (from dimitri@localhost)
	by teasel.sonytel.be (8.9.3+Sun/8.9.3) id TAA21510;
	Wed, 21 Jan 2004 19:35:51 +0100 (MET)
Date: Wed, 21 Jan 2004 19:35:51 +0100
From: Dimitri Torfs <dimitri@sonycom.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: Support for newer gcc/gas options
Message-ID: <20040121183551.GA21411@sonycom.com>
References: <20031223114644.GA5458@sonycom.com> <Pine.LNX.4.55.0312231303030.27594@jurand.ds.pg.gda.pl> <Pine.LNX.4.55.0401201332080.12841@jurand.ds.pg.gda.pl> <20040120204026.GA9470@sonycom.com> <Pine.LNX.4.55.0401211449170.11137@jurand.ds.pg.gda.pl> <20040121145120.GA14288@sonycom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040121145120.GA14288@sonycom.com>
User-Agent: Mutt/1.4.1i
Return-Path: <dimitri@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4083
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dimitri@sonycom.com
Precedence: bulk
X-list: linux-mips

On Wed, Jan 21, 2004 at 03:51:20PM +0100, Dimitri Torfs wrote:
> On Wed, Jan 21, 2004 at 03:09:12PM +0100, Maciej W. Rozycki wrote:
> >  But do we care of the ISA?  I don't think so -- it's just a leftover from
> > the days the MIPS world was less complicated.  If gcc 3.2 correctly emits
> > code for the selected processor and obeys the selected ABI, then
> > everything is fine.  Are the binaries correct?  If so, I'd like to apply
> > the patch.
> 
> I actually had problems compiling when the -mips3 was not set. The
> compiler choked on compiling some empty file, if I remember correctly.
> I will try again later to see what exactly went wrong.

Compiler choked on the first file it tries to compile: gcc added
-mips1 automatically to the as command line which conflicts with the
-Wa,--trap option:

/usr/local/lib/gcc-lib/mips-linux/3.2.2/../../../../mips-linux/bin/as
 -G 0 -O2 -g0 -32 -march=r4100 -v -mips1 -non_shared -32 -march=r4100
 --trap -o scripts/.tmp_empty.o -
Assembler messages:
Error: trap exception not supported at ISA 1

Removing the line which unsets the gas_isa option makes it work again:
/usr/local/lib/gcc-lib/mips-linux/3.2.2/../../../../mips-linux/bin/as
-G 0 -O2 -g0 -32 -march=r4100 -v -mips1 -non_shared -32 -march=r4100
-mips3 --trap -o scripts/.tmp_empty.o

Dimitri


-- 
Dimitri Torfs       |  NSCE 
dimitri@sonycom.com |  The Corporate Village
tel: +32 2 7008541  |  Da Vincilaan 7 - D1 
fax: +32 2 7008622  |  B-1935 Zaventem - Belgium
