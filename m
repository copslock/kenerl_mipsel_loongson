Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9JDLTA26769
	for linux-mips-outgoing; Fri, 19 Oct 2001 06:21:29 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9JDLED26763
	for <linux-mips@oss.sgi.com>; Fri, 19 Oct 2001 06:21:15 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA07780;
	Fri, 19 Oct 2001 15:20:35 +0200 (MET DST)
Date: Fri, 19 Oct 2001 15:20:33 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Gerald Champagne <gerald.champagne@esstech.com>
cc: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Moving kernel_entry to LOADADDR
In-Reply-To: <3BCF7AD2.2000000@esstech.com>
Message-ID: <Pine.GSO.3.96.1011019152007.1657E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 18 Oct 2001, Gerald Champagne wrote:

> I also removed the .fill, and now kernel_entry is always exactly LOADADDR,
> and that makes my bootloader easier to maintain.
> 
> Is this worth changing in cvs, or did I miss something?

 How about just getting it from the ELF header?  It's trivial.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
