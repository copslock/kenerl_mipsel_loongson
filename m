Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Apr 2003 17:25:06 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:36310 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225268AbTDOQZF>; Tue, 15 Apr 2003 17:25:05 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA17544;
	Tue, 15 Apr 2003 18:25:38 +0200 (MET DST)
Date: Tue, 15 Apr 2003 18:25:38 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Kevin D. Kissell" <kevink@mips.com>
cc: linux-mips@linux-mips.org, source@mvista.com
Subject: Re: wbflush() abuse for TOSHIBA_RBTX4927
In-Reply-To: <00ae01c3035e$d431aba0$10eca8c0@grendel>
Message-ID: <Pine.GSO.3.96.1030415180933.13254I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2063
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 15 Apr 2003, Kevin D. Kissell wrote:

> I remember that some of the Toshiba parts of the TX39 series
> had some interesting quirks relating to the write buffer.  Perhaps
> some of these were carried into the TX49 series as well?

 I suppose that's unrelated, since I'm specifically referring to the way
the buffer is handled in the TOSHIBA_RBTX4927 code -- the __wbflush()
backend is not invoked by wbflush() and calls like mb() (used by portable
drivers) unless the kernel is configured in an unobvious way and then
there is duplicate "sync" (but maybe that's needed, thus my question among
others). 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
