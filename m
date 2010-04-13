Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Apr 2010 20:15:42 +0200 (CEST)
Received: from elvis.franken.de ([193.175.24.41]:44606 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492265Ab0DMSPi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 13 Apr 2010 20:15:38 +0200
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1O1ke9-0007Zz-00; Tue, 13 Apr 2010 20:15:37 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
        id 2428D1D2E1; Tue, 13 Apr 2010 20:15:17 +0200 (CEST)
Date:   Tue, 13 Apr 2010 20:15:17 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Calculate proper ebase value for 64-bit kernels
Message-ID: <20100413181516.GA19223@alpha.franken.de>
References: <1270585790-12730-1-git-send-email-ddaney@caviumnetworks.com> <1271135034.25797.41.camel@falcon> <20100413073435.GA6371@alpha.franken.de> <20100413171610.GA16578@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100413171610.GA16578@linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26397
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Tue, Apr 13, 2010 at 06:16:10PM +0100, Ralf Baechle wrote:
> C0_ebase's design was a short-sigthed only considering 32-bit processors.
> So the exception base is in CKSEG0 on every 64-bit processor, be it R2 or
> older.  So yes, there is a bug as I've verified by testing but the patch
> is unfortunately incorrect.

well not quite every 64bit CPU, R8k is as always special. R8k has
a trap vector register. But since support for R8k is still lacking
no problem for now.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
