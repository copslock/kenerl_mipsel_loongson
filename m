Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4GF6fnC026368
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 16 May 2002 08:06:41 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4GF6f9e026367
	for linux-mips-outgoing; Thu, 16 May 2002 08:06:41 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from lars.roch.silverbacksystems.com ([209.180.49.225])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4GF6bnC026364
	for <linux-mips@oss.sgi.com>; Thu, 16 May 2002 08:06:37 -0700
Received: from silverbacksystems.com (mars.roch.silverbacksystems.com [10.0.0.15])
	by lars.roch.silverbacksystems.com (8.11.1/8.11.1) with ESMTP id g4GF73U24765
	for <linux-mips@oss.sgi.com>; Thu, 16 May 2002 10:07:03 -0500
Message-ID: <3CE3CB16.1040503@silverbacksystems.com>
Date: Thu, 16 May 2002 10:07:02 -0500
From: Ken Aaker <kaaker@silverbacksystems.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
CC: linux-mips@oss.sgi.com
Subject: Re: Mangled struct hd_driveid with MIPSEB.
References: <3CE2C834.2010302@silverbacksystems.com> <3CE3578C.CF29A2D6@mips.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

The problem with the difference isn't that it's byte swapped, its that 
the byte swapping isn't respecting the data types inside the structure. 
It fixes all of the "short" entities, but it re-orders the fields that 
happen to be two chars next to each other, and the "shorts" that are 
part of the two "ints" for lba capacity and capacity values are in the 
wrong order, even though the bytes within the "shorts" are in the right 
order. So, when the fixup code in ide.h is run, the values are still wrong.


old ----
0070: 3f0010fc fb000001 80ac7e03 00000704   "?.........~....."
0080: 03007800 78007800 78000000 00000000   "..x.x.x.x......."
new---
0070: 003ffc10 00fb0100 ac80037e 00000407   ".?.........~...."
0080: 00030078 00780078 00780000 00000000   "...x.x.x.x......"

proper--- (after fix up).
0070: 003f00fb fc100001 037eac80 00000407   ".?.......~......"
0080: 00030078 00780078 00780000 00000000   "...x.x.x.x......"


Ken
