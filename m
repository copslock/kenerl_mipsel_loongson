Received:  by oss.sgi.com id <S305166AbQBOAcm>;
	Mon, 14 Feb 2000 16:32:42 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:49957 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305156AbQBOAcW>;
	Mon, 14 Feb 2000 16:32:22 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id QAA03263; Mon, 14 Feb 2000 16:27:51 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA51191
	for linux-list;
	Mon, 14 Feb 2000 16:17:30 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA19906
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 14 Feb 2000 16:17:22 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA08207
	for <linux@cthulhu.engr.sgi.com>; Mon, 14 Feb 2000 16:17:20 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-16.uni-koblenz.de (cacc-16.uni-koblenz.de [141.26.131.16])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id BAA29181;
	Tue, 15 Feb 2000 01:17:10 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407895AbQBOANq>;
	Tue, 15 Feb 2000 01:13:46 +0100
Date:   Tue, 15 Feb 2000 01:13:46 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     geert@linux-m68k.org, Ralf Baechle <ralf@oss.sgi.com>,
        linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: Indy crashes
Message-ID: <20000215011346.D828@uni-koblenz.de>
References: <022301bf7730$92b87180$0ceca8c0@satanas.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <022301bf7730$92b87180$0ceca8c0@satanas.mips.com>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, Feb 14, 2000 at 10:15:02PM +0100, Kevin D. Kissell wrote:

> The problem may be in the assumption made even in the
> most recent 2.3.x code that a hit-writeback-invalidate cache
> operation on the secondary cache automagically affects the
> primary.  That's the way it is on the R4000/4400, but that's

Yep.

> not the way the R5000 is specified.  So rather than set
> dma_cache_wback_inv to r4k_dma_cache_wback_inv_sc
> or r4k_dma_cache_wback_inv_pc, depending on the
> presence or absence of a primary cache,  in the MIPS 
> Technologies I bound it to a function:

I don't even pretend that Linux is running on a R5000 with L2 except on
Indy R5000SC's.  These R5000 modules are different in that they don't use
the L2 support which is part of the processor but rather use the same
external cache implementation as the R4600SC CPU modules do.

  Ralf
