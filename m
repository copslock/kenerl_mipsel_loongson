Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Dec 2002 14:47:50 +0100 (CET)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:1938 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225265AbSLENrt>; Thu, 5 Dec 2002 14:47:49 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA00622;
	Thu, 5 Dec 2002 14:47:54 +0100 (MET)
Date: Thu, 5 Dec 2002 14:47:53 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Carsten Langgaard <carstenl@mips.com>
cc: Ralf Baechle <ralf@linux-mips.org>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: Latest sources from CVS.
In-Reply-To: <3DEF3524.7A5CDE57@mips.com>
Message-ID: <Pine.GSO.3.96.1021205143717.29101C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 782
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 5 Dec 2002, Carsten Langgaard wrote:

> > Everybody satisfied?
> 
> Not quite, I afraid.
> I would like to be able to compile a 64-bit kernel, using the
> MIPS32/MIPS64 config1 register, but I don't have a MIPS64 compliant n64
> compiler (assembler). So I need the hardcoded ".word" opcode version, we
> previously had.

 Please upgrade/patch your tools.  If you can't, then this qualifies for a
privately maintained patch perfectly. 

 Support for MIPS32/MIPS64 was added to binutils two years ago.  Version
2.11 suffices. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
