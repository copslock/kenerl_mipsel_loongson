Received:  by oss.sgi.com id <S305160AbQBOSEC>;
	Tue, 15 Feb 2000 10:04:02 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:19566 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305156AbQBOSDi>; Tue, 15 Feb 2000 10:03:38 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id KAA09849; Tue, 15 Feb 2000 10:06:30 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA48143
	for linux-list;
	Tue, 15 Feb 2000 09:51:05 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [163.154.5.24])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA36528;
	Tue, 15 Feb 2000 09:49:26 -0800 (PST)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id JAA11519;
	Tue, 15 Feb 2000 09:49:19 -0800
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
From:   "William J. Earl" <wje@cthulhu.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14505.37279.164044.582169@liveoak.engr.sgi.com>
Date:   Tue, 15 Feb 2000 09:49:19 -0800 (PST)
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     "Kevin D. Kissell" <kevink@mips.com>, geert@linux-m68k.org,
        linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: Indy crashes
In-Reply-To: <20000215011346.D828@uni-koblenz.de>
References: <022301bf7730$92b87180$0ceca8c0@satanas.mips.com>
	<20000215011346.D828@uni-koblenz.de>
X-Mailer: VM 6.74 under Emacs 20.3.1
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Ralf Baechle writes:
 > On Mon, Feb 14, 2000 at 10:15:02PM +0100, Kevin D. Kissell wrote:
...
 > > not the way the R5000 is specified.  So rather than set
 > > dma_cache_wback_inv to r4k_dma_cache_wback_inv_sc
 > > or r4k_dma_cache_wback_inv_pc, depending on the
 > > presence or absence of a primary cache,  in the MIPS 
 > > Technologies I bound it to a function:
 > 
 > I don't even pretend that Linux is running on a R5000 with L2 except on
 > Indy R5000SC's.  These R5000 modules are different in that they don't use
 > the L2 support which is part of the processor but rather use the same
 > external cache implementation as the R4600SC CPU modules do.
...

     If someone wants to do the real R5000SC (and RM5271 and RM7000)
cache routines, for some other platform, I can supply the required 
details.
