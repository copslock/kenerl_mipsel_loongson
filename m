Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Aug 2014 17:28:05 +0200 (CEST)
Received: from elvis.franken.de ([193.175.24.41]:53692 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6855229AbaHRP2BJ2Bvc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 18 Aug 2014 17:28:01 +0200
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1XJOqm-0002ob-00; Mon, 18 Aug 2014 17:28:00 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
        id 501C51D261; Mon, 18 Aug 2014 17:27:50 +0200 (CEST)
Date:   Mon, 18 Aug 2014 17:27:50 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: IP28 boot error under 3.16
Message-ID: <20140818152750.GA1860@alpha.franken.de>
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
X-archive-position: 42135
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
> Thoughts?

something like

#define IO_BASE                 _AC(0x9000000000000000, UL)

in mach-ip28/spaces.h should do the trick. UNCAC_BASE also looks
strange, no idea why there that way.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
