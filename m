Received:  by oss.sgi.com id <S305263AbQEAIDO>;
	Mon, 1 May 2000 01:03:14 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:6709 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305163AbQEAICx>; Mon, 1 May 2000 01:02:53 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id BAA02068; Mon, 1 May 2000 01:07:07 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id AAA75372
	for linux-list;
	Mon, 1 May 2000 00:48:29 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id AAA63781
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 1 May 2000 00:48:26 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id AAA00217
	for <linux@cthulhu.engr.sgi.com>; Mon, 1 May 2000 00:48:23 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-9.uni-koblenz.de (cacc-9.uni-koblenz.de [141.26.131.9])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id JAA07727;
	Mon, 1 May 2000 09:48:23 +0200 (MET DST)
Received:  by lappi.waldorf-gmbh.de id <S1405679AbQEAHru>;
	Mon, 1 May 2000 09:47:50 +0200
Date:   Mon, 1 May 2000 09:47:50 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     Florian Lohoff <flo@rfc822.org>, linux@cthulhu.engr.sgi.com
Subject: Re: VC exceptions
Message-ID: <20000501094750.B21036@uni-koblenz.de>
References: <002801bfb2e9$d0bec2f0$0ceca8c0@satanas.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <002801bfb2e9$d0bec2f0$0ceca8c0@satanas.mips.com>; from kevink@mips.com on Sun, Apr 30, 2000 at 11:19:41PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Sun, Apr 30, 2000 at 11:19:41PM +0200, Kevin D. Kissell wrote:

> >Apropriate placement of mappings in the address space isn't always possible.
> >MAP_FIXED is one example.  Aliases in the page cache are harder to handle. 
> >If one of the page cache mappings is writable then readers may even observe 
> >stale data or in worst  case stale data being written to disk.
> 
> mmap() is allowed to fail.  I would think that,  if someone tries to force an 
> unsafe mapping, one should give them EINVAL if one doesn't want to deal 
> with the special case otherwise, or create a copy-on-write clone in a safe
> physical page if one wants to be extra-specially nice...

I'm only worried because I don't know how much software such a change
would break.

IRIX uses something they call page ownership switching.  Essentially they
ensure that only mappings of one colour are accessible at any time.
Accessing a page's mapping of a different colour will make the mm flush
caches, make the old colour inaccessible and the new colour accessible
in the page tables.  That requires a reverse mapping of physical to virtual
addresses, something that Linus so far has always refused to accept.

  Ralf
