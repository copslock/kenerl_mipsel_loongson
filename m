Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2002 11:43:57 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:19690 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225424AbSLSLn4>; Thu, 19 Dec 2002 11:43:56 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA00218;
	Thu, 19 Dec 2002 12:44:08 +0100 (MET)
Date: Thu, 19 Dec 2002 12:44:08 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Juan Quintela <quintela@mandrakesoft.com>
cc: linux mips mailing list <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH]: fix compiler warnings in the math-emulator
In-Reply-To: <m2el8fnf36.fsf@demo.mitica>
Message-ID: <Pine.GSO.3.96.1021219124042.27339G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 995
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On 18 Dec 2002, Juan Quintela wrote:

> maciej> A few warnings are unavoidable -- e.g. there is no way to shut up gas
> maciej> complaining about macros expanding into multiple instructions in branch
> maciej> delay slots.  Too bad.
> 
> I tried the 
>   .set nowarn 
> and found it didn't work.

 There is no such gas directive, but perhaps it might be added as writing
".set nomacro" before every branch may be a nuisance and obfuscate the
code unnecessarily.  On the contrary ".set nowarn" should be fairly rare. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
