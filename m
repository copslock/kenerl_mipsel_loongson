Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2002 20:54:13 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:41670 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122958AbSIESyM>; Thu, 5 Sep 2002 20:54:12 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA11861;
	Thu, 5 Sep 2002 20:54:28 +0200 (MET DST)
Date: Thu, 5 Sep 2002 20:54:27 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Hartvig Ekner <hartvige@mips.com>
cc: Daniel Jacobowitz <dan@debian.org>,
	"Kevin D. Kissell" <kevink@mips.com>,
	Tor Arntsen <tor@spacetec.no>,
	Carsten Langgaard <carstenl@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: 64-bit and N32 kernel interfaces
In-Reply-To: <200209051807.g85I73W06904@coplin09.mips.com>
Message-ID: <Pine.GSO.3.96.1020905204345.7444N-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 130
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 5 Sep 2002, Hartvig Ekner wrote:

> The technical benefits of n32 over o32 are:
> 
> * More argument registers => less memory traffic, less D-cache use,
> 	=> faster code

 Generally, since the stack is usually frequently accessed it tends to
stick in the primary cache so the extra cost is null.  But a set
associative cache with an LFU or at least an LRU replacement algorithm is
needed for this to be effective.  Too bad such caches are rare for MIPS
processors...  So the win might actually be bigger than it should be.

> * 64-bit datapath of CPU can be utilized with big impact on certain
>   applications

 But an old program doesn't make use of them, so it won't normally
benefit.  For new development it's true, but you don't absolutely need to
cut long to 32 bits for new stuff. 

> * 32 floating point registers instead of 16 (and more efficient
>   parameter passing as well)

 Yes, that's true -- I missed it previously.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
