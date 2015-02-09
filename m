Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Feb 2015 01:53:52 +0100 (CET)
Received: from resqmta-ch2-12v.sys.comcast.net ([69.252.207.44]:52547 "EHLO
        resqmta-ch2-12v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012541AbbBIAxusYcEJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Feb 2015 01:53:50 +0100
Received: from resomta-ch2-15v.sys.comcast.net ([69.252.207.111])
        by resqmta-ch2-12v.sys.comcast.net with comcast
        id q0tk1p0012Qkjl9010tkwp; Mon, 09 Feb 2015 00:53:44 +0000
Received: from [192.168.1.13] ([69.250.160.75])
        by resomta-ch2-15v.sys.comcast.net with comcast
        id q0tj1p00D1duFqV010tjQy; Mon, 09 Feb 2015 00:53:44 +0000
Message-ID: <54D80515.3040208@gentoo.org>
Date:   Sun, 08 Feb 2015 19:53:41 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: IP27: Random hard locks after ~16hrs uptime
References: <54D6D0D5.8020704@gentoo.org> <alpine.LFD.2.11.1502081003060.22715@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1502081003060.22715@eddie.linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1423443224;
        bh=okr97s4BUTMZ8iXwtfc6edd3Y+umB3BgfqoU6vV5NOo=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=j8b6FubzOI6J6n+T/DRZRnh0wTdBU4VJacBZYx+XwlIK1dfP0+0Yf0l4ZmdZck/EO
         PR50OjdE/2OaFSbGMk268u3ZwSEZYefmhQPpnATzhEn2vaizdkolwHbJs23fQNCbvQ
         HzgLI3QQTpIAqbkX5ldOQsFkM2+xrX/vVarDdiXeZjKvQOFwOfuX+iPc6R7Wp+MQ1K
         yTBZBoUJL363Ept83OgmwL3Gn/HmgwU/TN88bdkMLbgeDYq1ahqq+W9pmazjiuv1LX
         3XC0HYljWAmdSdSwJ/GGK+yB3udFZN5rNgnnLktEKAOWkOWMeY2OyoXjV1i/OFV4Gy
         SXSx2fzKMeDmQ==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45765
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 02/08/2015 07:06, Maciej W. Rozycki wrote:
> On Sat, 7 Feb 2015, Joshua Kinard wrote:
> 
>> I've had my Onyx2 running quite a bit lately doing compile runs, and it seems
>> that after about ~16 hours, there's a random possibility that the machine just
>> completely stops.  No errors printed anywhere, serial becomes completely
>> unresponsive.  I have to issue a 'rst' from the MSC to bring it back up again.
> 
>  If the time spent up is always similar, then one possibility is a counter 
> wraparound or suchlike that is not handled correctly (i.e. the carry from 
> the topmost bit is not taken into account), causing a kernel deadlock.

I believe I've pinned the problem down to the block I/O layer and points
beneath, such as SCSI core, qla1280, etc.  I am using an out-of-tree patch to
add the BFQ I/O scheduler in, so that may also be a cause to consider.

I had a very similar hardlock on the Octane, too, when I upgraded the RAM to
3.5GB the other day, but going back to 2GB solves the problem there.  Octane
is, for all intents and purposes, a single-node Origin system w/ graphics
options, HEART instead of HUB, and a much more simplified PROM).  Both use the
same SCSI chip, a QLogic ISP1040B, and thus the same driver, qla1280.o.  The
difference with the Octane is I can reproduce the hardlock on demand by
untarring a large tarball (a Gentoo stage3, to be exact).  Compared to the
Onyx2, which has 8GB of RAM, and the lock seems more random.

I'll have to reconfigure the Octane later on with 3.5GB of RAM again, but test
BFQ, CFQ, and Deadline out to see if the hardlock happens with all three.  I
know BFQ is largely derived from the CFQ code, so if the system remains stable
with Deadline, but not CFQ or BFQ, then I know the subsystem.  Then, if it only
happens on BFQ, I'll go pester their upstream for debugging advice.

I thought it might've been filesystem related, but because the Octane is XFS
and the Onyx2 is Ext4, that eliminates that subsystem from consideration (I
hope).  On the Onyx2, I don't think I can trigger it on-demand, but I may have
found a way by running e4defrag on my large /usr partition.  So if I can pin a
cause down on the Octane, I might be able to test for that same cause on the
Onyx2 as well.  Provided it doesn't eat my filesystem...

Currently trying a 3.19-rc7 kernel out to see if the effects are any different.
 I also switched to compiling packages in a RAM filesystem for now.


>> It's currently got dual IP31 R14000 node boards (500MHz), and for the most
>> part, runs great (I'll regret the electric bill later...).  Clearly a bug,
>> though, but I am not sure where to start debugging on this platform to find
>> this bug, since I can't trigger it manually.  Even tried an NMI interrupt,
>> since this machine has an NMI handler in the kernel, but all that does is reset
>> the machine.
> 
>  The NMI exception is routed to the same vector reset is, firmware would 
> have to tell them apart (with the use of the CP0.Status.NMI bit) and then 
> call a handler supplied.  Perhaps there's a way to register such a handler 
> with the firmware -- does the kernel do it?  You could then use the 
> handler to examine the kernel state and perhaps dump it somehow.
> 
>  On MIPS processors an NMI or even a reset event does not clobber any 
> registers except from the CP0 ErrorEPC register, where the PC at the time 
> the event happened is stored, some bits in the CP0 Status register (ERL, 
> BEV, etc.), and of course the PC.  So alternatively does the firmware have 
> a way to dump registers on reset or NMI then somehow?
> 
>  For example R4k DECstations dump registers automatically, when the reset 
> button is pressed at a time when the machine operates normally (a power-up 
> reset can be told apart by the state of the CP0.Status.SR bit).

I only mentioned the NMI bit because IP27 does have an NMI handler in it, and I
can trigger it to dump some useful debugging information under normal
circumstances prior to the hardware reset.  But in this case, the kernel is so
dead at this point, that not even the NMI handler is executing.  I suspect it's
either a total hardware lockup at some level or something gets stuck in the CPU
so thoroughly, that the CPU stops processing all interrupts.

Actually on one use of 'nmi' from the MSC, something didn't get cleared right
in memory, so the booting of the PROM actually crashed and the Onyx2 dropped
into the POD debugger.  I was kinda hoping NMI would put me into the POD
debugger without clearing any memory banks, but in this instance, half of the
banks were cleared before the PROM crashed.  From POD, I can inspect memory
addresses (if I know where to look), but with half the banks cleared, there
really wasn't a point by then.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
