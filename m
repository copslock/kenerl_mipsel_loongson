Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Sep 2002 23:18:07 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:7418 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122961AbSI0VSH>; Fri, 27 Sep 2002 23:18:07 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id XAA23269;
	Fri, 27 Sep 2002 23:18:25 +0200 (MET DST)
Date: Fri, 27 Sep 2002 23:18:24 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Gerald Champagne <gerald.champagne@esstech.com>
cc: Linux Mips Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] show register names in show_regs
In-Reply-To: <1033159633.26894.50.camel@localhost.localdomain>
Message-ID: <Pine.GSO.3.96.1020927231028.16597B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 293
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On 27 Sep 2002, Gerald Champagne wrote:

> The following trivial patch makes show_regs display register names
> before each value.  I find this format much faster to read when
> comparing register dumps to assembly code.  The results look like this:
[...]
> Is this acceptable, or do people prefer the existing method without the
> register names?

 Note that the format is selected to optimize the space consumed as a
serial console is not always available and it's better not to let some
essential information scroll away from the virtual terminal.  Also
ksymoops will probably be unhappy with format changes (though it tries to
be flexible, so it might actually survive).  How about writing a small
program or a script that would parse register dumps and output them in
your favourite layout?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
