Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Aug 2014 17:12:15 +0200 (CEST)
Received: from elvis.franken.de ([193.175.24.41]:53640 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6855222AbaHRPMLTd2dC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 18 Aug 2014 17:12:11 +0200
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1XJObS-00027D-00; Mon, 18 Aug 2014 17:12:10 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
        id 72A0E1D25F; Mon, 18 Aug 2014 17:12:04 +0200 (CEST)
Date:   Mon, 18 Aug 2014 17:12:04 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: IP28 boot error under 3.16
Message-ID: <20140818151204.GA1784@alpha.franken.de>
References: <53F039B3.9010503@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53F039B3.9010503@gentoo.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42134
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

On Sun, Aug 17, 2014 at 01:12:19AM -0400, Joshua Kinard wrote:
> 
> Has anyone tried booting IP28 lately?

will try hopefully tonight. I've checked my logs and last boot of
one of my IP28 was with 3.1 *cough*

> To me, it looks like a pointer isn't getting converted to 64bit address
> space correctly (0xdfbdd600 -> ???).  I haven't played with this IP28
> machine for a few years, so I forget what the best approach to fixing this is.
> 
> Thoughts?

looks like ioremap is broken, that's where the hpc pointer is coming from.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
