Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Feb 2004 01:16:25 +0000 (GMT)
Received: from p508B619B.dip.t-dialin.net ([IPv6:::ffff:80.139.97.155]:39742
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225474AbUBNBQZ>; Sat, 14 Feb 2004 01:16:25 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i1E1Fhex004631;
	Sat, 14 Feb 2004 02:15:43 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i1E1FdYY004630;
	Sat, 14 Feb 2004 02:15:39 +0100
Date: Sat, 14 Feb 2004 02:15:39 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: David Daney <ddaney@avtrex.com>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	linux-mips@linux-mips.org
Subject: Re: [patch] Prevent dead code/data removal with gcc 3.4
Message-ID: <20040214011539.GB31847@linux-mips.org>
References: <Pine.LNX.4.55.0402131453360.15042@jurand.ds.pg.gda.pl> <20040213145316.GA23810@linux-mips.org> <20040213222253.GA20118@rembrandt.csv.ica.uni-stuttgart.de> <402D513F.8080205@avtrex.com> <20040213224959.GB20118@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040213224959.GB20118@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4359
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Feb 13, 2004 at 11:50:00PM +0100, Thiemo Seufer wrote:

> > My understanding is that with gcc-3.4 that __asm__ __volatile__ does not 
> > protect against dead code removal.  If the code is not dead __volatile__ 
> > works as documented, but dead code removal still happens.
> 
> The inline version isn't dead code, and gcc isn't allowed to reschedule
> code around a __asm__ __volatile__, so the patch should be ok.

It's the gcc generated function epilogue which is the problem.  There's
no reliable way to work around that ...

  Ralf
