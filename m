Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Mar 2003 10:09:47 +0000 (GMT)
Received: from [IPv6:::ffff:133.36.48.43] ([IPv6:::ffff:133.36.48.43]:2217
	"EHLO cat.os-omicron.org") by linux-mips.org with ESMTP
	id <S8225251AbTCDKJq>; Tue, 4 Mar 2003 10:09:46 +0000
Received: from wl04.sys.cs.tuat.ac.jp (pisces.sys.cs.tuat.ac.jp [165.93.162.82])
	by cat.os-omicron.org (Postfix) with SMTP id 934AFA4E7
	for <linux-mips@linux-mips.org>; Tue,  4 Mar 2003 19:11:39 +0900 (JST)
Date: Tue, 4 Mar 2003 19:09:02 +0900
From: TAKANO Ryousei <takano@os-omicron.org>
To: linux-mips@linux-mips.org
Subject: Re: JVM under Linux on MIPS
Message-Id: <20030304190902.68ffd5bb.takano@os-omicron.org>
In-Reply-To: <007701c2e22c$66e30e70$10eca8c0@grendel>
References: <20030302121820.A30790@linux-mips.org>
	<20030304011459.457.qmail@web13302.mail.yahoo.com>
	<20030304171340.1a9af44d.takano@os-omicron.org>
	<007701c2e22c$66e30e70$10eca8c0@grendel>
Organization: OS/omicron Project
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-vine-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <takano@os-omicron.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1616
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: takano@os-omicron.org
Precedence: bulk
X-list: linux-mips

Hi Kevin,

> I'm very pleased to hear that you got it running on a Vr41xx,
> but I'm curious about the JIT behavior you saw.  I can believe
> that it could run "hello world", but does it really pass all the
> internal regression tests ("make check")?  Are you running
> a "normal" MIPS/Linux distribution which assumes a
> hardware FPU and does kernel emulation where necessary,
> or are you using a purely soft-float environment?  I ask
> this because most of the problems I have with the JIT are
> in areas where mixed integer/floating arguments are being
> passed, and those might not be an issue with soft-float.
> 
I have cross-compiled Kaffe, so it did not pass "make check".
I tried it under a Linux-VR kernel(kernel-2.4.0-test9) which is
enabled with a kernel FPU emulation.
I have not tried under a Linux/MIPS kernel.

> As for the performance you observed, how much memory
> did you have on the board, and what kind of secondary storage
> (disk?) hardware was used?  66MHz isn't fast, but the combined
> compile-and-run time for Caffeinemark for the patched
> kaffe 1.0.7 on a MIPS 5Kc core at 160MHz was in fact
> pretty good, better than 3 Embedded Caffeienmarks
> per megahertz, which isn't as fast as commercial dynmic
> compilers, but which is still several times faster than most
> commercial interpretive JVMs.  Running fully interpretive,
> kaffe's performance is mediocre but reasonable, I certainly
> wasn't seeing delays of 10 seconds to run "hello world",
> which is roughly what one would expect scaling your reported
> run time by the frequency.  I really think that you are far more
> likely to have been I/O bound, either from paging or from file I/O.
> 
TANBAC TB0193 has 16MB SDRAM, and it is using Compact Flash
as a secondary storage.

I try to make jar files compact (strips unused packages) 
for a faster initialization.

Thanks,
TAKANO Ryousei
