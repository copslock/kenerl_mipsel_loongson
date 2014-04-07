Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Apr 2014 00:23:01 +0200 (CEST)
Received: from elvis.franken.de ([193.175.24.41]:51335 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816886AbaDGWW6HJtbe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Apr 2014 00:22:58 +0200
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1WXHwP-0000dj-00; Tue, 08 Apr 2014 00:22:57 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
        id B430F1BB731; Tue,  8 Apr 2014 00:19:20 +0200 (CEST)
Date:   Tue, 8 Apr 2014 00:19:20 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] DEC/SNI: O32 wrapper stack switching fixes
Message-ID: <20140407221920.GA9418@alpha.franken.de>
References: <alpine.LFD.2.11.1403312351450.27402@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.11.1403312351450.27402@eddie.linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39690
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

On Tue, Apr 01, 2014 at 12:14:41AM +0100, Maciej W. Rozycki wrote:
>  Please verify this works for your system.

works on a RM200 system (after removing stupid EARLY_CRAP_8250 select).

Only strange thing I see is

WARNING: CPU: 0 PID: 0 at /home/tsbogend/mips/work/linux/arch/mips/mm/uasm.c:97 build_insn+0x4c4/0x570()
Micro-assembler field overflow

Happens twice one for build_clear_cache() and build_copy_cache(). 
CPU is is R4600PC 2.0.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
