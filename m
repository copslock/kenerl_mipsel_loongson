Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g649CERw014614
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 4 Jul 2002 02:12:14 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g649CEmj014613
	for linux-mips-outgoing; Thu, 4 Jul 2002 02:12:14 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g649C7Rw014600
	for <linux-mips@oss.sgi.com>; Thu, 4 Jul 2002 02:12:08 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id LAA13894;
	Thu, 4 Jul 2002 11:16:38 +0200 (MET DST)
Date: Thu, 4 Jul 2002 11:16:38 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: linux-mips@oss.sgi.com
Subject: Re: Small correction for fault.c
In-Reply-To: <20020703104659.GX16753@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.GSO.3.96.1020704110731.11369C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 3 Jul 2002, Thiemo Seufer wrote:

> I use HEAD. The change from CVS Revision 1.61 to 1.62 was dropping
> the tty.h include. Apparently a 2.5 cleanup.

 Well, the trunk is outdated -- it's 2.5.1, while the rest of the world
uses 2.5.24.  I'm using 2.4 for development, too, and I only syntactically
port changes to the trunk.

 Adding a local declaration is the worst that can happen and
it should not be used if at all possible (sometimes it's not, but the
cases are rare).  What if the interface changes?

 The correct fix is to include the appropriate header either in the header
that depends on it or in the sources that include it.  I prefer the
former, but it may sometimes lead to circular dependencies because of a
few Linux headers being too coarse.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
