Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2003 19:29:04 +0100 (BST)
Received: from mx2.mips.com ([IPv6:::ffff:206.31.31.227]:41167 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8225474AbTI3S2b>;
	Tue, 30 Sep 2003 19:28:31 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id h8UIPqYY022467;
	Tue, 30 Sep 2003 11:25:52 -0700 (PDT)
Received: from uhler-linux.mips.com (uhler-linux [192.168.65.120])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id LAA12735;
	Tue, 30 Sep 2003 11:29:28 -0700 (PDT)
Subject: Re: 64 bit operations w/32 bit kernel
From: Michael Uhler <uhler@mips.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: "Finney, Steve" <Steve.Finney@spirentcom.com>,
	linux-mips@linux-mips.org
In-Reply-To: <20030930160023.GB4231@linux-mips.org>
References: <DC1BF43A8FAE654DA6B3FB7836DD3A56DEB75C@iris.adtech-inc.com>
	 <20030930160023.GB4231@linux-mips.org>
Content-Type: text/plain
Organization: MIPS Technologies, Inc.
Message-Id: <1064946568.13742.51.camel@uhler-linux.mips.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 30 Sep 2003 11:29:28 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <uhler@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3332
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: uhler@mips.com
Precedence: bulk
X-list: linux-mips

On Tue, 2003-09-30 at 09:00, Ralf Baechle wrote:
> On Mon, Sep 29, 2003 at 07:31:57AM -1000, Finney, Steve wrote:
> 
> > What would be the downside to enabling 64 bit operations in user space
> > on a 32 bit kernel (setting the PX bit in the status register?). The
> > particular issue is that I want to access 64 bit-memory mapped registers,
> > and I really need to do it as an atomic operation. I tried borrowing
> > sibyte/64bit.h from the kernel, but I get an illegal instruction on the
> > double ops.
> 
> Common design bug in hardware, imho ...
> 
> > Also, assuming this isn't a horrible idea, is there any obvious single
> > place where "default" values in the CP0 status register get set?
> 
> There isn't.
> 
> What you want really is a 64-bit kernel.  On a 64-bit kernel even for
> processes running in 32-bit address spaces (o32, N32) the processor
> will run with the UX bit enabled.  o32 userspace still lives in the
> assumption that registers are 32-bit so only those bits will be restored
> in function calls etc.  N32 (where userspace isn't ready for prime time
> yet) does guarantee that.  And N64 (userspace similarly not ready for
> prime time) obviously is fully 64-bit everything.

I don't think you want to run o32 processes with the UX bit set.  UX not
only enables 64-bit addressing (which you can, in software, make look
like 32-bit addressing), it also enables access to the 64-bit opcodes.
This means that you are going to get unexpected and potentially
unreproducible results.

N32 is a 64-bit data model with 32-bit addresses, so you're OK there.

/gmu

> 
>   Ralf
-- 

Michael Uhler, Chief Technology Officer
MIPS Technologies, Inc.  Email: uhler@mips.com  Pager:uhler_p@mips.com
1225 Charleston Road     Voice:  (650)567-5025  FAX:   (650)567-5225
Mountain View, CA 94043  Mobile: (650)868-6870  Admin: (650)567-5085
