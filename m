Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Sep 2002 16:22:57 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:45722 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122958AbSIDOW4>; Wed, 4 Sep 2002 16:22:56 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA14149;
	Wed, 4 Sep 2002 16:14:14 +0200 (MET DST)
Date: Wed, 4 Sep 2002 16:14:13 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: Re: 64-bit and N32 kernel interfaces
In-Reply-To: <20020904155645.A31893@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1020904160219.10619G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 76
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 4 Sep 2002, Ralf Baechle wrote:

> Right now the 64-bit kernel interfaces are still pretty much an ad-hoc
> approach and can't be considered frozen.  There is now some pressure to
> come up with a stable 64-bit API asap.

 Well, they are not really used by anything, yet so they are far from
being frozen.

> As first think I want to get rid of all the historic crap we have in
> our syscall tables for the 64-bit syscalls.  Let's start here:
[...]

 Definitely.

> I probably missed a few.  The primary purpose of this posting is to get a
> discussion about the 64-bit syscall interface started.  It's still not
> cast into stone so we can modify it as we see fit.  The entire syscall
> interface is still open for changes, this includes all structures etc.
> Along with a 64-bit ABI we'll also have to deciede about a N32 ABI.

 It would be nice if we could keep a single set of syscalls for both (n)64
and n32.  The address crop for n32 may be handled the Alpha way.  I will
investigate the topic soon.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
