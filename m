Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6OFInRw021847
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 24 Jul 2002 08:18:49 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6OFInfT021846
	for linux-mips-outgoing; Wed, 24 Jul 2002 08:18:49 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6OFIfRw021836
	for <linux-mips@oss.sgi.com>; Wed, 24 Jul 2002 08:18:42 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA00963;
	Wed, 24 Jul 2002 17:19:54 +0200 (MET DST)
Date: Wed, 24 Jul 2002 17:19:54 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Zajerko-McKee, Nick" <nmckee@telogy.com>
cc: linux-mips@oss.sgi.com
Subject: RE: Question about generic\time.c 2.4.17
In-Reply-To: <37A3C2F21006D611995100B0D0F9B73CBFE202@tnint11.telogy.design.ti.com>
Message-ID: <Pine.GSO.3.96.1020724171209.27732H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 24 Jul 2002, Zajerko-McKee, Nick wrote:

> Thanks for the reply.   No, the code wasn't too obvious.  I went through the
> gas info page to try to understand the inline assembler options + see mips
> run.  I believe the code is used in the MIPS32 condition, which is what mode
> I'm building for...  

 For the 32-bit mode, not necessarily on a MIPS32 processor. 

> so the result is res = (high |low)/ base ?

 Strictly speaking, res = (high:low) / base and the result is (high:low) %
base.  That's a macro, hence a bit weird semantics (two results are
actually provided), but it makes the use easier.  A few architectures
provide such an operation in hardware.

> What had me confused was high and low are also modified as part of the
> function.

 That's just how the algorithm works.  These are local variables anyway.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
