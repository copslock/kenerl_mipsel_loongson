Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Dec 2002 17:36:42 +0100 (MET)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:13016 "EHLO
	delta.ds2.pg.gda.pl") by ralf.linux-mips.org with ESMTP
	id <S868815AbSLFQg3>; Fri, 6 Dec 2002 17:36:29 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA01020;
	Fri, 6 Dec 2002 17:32:25 +0100 (MET)
Date: Fri, 6 Dec 2002 17:32:24 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: Carsten Langgaard <carstenl@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: Latest sources from CVS.
In-Reply-To: <20021206135110.GD23743@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.GSO.3.96.1021206165118.26674N-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 6 Dec 2002, Thiemo Seufer wrote:

> Er, well, for some values of 'fine'. In principle, 64 bit code shouldn't
> be disguised in O32 objects. OTOH i must admit it's a bit early to use
> binutils N32 for this purpose.

 Which wouldn't work either as it implies 32-bit pointers, while gcc still
emits 64-bit assembly.  If we want to preserve the setup cleanly, we
probably need yet another ABI model in gcc (especially in the face of the
coming changes to get rid of assembly macros), with sign-extended 32-bit
pointers for accessing program segments and 64-bit ones for the remaining
addresses.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
