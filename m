Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Oct 2002 13:39:12 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:23020 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1123930AbSJCLjL>; Thu, 3 Oct 2002 13:39:11 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA07121;
	Thu, 3 Oct 2002 13:39:34 +0200 (MET DST)
Date: Thu, 3 Oct 2002 13:39:33 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Carsten Langgaard <carstenl@mips.com>, linux-mips@linux-mips.org
Subject: Re: 64-bit kernel patch.
In-Reply-To: <20021002160948.F16482@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1021003133548.7000A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 349
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 2 Oct 2002, Ralf Baechle wrote:

> > Ok, here is the next patch.
> > It fixes the sys32_sendmsg and sys32_recvmsg.
> 
> Ok, in.  Maciej, you can start the chainsawing ;-)

 Hmm, I couldn't test it as init now crashes with a SIGSEGV soon after
starting.  I had no time to investigate it further.  I fear it might be
related, though -- /dev/initctl communication? 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
