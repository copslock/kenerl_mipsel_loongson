Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Dec 2002 16:47:32 +0100 (CET)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:51095 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225289AbSLEPrc>; Thu, 5 Dec 2002 16:47:32 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA03290;
	Thu, 5 Dec 2002 16:47:28 +0100 (MET)
Date: Thu, 5 Dec 2002 16:47:27 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Carsten Langgaard <carstenl@mips.com>
cc: Dominic Sweetman <dom@algor.co.uk>,
	Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@linux-mips.org,
	dom@mips.com, chris@mips.com, kevink@mips.com
Subject: Re: Prefetches in memcpy
In-Reply-To: <3DEF6D4D.C0E886B0@mips.com>
Message-ID: <Pine.GSO.3.96.1021205164636.29101G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 789
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 5 Dec 2002, Carsten Langgaard wrote:

> Here's what I think we should do for now (attached patch).

 Obviously you want to #undef them first...

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
