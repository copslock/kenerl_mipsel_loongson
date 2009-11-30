Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2009 23:38:45 +0100 (CET)
Received: from vitalin.sorra.shikadi.net ([64.71.152.201]:1780 "EHLO
        vitalin.sorra.shikadi.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492963AbZK3Wim (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2009 23:38:42 +0100
Received: from berkeloid.vlook.shikadi.net ([172.16.255.5])
        by vitalin.sorra.shikadi.net with esmtp (Exim 4.62)
        (envelope-from <a.nielsen@shikadi.net>)
        id 1NFEtE-0006Y0-MG; Tue, 01 Dec 2009 08:38:40 +1000
Received: from korath.teln.shikadi.net ([192.168.0.14])
        by berkeloid.teln.shikadi.net with esmtp (Exim 4.68)
        (envelope-from <a.nielsen@shikadi.net>)
        id 1NFEtD-0006rq-TG; Tue, 01 Dec 2009 08:38:39 +1000
Message-ID: <4B14496F.1060108@shikadi.net>
Date:   Tue, 01 Dec 2009 08:38:39 +1000
From:   Adam Nielsen <a.nielsen@shikadi.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-GB; rv:1.8.1.22) Gecko/20090809 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: Setting the physical RAM map
References: <4B1135FF.9050908@shikadi.net> <20091130214118.GB27721@linux-mips.org>
In-Reply-To: <20091130214118.GB27721@linux-mips.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <a.nielsen@shikadi.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25214
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.nielsen@shikadi.net
Precedence: bulk
X-list: linux-mips

> Are you sure it's a R4600, not R4640 or R4650?
>
> It's like a decade that I last read up on these but afair they have a
> fixed mapping starting at 0x40000000.  It would make perfect sense to
> use such a CPU in an X terminal.

Hmm, I'm not sure.  I'd have to peel off the heatsink to be sure I guess.  The 
very first kernel messages print this:

   CPU revision is: 00002020 (R4600)
   FPU revision is: 00002020

So I guess these values would be more specific if the CPU was indeed one of 
those revisions.

Cheers,
Adam.
