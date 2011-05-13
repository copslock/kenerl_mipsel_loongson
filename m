Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2011 18:37:57 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:38752 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491849Ab1EMQhv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 May 2011 18:37:51 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p4DGdNrS011825;
        Fri, 13 May 2011 17:39:23 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p4DGdNvg011823;
        Fri, 13 May 2011 17:39:23 +0100
Date:   Fri, 13 May 2011 17:39:23 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Alexander Clouter <alex@digriz.org.uk>
Cc:     Sergei Shtylyov <sshtylyov@mvista.com>, linux-mips@linux-mips.org,
        florian@openwrt.org
Subject: Re: [PATCH] MIPS: AR7: Fix GCC 4.6.0 build error.
Message-ID: <20110513163923.GA11814@linux-mips.org>
References: <20110513152855.GM25017@chipmunk>
 <4DCD4EC9.1070804@mvista.com>
 <20110513155030.GO25017@chipmunk>
 <20110513163055.GA11537@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110513163055.GA11537@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30010
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, May 13, 2011 at 05:30:55PM +0100, Ralf Baechle wrote:

>  	gpch->regs = ioremap_nocache(AR7_REGS_GPIO,
> -					AR7_REGS_GPIO + 0x10);
> +					AR7_REGS_GPIO + size);

And promptly screwed up, sigh ...

  Ralf
