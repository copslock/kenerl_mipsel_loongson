Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2002 17:10:36 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:5824 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122958AbSIEPKg>; Thu, 5 Sep 2002 17:10:36 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA08673;
	Thu, 5 Sep 2002 17:10:52 +0200 (MET DST)
Date: Thu, 5 Sep 2002 17:10:51 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Daniel Jacobowitz <dan@debian.org>
cc: Hartvig Ekner <hartvige@mips.com>,
	"Kevin D. Kissell" <kevink@mips.com>,
	Tor Arntsen <tor@spacetec.no>,
	Carsten Langgaard <carstenl@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: 64-bit and N32 kernel interfaces
In-Reply-To: <20020905145954.GA17383@nevyn.them.org>
Message-ID: <Pine.GSO.3.96.1020905170830.7444E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 115
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 5 Sep 2002, Daniel Jacobowitz wrote:

> No - the point is that all data types have the same size in N32.  It
> was created explicitly as a transitional sop for people who didn't want
> to fix their code, but wanted a performance increase from their 64-bit
> hardware.

 Well, what's the performance increase of n32 over o32?  The increased
number of argument registers?  I doubt it's noticeable in most cases.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
