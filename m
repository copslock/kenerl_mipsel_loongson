Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Oct 2002 14:03:02 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:18059 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1123891AbSJQMDB>; Thu, 17 Oct 2002 14:03:01 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA25029;
	Thu, 17 Oct 2002 14:02:35 +0200 (MET DST)
Date: Thu, 17 Oct 2002 14:02:35 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
cc: Johannes Stezenbach <js@convergence.de>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: Once again: test_and_set for CPUs w/o LL/SC
In-Reply-To: <3DAE872E.D5EF0E4D@niisi.msk.ru>
Message-ID: <Pine.GSO.3.96.1021017135738.24495B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 469
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 17 Oct 2002, Gleb O. Raiko wrote:

> Implement new sysmips then.

 I'm not sure if that's a good idea.  Glibc alone uses test_and_set(),
exchange_and_add(), atomic_add() and compare_and_swap().  Do you want a
separate syscall for each of these functions?  I think the ll/sc emulation
may be the best solution after all.  At least it's most flexible and not
much slower if at all.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
