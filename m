Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6IEQbRw000943
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 18 Jul 2002 07:26:37 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6IEQbCH000942
	for linux-mips-outgoing; Thu, 18 Jul 2002 07:26:37 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6IEQVRw000933
	for <linux-mips@oss.sgi.com>; Thu, 18 Jul 2002 07:26:32 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA17216;
	Thu, 18 Jul 2002 16:27:31 +0200 (MET DST)
Date: Thu, 18 Jul 2002 16:27:31 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Houten K.H.C. van (Karel)" <vhouten@kpn.com>
cc: linux-mips@oss.sgi.com
Subject: Re: DECStation: Support for PMAZ-AA TC SCSI card? 
In-Reply-To: <200207171830.UAA04138@sparta.research.kpn.com>
Message-ID: <Pine.GSO.3.96.1020718160853.14993C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.5 required=5.0 tests=IN_REP_TO,SUBJ_ENDS_IN_Q_MARK version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi Karel,

> Sorry, same result. See attached log.

 Thanks for the report.  Apart from missing WB flushing, there is nothing
obviously broken in the PMAZ-A code -- I'll look at the problem more
deeply later.  The driver seems to work to some extent as it was able to
retrieve inquiry data, so it's not broken in principle.

 It would be great if you could check if the driver works for the /200's
onboard PMAZ-A.  If it worked there, I'd suspect a bug in the NCR53C8x
support core.  But please don't put a second PMAZ-A into your /200 -- for
an unclear reason the driver only supports a single I/O ASIC-based HBA and
a single additional PMAZ-A board.  All PMAZ-A boards share operational
variables with one another, so using more than a single one leads to data
corruption.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
