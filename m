Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1PEDKN29564
	for linux-mips-outgoing; Mon, 25 Feb 2002 06:13:20 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1PED1929502
	for <linux-mips@oss.sgi.com>; Mon, 25 Feb 2002 06:13:02 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA15341;
	Mon, 25 Feb 2002 14:10:37 +0100 (MET)
Date: Mon, 25 Feb 2002 14:10:36 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Matthew Dharm <mdharm@momenco.com>
cc: Kevin Paul Herbert <kph@ayrnetworks.com>,
   Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: Anyone have the e1000.o driver working?
In-Reply-To: <20020223123037.A8314@momenco.com>
Message-ID: <Pine.GSO.3.96.1020225140353.12500C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, 23 Feb 2002, Matthew Dharm wrote:

> Hopefully my last message will get through... but basically e1000_main.c
> references and extern struct pointer, and the code generated doesn't look
> right -- it does a lui v0,0x0 and then a lw v0,0(v0) which causes a crash.

 What's wrong with it?  Doesn't it have a relocation attached (check with
`objdump -r')?  If so, that's a problem, otherwise there is nothing wrong
with it.  Since addresses of external symbols are only known at the load
time, relocations in kernel modules are resolved by insmod.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
