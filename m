Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Nov 2004 18:46:01 +0000 (GMT)
Received: from pimout1-ext.prodigy.net ([IPv6:::ffff:207.115.63.77]:19190 "EHLO
	pimout1-ext.prodigy.net") by linux-mips.org with ESMTP
	id <S8225282AbUK3Sp4>; Tue, 30 Nov 2004 18:45:56 +0000
Received: from 127.0.0.1 (adsl-68-124-224-225.dsl.snfc21.pacbell.net [68.124.224.225])
	by pimout1-ext.prodigy.net (8.12.10 milter /8.12.10) with ESMTP id iAUIjj6M178986;
	Tue, 30 Nov 2004 13:45:50 -0500
Received: from  [63.194.214.47] by 127.0.0.1
  (ArGoSoft Mail Server Pro for WinNT/2000/XP, Version 1.8 (1.8.6.7)); Tue, 30 Nov 2004 10:45:37 -0800
Message-ID: <41ACBFC3.1000107@embeddedalley.com>
Date: Tue, 30 Nov 2004 10:45:23 -0800
From: Pete Popov <ppopov@embeddedalley.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gilad Rom <gilad@romat.com>
CC: "'Maciej W. Rozycki'" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: CP0 EntryLo
References: <20041130181638.D260DEB2B8@mail.romat.com>
In-Reply-To: <20041130181638.D260DEB2B8@mail.romat.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ArGoMail-Authenticated: ppopov@embeddedalley.com
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6511
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips


> Okay. I've pretty much figured out that part. What I'm puzzled
> About now is how do change the values of the CP0 EntryLo0/1
> Registers, since I've changed the DTY bits to "1" on the MEM_STCFG1
> Register (in order to set it to work in "I/O Device" mode) , 
> I need to "change bits 29:26 of CoProcessor 0 to 0xD" (Au1500 Databook
> quote)
> since the Databook doesn't specify an offset
> To these registers, I assume they're not like the other
> Registers I've been dealing with (Chip Select and GPIO).

The reason for the 0XD is because the CS is on a 36 bit physical 
address. You're in luck because the 36 bit address support went in 
the 2.6 tree a couple of days ago (I don't remember if you're using 
2.4 or 2.6, but 2.4 has the 36 bit support as well). You don't mess 
with the tlb registers yourself -- you let ioremap do its work. Take 
a look at drivers/pcmcia/au1000_generic.c and you'll see how the 
pcmcia CS is remapped. You simply pass the 36 bit phys address and 
ioremap will do its job.

If there was no 36 bit address support in the kernel, your only 
option would have been to use a wired tlb, and then you would end up 
programming the tlb registers directly. In this case there is no 
reason to do that because ioremap will handle the 36 bit phys address.

Pete
