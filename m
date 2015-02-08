Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Feb 2015 13:06:18 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27011396AbbBHMGRH3Msd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 8 Feb 2015 13:06:17 +0100
Date:   Sun, 8 Feb 2015 12:06:17 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
cc:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: IP27: Random hard locks after ~16hrs uptime
In-Reply-To: <54D6D0D5.8020704@gentoo.org>
Message-ID: <alpine.LFD.2.11.1502081003060.22715@eddie.linux-mips.org>
References: <54D6D0D5.8020704@gentoo.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45764
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Sat, 7 Feb 2015, Joshua Kinard wrote:

> I've had my Onyx2 running quite a bit lately doing compile runs, and it seems
> that after about ~16 hours, there's a random possibility that the machine just
> completely stops.  No errors printed anywhere, serial becomes completely
> unresponsive.  I have to issue a 'rst' from the MSC to bring it back up again.

 If the time spent up is always similar, then one possibility is a counter 
wraparound or suchlike that is not handled correctly (i.e. the carry from 
the topmost bit is not taken into account), causing a kernel deadlock.

> It's currently got dual IP31 R14000 node boards (500MHz), and for the most
> part, runs great (I'll regret the electric bill later...).  Clearly a bug,
> though, but I am not sure where to start debugging on this platform to find
> this bug, since I can't trigger it manually.  Even tried an NMI interrupt,
> since this machine has an NMI handler in the kernel, but all that does is reset
> the machine.

 The NMI exception is routed to the same vector reset is, firmware would 
have to tell them apart (with the use of the CP0.Status.NMI bit) and then 
call a handler supplied.  Perhaps there's a way to register such a handler 
with the firmware -- does the kernel do it?  You could then use the 
handler to examine the kernel state and perhaps dump it somehow.

 On MIPS processors an NMI or even a reset event does not clobber any 
registers except from the CP0 ErrorEPC register, where the PC at the time 
the event happened is stored, some bits in the CP0 Status register (ERL, 
BEV, etc.), and of course the PC.  So alternatively does the firmware have 
a way to dump registers on reset or NMI then somehow?

 For example R4k DECstations dump registers automatically, when the reset 
button is pressed at a time when the machine operates normally (a power-up 
reset can be told apart by the state of the CP0.Status.SR bit).

  Maciej
