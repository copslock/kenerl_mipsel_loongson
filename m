Received:  by oss.sgi.com id <S553698AbQJXEfu>;
	Mon, 23 Oct 2000 21:35:50 -0700
Received: from ns1.SuSE.com ([202.58.118.2]:64527 "HELO ns1.suse.com")
	by oss.sgi.com with SMTP id <S553679AbQJXEfb>;
	Mon, 23 Oct 2000 21:35:31 -0700
Received: from zappa.oak.suse.com (fw.SuSE.com [202.58.118.35])
	by ns1.suse.com (Postfix) with ESMTP id A07C6DF918
	for <linux-mips@oss.sgi.com>; Mon, 23 Oct 2000 21:34:25 -0700 (PDT)
Received: from home.oak.suse.com (home.oak.suse.com [192.168.0.4])
	by zappa.oak.suse.com (Postfix) with ESMTP id 07203AFB15
	for <linux-mips@oss.sgi.com>; Mon, 23 Oct 2000 21:35:31 -0700 (PDT)
Received: by home.oak.suse.com (Postfix, from userid 0)
	id D890C7E824; Mon, 23 Oct 2000 21:35:30 -0700 (PDT)
Date:   Mon, 23 Oct 2000 21:35:30 -0700
From:   Randall Craig <randall@suse.com>
To:     linux-mips@oss.sgi.com
Subject: R5000SC
Message-ID: <20001023213530.A32077@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I think from the faq that the R5000SC is not supported:
---Snip----
Not supported are R4000MC and R4400MC CPUs (that is multiprocessor
systems) as well as R5000 systems with a CPU controlled second level
cache. This means where the cache is controlled by the R5000 itself in
contrast to some external external cache controller. The difference is
important because, unlike other systems, especially PCs, on MIPS the
cache is architecturally visible and needs to be controlled by
software.
---Snap---

The machine seems seems to have Secondary unified cache.  Could anyone
confirm that this machine is not supported.


Here is some more info, I do not have access to the machine.


     1 180 MHZ IP22 Processor
     FPU: MIPS R5000 Floating Point Coprocessor Revision: 1.0
     CPU: MIPS R5000 Processor Chip Revision: 2.1
     On-board serial ports: 2
     On-board bi-directional parallel port
     Data cache size: 32 Kbytes
     Instruction cache size: 32 Kbytes
     Secondary unified instruction/data cache size: 512 Kbytes on
     Processor 0


-- 
Randall H. Craig
SuSE Inc.,                 Tel:   +1-510-628-3380 (ext. 5004)
580 Second St., Suite 210  Fax:   +1-510-835-3381
Oakland CA 94607           Email: randall@suse.com
USA                        WWW:   http://www.suse.com
