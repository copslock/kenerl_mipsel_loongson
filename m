Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2002 16:08:54 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:13246 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122958AbSIEOIx>; Thu, 5 Sep 2002 16:08:53 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA07739;
	Thu, 5 Sep 2002 16:09:11 +0200 (MET DST)
Date: Thu, 5 Sep 2002 16:09:11 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Kevin D. Kissell" <kevink@mips.com>
cc: Tor Arntsen <tor@spacetec.no>,
	Carsten Langgaard <carstenl@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: 64-bit and N32 kernel interfaces
In-Reply-To: <010301c254da$892fcc50$10eca8c0@grendel>
Message-ID: <Pine.GSO.3.96.1020905155411.7444A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 109
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 5 Sep 2002, Kevin D. Kissell wrote:

> n32 has the same data types as o32, an "ILP32" C integer 
> model.  n64 is a pretty normal "LP64" C integer model.
> 
> What do you consider to be broken, and how would you
> have preferred it to have been done?

 For n32 it would be natural to have:

- sizeof(int) = 32

- sizeof(long) = 64

- sizeof(void *) = 32

as the underlying hardware directly supports 64-bit operations (n32
requires at least MIPS III).  Thus there is no penalty for 64-bit
arithmetics and if one uses longs one normally wants the largest native
integer type -- using long long typically (i.e. on most platforms) implies
double-precision arithmetics with all the drawbacks, especially for the
division and multiplication operations. 

 With 32-bit long on 64-bit hardware software has no easy way to figure
using 64-bit operations is still optimal performance-wise.  I can't see
any technical benefit from such a setup -- is there any?  I doubt it. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
