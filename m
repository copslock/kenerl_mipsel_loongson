Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 21:09:39 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:19668 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225358AbSLRVJj>; Wed, 18 Dec 2002 21:09:39 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id WAA14900;
	Wed, 18 Dec 2002 22:09:37 +0100 (MET)
Date: Wed, 18 Dec 2002 22:09:37 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Hartvig Ekner <hartvige@mips.com>
cc: linux mips mailing list <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: fix compiler warnings in the math-emulator
In-Reply-To: <200212181950.gBIJo4B11893@coplin09.mips.com>
Message-ID: <Pine.GSO.3.96.1021218220828.14826A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 960
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 18 Dec 2002, Hartvig Ekner wrote:

> Sometimes you don't care whether you do only "half" a macro instruction
> if the branch is taken. Usually though, the warning is a good thing - I
> remember having spent many hours finding bugs like this with assemblers
> that don't issue warnings.

 This is exactly what ".set nomacro" is for -- I can't see any reason for
such warnings when ".set macro" is active.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
