Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7NHTYS32729
	for linux-mips-outgoing; Thu, 23 Aug 2001 10:29:34 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7NHTVd32726
	for <linux-mips@oss.sgi.com>; Thu, 23 Aug 2001 10:29:31 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA24561;
	Thu, 23 Aug 2001 19:31:46 +0200 (MET DST)
Date: Thu, 23 Aug 2001 19:31:46 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.5: Export mips_machtype
In-Reply-To: <3B8537C2.E18E5125@mvista.com>
Message-ID: <Pine.GSO.3.96.1010823192712.21718H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 23 Aug 2001, Jun Sun wrote:

> I talked about machine detection a while back.  My idea is following:
> 
> 0. all machines that are *configured* into the image will supply <my>_detect()
> and <my>_setup() functions.
> 
> 1. at MIPS start up, we loop through all <my>_detect(), which returns three
> values, a) run-time detection negative, b) run-time detection positive, and c)
> no run-time detection code, but I return positive because I am configured in.
> 
> 2. the startup code resolves conflicts (which sometimes may panic); and decide
> on one machine.
> 
> 3. then the startup code calls the right <my>_setup() code which will set up
> the mach_type and other stuff. 

 It sounds reasonable.  We may also check the Alpha port for solutions --
it supports multiple dissimilar systems as well.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
