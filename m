Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Nov 2014 12:20:55 +0100 (CET)
Received: from elvis.franken.de ([193.175.24.41]:57762 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006150AbaKJLUxi4Jun (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Nov 2014 12:20:53 +0100
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1Xnn1h-0007PL-00; Mon, 10 Nov 2014 12:20:53 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
        id E36B11D33A; Mon, 10 Nov 2014 12:20:39 +0100 (CET)
Date:   Mon, 10 Nov 2014 12:20:39 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Joshua Kinard <kumba@gentoo.org>,
        David Daney <ddaney.cavm@gmail.com>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: IP27: CONFIG_TRANSPARENT_HUGEPAGE triggers bus errors
Message-ID: <20141110112039.GA7294@alpha.franken.de>
References: <54560D3B.8060602@gentoo.org>
 <5457CF0A.7020303@gmail.com>
 <5458272A.7050309@gentoo.org>
 <54582A91.8040401@gmail.com>
 <20141105160945.GB13785@linux-mips.org>
 <545C9D4D.4090501@gentoo.org>
 <545D0FC4.7020205@gmail.com>
 <545EB09C.40006@gentoo.org>
 <5460636A.5090401@gentoo.org>
 <20141110105106.GA4302@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141110105106.GA4302@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43944
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
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

On Mon, Nov 10, 2014 at 11:51:06AM +0100, Ralf Baechle wrote:
> Thomas,
> 
> can you test CONFIG_TRANSPARENT_HUGEPAGE on an IP28?
> 
> All in all the R10000's TLB is unproblematic; my gut feeling is that
> rather something else specific to IP27 is spoiling the broth.

I'll give it a spin later today.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
