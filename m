Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2002 11:22:28 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:49641 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225424AbSLSLW1>; Thu, 19 Dec 2002 11:22:27 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA29876;
	Thu, 19 Dec 2002 12:22:39 +0100 (MET)
Date: Thu, 19 Dec 2002 12:22:38 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Juan Quintela <quintela@mandrakesoft.com>,
	linux mips mailing list <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: make prototype of printk available
In-Reply-To: <20021219000332.B1132@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1021219120946.27339E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 993
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 19 Dec 2002, Ralf Baechle wrote:

> This is a printk that's executed if a user program is just trying to
> execute the right code, so a user could flood syslog that way.  Imho the
> printk call should go away?

 Indeed -- that's a report of a non-fatal exception.  If unhandled, user
will get output from the default signal handler.  And if diagnostics is
needed in the emulator, Dprintk or a similar solution may be used. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
