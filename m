Received:  by oss.sgi.com id <S305253AbQD2WIa>;
	Sat, 29 Apr 2000 15:08:30 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:20051 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305163AbQD2WIL>; Sat, 29 Apr 2000 15:08:11 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id PAA02768; Sat, 29 Apr 2000 15:12:23 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA57321
	for linux-list;
	Sat, 29 Apr 2000 14:57:42 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA39397
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 29 Apr 2000 14:57:41 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA01404
	for <linux@cthulhu.engr.sgi.com>; Sat, 29 Apr 2000 14:57:39 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-23.uni-koblenz.de (cacc-23.uni-koblenz.de [141.26.131.23])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id XAA10027;
	Sat, 29 Apr 2000 23:57:37 +0200 (MET DST)
Received:  by lappi.waldorf-gmbh.de id <S1406466AbQD2FdY>;
	Sat, 29 Apr 2000 07:33:24 +0200
Date:   Sat, 29 Apr 2000 07:33:24 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     Florian Lohoff <flo@rfc822.org>, linux@cthulhu.engr.sgi.com
Subject: Re: VC exceptions
Message-ID: <20000429073324.B491@uni-koblenz.de>
References: <001001bfb074$22311480$0957d3d4@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <001001bfb074$22311480$0957d3d4@Ulysses>; from kevink@mips.com on Thu, Apr 27, 2000 at 08:12:14PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Thu, Apr 27, 2000 at 08:12:14PM +0200, Kevin D. Kissell wrote:

> It's a thing that can happen whenever caches are
> virtually indexed (for speed) but physically tagged
> (for correctness), and caches get large enough for
> the algorithm to be wrong once in a while.  They can
> be avoided with a little thought and overhead in the
> assignment of physical pages to virtual addresses.
> Gimme a day or so to look at the code, and I'll propose
> a fix for Linux...

Apropriate placement of mappings in the address space isn't always possible.
MAP_FIXED is one example.  Aliases in the page cache are harder to handle.
If one of the page cache mappings is writable then readers may even
observe stale data or in worst case stale data being written to disk.

Btw, the creators of the MIPS ABI were smart, they specified a sufficiently
large value for SHMLBA such that we don't need to care about SysV IPC.

  Ralf
