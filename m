Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g62GKTRw009118
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 2 Jul 2002 09:20:29 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g62GKTdN009117
	for linux-mips-outgoing; Tue, 2 Jul 2002 09:20:29 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g62GKORw009098
	for <linux-mips@oss.sgi.com>; Tue, 2 Jul 2002 09:20:25 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA06330;
	Tue, 2 Jul 2002 18:24:40 +0200 (MET DST)
Date: Tue, 2 Jul 2002 18:24:40 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "H. J. Lu" <hjl@lucon.org>
cc: Eric Christopher <echristo@redhat.com>, bkoz@redhat.com,
   linux-mips@oss.sgi.com
Subject: Re: Kernel ll/sc emulation?
In-Reply-To: <20020701192415.A2617@lucon.org>
Message-ID: <Pine.GSO.3.96.1020702182354.27564D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.5 required=5.0 tests=IN_REP_TO,SUBJ_ENDS_IN_Q_MARK version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 1 Jul 2002, H. J. Lu wrote:

> That is a news to me. I couldn't find it anywhere in the Linux mips
> kernel. Could someone point me to the right place in the Linux mips
> kernel source tree?

 See do_ri() in arch/mips/kernel/traps.c.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
