Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g04HZ9N12687
	for linux-mips-outgoing; Fri, 4 Jan 2002 09:35:09 -0800
Received: from oval.algor.co.uk (root@oval.algor.co.uk [62.254.210.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g04HZ1g12684
	for <linux-mips@oss.sgi.com>; Fri, 4 Jan 2002 09:35:01 -0800
Received: from mudchute.algor.co.uk (dom@mudchute.algor.co.uk [62.254.210.251])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id g04GYnt09101;
	Fri, 4 Jan 2002 16:34:49 GMT
Received: (from dom@localhost)
	by mudchute.algor.co.uk (8.8.5/8.8.5) id QAA19027;
	Fri, 4 Jan 2002 16:34:49 GMT
Date: Fri, 4 Jan 2002 16:34:49 GMT
Message-Id: <200201041634.QAA19027@mudchute.algor.co.uk>
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-mips <linux-mips@oss.sgi.com>
cc: rick@algor.co.uk, nigel@algor.co.uk, john@algor.co.uk
Subject: Designing hardware to join PCI to large local memory
X-Mailer: VM 6.34 under 19.16 "Lille" XEmacs Lucid
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Up to now, Algorithmics' MIPS-based single-board computers have
offered a maximum of 256Mbytes DRAM.  We can (and do) map all of that
to PCI at the beginning of time, so any PCI "bus master" device can
get to any part of system DRAM.

We're now working out how our system controller ("north bridge", more
or less) can handle much larger memories - we would like it to go on
past 4Gbytes.  So now there aren't enough addresses on PCI to map all
the memory.

We can see two options:

1. Just say it's too bad: PCI devices can only get at memory, say,
   from 0-256Mbytes.  We know that some PCs a while back couldn't DMA
   above 16Mbytes, and we see that the kernel memory allocator has a
   "DMA-able" flag...

   But this seems quite difficult to handle in a robust and efficient
   way; for example:

   - The virtual memory paging system presumably uses DMA into user
     pages; it would need to choose instead to allocate an
     intermediate buffer and copy data when the user page was not
     DMA-able.  Yuk.  Or copy everything - double-yuk.
     
   - Any system which is up for a long time with high memory demand
     will risk deadlock if non-DMA requirements take too much
     DMAable memory, or waste a lot of memory if they take too little.

2. Add some dynamic kind of translation so PCI devices can get to
   the memory they need anywhere, and we have enough translation
   resources to keep all pending-DMA devices happy.
   
   But the hardware will be relatively complicated, and may need
   special software routines to maintain it.

We (more specifically Chris) have looked at the kernel sources, and
concluded that schemes of both types have been attempted - though the
sources don't, of course, pass judgement on how well it worked.

Those of you with experience: which would you recommend?  And if (2),
can you point us to descriptions of good hardware facilities you've
met or even imagined?

-- 
Dominic Sweetman
Algorithmics Ltd - http://www.algor.co.uk
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone: +44 1223 706200 / fax: +44 1223 706250 / direct: +44 1223 706205
