Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2004 15:22:16 +0000 (GMT)
Received: from p508B617B.dip.t-dialin.net ([IPv6:::ffff:80.139.97.123]:26379
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224914AbUASPWQ>; Mon, 19 Jan 2004 15:22:16 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i0JFMFex010119;
	Mon, 19 Jan 2004 16:22:15 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i0JFMEpK010118;
	Mon, 19 Jan 2004 16:22:14 +0100
Date: Mon, 19 Jan 2004 16:22:14 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: karthikeyan natarajan <karthik_96cse@yahoo.com>
Cc: Dominic Sweetman <dom@mips.com>, linux-mips@linux-mips.org
Subject: Re: In r4k, where does PC point to?
Message-ID: <20040119152214.GA9933@linux-mips.org>
References: <16395.61512.498041.811385@gladsmuir.mips.com> <20040119151403.71569.qmail@web10106.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040119151403.71569.qmail@web10106.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4037
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 19, 2004 at 03:14:03PM +0000, karthikeyan natarajan wrote:

> > Which is true, but perhaps a bit cryptic given the
> > question.
> > 
> > A MIPS CPU does not have a register called "PC".  In
> 
> In the r4k user manual, it is mentioned that there is
> a special register PC in the core CPU (other than the 
> HI & LO special registers). Could you please let me 
> know the purpose of this register?

Obviously the CPU needs to know where to fetch the next instruction from
or for computing the destination address of branch and jump instructions
or the value to put into the programmer visible EPC and ErrorEPC registers
etc.  The PC register is an internal register that isn't visible to the
programmer.

  Ralf
