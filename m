Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2003 23:37:51 +0100 (BST)
Received: from p508B5B34.dip.t-dialin.net ([IPv6:::ffff:80.139.91.52]:47238
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225230AbTGVWht>; Tue, 22 Jul 2003 23:37:49 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h6MMbkDB011057;
	Wed, 23 Jul 2003 00:37:46 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h6MMbj7V011056;
	Wed, 23 Jul 2003 00:37:45 +0200
Date: Wed, 23 Jul 2003 00:37:45 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Jun Sun <jsun@mvista.com>, linux-mips@linux-mips.org
Subject: Re: [patch] Generic time fixes
Message-ID: <20030722223745.GC1660@linux-mips.org>
References: <20030722101014.B3135@mvista.com> <Pine.GSO.3.96.1030722225739.607J-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030722225739.607J-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2868
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

To add some performance numbers to the debate.  The DS1286 which is one of
the oldest chips we're supporting has a minimum write cycle time of 150ns.
The M48T02 which is used in the Origin needs 70ns, 150ns or 200ns depending
on the version.  Ok, those are slow numbers but they're not as bad as
postcards ...  I2C and it's evil brothers a is in a different universe
though.  There are busses in that cathegory that can transfer like 1kbyte/s.

  Ralf
