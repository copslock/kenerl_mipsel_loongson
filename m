Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2002 18:33:37 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:35522 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122958AbSIEQdg>; Thu, 5 Sep 2002 18:33:36 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA09858;
	Thu, 5 Sep 2002 18:33:54 +0200 (MET DST)
Date: Thu, 5 Sep 2002 18:33:53 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Daniel Jacobowitz <dan@debian.org>
cc: Hartvig Ekner <hartvige@mips.com>,
	"Kevin D. Kissell" <kevink@mips.com>,
	Tor Arntsen <tor@spacetec.no>,
	Carsten Langgaard <carstenl@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: 64-bit and N32 kernel interfaces
In-Reply-To: <20020905161933.GA5023@nevyn.them.org>
Message-ID: <Pine.GSO.3.96.1020905182938.7444I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 123
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 5 Sep 2002, Daniel Jacobowitz wrote:

> Right.  You don't recompile and get a magic bullet speed improvement
> (well, you do, but not a drastic one I think); but you don't recompile
> and get a magic bullet binary incompatibility either.  Then you add
> 64-bit pieces by hand as necessary.

 Huh?  I can somewhat understand the "rebuild and forget" approach,
especially in cases suitably experienced stuff was lost meanwhile.  But if
you start to fiddle with some old crap, you may equally well run
's/long/int/' within it, what's a deal. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
