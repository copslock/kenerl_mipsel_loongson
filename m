Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Mar 2004 16:18:45 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:32973 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225229AbUCQQSp>; Wed, 17 Mar 2004 16:18:45 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id CD39A4AEC1; Wed, 17 Mar 2004 17:18:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id B70C147B50; Wed, 17 Mar 2004 17:18:37 +0100 (CET)
Date: Wed, 17 Mar 2004 17:18:37 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Eric Christopher <echristo@redhat.com>, cgd@broadcom.com
Cc: linux-mips@linux-mips.org
Subject: Re: gcc support for mips32 release 2]
In-Reply-To: <1078525778.3353.2.camel@dzur.sfbay.redhat.com>
Message-ID: <Pine.LNX.4.55.0403171714410.14525@jurand.ds.pg.gda.pl>
References: <1078525778.3353.2.camel@dzur.sfbay.redhat.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4558
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 5 Mar 2004, Eric Christopher wrote:

> > If anybody knows of a MIPS64 release 2 implementation, I also have
> > support for GCC to do that.  (Problem is, the way the GCC MIPS
> > back-end currently is, it really wants a processor implementation
> > before a new ISA is added.)

 Well, I think this can be handled by creating an artificial processor
entry (e.g. "PROCESSOR_MIPS64R2" in this case) and replacing it with a
real one once an implementation is publicly available.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
