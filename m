Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Feb 2004 16:20:20 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:50076 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225226AbUBCQUU>; Tue, 3 Feb 2004 16:20:20 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 658564C39F; Tue,  3 Feb 2004 17:20:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 41DBC474C8; Tue,  3 Feb 2004 17:20:18 +0100 (CET)
Date: Tue, 3 Feb 2004 17:20:18 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Re: R4600 V1.7 errata
In-Reply-To: <20040203161202.GC1018@linux-mips.org>
Message-ID: <Pine.LNX.4.55.0402031716140.16076@jurand.ds.pg.gda.pl>
References: <20040129102215.GC17760@ballina> <4018E322.9030801@gentoo.org>
 <20040131030435.GA24228@linux-mips.org> <20040131141027.GA11048@ballina>
 <20040201045258.GA4601@linux-mips.org> <20040203113928.GA28340@linux-mips.org>
 <20040203114252.GA27810@icm.edu.pl> <20040203115236.GB28340@linux-mips.org>
 <Pine.LNX.4.55.0402031636210.16076@jurand.ds.pg.gda.pl>
 <20040203161202.GC1018@linux-mips.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4268
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 3 Feb 2004, Ralf Baechle wrote:

> Under a different bug number this bug also affects the R4600 V1.x; it's
> fixed in post-2.0 R4600 (which all identify as 2.0) and post-1.1 R4700.
> Since a workaround may be a bit performance sensitive I think I'll try if
> it can be probed for reliably.

 The conditions appear clear, so they may be quite easy to reproduce for
the erratum to trigger.  I guess you may take the optimization hint from
the document into account as well.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
