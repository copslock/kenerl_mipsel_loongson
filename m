Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Mar 2004 18:44:49 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:27057 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225308AbUCQSos>; Wed, 17 Mar 2004 18:44:48 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 646734B44A; Wed, 17 Mar 2004 19:44:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 455114ADFC; Wed, 17 Mar 2004 19:44:42 +0100 (CET)
Date: Wed, 17 Mar 2004 19:44:42 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: cgd@broadcom.com
Cc: Eric Christopher <echristo@redhat.com>, linux-mips@linux-mips.org
Subject: Re: gcc support for mips32 release 2]
In-Reply-To: <yov5ish3zar8.fsf@ldt-sj3-010.sj.broadcom.com>
Message-ID: <Pine.LNX.4.55.0403171941250.14525@jurand.ds.pg.gda.pl>
References: <1078525778.3353.2.camel@dzur.sfbay.redhat.com>
 <Pine.LNX.4.55.0403171714410.14525@jurand.ds.pg.gda.pl>
 <yov5ish3zar8.fsf@ldt-sj3-010.sj.broadcom.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4562
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 17 Mar 2004 cgd@broadcom.com wrote:

> >  Well, I think this can be handled by creating an artificial processor
> > entry (e.g. "PROCESSOR_MIPS64R2" in this case) and replacing it with a
> > real one once an implementation is publicly available.
> 
> yeah.  doing that, but introducing known "to be removed" code bugs me.

 That's a mechanical update and a very trivial one -- to be done with
"s///".  Sometimes you just cannot avoid placeholders.

> it's probably better than not getting the rest of the infrastructure
> in, though.

 Indeed -- you get certain automatical updates done by the others in
return.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
