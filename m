Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Dec 2002 03:20:56 +0100 (CET)
Received: from gateway-1237.mvista.com ([12.44.186.158]:57333 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225215AbSLKCUz>;
	Wed, 11 Dec 2002 03:20:55 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id gBB2KpA01237;
	Tue, 10 Dec 2002 18:20:51 -0800
Date: Tue, 10 Dec 2002 18:20:51 -0800
From: Jun Sun <jsun@mvista.com>
To: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: possible cache aliasing problem with O_DIRECT?
Message-ID: <20021210182051.X8642@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 848
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


I am chasing a problem which might be a cache aliasing problem
when a disk file is opened with O_DIRECT flag.

I attached the source code of two programs.  One generates a binary file
and the other opens the file with O_DIRECT and reads it.  It checks
the content of the file while reading it.

I tested this on a MIPS board with NEC vr5432 CPU, which has a
virtually indexed, two-way set associative d-cache, and can easily 
re-produce the data corruption problem.

I attached a patch which apparently solves the problem.

I am not an expert in fs and mm, but my guess is:

1) user process allocates a big buffer
2) the user buffer is mapped into kernel virtual space for doing direct IO 
   through map_user_kiobuf()
3) since the virtual address for buffer area is different in user space
   from that in kernel virtual, kernel should do a flush cache for those
   pages after doing the IO.  That is why my attached patch makes it work.

Does this make sense?

However, I still have some puzzles.  For it to work completely, another
cache flushing needs to be done for the address range of the buffer in user
space.  I thought this should be done some where inside map_user_kiobuf()
but could not find it anywhere.  Did I miss it?  Or it just happens to work
even without it?

Another puzzling part is that I also tested the program on another couple
of MIPS boards which *should* suffer from this problem, but failed to 
re-produce it.

Any thoughts?

Jun
