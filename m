Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2010 23:13:09 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:52018 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491869Ab0KWWNG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 Nov 2010 23:13:06 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id oANMCxlO003195;
        Tue, 23 Nov 2010 22:12:59 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id oANMCwRr003175;
        Tue, 23 Nov 2010 22:12:58 GMT
Date:   Tue, 23 Nov 2010 22:12:57 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Felix Fietkau <nbd@openwrt.org>, Gabor Juhos <juhosg@openwrt.org>,
        Arnaud Lacombe <lacombar@gmail.com>, linux-mips@linux-mips.org,
        kaloz@openwrt.org, "Luis R. Rodriguez" <lrodriguez@atheros.com>,
        Cliff Holden <Cliff.Holden@atheros.com>
Subject: Re: [PATCH 03/18] MIPS: add generic support for multiple machines
 within a single kernel
Message-ID: <20101123221257.GA21583@linux-mips.org>
References: <1290524800-21419-1-git-send-email-juhosg@openwrt.org>
 <1290524800-21419-4-git-send-email-juhosg@openwrt.org>
 <AANLkTikMwNqd507sPSTQOXt4KYkr9v61H=4_ESo7xFdj@mail.gmail.com>
 <4CEC0D1C.7090605@openwrt.org>
 <4CEC10AE.10305@openwrt.org>
 <4CEC13E1.4080202@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4CEC13E1.4080202@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28503
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 23, 2010 at 11:20:01AM -0800, David Daney wrote:

> For what it's worth, the FDT support in the kernel is almost
> completely generic.  The appropriate hooks are already in the mips
> archetecture support, but most of the contents of
> arch/mips/kernel/prom.c will likely need to be moved to chip/board
> specific files.
> 
> Over the next few weeks I plan on sending out patches to the
> cavium-octeon support to convert it to use the FDT.  So I don't
> think it is out of the question that other chips would start to use
> it as well.

I'm willing to accept this patch because DT is still being introduced into the
kernel.  It's new, it's not entirely trivial and it will take some time until
everybody is up to speed and I just can't stall new submissions until that
changes.  Even though this is a patch which we actually don't want ...

So queued for 2.6.38.  Thanks!

  Ralf
