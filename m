Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Aug 2003 15:31:26 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:61064 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225213AbTHDObW>; Mon, 4 Aug 2003 15:31:22 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA18988;
	Mon, 4 Aug 2003 16:31:19 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Mon, 4 Aug 2003 16:31:19 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: Re: [patch] More time fixes: do_gettimeofday() & do_settimeofday()
In-Reply-To: <20030802170542.GB19401@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030804162919.17066G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2978
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Sat, 2 Aug 2003, Ralf Baechle wrote:

> >  Here are fixes for do_gettimeofday() and do_settimeofday() not taking the
> > wall time and the value of tick properly into account.  OK to apply? 
> 
> Yes, looks good.  One user less of USECS_PER_JIFFY ...

 Actually, I decided to keep USECS_PER_JIFFY, only redefining it more
sanely.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
