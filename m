Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2002 18:16:33 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:962 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122958AbSIEQQd>; Thu, 5 Sep 2002 18:16:33 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA09637;
	Thu, 5 Sep 2002 18:16:49 +0200 (MET DST)
Date: Thu, 5 Sep 2002 18:16:49 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Daniel Jacobowitz <dan@debian.org>
cc: Hartvig Ekner <hartvige@mips.com>,
	"Kevin D. Kissell" <kevink@mips.com>,
	Tor Arntsen <tor@spacetec.no>,
	Carsten Langgaard <carstenl@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: 64-bit and N32 kernel interfaces
In-Reply-To: <20020905151409.GA25023@nevyn.them.org>
Message-ID: <Pine.GSO.3.96.1020905181042.7444G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 118
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 5 Sep 2002, Daniel Jacobowitz wrote:

> N32 supports saving and restoring 64-bit registers, which O32 doesn't -
> according to some comments in GCC, O32 is in fact incompatible with
> using 64-bit operations.

 But that old software wouldn't benefit as it didn't perform 64-bit
operations unless manually coded in software using narrower data types. 
There is no 64-bit C data type for o32 and long long is quite a recent
invention -- it didn't exist in the 80s or even early 90s. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
