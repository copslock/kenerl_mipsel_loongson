Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Dec 2014 11:42:05 +0100 (CET)
Received: from elvis.franken.de ([193.175.24.41]:34954 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006509AbaLAKmEgIS67 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Dec 2014 11:42:04 +0100
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1XvOQa-0006A6-00; Mon, 01 Dec 2014 11:42:00 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
        id 153A91BB799; Mon,  1 Dec 2014 11:41:33 +0100 (CET)
Date:   Mon, 1 Dec 2014 11:41:33 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc:     peter fuerst <post@pfrst.de>, linux-mips@linux-mips.org
Subject: Re: fast_iob() vs PHYS_OFFSET
Message-ID: <20141201104132.GA1973@alpha.franken.de>
References: <yw1xsih2evgn.fsf@unicorn.mansr.com>
 <Pine.LNX.4.64.1411300255520.2113@Opal.Peter>
 <yw1xoaroev7i.fsf@unicorn.mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xoaroev7i.fsf@unicorn.mansr.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44528
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

On Sun, Nov 30, 2014 at 12:20:17PM +0000, Måns Rullgård wrote:
> My concern is over systems like AR7.  It defines PHYS_OFFSET to
> 0x14000000 and UNCAC_BASE, correspondingly, to 0xb4000000.  According to
> the linux-mips wiki, there is some on-chip RAM at physical address 0,
> which explains why the __fast_iob() macro works there.

there is really on-chip RAM for AR7 at address 0. The AR7 CPU core
is only MIPS32r1, so it doesn't have the exception vector base register
and needs ram at physical address 0 for exception handlers (which all
older cores do). I can't check right now, but even IP28 should have
some memory mirrored there. The problem on IP28 is that accessing
memory uncached requires reprogramming the memory controller (which
then doesn't fit the concept of fast_iob()).

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
