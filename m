Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2003 20:40:52 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:28669 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224821AbTGVTku>; Tue, 22 Jul 2003 20:40:50 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id VAA09241;
	Tue, 22 Jul 2003 21:40:48 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Tue, 22 Jul 2003 21:40:47 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
In-Reply-To: <20030721211402.GC5188@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030722213958.607E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2859
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Mon, 21 Jul 2003, Ralf Baechle wrote:

> I even have some hope that with continuing cleanup mm-32 and mm-64, which
> are supposed to contain only things that due to conflicts can't live in
> mm, will finally become empty.

 If that's going to happen, a removal of arch/mips64/mm does make sense,
indeed.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
