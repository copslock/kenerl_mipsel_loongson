Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 16:45:09 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:10444 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225329AbSLRQpJ>; Wed, 18 Dec 2002 16:45:09 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA09650;
	Wed, 18 Dec 2002 17:43:34 +0100 (MET)
Date: Wed, 18 Dec 2002 17:43:34 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Juan Quintela <quintela@mandrakesoft.com>
cc: linux mips mailing list <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH]: fix compiler warnings in the math-emulator
In-Reply-To: <m2znr4p0e2.fsf@demo.mitica>
Message-ID: <Pine.GSO.3.96.1021218173810.5977D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On 18 Dec 2002, Juan Quintela wrote:

>         this patch does:
> 
> * redefine SETCX to only set cx
> * define a new macre SETANDTESTCX for the few cases when we also want to
>   test the value set.

 Is it needed?  The part that returns .mx should be optimized away by the
compiler automagically if unused. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
