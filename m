Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6GDaXRw031029
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 16 Jul 2002 06:36:33 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6GDaX1c031028
	for linux-mips-outgoing; Tue, 16 Jul 2002 06:36:33 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6GDaSRw031019
	for <linux-mips@oss.sgi.com>; Tue, 16 Jul 2002 06:36:29 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA27241;
	Tue, 16 Jul 2002 15:41:53 +0200 (MET DST)
Date: Tue, 16 Jul 2002 15:41:53 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Houten K.H.C. van (Karel)" <vhouten@kpn.com>
cc: linux-mips@oss.sgi.com
Subject: Re: DECStation: Support for PMAZ-AA TC SCSI card?
In-Reply-To: <200207150940.LAA24361@sparta.research.kpn.com>
Message-ID: <Pine.GSO.3.96.1020716153355.20654M-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.5 required=5.0 tests=IN_REP_TO,SUBJ_ENDS_IN_Q_MARK version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 15 Jul 2002, Houten K.H.C. van (Karel) wrote:

> I'm currently experimenting with software raid support on my decstation,
> and it looks fine! But I would love to use more than one SCSI chain
> for my raid disks. My DECStation contains a Turbochannel PMAZ-AA
> SCSI card, which WAS once supported in the driver, but isn't anymore. :-(

 That's basically the same as the /200's onboard SCSI.  If that works, why
wouldn't an additional card (yup, I know the SCSI driver is a mess...)?

 [Looking at the sources...]  The driver seems to have all necessary bits
to support additional HBAs.  What do you mean by "not supported anymore?" 
What does it report for PMAZ-AA cards?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
