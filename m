Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2002 11:52:47 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:18871 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122958AbSIEJwr>; Thu, 5 Sep 2002 11:52:47 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id LAA03361;
	Thu, 5 Sep 2002 11:53:12 +0200 (MET DST)
Date: Thu, 5 Sep 2002 11:53:12 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: Re: 64-bit and N32 kernel interfaces
In-Reply-To: <20020904204622.D32519@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1020905112351.2423E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 102
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 4 Sep 2002, Ralf Baechle wrote:

> Well, N32 is yet another case.  Have to look into details again but some
> MIPS guy recently pointed out to me that there are a few syscalls which
> for N32 cannot be handled by the o32 or N64 syscall entry as they are right
> now.

 Which ones?  Maybe we might just add some padding to structures.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
