Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Apr 2010 09:35:04 +0200 (CEST)
Received: from elvis.franken.de ([193.175.24.41]:33446 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491900Ab0DMHfA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 13 Apr 2010 09:35:00 +0200
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1O1aeB-00077x-00; Tue, 13 Apr 2010 09:34:59 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
        id 2694E1D2DE; Tue, 13 Apr 2010 09:34:38 +0200 (CEST)
Date:   Tue, 13 Apr 2010 09:34:38 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Subject: Re: [PATCH] MIPS: Calculate proper ebase value for 64-bit kernels
Message-ID: <20100413073435.GA6371@alpha.franken.de>
References: <1270585790-12730-1-git-send-email-ddaney@caviumnetworks.com> <1271135034.25797.41.camel@falcon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1271135034.25797.41.camel@falcon>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26392
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Tue, Apr 13, 2010 at 01:03:54PM +0800, Wu Zhangjin wrote:
> This patch have broken the support to the MIPS variants whose
> cpu_has_mips_r2 is 0 for the CAC_BASE and CKSEG0 is completely different
> in these MIPSs.

I've checked R4k and R10k manulas and the exception base is at CKSEG0, so
about CPU we are talking ? And wouldn't it make for senso to have
an extra define for the exception base then ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
