Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Mar 2004 19:27:59 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:41864 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225255AbUCZT16>; Fri, 26 Mar 2004 19:27:58 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 9B4BB4787B; Fri, 26 Mar 2004 20:27:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 8A932475C5; Fri, 26 Mar 2004 20:27:51 +0100 (CET)
Date: Fri, 26 Mar 2004 20:27:51 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Peter Horton <pdh@colonel-panic.org>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, phorton@bitbox.co.uk,
	linux-mips@linux-mips.org
Subject: Re: missing flush_dcache_page call in 2.4 kernel
In-Reply-To: <20040326184317.GA3661@skeleton-jack>
Message-ID: <Pine.LNX.4.55.0403262026380.3736@jurand.ds.pg.gda.pl>
References: <20040325.224229.112629304.nemoto@toshiba-tops.co.jp>
 <20040325143319.GA873@linux-mips.org> <4062F1A1.9070005@bitbox.co.uk>
 <20040326.122258.41628012.nemoto@toshiba-tops.co.jp> <20040326184317.GA3661@skeleton-jack>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4665
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 26 Mar 2004, Peter Horton wrote:

> > I'm quite sure that it's a kernel bug and may cause problems if any
> > PIO block device (PIO ide, ide-cs, mtdblock, etc.) are used on CPUs
> > which have d-cache aliases (not only MIPS).  We need a correct fix ...
> 
> True. A proper fix would flush the relevant page after PIO transfers
> into the page cache / swap pages. Unfortunately this would require a
> hook in the generic kernel.

 Why is it unfortunate?  A bug in generic code deserves a fix just like 
any other.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
