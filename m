Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7KEXkEC028065
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 20 Aug 2002 07:33:46 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7KEXklr028064
	for linux-mips-outgoing; Tue, 20 Aug 2002 07:33:46 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7KEXeEC028055
	for <linux-mips@oss.sgi.com>; Tue, 20 Aug 2002 07:33:42 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA13322;
	Tue, 20 Aug 2002 16:36:56 +0200 (MET DST)
Date: Tue, 20 Aug 2002 16:36:55 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>,
   SGI MIPS list <linux-mips@oss.sgi.com>
Subject: Re: [PATCH] Bring back R4600 V1.7 support
In-Reply-To: <20020820160311.A26912@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1020820163113.8700I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 20 Aug 2002, Ralf Baechle wrote:

> I was thinking about that already but the erratas don't provide enough
> details.  The only problem I can see is that ll/sc are fairly slow on some

 Well, IDT didn't seem much mobilized with my single query.  Maybe if
there was more interest expressed, someone would go digging through old
resources for real.

> architectures.  They're supposed to be quite light according to the docs
> but in reality I benchmarked ~ 13 cycles for a spinlock on a R10000 and
> ~ 44 on a more recent chip.

 Well, the code would only execute on an R4600 V1.7... 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
