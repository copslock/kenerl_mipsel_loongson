Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Sep 2002 19:39:02 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:18361 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122960AbSIIRjC>; Mon, 9 Sep 2002 19:39:02 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA03069;
	Mon, 9 Sep 2002 19:39:12 +0200 (MET DST)
Date: Mon, 9 Sep 2002 19:39:12 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: Daniel Jacobowitz <dan@debian.org>,
	"Kevin D. Kissell" <kevink@mips.com>,
	Tor Arntsen <tor@spacetec.no>,
	Carsten Langgaard <carstenl@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: 64-bit and N32 kernel interfaces
In-Reply-To: <20020905221221.GX4194@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.GSO.3.96.1020909193304.28323E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 150
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 6 Sep 2002, Thiemo Seufer wrote:

> I agree. And I believe in the "least surprise" principle, which means
> we shouldn't deviate from widely known conventions without good reason.
> I still don't see the advantage of a 64 bit long in n32.

 Well, for me it's more surprising to see long not sufficient to contain
data of the register width than to see the width of long being different
from the width of a pointer.  The latter I've already seen (both ways). 
The former is new to me.  Others may have different experiences, though. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
