Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBIN1j420750
	for linux-mips-outgoing; Tue, 18 Dec 2001 15:01:45 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBIN1ao20747
	for <linux-mips@oss.sgi.com>; Tue, 18 Dec 2001 15:01:36 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id XAA12551;
	Tue, 18 Dec 2001 23:01:05 +0100 (MET)
Date: Tue, 18 Dec 2001 23:01:04 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jim Paris <jim@jtan.com>
cc: linux-mips@oss.sgi.com
Subject: Re: ISA
In-Reply-To: <20011218164409.A12517@neurosis.mit.edu>
Message-ID: <Pine.GSO.3.96.1011218225404.10322C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 18 Dec 2001, Jim Paris wrote:

> 1) Isn't the purpose of ioremap to remap I/O memory addresses to
>    physical ones?  For an ISA architecture like mine, this means
>    it needs to add isa_slot_offset.

 Yes it is.  Also see Documentation/IO-mapping.txt and the Alpha port.

> 2) /proc/iomem should not contain system RAM.  The RAM is not 
>    in I/O memory space on my system, so why does it show up in the
>    iomem resource?  On x86, sure, I/O and RAM memory space are the
>    same, but they're not here.

 It *has to* contain the system RAM.  Otherwise a device driver would be
allowed to grab a chunk of that memory successfully, possibly destroying
the system.  Now it gets an error and can gracefully handle it if it tries
to get the memory for some, possibly legitimate reason. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
