Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Feb 2004 02:17:42 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:3185
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225513AbUBNCRl>; Sat, 14 Feb 2004 02:17:41 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42] ident=mail)
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1ArpNF-0005mq-00; Sat, 14 Feb 2004 03:17:41 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1ArpNE-0004p5-00; Sat, 14 Feb 2004 03:17:40 +0100
Date: Sat, 14 Feb 2004 03:17:40 +0100
To: Ralf Baechle <ralf@linux-mips.org>
Cc: David Daney <ddaney@avtrex.com>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	linux-mips@linux-mips.org
Subject: Re: [patch] Prevent dead code/data removal with gcc 3.4
Message-ID: <20040214021740.GE20118@rembrandt.csv.ica.uni-stuttgart.de>
References: <Pine.LNX.4.55.0402131453360.15042@jurand.ds.pg.gda.pl> <20040213145316.GA23810@linux-mips.org> <20040213222253.GA20118@rembrandt.csv.ica.uni-stuttgart.de> <402D513F.8080205@avtrex.com> <20040213224959.GB20118@rembrandt.csv.ica.uni-stuttgart.de> <20040214011539.GB31847@linux-mips.org> <20040214012801.GC20118@rembrandt.csv.ica.uni-stuttgart.de> <20040214014520.GA4588@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040214014520.GA4588@linux-mips.org>
User-Agent: Mutt/1.5.5.1i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4363
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
[snip]
> Anyway, gcc could load next weeks lucky lottery numbers into the
> s-registers after saving them.  That'd break save_static but not the
> ABI which only promises to restore the old values in s-registers on
> return.

Ok, it could, but adding such insns to the prologue wouldn't make
sense at all, so this is unlikely to happen.


Thiemo
