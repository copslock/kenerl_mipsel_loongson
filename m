Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jan 2004 15:24:30 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:1992 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224991AbUAFPY3>; Tue, 6 Jan 2004 15:24:29 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 478944C3A7; Tue,  6 Jan 2004 16:24:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 30FE04C386; Tue,  6 Jan 2004 16:24:25 +0100 (CET)
Date: Tue, 6 Jan 2004 16:24:25 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [patch] 2.4: Support for newer gcc/gas options
In-Reply-To: <20040105.100429.74756139.nemoto@toshiba-tops.co.jp>
Message-ID: <Pine.LNX.4.55.0401061622580.5272@jurand.ds.pg.gda.pl>
References: <Pine.LNX.4.55.0312161822240.8262@jurand.ds.pg.gda.pl>
 <20040105.100429.74756139.nemoto@toshiba-tops.co.jp>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3869
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Mon, 5 Jan 2004, Atsushi Nemoto wrote:

> Recent tools have -march=r3900 option.  Now we can use this without
> hitting old tool users.  Please apply this patch.  Thank you.

 Thanks -- this is now in as obviously correct.  I wonder why there is
that naming inconsistency: r3900 vs tx3900...

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
