Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA72666 for <linux-archive@neteng.engr.sgi.com>; Tue, 4 May 1999 15:17:51 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA39948
	for linux-list;
	Tue, 4 May 1999 15:16:35 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA72205;
	Tue, 4 May 1999 15:16:29 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA01990; Tue, 4 May 1999 18:16:24 -0400 (EDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-12.uni-koblenz.de [141.26.131.12])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id AAA23484;
	Wed, 5 May 1999 00:16:17 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id AAA01300;
	Wed, 5 May 1999 00:16:07 +0200
Message-ID: <19990505001606.E1063@uni-koblenz.de>
Date: Wed, 5 May 1999 00:16:06 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Dave Olson <olson@anchor.engr.sgi.com>,
        Charles Lepple <clepple@foo.tho.org>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: building an elf64 R10k kernel
References: <372E6AA0.505A6071@foo.tho.org> <199905040354.UAA16791@anchor.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <199905040354.UAA16791@anchor.engr.sgi.com>; from Dave Olson on Mon, May 03, 1999 at 08:54:28PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, May 03, 1999 at 08:54:28PM -0700, Dave Olson wrote:

> Charles Lepple wrote: 
> |  Hey all,
> |  Does anyone out there know any details on building elf64 objects? I was
> |  all happy about seeing Andrew's Indigo2 patches, and decided that I
> |  _had_ to try and make it work on an Indigo2 Impact 10000... Suffice it
> |  to say that it isn't straightforward.
> 
> For r10k Indigo2 to work, you will need to hack the compiler,
> for various reasons (the way the r10k works, plus the fact that
> indigo2 doesn't have i/o cache coherency, interact in some "interesting"
> ways.  I would suggest not attempting this port, unless you have a *lot*
> of spare time.

Let me point out that SGI has invented an almost genious workaround for a
R10000 bug that only hits systems without I/O cache coherency, that is the
Indigo2 and O2.

When I first read the description of the bug and it's workaround I thought
I'd be halucinating ...

  Ralf
