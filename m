Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBAH4Rl08970
	for linux-mips-outgoing; Mon, 10 Dec 2001 09:04:27 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBAH4Jo08902;
	Mon, 10 Dec 2001 09:04:20 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA25531;
	Mon, 10 Dec 2001 17:03:43 +0100 (MET)
Date: Mon, 10 Dec 2001 17:03:41 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Kip Walker <kwalker@broadcom.com>, linux-mips@oss.sgi.com
Subject: Re: .section problems in entry.S
In-Reply-To: <20011209221835.A11737@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1011210165719.24010A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, 9 Dec 2001, Ralf Baechle wrote:

> Certainly not.  The problem is known and so far I've just hacked around
> it more or less elegant.  But it's a trap and so I think we've got good
> reasons to force people to upgrade to a newer assembler than the current
> minimal version.  The question is which - I don't like frequent tool
> upgrades.

 There are no working released binutils for a modern MIPS/Linux system,
AFAIK.  However, version 2.11.92 from the CVS seems to work reasonably
well now, so chances are the next release will do as well.  Maybe 2.12
will be a good candidate then, once it is released and tested a bit. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
