Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Sep 2017 12:28:51 +0200 (CEST)
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:24378 "EHLO
        ste-ftg-msa2.bahnhof.se" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990517AbdIBK2kYjgTw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 2 Sep 2017 12:28:40 +0200
Received: from localhost (localhost [127.0.0.1])
        by ste-ftg-msa2.bahnhof.se (Postfix) with ESMTP id AC5D13F303;
        Sat,  2 Sep 2017 12:28:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-ftg-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id C3cBObGOsXFG; Sat,  2 Sep 2017 12:28:34 +0200 (CEST)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by ste-ftg-msa2.bahnhof.se (Postfix) with ESMTPA id A961B3F281;
        Sat,  2 Sep 2017 12:28:32 +0200 (CEST)
Date:   Sat, 2 Sep 2017 12:28:31 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Add basic R5900 support
Message-ID: <20170902102830.GA2602@localhost.localdomain>
References: <20170827132309.GA32166@localhost.localdomain>
 <alpine.DEB.2.00.1708271511430.17596@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1708271511430.17596@tp.orcam.me.uk>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi Maciej,

>  If you don't have documentation, but you have the hardware at hand, then 
> you'll best check it yourself by writing a small user program that writes 
> to CP1.FCSR and checks which bits stick (of course you need to leave the 
> exception cause/mask bits alone for this check or you'll get SIGFPE sent 
> instead).

Did you have something like this in mind? It prints 01000001 so the bits
above FS does not seem to stick.

	uint32_t fcr31;
	asm volatile (" cfc1 $t0,$31\n"
		      " lui  $t1,0xfe00\n"
		      " or   $t0,$t1,$t0\n"
	              " ctc1 $t0,$31\n"
	              " nop\n"
	              " cfc1 $t0,$31\n"
	              " nop\n"
	              " move %0,$t0\n" : "=r" (fcr31));
	printf("fcr31 %08" PRIx32 "\n", fcr31);

The "TX System RISC TX79 Core Architecture" manual says that both data and
instruction caches are 32 kB, but other sources seem to contradict this with
8 kB for data and 16 kB for instructions. So R5900 and C790 seem to be very
similar but not identical which could bring various surprises. Here is
another source:

https://www.linux-mips.org/wiki/PS2

Fredrik
