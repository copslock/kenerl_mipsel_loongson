Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6MHUoRw028028
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 22 Jul 2002 10:30:50 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6MHUoja028027
	for linux-mips-outgoing; Mon, 22 Jul 2002 10:30:50 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6MHUfRw028017;
	Mon, 22 Jul 2002 10:30:42 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA08872;
	Mon, 22 Jul 2002 19:32:04 +0200 (MET DST)
Date: Mon, 22 Jul 2002 19:32:04 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: "Houten K.H.C. van (Karel)" <vhouten@kpn.com>, linux-mips@oss.sgi.com
Subject: Re: DECStation: Support for PMAZ-AA TC SCSI card?
In-Reply-To: <20020722154405.A29300@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1020722192254.2373M-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.5 required=5.0 tests=IN_REP_TO,SUBJ_ENDS_IN_Q_MARK version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 22 Jul 2002, Ralf Baechle wrote:

> We had some discussion with the IA64 guys at SGI on how to handle this
> kind of I/O ordering issues.  We never came to a final conclusion but
> the proposal was the introduction of separate memory barriers macros for
> I/O stuff.  Anyway, I think for the moment we should go with your proposal.

 Well, nothing stops code from evolving -- if there is a need for a more
finegrained choice of macros, we may fulfill it, don't we?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
