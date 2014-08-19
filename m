Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2014 22:02:04 +0200 (CEST)
Received: from elvis.franken.de ([193.175.24.41]:60700 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6855328AbaHSUB0bk8ZN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Aug 2014 22:01:26 +0200
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1XJpat-00060S-02; Tue, 19 Aug 2014 22:01:23 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
        id 7FD061D270; Tue, 19 Aug 2014 22:01:15 +0200 (CEST)
Date:   Tue, 19 Aug 2014 22:01:15 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Joshua Kinard <kumba@gentoo.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: IP28: Correct IO_BASE in mach-ip28/spaces.h for
 proper ioremap
Message-ID: <20140819200115.GA13326@alpha.franken.de>
References: <53F2BC86.8000506@gentoo.org>
 <20140819080034.GA11547@linux-mips.org>
 <20140819100502.GA5321@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140819100502.GA5321@alpha.franken.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42152
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

On Tue, Aug 19, 2014 at 12:05:02PM +0200, Thomas Bogendoerfer wrote:
> On Tue, Aug 19, 2014 at 10:00:34AM +0200, Ralf Baechle wrote:
> I'll give a spin later.

after fixing the L1_CACHE_SHIFT my IP28 booted successfull to a shell
prompt.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
