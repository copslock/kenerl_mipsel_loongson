Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2002 12:03:54 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:52202 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225424AbSLSMDy>; Thu, 19 Dec 2002 12:03:54 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA00586;
	Thu, 19 Dec 2002 13:04:05 +0100 (MET)
Date: Thu, 19 Dec 2002 13:04:05 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Juan Quintela <quintela@mandrakesoft.com>
cc: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH]: remove warnings on promlib
In-Reply-To: <m2r8cemhxt.fsf@demo.mitica>
Message-ID: <Pine.GSO.3.96.1021219125957.27339J-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 998
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On 19 Dec 2002, Juan Quintela wrote:

> Something like that?

 Sure.

> Once there, s/vsprintf/vsnprintf/.
> 
> If anybody calls prom_printf with more than 1024 chars, we were b0rked
> :((

 And thanks for fixing this.

> I didn't did the changes for the other users of prom_* that was using 
> asm/sgialib.h, but change is trivial.

 Well, it's usually quite easy to do such stuff to offload maintainers of
the respective files.  And sometimes there are ones that lack an active
maintainer but "just work".  Alternatively, <asm/sgialib.h> itself might
include <asm/prom.h> to ease the transition. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
