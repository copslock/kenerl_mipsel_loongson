Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g77C9NRw001064
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 7 Aug 2002 05:09:23 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g77C9NPa001063
	for linux-mips-outgoing; Wed, 7 Aug 2002 05:09:23 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g77C9HRw001053
	for <linux-mips@oss.sgi.com>; Wed, 7 Aug 2002 05:09:18 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA18963;
	Wed, 7 Aug 2002 14:11:47 +0200 (MET DST)
Date: Wed, 7 Aug 2002 14:11:47 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Brian Murphy <brian@murphy.dk>
cc: linux-mips@oss.sgi.com
Subject: Re: [2.5 patch] R5K SC support
In-Reply-To: <3D5025AC.9020203@murphy.dk>
Message-ID: <Pine.GSO.3.96.1020807140817.18037D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 6 Aug 2002, Brian Murphy wrote:

> On the other hand with the application of this (attached) patch the 
> cache is
> detected correctly and appropriate routines are selected.

 Hmm, I bet you wanted to put the code to arch/mips/mm/c-r5k.c, didn't
you?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
