Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Mar 2009 16:26:47 +0000 (GMT)
Received: from mail.kernelconcepts.de ([212.60.202.196]:23684 "EHLO
	mail.kernelconcepts.de") by ftp.linux-mips.org with ESMTP
	id S20808084AbZCIQ0o (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Mar 2009 16:26:44 +0000
Received: from [192.168.2.28]
	by mail.kernelconcepts.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <nils.faerber@kernelconcepts.de>)
	id 1LgiZ6-0004p1-Pu
	for linux-mips@linux-mips.org; Mon, 09 Mar 2009 17:42:56 +0100
Message-ID: <49B54342.8070004@kernelconcepts.de>
Date:	Mon, 09 Mar 2009 17:26:42 +0100
From:	Nils Faerber <nils.faerber@kernelconcepts.de>
Organization: kernel concepts GbR
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Ingenic JZ4730 - illegal instruction
References: <49B1510B.8020606@kernelconcepts.de> <49B4D5BC.5020203@paralogos.com> <49B4E8BB.8080704@kernelconcepts.de> <49B523B6.6090006@paralogos.com> <49B5302F.4070301@kernelconcepts.de> <49B53987.8020206@paralogos.com>
In-Reply-To: <49B53987.8020206@paralogos.com>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <nils.faerber@kernelconcepts.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22050
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nils.faerber@kernelconcepts.de
Precedence: bulk
X-list: linux-mips

Kevin D. Kissell schrieb:
> Nils Faerber wrote:
>> Kevin D. Kissell schrieb:
>>> Are you sure that the JZ_RISC section is in fact the version of those
>>> functions that's being built into your kernel?
>> Well, there is CONFIG_JZRISC=y in the kernel .config and a
>> switch(current_cpu_type) { case CPU_JZRISC: ...} so I would assume it is
>> being used. But I will verify that the CONFIG_JZRISC=y is correctly
>> translated into a current_cpu_type.
> Your assumption is reasonable.  But given that things aren't working,
> yes, it's good to verify.

It should be proper - it is as I can see set by cpu_probe.

>> Oh, one last question, in order to rule out the cache as bug-spot would
>> the kernel option "run uncached" "solve" the issue (and be darn slow)?
> It would certainly solve the issue, and would *probably* result in a
> system that would be fully functional but slow.  Very high end and very

It is *very* slow - you can almost watch every single instruction ;)

> low end systems can be rendered unusable by forcing uncached operation,
> but it's certainly worth a try.  Also, if your cache control logic

It seems to run - I am still stuck at the GUI login screen, everything
is so darn slow now. Testing for he fault could take ages now, a game of
patience it seems ;)

> supports both write-back and write-through operation, if you set the
> default cache "attribute" for kernel and page tables (which is
> essentially what you're doing under-the-hood when you configure for
> uncached operation) to write-through, that should cure the problems with
> copying text pages, but *not* those with re-using them, with less
> performance impact.  I'd be a little surprised if the Ingenic part
> offered both modes, though.

The really bad thing is that I do not have the full datasheet to the CPU
so I basically have no idea what this thing really supports or not. So I
can only try and test. Luckily this is just a toy project and not a
commecial contract work (which I would not have accepted without proper
documentation).

PS: Login is done now and I suddenly see apps initialisiing that
obviously silently failed before - so I am pretty sure now that uncached
does work, which means that the cache handling has the bug I am looking for.

>           Regards,
>           Kevin K.
Cheers
  nils faerber

-- 
kernel concepts GbR        Tel: +49-271-771091-12
Sieghuetter Hauptweg 48    Fax: +49-271-771091-19
D-57072 Siegen             Mob: +49-176-21024535
http://www.kernelconcepts.de
