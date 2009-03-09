Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Mar 2009 15:05:28 +0000 (GMT)
Received: from mail.kernelconcepts.de ([212.60.202.196]:10919 "EHLO
	mail.kernelconcepts.de") by ftp.linux-mips.org with ESMTP
	id S21367118AbZCIPFW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Mar 2009 15:05:22 +0000
Received: from [192.168.2.28]
	by mail.kernelconcepts.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <nils.faerber@kernelconcepts.de>)
	id 1LghIK-00043g-Mr; Mon, 09 Mar 2009 16:21:32 +0100
Message-ID: <49B5302F.4070301@kernelconcepts.de>
Date:	Mon, 09 Mar 2009 16:05:19 +0100
From:	Nils Faerber <nils.faerber@kernelconcepts.de>
Organization: kernel concepts GbR
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
MIME-Version: 1.0
To:	"Kevin D. Kissell" <kevink@paralogos.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Ingenic JZ4730 - illegal instruction
References: <49B1510B.8020606@kernelconcepts.de> <49B4D5BC.5020203@paralogos.com> <49B4E8BB.8080704@kernelconcepts.de> <49B523B6.6090006@paralogos.com>
In-Reply-To: <49B523B6.6090006@paralogos.com>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <nils.faerber@kernelconcepts.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22048
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nils.faerber@kernelconcepts.de
Precedence: bulk
X-list: linux-mips

Kevin D. Kissell schrieb:
> I don't have time to go chasing this stuff any further on your behalf,

I do not expect that either ;)
I am already quite happy that you shared your experience with me - it
already helped me a lot to fid some points in the code that could be the
culprit and I can dig further from here.

> but it *does* smell to me like an icache management problem.  Remember,
> MIPS processors almost universally have split I/D caches and no
> coherence support between them, so if you either (a) forget to do an
> explicit D-cache write-back operation after copying to a page mapped
> write-back that's going to be used as instructions/text, or (b) forget
> to do an explicit I-cache invalidate when you re-use a page for
> instructions that has been previously used for a different instruction
> page, you will have problems, even without going into DMA I/O coherence
> issues.  If your problem were (b), though, you'd be seeing bad answers,
> segmentation violations, bus errors, etc., at least as often as you'd be
> seeing illegal instruction exceptions.  So my money would be on (a).

Yes, it is only illegal instructions, no other faults.

> The need for cache management is so fundamental to Linux for MIPS that
> all the necessary general hooks have been there for years.  If I were
> you, I'd focus on the definitions of the primitives that you spotted in
> c-r4k.c.  Does the stuff in the JZ_RISC section correspond to the

OK.

> assembly language flush sequence done in the Ingenic patch to head.S? 
> Are you sure that the JZ_RISC section is in fact the version of those
> functions that's being built into your kernel?

Well, there is CONFIG_JZRISC=y in the kernel .config and a
switch(current_cpu_type) { case CPU_JZRISC: ...} so I would assume it is
being used. But I will verify that the CONFIG_JZRISC=y is correctly
translated into a current_cpu_type.

Oh, one last question, in order to rule out the cache as bug-spot would
the kernel option "run uncached" "solve" the issue (and be darn slow)?

>           Regards,
>           Kevin K.
Thanks a lot so far!
It helped me a great deal to start to understand what is going on here...

Cheers
  nils faerber

-- 
kernel concepts GbR        Tel: +49-271-771091-12
Sieghuetter Hauptweg 48    Fax: +49-271-771091-19
D-57072 Siegen             Mob: +49-176-21024535
http://www.kernelconcepts.de
