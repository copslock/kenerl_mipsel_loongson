Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2002 11:23:12 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:32182 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122958AbSIEJXL>; Thu, 5 Sep 2002 11:23:11 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id LAA02910;
	Thu, 5 Sep 2002 11:23:34 +0200 (MET DST)
Date: Thu, 5 Sep 2002 11:23:33 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Carsten Langgaard <carstenl@mips.com>
cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: 64-bit and N32 kernel interfaces
In-Reply-To: <3D76FC6B.C9AA72F3@mips.com>
Message-ID: <Pine.GSO.3.96.1020905111911.2423D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 100
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 5 Sep 2002, Carsten Langgaard wrote:

> >  The (n)64 versions seem suitable and the o32 ones do not as n32 only
> > crops addresses to 32-bit -- data may still be 64-bit (e.g. file position
> > pointers).
> 
> Please notice, that a 'long' is 32-bit for n32, so we need to do the same
> conversion for a lot of syscalls, as we already do for o32.

 Any reference?  AFAIK, long is 64-bit for n32 and only void * is 32-bit. 
It doesn't make sense otherwise. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
