Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Nov 2002 12:53:25 +0100 (MET)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:34765 "EHLO
	delta.ds2.pg.gda.pl") by ralf.linux-mips.org with ESMTP
	id <S869801AbSK2LxR>; Fri, 29 Nov 2002 12:53:17 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA25088;
	Fri, 29 Nov 2002 12:56:10 +0100 (MET)
Date: Fri, 29 Nov 2002 12:56:10 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: atul srivastava <atulsrivastava9@rediffmail.com>,
	linux-mips@linux-mips.org
Subject: Re: a quick question regarding CONFIG_MIPS_UNCACHED..
In-Reply-To: <20021128171519.A18165@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1021128172026.8D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 740
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 28 Nov 2002, Ralf Baechle wrote:

> We've talked about this before - the specification of the ll/sc
> instructions says they only work ok on cached memory.  In the real world
> they seem to work also in uncached memory but I'd not bet the farm on
> that, too many implementations out there, too many chances for subtle
> bugs.

 Indeed -- CONFIG_MIPS_UNCACHED should either be removed or imply
CONFIG_CPU_HAS_LLSC=n.  I suppose there is some interest in the option, so
the latter is preferable.  That would imply moving the option into the CPU
configuration section as now it's set very late, long after
CONFIG_CPU_HAS_LLSC is set.  Or it could be set up the other way, i.e. the
option would only become available if CONFIG_CPU_HAS_LLSC had been set to
n.  There would be no need to move it then. 

 What do you think? 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
