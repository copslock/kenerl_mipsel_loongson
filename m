Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Nov 2004 18:02:02 +0000 (GMT)
Received: from pimout2-ext.prodigy.net ([IPv6:::ffff:207.115.63.101]:51355
	"EHLO pimout2-ext.prodigy.net") by linux-mips.org with ESMTP
	id <S8225251AbUK3SB5>; Tue, 30 Nov 2004 18:01:57 +0000
Received: from 127.0.0.1 (adsl-68-124-224-225.dsl.snfc21.pacbell.net [68.124.224.225])
	by pimout2-ext.prodigy.net (8.12.10 milter /8.12.10) with ESMTP id iAUI1nL6119994;
	Tue, 30 Nov 2004 13:01:50 -0500
Received: from  [63.194.214.47] by 127.0.0.1
  (ArGoSoft Mail Server Pro for WinNT/2000/XP, Version 1.8 (1.8.6.7)); Tue, 30 Nov 2004 10:01:44 -0800
Message-ID: <41ACB576.6000501@embeddedalley.com>
Date: Tue, 30 Nov 2004 10:01:26 -0800
From: Pete Popov <ppopov@embeddedalley.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gilad Rom <gilad@romat.com>
CC: "Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: CP0 EntryLo
References: <20041130162659.BA5FAEB2A9@mail.romat.com> <Pine.LNX.4.58L.0411301635590.31151@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.58L.0411301635590.31151@blysk.ds.pg.gda.pl>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ArGoMail-Authenticated: ppopov@embeddedalley.com
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6509
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Tue, 30 Nov 2004, Gilad Rom wrote:
> 
> 
>>So, what I need to do, if I understand correctly, is to create a fixed
>>mapping
>>>From a virtual address to a physical address on the tlb, and use this
>>Virtual address to change the values of EntryLo to 0xD in order to 
>>Access the device on the address range I mapped Chip-select 1 to?
>>
>>(Excuse my poor phrasing, I've been googling all day...)
>>
>>Any idea on how I might accomplish that from a driver?
>>I've found a function called add_wired_entry(...), is this
>>What I should be using?
> 
> 
>  ioremap()

Exactly. You program the CS with a physical address. Make sure that 
address does not overlap with anything else. Then you call ioremap 
from your driver and you get back a virtual address. You use that 
virtual address to access the peripheral.

At this stage I would say that probably reading something like the 
Linux Kernel book or Linux Device Drivers both by Oreilly will 
really help you.

Pete
