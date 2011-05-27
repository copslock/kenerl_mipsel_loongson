Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 May 2011 22:13:59 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:64697 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491779Ab1E0UNy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 May 2011 22:13:54 +0200
Received: by pwi8 with SMTP id 8so1099053pwi.36
        for <multiple recipients>; Fri, 27 May 2011 13:13:48 -0700 (PDT)
Received: by 10.68.17.195 with SMTP id q3mr1027130pbd.369.1306527228064;
        Fri, 27 May 2011 13:13:48 -0700 (PDT)
Received: from localhost (S01060002b3d79728.cg.shawcable.net [70.72.87.49])
        by mx.google.com with ESMTPS id a6sm749308pbo.47.2011.05.27.13.13.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 27 May 2011 13:13:46 -0700 (PDT)
Received: by localhost (Postfix, from userid 1000)
        id C5A5F181763; Fri, 27 May 2011 14:13:45 -0600 (MDT)
Date:   Fri, 27 May 2011 14:13:45 -0600
From:   Grant Likely <grant.likely@secretlab.ca>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 3/6] MIPS: Octeon: Add device tree source files.
Message-ID: <20110527201345.GC6645@ponder.secretlab.ca>
References: <1305930343-31259-1-git-send-email-ddaney@caviumnetworks.com>
 <1305930343-31259-4-git-send-email-ddaney@caviumnetworks.com>
 <20110527015618.GC5032@ponder.secretlab.ca>
 <4DDFD892.1040309@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DDFD892.1040309@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30165
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips

On Fri, May 27, 2011 at 10:00:02AM -0700, David Daney wrote:
> On 05/26/2011 06:56 PM, Grant Likely wrote:
> >>+- #interrupt-cells: Must be<2>.  The first cell is the GPIO pin
> >>+   connected to the interrupt source.  The second cell is the interrupt
> >>+   triggering protocol and may have one of four values:
> >>+   0 - level triggered active high.
> >>+   1 - level triggered active low
> >>+   2 - edge triggered on the rising edge.
> >>+   3 - edge triggered on the falling edge.
> >
> >Since you're choosing arbitrary values here anyway, it's convenient to
> >follow the lead of include/linux/irq.h and using 1->edge rising,
> >2->edge falling, 4->level high, 8->level low.  In the past every irq
> >controller kind of did it's own thing, but that's not very scalable.
> >
> 
> OK.  I will use those still somewhat arbitrary values instead.

Indeed, they are still completely arbitrary, but at least they are the
same completely arbitrary values.  :-)

g.
