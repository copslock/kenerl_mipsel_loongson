Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2004 14:18:37 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:40349 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225539AbUA2OSh>; Thu, 29 Jan 2004 14:18:37 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id B03634787B; Thu, 29 Jan 2004 15:18:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 81F2947631; Thu, 29 Jan 2004 15:18:33 +0100 (CET)
Date: Thu, 29 Jan 2004 15:18:33 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Jun Sun <jsun@mvista.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6] 32bit module support
In-Reply-To: <20040129140450.GA5589@linux-mips.org>
Message-ID: <Pine.LNX.4.55.0401291516270.13474@jurand.ds.pg.gda.pl>
References: <20040123182436.C27362@mvista.com> <20040129140450.GA5589@linux-mips.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4191
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 29 Jan 2004, Ralf Baechle wrote:

> What still needs to be done is adding module supprt for 64-bit also - but
> that's not functional in 2.4 either and I have no plans to implement
> 64-bit modules in 2.4.

 AFAIK, what would be needed for 2.4 is an update to modutils, not the 
kernel itself.  It can be done any time provided the interested party 
writes appropriate code.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
