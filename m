Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Oct 2002 14:43:15 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:16271 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1123397AbSJDMnO>; Fri, 4 Oct 2002 14:43:14 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA07129;
	Fri, 4 Oct 2002 14:43:35 +0200 (MET DST)
Date: Fri, 4 Oct 2002 14:43:35 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Carsten Langgaard <carstenl@mips.com>
cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: 64-bit kernel patch.
In-Reply-To: <3D9D37AC.B239FA5D@mips.com>
Message-ID: <Pine.GSO.3.96.1021004142443.6208B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 362
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 4 Oct 2002, Carsten Langgaard wrote:

> Hmm, are you sure it's related ?

 No, I wasn't -- as I wrote I had no time to investigate it further and I
was asking for comments from people.  Now I'm sure it is not. 

> It works fine for me, and it fixes the problems I had before I added this
> fix.

 Yep, it works here with openssh, which used not to work before.  Thanks a
lot. 

 The reason of the failure was a recent r4kcache.h breakage -- this is the
kind of mistakes that makes me consider a run-time check a necessity even
for supposedly trivial and innocent changes (well, a compilation should
actually suffice for lone comment updates). 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
