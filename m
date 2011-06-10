Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jun 2011 20:56:45 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:40493 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491037Ab1FJS4n (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 Jun 2011 20:56:43 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p5AIvkkl016609;
        Fri, 10 Jun 2011 19:57:47 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p5AIvjd6016605;
        Fri, 10 Jun 2011 19:57:45 +0100
Date:   Fri, 10 Jun 2011 19:57:45 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     David VomLehn <dvomlehn@cisco.com>,
        Grant Likely <grant.likely@secretlab.ca>,
        linux-mips@linux-mips.org, Imre Kaloz <kaloz@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        "Dezhong Diao (dediao)" <dediao@cisco.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Converting MIPS to Device Tree
Message-ID: <20110610185745.GA3536@linux-mips.org>
References: <20110606010753.GA16202@linux-mips.org>
 <BANLkTik1mRWTcX8WgO5s6mFrUGYwBRmSow@mail.gmail.com>
 <20110607230218.GA23552@dvomlehn-lnx2.corp.sa.net>
 <4DEEB2A8.8050302@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DEEB2A8.8050302@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30322
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9495

On Tue, Jun 07, 2011 at 04:22:16PM -0700, David Daney wrote:

> >use a parameter like "devtree=<virtual-address>" on the command line, passed
> >in any way the bootloader likes.
> 
> Some  u-boots for non-mips platforms pass it in the environment of
> the bootm protocol.
> 
> I would say to pass the pointer to the DTB in the environment, but
> not all platforms (like powertv) have an environment.  So I guess
> the command line has to do.

3 steps:

  1) Use command line argument for DT
  2) Iff 1) fails, use DT specified by environment
  3) Iff 1) and 2) fail, use builtin DTB.

> Also I think we should pass the physical address of the DTB, not the
> virtual address.  It would be the kernel's responsibility to figure
> out what the virtual address is.

I like the basic idea - but ...  Most firmware will only use KSEG0 / XKPHYS
mappings so there should be no aliasing issue but still there could be
conflicting cache modes.  So we should also specify that firmware should
writeback and invalidate the DTB from caches.

  Ralf
