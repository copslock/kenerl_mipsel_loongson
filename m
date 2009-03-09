Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Mar 2009 10:00:32 +0000 (GMT)
Received: from mail.kernelconcepts.de ([212.60.202.196]:37312 "EHLO
	mail.kernelconcepts.de") by ftp.linux-mips.org with ESMTP
	id S21102833AbZCIKA3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Mar 2009 10:00:29 +0000
Received: from [192.168.2.28]
	by mail.kernelconcepts.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <nils.faerber@kernelconcepts.de>)
	id 1LgcXH-0000cr-GH; Mon, 09 Mar 2009 11:16:39 +0100
Message-ID: <49B4E8BB.8080704@kernelconcepts.de>
Date:	Mon, 09 Mar 2009 11:00:27 +0100
From:	Nils Faerber <nils.faerber@kernelconcepts.de>
Organization: kernel concepts GbR
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
MIME-Version: 1.0
To:	"Kevin D. Kissell" <kevink@paralogos.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Ingenic JZ4730 - illegal instruction
References: <49B1510B.8020606@kernelconcepts.de> <49B4D5BC.5020203@paralogos.com>
In-Reply-To: <49B4D5BC.5020203@paralogos.com>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <nils.faerber@kernelconcepts.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22045
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nils.faerber@kernelconcepts.de
Precedence: bulk
X-list: linux-mips

Hi Kevin!

Kevin D. Kissell schrieb:
> The only thing that you've mentioned below that really makes me think
> that you're looking at a kernel bug is the comment about things not
> failing under GDB.  But if *any* of the programs that are failing fail
> under gdb, I'd want to know just what instruction is at the place where
> they're taking a SIGILL. If gdb heisenbergs things too much, then the
> basic brute force thing to do would be to instrument the kernel itself
> to report on what happened, and what it sees at the "bad instruction"
> address, using printk.  If the memory value actually looks like a legit
> instruction, it would confirm the hypothesis that you've got an icache
> maintenance problem.  I note that the Ingenic patch has a "flushcaches"
> routine that has hardwired assumptions about the cache organization. 
> Could those be incorrect on the chip you're using?

Thanks for having a thought about the issue!

By now I pitily have to admit that my GDB assumption was not all that
correct :( After *a*lot* more tries I found an application that actually
also fails inside GDB. But with some more tries I can now confirm that
applications fail at random points - it is not a single instruction that
causes the fault but rather random points.
So I think your memory/cache issue theory sounds pretty interesting...
I just had a look at the JZ4730 code (in arch/mips/jz4730/) and the only
 mention of a cache flush is in pm.c which will only be executed in case
of going to sleep (i.e. CPU deep sleep aka s2ram).
arch/mips/mm/c-r4k.c also contains a JZ_RISC section for setting up
cache options and arch/mips/mm/tlbex.c a TLB case special for the JZ.

Those look promising!
I could very well think of cases where a wrong cache flush could cause
such or similar problems.

>          Regards, and happy hunting,

Happy? When I found it maybe. The annoying thing about this is that
Ingenic is not very helpful. I emailed them several times already asking
for the full datasheet of the CPU with no replay at all yet. The
datasheet they hae on their webpage is just the brief with about 60
pages and not very helpful when you ar elooking for details like cache
handling etc.

So I will have to resort to experiments - trial an error.

Thank you very much for your thoughts and idea!

>          Kevin K.
Cheers
  nils faerber

-- 
kernel concepts GbR        Tel: +49-271-771091-12
Sieghuetter Hauptweg 48    Fax: +49-271-771091-19
D-57072 Siegen             Mob: +49-176-21024535
http://www.kernelconcepts.de
