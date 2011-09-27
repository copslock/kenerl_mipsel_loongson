Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Sep 2011 04:01:26 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:56826 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491890Ab1I0CBW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 27 Sep 2011 04:01:22 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p8R21dXL004431;
        Tue, 27 Sep 2011 04:01:39 +0200
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p8R21SKT004410;
        Tue, 27 Sep 2011 04:01:28 +0200
Date:   Tue, 27 Sep 2011 04:01:28 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Greg KH <greg@kroah.com>
Cc:     David Daney <david.daney@cavium.com>, rongqing.li@windriver.com,
        netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] staging/octeon: Software should check the checksum of no
 tcp/udp packets
Message-ID: <20110927020128.GA26048@linux-mips.org>
References: <1316999280-11999-1-git-send-email-rongqing.li@windriver.com>
 <4E80D794.3040701@cavium.com>
 <20110927005127.GB10447@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110927005127.GB10447@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15118

On Mon, Sep 26, 2011 at 05:51:27PM -0700, Greg KH wrote:

> > This looks fine to me,
> > 
> > Acked-by: David Daney <david.daney@cavium.com>
> > 
> > I would let davem, Ralf and Greg KH fight over who gets to merge it.
> 
> I'll let Ralf take it, unless he wants me to.
> 
> Ralf?

Ok.  Yes, that seems the best solution.

  Ralf
