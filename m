Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Feb 2004 01:46:08 +0000 (GMT)
Received: from p508B619B.dip.t-dialin.net ([IPv6:::ffff:80.139.97.155]:64318
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225474AbUBNBqI>; Sat, 14 Feb 2004 01:46:08 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i1E1jKex005142;
	Sat, 14 Feb 2004 02:45:20 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i1E1jKlW005141;
	Sat, 14 Feb 2004 02:45:20 +0100
Date: Sat, 14 Feb 2004 02:45:20 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: David Daney <ddaney@avtrex.com>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	linux-mips@linux-mips.org
Subject: Re: [patch] Prevent dead code/data removal with gcc 3.4
Message-ID: <20040214014520.GA4588@linux-mips.org>
References: <Pine.LNX.4.55.0402131453360.15042@jurand.ds.pg.gda.pl> <20040213145316.GA23810@linux-mips.org> <20040213222253.GA20118@rembrandt.csv.ica.uni-stuttgart.de> <402D513F.8080205@avtrex.com> <20040213224959.GB20118@rembrandt.csv.ica.uni-stuttgart.de> <20040214011539.GB31847@linux-mips.org> <20040214012801.GC20118@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040214012801.GC20118@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4362
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Feb 14, 2004 at 02:28:01AM +0100, Thiemo Seufer wrote:

> > It's the gcc generated function epilogue which is the problem.  There's
> > no reliable way to work around that ...
> 
> ITYM prologue. It has to follow the ABI specification, so $fp is the only
> possibly problematic one, and that's excluded by -fomit-frame-pointers.

Daniel Jacobowitz reported the problem which indeed was about $30.  Since
the kernel uses -fomit-frame-pointer by default (and -O1 enables it
by default on MIPS anyway) I would assume his kernel was built using that
option.  Maybe he can elaborate ...

Anyway, gcc could load next weeks lucky lottery numbers into the
s-registers after saving them.  That'd break save_static but not the
ABI which only promises to restore the old values in s-registers on
return.

  Ralf
