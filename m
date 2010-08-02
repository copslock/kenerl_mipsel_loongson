Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Aug 2010 16:59:12 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:44171 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492728Ab0HBO7I (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 2 Aug 2010 16:59:08 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o72Ex5qt006567;
        Mon, 2 Aug 2010 15:59:06 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o72Ex5hw006565;
        Mon, 2 Aug 2010 15:59:05 +0100
Date:   Mon, 2 Aug 2010 15:59:04 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Florian Fainelli <florian@openwrt.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] OCTEON: workaround linking failures with gcc-4.4.x
 32-bits toolchains
Message-ID: <20100802145904.GA6123@linux-mips.org>
References: <201007290013.08797.florian@openwrt.org>
 <4C50AC0C.9010507@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4C50AC0C.9010507@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27531
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 28, 2010 at 03:15:40PM -0700, David Daney wrote:

> >executables by default, we will produce __lshrti3 in sched_clock() which is
> >never resolved so the kernel fails to link. Unconditionally use the inline
> >assembly version as suggested by David Daney, which works around the issue.
> >
> >CC: David Daney<ddaney@caviumnetworks.com>
> >Signed-off-by: Florian Fainelli<florian@openwrt.org>
> 
> Acked-by: David Daney <ddaney@caviumnetworks.com>

Applied - but maybe we should just add lshrti3 instead?  We already have
ashldi3, ashrdi3 and lshrdi3.

  Ralf
