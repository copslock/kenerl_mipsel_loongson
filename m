Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2003 17:50:03 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:17403 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225344AbTJ0RuA>;
	Mon, 27 Oct 2003 17:50:00 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h9RHnss01701;
	Mon, 27 Oct 2003 09:49:54 -0800
Date: Mon, 27 Oct 2003 09:49:54 -0800
From: Jun Sun <jsun@mvista.com>
To: Teresa Tao <TERESAT@TTI-DM.COM>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: need help on bus error problem
Message-ID: <20031027094954.B1678@mvista.com>
References: <92F2591F460F684C9C309EB0D33256FA01B54329@trid-mail1.tridentmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <92F2591F460F684C9C309EB0D33256FA01B54329@trid-mail1.tridentmicro.com>; from TERESAT@TTI-DM.COM on Sat, Oct 25, 2003 at 09:44:35AM -0700
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3519
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Sat, Oct 25, 2003 at 09:44:35AM -0700, Teresa Tao wrote:
> Hi there,
> 
> I am working on an real time video playback applicaion on a mips cpu. But after my video application play a while like 5 to 10 minutes, a bus error happened.
> 
> We add some debug meesage in the kernel, so we know that after the do_ade function inside the unalign.c, the bus error happens for the opcode lw or sw. So my guess is that I have an unaligned memory pointer(not in 4 byte boundary).
> But my puzzle is that if I have an unaligned memory pointer, it should happen at the first loop I playback, how come it happens after it plays several loops?
> 

There are many reasons for having bus error, cache, errant pointers,
unstable hardware, or some tricky kernel bugs which happens when
certain conditions happen together.

> Is there a possibility that my application's stack being trashed after a while? but I don't have recursive calls inside my application.

Everything is possible.  :)

Jun
