Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Nov 2009 15:39:00 +0100 (CET)
Received: from vitalin.sorra.shikadi.net ([64.71.152.201]:2535 "EHLO
        vitalin.sorra.shikadi.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493511AbZK1Oi5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Nov 2009 15:38:57 +0100
Received: from berkeloid.vlook.shikadi.net ([172.16.255.5])
        by vitalin.sorra.shikadi.net with esmtp (Exim 4.62)
        (envelope-from <a.nielsen@shikadi.net>)
        id 1NEORs-0005Te-79
        for linux-mips@linux-mips.org; Sun, 29 Nov 2009 00:38:56 +1000
Received: from korath.teln.shikadi.net ([192.168.0.14])
        by berkeloid.teln.shikadi.net with esmtp (Exim 4.68)
        (envelope-from <a.nielsen@shikadi.net>)
        id 1NEORr-0007zL-EB
        for linux-mips@linux-mips.org; Sun, 29 Nov 2009 00:38:55 +1000
Message-ID: <4B1135FF.9050908@shikadi.net>
Date:   Sun, 29 Nov 2009 00:38:55 +1000
From:   Adam Nielsen <a.nielsen@shikadi.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-GB; rv:1.8.1.22) Gecko/20090809 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Setting the physical RAM map
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <a.nielsen@shikadi.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25192
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.nielsen@shikadi.net
Precedence: bulk
X-list: linux-mips

Hi all,

I'm attempting to port the Linux kernel to an NCD HMX, an R4600-based X-Terminal.

I've currently got it to the point where it will download the kernel and 
execute it, and start printing some messages out on the screen.

It gets as far as printing the physical RAM map and then crashes, but I'm not 
sure why:

   Determined physical RAM map:
    memory: 00800000 @ 40250000 (usable)
    memory: 00040000 @ 9fc00000 (ROM data)
   Wasting 8407552 bytes for tracking 262736 unused pages

   TLB refill exception PC = 40024094 address = 7FFFF000

The last message is from the boot monitor (the kernel is loaded at address 
0x40020000.)  I'm just guessing with the memory map, but I've tried lots of 
different values with the same result, and I'm fairly sure there is RAM mapped 
to the address I have used above (it's after the end of the kernel.)  At any 
rate the error message is from a completely different address, and it still 
happens if I flag that area as reserved memory in the RAM map.

Some of the MIPS devices don't seem to have code to create a memory map, so 
I'm wondering whether this is necessary or if there's a generic MIPS way to 
retrieve the current mapping.

Also, if anyone has any ideas what the kernel is trying to do accessing that 
invalid address I could use some hints!

Many thanks,
Adam.
