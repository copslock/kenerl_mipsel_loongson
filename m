Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Feb 2004 12:50:45 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:58298 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225237AbUBQMuo>; Tue, 17 Feb 2004 12:50:44 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 092BE4C3C4; Tue, 17 Feb 2004 13:50:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id E7113477F0; Tue, 17 Feb 2004 13:50:41 +0100 (CET)
Date: Tue, 17 Feb 2004 13:50:41 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: David Daney <ddaney@avtrex.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [patch] Prevent dead code/data removal with gcc 3.4
In-Reply-To: <20040213224959.GB20118@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.LNX.4.55.0402171340230.8356@jurand.ds.pg.gda.pl>
References: <Pine.LNX.4.55.0402131453360.15042@jurand.ds.pg.gda.pl>
 <20040213145316.GA23810@linux-mips.org> <20040213222253.GA20118@rembrandt.csv.ica.uni-stuttgart.de>
 <402D513F.8080205@avtrex.com> <20040213224959.GB20118@rembrandt.csv.ica.uni-stuttgart.de>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4373
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 13 Feb 2004, Thiemo Seufer wrote:

> The inline version isn't dead code, and gcc isn't allowed to reschedule
> code around a __asm__ __volatile__, so the patch should be ok.

 Note that it's a valid point gcc can do whatever it wants in the prologue
as long as it conforms to the ABI.  Wrt static registers it only needs to
make sure they are restored in the epilogue (and that's exactly what
happens for "s8"); then after saving them in the prologue, it can use
them, possibly destructibly, as we don't express (nor have a way to) the
need to have them preserved from the entry point.

 I think we could have a gcc extension to express certain function 
arguments are the entry values of registers (e.g. by specifying 
"asm("foo")" like it can be done for variables), but currently there's no 
such option.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
