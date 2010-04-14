Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Apr 2010 13:25:11 +0200 (CEST)
Received: from elvis.franken.de ([193.175.24.41]:57641 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491845Ab0DNLZH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Apr 2010 13:25:07 +0200
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1O20iQ-0004pT-00; Wed, 14 Apr 2010 13:25:06 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
        id C92411D2DE; Wed, 14 Apr 2010 13:24:58 +0200 (CEST)
Date:   Wed, 14 Apr 2010 13:24:58 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Calculate proper ebase value for 64-bit kernels
Message-ID: <20100414112458.GA8861@alpha.franken.de>
References: <1270585790-12730-1-git-send-email-ddaney@caviumnetworks.com> <1271135034.25797.41.camel@falcon> <20100413073435.GA6371@alpha.franken.de> <20100413171610.GA16578@linux-mips.org> <1271232185.25872.142.camel@falcon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1271232185.25872.142.camel@falcon>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26409
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Wed, Apr 14, 2010 at 04:03:05PM +0800, Wu Zhangjin wrote:
> If using CKSEG0 as the ebase, CKSEG0 is defined as 0xffffffff80000000,
> then we get the address: 0x97ffffff80000100, is this address ok?

the address is broken TO_UNCAC doesn't work properly for CKSEG0 addresses.
And that's IMHO the real bug... I'm wondering whether this 
set_uncached_handler() stunt is even needed. Is there a machine
where CKSEG0 and CKSEG1 address different memory ? If not, we could
just use the normal set_handler() function and be done with it.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
