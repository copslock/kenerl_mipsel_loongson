Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f39EG9q07199
	for linux-mips-outgoing; Mon, 9 Apr 2001 07:16:09 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f39EFXM07183
	for <linux-mips@oss.sgi.com>; Mon, 9 Apr 2001 07:15:34 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA19477;
	Mon, 9 Apr 2001 16:15:03 +0200 (MET DST)
Date: Mon, 9 Apr 2001 16:15:02 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Scott A McConnell <samcconn@cotw.com>
cc: linux-mips@oss.sgi.com
Subject: Re: mips_memory_upper
In-Reply-To: <3AD1BB55.224407E1@cotw.com>
Message-ID: <Pine.GSO.3.96.1010409160306.9470F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 9 Apr 2001, Scott A McConnell wrote:

> Used to be defined in ./arch/mips/kernel/setup.c

 It's no longer needed -- MIPS now uses the bootmem allocator cosistently
across system variations.  Memory holes are now permitted.  User may
override the determined memory map using a kernel command line (for
debugging, to isolate a faulty module, etc.).  The add_memory_region()
function is used to register an area of memory. 

> It is no longer defined. I also noticed that badget is now using
> vac_memory_upper.

 This is a system-specific value to write into chipset registers.  It's
not overriden by a kernel command line in any case to initialize the
chipset properly.  I can't say anything more specific about it -- I'm not
a Baget expert. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
