Received:  by oss.sgi.com id <S553892AbRBFSLH>;
	Tue, 6 Feb 2001 10:11:07 -0800
Received: from pobox.sibyte.com ([208.12.96.20]:18444 "HELO pobox.sibyte.com")
	by oss.sgi.com with SMTP id <S553888AbRBFSLA>;
	Tue, 6 Feb 2001 10:11:00 -0800
Received: from postal.sibyte.com (moat.sibyte.com [208.12.96.21])
	by pobox.sibyte.com (Postfix) with SMTP id 182CB205FB
	for <linux-mips@oss.sgi.com>; Tue,  6 Feb 2001 10:10:50 -0800 (PST)
Received: from SMTP agent by mail gateway 
 Tue, 06 Feb 2001 10:04:49 -0800
Received: from plugh.sibyte.com (plugh.sibyte.com [10.21.64.158])
	by postal.sibyte.com (Postfix) with ESMTP id 9AB521595F
	for <linux-mips@oss.sgi.com>; Tue,  6 Feb 2001 10:10:50 -0800 (PST)
Received: by plugh.sibyte.com (Postfix, from userid 61017)
	id 319A2686D; Tue,  6 Feb 2001 10:11:47 -0800 (PST)
From:   Justin Carlson <carlson@sibyte.com>
Reply-To: carlson@sibyte.com
Organization: Sibyte
To:     linux-mips@oss.sgi.com
Date:   Tue, 6 Feb 2001 10:11:00 -0800
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <0102061011470N.21018@plugh.sibyte.com>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, 06 Feb 2001, Greeen-III wrote:
> All experts,
> 
> I am trying to port mips to my target board.
> The board has two pieces of ram. One is addressed at 0x80000000(bank0).
> The other is addressed at 0x82000000(bank1).
> The loader will load the kernel and ramdisk to the bank0.
> The ramdisk seems too small. The system will halt at gunzip() function.
> 

The memory is at physical address 0 and 0x2000000, then, as those addresses are
unmapped virtual in KSEG0 that map to these general addresses.

You need to find a way to call add_memory_region, typically from the
prom_meminit function for your board.  This function (among other things)
should be able to figure out what the physical memory map is, usually by
querying the firmware. 

Take a look at arch/mips/arc/memory.c in prom_meminit() for sample code on how
to do this.

> So I modify the file "/linux-vr/arch/mips/ld.script".
> >From the address ". = 0x80020000" to ". = 0x82020000 "
> But the situation still exist.

This just moves the entry point for the kernel to your second chunk of memory. 
For things to work properly, the kernel needs to be able to figure out what
the physical memory layout looks like; where the kernel lies within this
memory, so long as it's reserved, isn't terribly important.

How much memory is on your board, anyways, and what kind of board is it?  As
the initrd stuff is currently set up, the whole ramdisk is loaded into the
buffer cache, and *then* the ramdisk image memory is freed.  I've got a small
patch to do the image reclamation on the fly, which I'm using for really tiny
memory systems, but it's not really a clean solution.  If you're on a really
small memory system, I'll post it for you to try out.

-Justin
