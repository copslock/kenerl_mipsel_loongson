Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Nov 2004 16:27:18 +0000 (GMT)
Received: from mail.romat.com ([IPv6:::ffff:212.143.245.3]:23059 "EHLO
	mail.romat.com") by linux-mips.org with ESMTP id <S8225236AbUK3Q1M>;
	Tue, 30 Nov 2004 16:27:12 +0000
Received: from localhost (localhost.lan [127.0.0.1])
	by mail.romat.com (Postfix) with ESMTP id 8EE4CEB2D3;
	Tue, 30 Nov 2004 18:27:04 +0200 (IST)
Received: from mail.romat.com ([127.0.0.1])
 by localhost (mail.romat.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 03192-05; Tue, 30 Nov 2004 18:26:59 +0200 (IST)
Received: from gilad (unknown [192.168.1.167])
	by mail.romat.com (Postfix) with ESMTP id BA5FAEB2A9;
	Tue, 30 Nov 2004 18:26:59 +0200 (IST)
From: "Gilad Rom" <gilad@romat.com>
To: "'Dominic Sweetman'" <dom@mips.com>
Cc: <linux-mips@linux-mips.org>
Subject: RE: CP0 EntryLo
Date: Tue, 30 Nov 2004 18:26:59 +0200
Organization: Romat Telecom
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcTW1kRF9gMSusawQCq9nUlJg3s8BQAIlxwg
In-Reply-To: <16812.19039.764510.640663@gargle.gargle.HOWL>
Message-Id: <20041130162659.BA5FAEB2A9@mail.romat.com>
X-Virus-Scanned: by amavisd-new at romat.com
Return-Path: <gilad@romat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6507
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gilad@romat.com
Precedence: bulk
X-list: linux-mips

So, what I need to do, if I understand correctly, is to create a fixed
mapping
From a virtual address to a physical address on the tlb, and use this
Virtual address to change the values of EntryLo to 0xD in order to 
Access the device on the address range I mapped Chip-select 1 to?

(Excuse my poor phrasing, I've been googling all day...)

Any idea on how I might accomplish that from a driver?
I've found a function called add_wired_entry(...), is this
What I should be using?

Thanks!
Gilad.

-----Original Message-----
From: Dominic Sweetman [mailto:dom@mips.com] 
Sent: Tuesday, November 30, 2004 12:25 PM
To: Gilad Rom
Cc: linux-mips@linux-mips.org
Subject: Re: CP0 EntryLo


Gilad Rom (gilad@romat.com) writes:

> I am attempting to access a peripheral device over the Au1500 static bus.
> 
> According to the Au1500 Databook, Whenever I set the Chip Select config
> Register DTY bits to 1 (for "I/O Device").

> I must also set Bits 29:26 of CoProcessor 0 to 0xD, to represent
> bits 35:32 of the Physical address.

"CoProcessor 0" is a kind of fiction represented by a whole bunch of
registers, so you've wandered a long way into the weeds here.

> My question is, if anyone can answer it, is how do I setup
> The CoProcessor0 registers 29:26 in my driver?

I think you are referring to the "EntryLo0-1" register pair.  These
are used as staging registers when reading or writing entries in the
TLB, which is the address translation table.  

The manual is implying is that you need to set up a TLB entry to
access these high physical addresses.  

In Linux most of the TLB is maintained by the kernel as a cache of the
translations used by user programs.  That's probably why you see
"random values" from the staging registers; the kernel is busy taking
exceptions when required translations aren't in the TLB and fixing
them up.

However, the Au1500 hardware permits a small number of TLB entries to
be "wired", for fixed functions like your I/O accesses.

I'm not enough of an expert on the Linux kernel to tell you how to set
up a wired entry: but grep through the sources and you'll turn
something up!

> I have noticed a set of functions called write/read_c0_entrylo[0,1],
> But I keep getting random values when invoking these from my driver.

I think those are way too low-level for your purposes.

--
Dominic Sweetman
MIPS Technologies
