Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBIL4RG06950
	for linux-mips-outgoing; Tue, 18 Dec 2001 13:04:27 -0800
Received: from neurosis.mit.edu (NEUROSIS.MIT.EDU [18.243.0.82])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBIL4Po06947
	for <linux-mips@oss.sgi.com>; Tue, 18 Dec 2001 13:04:25 -0800
Received: (from jim@localhost)
	by neurosis.mit.edu (8.11.4/8.11.4) id fBIK4Nn12205
	for linux-mips@oss.sgi.com; Tue, 18 Dec 2001 15:04:23 -0500
Date: Tue, 18 Dec 2001 15:04:23 -0500
From: Jim Paris <jim@jtan.com>
To: linux-mips@oss.sgi.com
Subject: ISA
Message-ID: <20011218150423.A12143@neurosis.mit.edu>
Reply-To: jim@jtan.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Okay, so I'll change the i82365 driver to use isa_{read,write}[bwl]
instead of ioremap & {read,write}[bwl], when CONFIG_ISA is defined.
That shouldn't break other architectures.

But how should I deal with {check,request,release}_mem_region? 
Should I make isa_{check,request,release}_mem_region which adds
isa_slot_offset to all of the memory addresses?  Or should I add
isa_slot_offset - KSEG1?  Or..?

-jim
