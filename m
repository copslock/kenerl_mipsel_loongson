Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2002 11:09:22 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:26345 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225416AbSLSLJV>; Thu, 19 Dec 2002 11:09:21 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA29664;
	Thu, 19 Dec 2002 12:09:34 +0100 (MET)
Date: Thu, 19 Dec 2002 12:09:33 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Juan Quintela <quintela@mandrakesoft.com>,
	linux mips mailing list <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: fix compiler warnings in the math-emulator
In-Reply-To: <20021219012013.A6998@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1021219120836.27339D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 992
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 19 Dec 2002, Ralf Baechle wrote:

> Functionally these two patches are more or less equivalent but I think
> Juan's patch is more readable.  Don't change the fact that the whole FP
> emulator could need some heavy polishing ...

 If the additional macro is OK, then I see no problem.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
