Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Mar 2004 14:16:17 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:2949 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225377AbUCSOQQ>; Fri, 19 Mar 2004 14:16:16 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id B3A614BE01; Fri, 19 Mar 2004 15:16:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 9F3A34B44A; Fri, 19 Mar 2004 15:16:07 +0100 (CET)
Date: Fri, 19 Mar 2004 15:16:07 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: cgd@broadcom.com, Eric Christopher <echristo@redhat.com>,
	linux-mips@linux-mips.org
Subject: Re: gcc support for mips32 release 2]
In-Reply-To: <20040318225154.GA761@linux-mips.org>
Message-ID: <Pine.LNX.4.55.0403191511430.18215@jurand.ds.pg.gda.pl>
References: <1078525778.3353.2.camel@dzur.sfbay.redhat.com>
 <Pine.LNX.4.55.0403171714410.14525@jurand.ds.pg.gda.pl>
 <yov5ish3zar8.fsf@ldt-sj3-010.sj.broadcom.com> <20040318225154.GA761@linux-mips.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4594
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 18 Mar 2004, Ralf Baechle wrote:

> > yeah.  doing that, but introducing known "to be removed" code bugs me.
> > 
> > it's probably better than not getting the rest of the infrastructure
> > in, though.
> 
> It seems a small problem compared to having to answer all the questions
> about why Linux tries to optimize for processor X when it's configured
> for type Y.  People just love tweaking compiler flags it seems - even if
> not necessarily knowing all the consequences ...

 The recent updates to Makefiles should help a bit -- now at least you can
give a short answer of: "Because you use outdated tools."  Note there's a
single trivial update still awaiting approval in this area (I can resend
it, if it would help).

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
