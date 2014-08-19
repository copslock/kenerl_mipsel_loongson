Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2014 10:13:01 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:59934 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6855120AbaHSIM7gxfA4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Aug 2014 10:12:59 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s7J8CwXQ020756;
        Tue, 19 Aug 2014 10:12:58 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s7J8CwSH020755;
        Tue, 19 Aug 2014 10:12:58 +0200
Date:   Tue, 19 Aug 2014 10:12:58 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: IP28: Correct IO_BASE in mach-ip28/spaces.h for
 proper ioremap
Message-ID: <20140819081258.GB11547@linux-mips.org>
References: <53F2BC86.8000506@gentoo.org>
 <20140819080034.GA11547@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140819080034.GA11547@linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42141
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Tue, Aug 19, 2014 at 10:00:34AM +0200, Ralf Baechle wrote:

CAC_BASE is also just redefining the default value and the value for
HIGHMEM_START appears bogus.  Can you just remove the entire file?
That should make the kernel pickup arch/mips/include/asm/mach-generic/spaces.h
with its defaults that should work for IP28 instead.

  Ralf
