Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jun 2003 20:45:08 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:52955 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225215AbTF0TpG>; Fri, 27 Jun 2003 20:45:06 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id VAA01905;
	Fri, 27 Jun 2003 21:46:05 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Fri, 27 Jun 2003 21:46:05 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: kwalker@linux-mips.org
cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux 
In-Reply-To: <20030627191204Z8225311-1272+2885@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030627214156.27044M-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 27 Jun 2003 kwalker@linux-mips.org wrote:

> Modified files:
> 	arch/mips/lib  : memcpy.S 
> 	arch/mips64/lib: memcpy.S 
> 
> Log message:
> 	fix bug in getting the thread's BUADDR in l_exc case

 There's still missing a load delay slot filler there.  I'm checking in an
obvious fix immediately.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
