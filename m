Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g42IpbwJ013341
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 2 May 2002 11:51:37 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g42IpaRm013340
	for linux-mips-outgoing; Thu, 2 May 2002 11:51:36 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from real.realitydiluted.com (real.realitydiluted.com [208.242.241.164])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g42IpTwJ013337
	for <linux-mips@oss.sgi.com>; Thu, 2 May 2002 11:51:30 -0700
Received: from dsl73.cedar-rapids.net ([208.242.241.39] helo=cotw.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 173Lgm-0008Pi-00
	for <linux-mips@oss.sgi.com>; Thu, 02 May 2002 13:52:24 -0500
Message-ID: <3CD19872.63FBF81E@cotw.com>
Date: Thu, 02 May 2002 14:50:10 -0500
From: Scott A McConnell <samcconn@cotw.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Accounting for all memory.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I am trying to understand memory usage on my system.
NEC VR5432, mipsel, 2.4.5 kernel

Does slab info appear in "used:" column of /proc/meminfo?
What the holes "??????" in /proc/iomem are used for?
I can not account for all of the "1268k reserved memory.

Thanks in advance,
Scott

-----------------------------------------------------------------------
<4>Memory: 4876k/6144k available (801k kernel code, 1268k reserved, 69k
data, 60k init)
...
<4>Freeing unused kernel memory: 60k freed
-----------------------------------------------------------------------

/proc # cat iomem 
00000000-005fffff : System RAM
  00000000-00000fff : ???????????       4096 (added by hand)
  00001000-000ca687 : Kernel code     824968
  000ca688-000db99f : ???????????      70424 (added by hand)
  000db9a0-000ed033 : Kernel data      71316
                                      ------
                                      970804

/proc # cat meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:   5046272  1392640  3653632        0    16384   598016
Swap:        0        0        0
MemTotal:         4928 kB
MemFree:          3568 kB
MemShared:           0 kB
Buffers:            16 kB
Cached:            584 kB
Active:            600 kB
Inact_dirty:         0 kB
Inact_clean:         0 kB
Inact_target:       12 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:         4928 kB
LowFree:          3568 kB
SwapTotal:           0 kB

  6291456     (6 MB allocated to kernel in prom.c)
- 5046272     (Total memory in use)
---------
  1245184     

1245184 - 970804(Kernel memory) = 274380 I can not account for this
memory.

-- 
Scott A. McConnell
