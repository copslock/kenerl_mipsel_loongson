Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAR7ckd08998
	for linux-mips-outgoing; Mon, 26 Nov 2001 23:38:46 -0800
Received: from holomorphy (mail@holomorphy.com [216.36.33.161])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAR7cgo08995
	for <linux-mips@oss.sgi.com>; Mon, 26 Nov 2001 23:38:42 -0800
Received: from wli by holomorphy with local (Exim 3.31 #1 (Debian))
	id 168bss-00038I-00
	for <linux-mips@oss.sgi.com>; Mon, 26 Nov 2001 22:38:22 -0800
Date: Mon, 26 Nov 2001 22:38:22 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-mips@oss.sgi.com
Subject: [RFC] tree-based bootmem
Message-ID: <20011126223822.N1048@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Organization: The Domain of Holomorphy
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

A number of people have expressed a wish to replace the bitmap-based            
bootmem allocator with one that tracks ranges explicitly. I have
written such a replacement in order to deal with some of the situations
I have encountered, in particular, to require less programming effort
to initialize on machines with sparse and irregular memory layouts.

The following patch features space usage proportional only to the number
of distinct fragments of memory, tracking available memory at address
granularity up until the point of initializing per-page data structures,
and the use of segment trees in order to support efficient searches on
those rare machines where this is an issue. According to testing, this
patch appears to save somewhere between 8KB and 2MB on i386 PC's versus
the bitmap-based bootmem allocator.

The following patch has been tested on i386 PC's, IA64 Lions, Netwinders,
DecStation 5000/200's, and IBM IA64 NUMA hardware with sparse memory,
and debugged without the help of logic analyzers or in-target probes. I
would like to thank the testers of #kernelnewbies (reltuk and asalib)
and my co-workers for their help in making this work, and Tony Luck and
Jack Steiner for their assistance in profiling the existing bootmem.

I am now especially interested in feedback regarding its design, and
also the results of wider testing.

The patch is available at

  ftp://ftp.kernel.org/pub/linux/kernel/people/wli/bootmem/bootmem-2.5.1-pre1


Cheers,
Bill
