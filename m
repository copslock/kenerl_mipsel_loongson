Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7KE7YEC027535
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 20 Aug 2002 07:07:34 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7KE7YEL027534
	for linux-mips-outgoing; Tue, 20 Aug 2002 07:07:34 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7KE7TEC027516
	for <linux-mips@oss.sgi.com>; Tue, 20 Aug 2002 07:07:30 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA12807;
	Tue, 20 Aug 2002 16:10:48 +0200 (MET DST)
Date: Tue, 20 Aug 2002 16:10:48 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@oss.sgi.com
Subject: Re: CVS Update@oss.sgi.com: linux
In-Reply-To: <20020819154215.B14266@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1020820160750.8700G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 19 Aug 2002, Ralf Baechle wrote:

> So disabling PCI on that machine would disable IDE also.  Other machines
> had IDE on PCMCIA with the PCMCIA bridge not hanging off an (E)ISA or PCI
> bridge.  Basically I could have changed that if statement into an
> increasingly obscure and braindamagedly complex if statement.

 Well, that would be of questional benefit, indeed.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
