Received:  by oss.sgi.com id <S305166AbQBNW0C>;
	Mon, 14 Feb 2000 14:26:02 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:28534 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305156AbQBNWZs>;
	Mon, 14 Feb 2000 14:25:48 -0800
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id OAA14815; Mon, 14 Feb 2000 14:21:17 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id OAA27393; Mon, 14 Feb 2000 14:25:17 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA88568
	for linux-list;
	Mon, 14 Feb 2000 13:57:50 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [163.154.5.24])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA11954;
	Mon, 14 Feb 2000 13:57:29 -0800 (PST)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id NAA26704;
	Mon, 14 Feb 2000 13:57:23 -0800
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
From:   "William J. Earl" <wje@cthulhu.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14504.31299.82555.477086@liveoak.engr.sgi.com>
Date:   Mon, 14 Feb 2000 13:57:23 -0800 (PST)
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     <geert@linux-m68k.org>, "Ralf Baechle" <ralf@oss.sgi.com>,
        <linux@cthulhu.engr.sgi.com>, <linux-mips@fnet.fr>,
        <linux-mips@vger.rutgers.edu>
Subject: Re: Indy crashes
In-Reply-To: <022301bf7730$92b87180$0ceca8c0@satanas.mips.com>
References: <022301bf7730$92b87180$0ceca8c0@satanas.mips.com>
X-Mailer: VM 6.74 under Emacs 20.3.1
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Kevin D. Kissell writes:
...
 > However, I have not had the opportunity to test this code on
 > an R5000SC platform.   Looking at the R5000 spec, it is a
 > little ambiguous.  The special case of sc HWIs affecting
 > the primary isn't there, but then again sc HWIs aren't even
 > called out in the table of defined cache operations.  Indeed,
 > one *could* interpret the spec to mean that HWI on the 
 > *primary* flushes the secondary, the reverse of the R4000,
 > but it's by no means clear.   Thus I suggest hitting 'em both.
 > 
 > Does anybody on this list have an R527x manual?   How
 > is HWI of the primary/seconday caches defined there?

      I am very familiar with how the R5000 and similar processors
works.  The secondary cache is essentially independent of the primary
caches, and is write-through.  It hangs on the SysAD bus and captures
cache lines being read, and returns a captured cache line on a later
read.

     You must separately invalidate the primary and secondary caches.
If you care about instruction cache coherency (as when reading in executable
pages), you have to invalidate the primary instruction cache, not just
the primary data cache.

     Since the secondary cache is write-through, you need only invalidate
it on reads; you can ignore it on writes.
