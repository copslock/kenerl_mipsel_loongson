Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Feb 2004 15:43:21 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:40938 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225226AbUBCPnV>; Tue, 3 Feb 2004 15:43:21 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 9AE4947823; Tue,  3 Feb 2004 16:43:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 89D3B474C8; Tue,  3 Feb 2004 16:43:19 +0100 (CET)
Date: Tue, 3 Feb 2004 16:43:19 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Re: R4600 V1.7 errata
In-Reply-To: <20040203115236.GB28340@linux-mips.org>
Message-ID: <Pine.LNX.4.55.0402031636210.16076@jurand.ds.pg.gda.pl>
References: <20040129102215.GC17760@ballina> <4018E322.9030801@gentoo.org>
 <20040131030435.GA24228@linux-mips.org> <20040131141027.GA11048@ballina>
 <20040201045258.GA4601@linux-mips.org> <20040203113928.GA28340@linux-mips.org>
 <20040203114252.GA27810@icm.edu.pl> <20040203115236.GB28340@linux-mips.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4262
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 3 Feb 2004, Ralf Baechle wrote:

> 2.0 requires different workarounds which are already in place and functional
> since quite some time.  We still lacking a fix for one important erratum of
> the 2.0 but it seems pretty stable without.

 Well, I can actually see two problems: #4 that is fairly easy to handle
and #7 which is painful and which is unfortunately present with the R4700
as well.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
