Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Oct 2003 04:58:24 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:56021 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225200AbTJAD6T>; Wed, 1 Oct 2003 04:58:19 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id FAA21101;
	Wed, 1 Oct 2003 05:58:17 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Wed, 1 Oct 2003 05:58:16 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: "Finney, Steve" <Steve.Finney@SpirentCom.COM>,
	linux-mips@linux-mips.org
Subject: Re: 64 bit operations w/32 bit kernel
In-Reply-To: <20030930184755.GA12599@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1031001055324.20371B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3340
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 30 Sep 2003, Ralf Baechle wrote:

> What I called a bug is the necessity to access hardware registers with
> 64-bit loads and stores in some systems as opposed to of 32-bit
> instructions - that simply doesn't work from 32-bit universes.
> 
> To clarify, it was my understanding of Steve's problem he needs 64-bit
> loads and stores, not something in the 64-bit physical address space.
> The later problem obviously would get a different answer.

 I must have missed the detail.  Well, if 64-bit transfers are needed,
then going for the 64-bit kernel is about the only way.  Or, as a wild
hack, perhaps "ldc1" and "sdc1" can be used, if it's known the FP is
present.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
