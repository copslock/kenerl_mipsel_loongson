Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jan 2003 20:11:53 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:21997 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226069AbTAHULw>; Wed, 8 Jan 2003 20:11:52 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id VAA11713;
	Wed, 8 Jan 2003 21:12:03 +0100 (MET)
Date: Wed, 8 Jan 2003 21:12:03 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Mike Uhler <uhler@mips.com>, Dominic Sweetman <dom@mips.com>,
	linux-mips@linux-mips.org
Subject: Re: [patch] Use XKPHYS for 64-bit TLB flushes
In-Reply-To: <20030108204408.A27888@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030108210002.11293A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1102
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 8 Jan 2003, Ralf Baechle wrote:

> We used to use just KSEG0 instead of KSEG0+entry*0x2000.  That was running
> fine over years but had to be changed for the sake of two CPUs afair.  There
> was some discussion on this list about this and I accepted the change by that
> time because Kevin imho correctly argued that the spec left it unspecified
> if an implementation is feeding addresses in an unmapped address space
> though the TLB.

 Well, like it or not, CAMs do not like multiple matches -- up to a
physical damage even.  So they should be avoided if possible.  While KSEG0
won't match for any real address translation, there is a non-zero
probability of executing a tlbp for it as a result of buggy code or
execution gone wild (root running crashme?). 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
