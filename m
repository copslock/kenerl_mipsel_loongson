Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8DFDGb08710
	for linux-mips-outgoing; Thu, 13 Sep 2001 08:13:16 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8DFDAe08707
	for <linux-mips@oss.sgi.com>; Thu, 13 Sep 2001 08:13:13 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA12854;
	Thu, 13 Sep 2001 17:14:45 +0200 (MET DST)
Date: Thu, 13 Sep 2001 17:14:45 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Kjeld Borch Egevang <kjelde@mips.com>
cc: linux-mips@oss.sgi.com
Subject: Re: Error in gcc version 2.96 20000731
In-Reply-To: <3BA0BF6E.2010300@mips.com>
Message-ID: <Pine.GSO.3.96.1010913171138.4511A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 13 Sep 2001, Kjeld Borch Egevang wrote:

> I discovered an optimization error in the current gcc for MIPS.

 Is 2.96 20000731 current?  I thought 3.0.1 is.

> When I compile the code below with -O2 it clears the code-field just 
> after setting it. The instructions are mixed up. It works fine with -O1 
> and -O0.

 Use "-fno-strict-aliasing"?

> If the "//" is removed in front of the first printf, it works too.

 Why don't you use memset() to clear the struct in the first place?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
