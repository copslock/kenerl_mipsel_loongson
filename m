Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3CED8M08388
	for linux-mips-outgoing; Thu, 12 Apr 2001 07:13:08 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3CEB8M08321
	for <linux-mips@oss.sgi.com>; Thu, 12 Apr 2001 07:13:00 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA25904;
	Thu, 12 Apr 2001 16:09:48 +0200 (MET DST)
Date: Thu, 12 Apr 2001 16:09:47 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Michael Shmulevich <michaels@jungo.com>
cc: Linux/MIPS <linux-mips@oss.sgi.com>, FR Linux/MIPS <linux-mips@fnet.fr>
Subject: Re: Dynamic linker and .interp section
In-Reply-To: <3AD5B003.7000908@jungo.com>
Message-ID: <Pine.GSO.3.96.1010412160800.24526A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 12 Apr 2001, Michael Shmulevich wrote:

> So my question sounds like: can I specify a non-existing linker and tell 
> ld to ignore missing file?

 You can.  Ld never checks for its existence.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
