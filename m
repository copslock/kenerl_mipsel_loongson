Received:  by oss.sgi.com id <S305198AbQBJQsZ>;
	Thu, 10 Feb 2000 08:48:25 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:63541 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305155AbQBJQsN>; Thu, 10 Feb 2000 08:48:13 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id IAA03458; Thu, 10 Feb 2000 08:50:59 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA11097
	for linux-list;
	Thu, 10 Feb 2000 08:26:31 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA02341
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 10 Feb 2000 08:26:25 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA09142
	for <linux@cthulhu.engr.sgi.com>; Thu, 10 Feb 2000 08:26:23 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-9.uni-koblenz.de (cacc-9.uni-koblenz.de [141.26.131.9])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id RAA29536;
	Thu, 10 Feb 2000 17:25:57 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407895AbQBJQPd>;
	Thu, 10 Feb 2000 17:15:33 +0100
Date:   Thu, 10 Feb 2000 17:15:33 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jeff Harrell <jharrell@ti.com>
Cc:     sgi-mips <linux@cthulhu.engr.sgi.com>,
        linux-mips <linux-mips@fnet.fr>,
        linux-mips <linux-mips@vger.rutgers.edu>
Subject: Re: Question concerning memory initialization (4M->64M)
Message-ID: <20000210171533.A2933@uni-koblenz.de>
References: <38A1CFAE.EFA429BA@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <38A1CFAE.EFA429BA@ti.com>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, Feb 09, 2000 at 01:35:58PM -0700, Jeff Harrell wrote:

> I have run into an interesting problem and would like to run it past this
> newsgroup to see if anyone has any experience in these areas.  I am
> running kernel 2.3.22 and have upgraded my memory space from ~4M
> (0x400000) to ~64M (0x4000000).  I run the 4M version of the kernel and
> have no problems but when I run the 64M version, I run into problems
> during the mem_init() portion of the code.  Specifically during the
> free_page(tmp) call during the determination of totalram, codepages and
> datapages.  It looks like it is failing during the call to
> remove_mem_queue() within free_pages_ok().  I am seeing the next->prev and
> prev->next set to 0 causing a page fault.

The free pages are being stored in a circular list, so struct page of a free
page should never have prev or next set to zero.  Smells like memory
corruption.

> Is there anything that anyone is aware of that I would need to change
> (beyond mips_memory_upper) that would enable me to increase available
> memory to 64M.  Any insights would be greatly appreciated.

That alone should be sufficient.

> Additional information:
> ------------------
> 
> high memory: 0x83fff000  start memory: 0x80433000

I assume these are the values of start_mem and mem_end as passed to
mem_init()?  In that case these values look sane.

  Ralf
