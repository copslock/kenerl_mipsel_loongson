Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2009 22:41:01 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:36981 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492802AbZK3Vk6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Nov 2009 22:40:58 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAULfKsf030891;
        Mon, 30 Nov 2009 21:41:21 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAULfJbo030889;
        Mon, 30 Nov 2009 21:41:19 GMT
Date:   Mon, 30 Nov 2009 21:41:19 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Adam Nielsen <a.nielsen@shikadi.net>
Cc:     linux-mips@linux-mips.org
Subject: Re: Setting the physical RAM map
Message-ID: <20091130214118.GB27721@linux-mips.org>
References: <4B1135FF.9050908@shikadi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B1135FF.9050908@shikadi.net>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25212
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Nov 29, 2009 at 12:38:55AM +1000, Adam Nielsen wrote:

> I'm attempting to port the Linux kernel to an NCD HMX, an R4600-based X-Terminal.
> 
> I've currently got it to the point where it will download the kernel
> and execute it, and start printing some messages out on the screen.
> 
> It gets as far as printing the physical RAM map and then crashes,
> but I'm not sure why:
> 
>   Determined physical RAM map:
>    memory: 00800000 @ 40250000 (usable)
>    memory: 00040000 @ 9fc00000 (ROM data)
>   Wasting 8407552 bytes for tracking 262736 unused pages
> 
>   TLB refill exception PC = 40024094 address = 7FFFF000
> 
> The last message is from the boot monitor (the kernel is loaded at
> address 0x40020000.)  I'm just guessing with the memory map, but
> I've tried lots of different values with the same result, and I'm
> fairly sure there is RAM mapped to the address I have used above
> (it's after the end of the kernel.)  At any rate the error message
> is from a completely different address, and it still happens if I
> flag that area as reserved memory in the RAM map.

Are you sure it's a R4600, not R4640 or R4650?

It's like a decade that I last read up on these but afair they have a
fixed mapping starting at 0x40000000.  It would make perfect sense to
use such a CPU in an X terminal.

  Ralf
