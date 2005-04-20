Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Apr 2005 13:23:23 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:15879 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226086AbVDTMXI>; Wed, 20 Apr 2005 13:23:08 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id BC789F59C0; Wed, 20 Apr 2005 14:23:02 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 14944-04; Wed, 20 Apr 2005 14:23:02 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 7CF98E1C92; Wed, 20 Apr 2005 14:23:02 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j3KCN4sW015386;
	Wed, 20 Apr 2005 14:23:05 +0200
Date:	Wed, 20 Apr 2005 13:23:11 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: ieee754[sd]p_neg workaround
In-Reply-To: <20050420.174023.113589096.nemoto@toshiba-tops.co.jp>
Message-ID: <Pine.LNX.4.61L.0504201312520.7109@blysk.ds.pg.gda.pl>
References: <20050420.174023.113589096.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV version 0.83, clamav-milter version 0.83 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7773
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 20 Apr 2005, Atsushi Nemoto wrote:

> I have a long standing patch for FPU emulator to fix a segmentation
> fault in pow() library function.
> 
> Here is a test program to reproduce it.
> 
> main()
> {
> 	union {
> 		double d;
> 		struct {
> #ifdef __MIPSEB
> 			unsigned int high, low;
> #else
> 			unsigned int low, high;
> #endif
> 		} i;
> 	} x, y, z;
>         x.i.low = 0x00000000;
>         x.i.high = 0xfff00001;
>         y.i.low = 0x80000000;
>         y.i.high = 0xcff00000;
>         z.d = pow(x.d, y.d);
>         printf("%x %x\n", z.i.high, z.i.low);
>         return 0;
> }
> 
> 
> If you run this program, you will get segmentation fault (unless your
> FPU does not raise Unimplemented exception for NaN operands).  The
> segmentation fault is caused by endless recursion in __ieee754_pow().
> 
> It looks glibc's pow() assume unary '-' operation for any number
> (including NaN) always invert its sign bit.

 AFAICS, the IEEE 754 standard explicitly leaves interpretation of the 
sign bit for NaNs as unspecified.  Therefore our implementation is correct 
and its glibc that should be fixed instead.  Please file a bug report 
against glibc.

  Maciej
