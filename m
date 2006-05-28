Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 May 2006 06:20:50 +0200 (CEST)
Received: from rwcrmhc14.comcast.net ([204.127.192.84]:6821 "EHLO
	rwcrmhc14.comcast.net") by ftp.linux-mips.org with ESMTP
	id S8126484AbWE1EUl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 28 May 2006 06:20:41 +0200
Received: from [127.0.0.1] (unknown[69.140.185.142])
          by comcast.net (rwcrmhc14) with ESMTP
          id <20060528042033m1400kolboe>; Sun, 28 May 2006 04:20:34 +0000
Message-ID: <4479250E.3080604@gentoo.org>
Date:	Sun, 28 May 2006 00:20:30 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To:	Andrew Morton <akpm@osdl.org>
CC:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Commit 78eef01b0fae087c5fadbd85dd4fe2918c3a015f (on_each_cpu():
 disable local interrupts) Breaks SGI IP32
References: <4478C0F1.8000006@gentoo.org>	<20060528010603.GA24997@linux-mips.org> <20060527194243.a8157338.akpm@osdl.org>
In-Reply-To: <20060527194243.a8157338.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11584
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Andrew Morton wrote:
> 
> on_each_cpu() calls smp_call_function().  It is not correct to call
> smp_call_function() with local interrupts disabled, because it can lead to
> deadlocks.
> 
> Therefore on_each_cpu() also must not be called with local interrupts
> disabled.  Therefore on_each_cpu() may use
> local_irq_disable()/local_irq_enable().
> 
>>  A while ago I've
>> fixes all such calls but I may have missed some instances.
>>
>> Andrew, what was the reason for 78eef01b0fae087c5fadbd85dd4fe2918c3a015f ?
>>
> 
> That change made the various calling environments consistent, as described
> in the changelog.
> 
> If it's really, really not deadlocky to call smp_call_function() with
> interrupts disabled at that time in the MIPS kernel bringup then I'd
> suggest you should open-code an smp_call_function() and put a big comment
> over it explaining why it's done this way, and why it isn't deadlocky.
> 
> <tries to remember what the deadlock is>
> 
> If CPU A is running smp_call_function() it's waiting for CPU B to run the
> handler.
> 
> But if CPU B is presently _also_ running smp_call_function(), it's waiting
> for CPU A to run the handler.
> 
> If either of those CPUs is waiting for the other with local interrupts
> disabled, that CPU will never respond to the other CPU's IPI and they'll
> deadlock.

The catch is, the system being affected here is strictly a UP machine.  It's 
impossible to make an O2 go SMP.  It seems that the disable call in the UP 
version of on_each_cpu() (which I assume is the #define macro) is what's causing 
this issue, since the machine comes to a halt in the dark void between function 
calls (i.e., that memset() I alluded to earlier)

So I'm wondering, is there a way to see if the IRQ handlers have been installed 
already prior to disabling them, or is this more of a machine-specific oddity 
wherein the IRQ handlers need to be setup earlier (I don't even know if this is 
even possible/relevant to O2 systems)?

It also seems this was affecting AMD Alchemy-based systems too.  Other SGI 
machines are known to work fine, except Indy and Indigo2, as I haven't tested 
those yet.


--Kumba

-- 
Gentoo/MIPS Team Lead
Gentoo Foundation Board of Trustees

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
