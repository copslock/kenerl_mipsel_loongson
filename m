Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jan 2010 19:06:17 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:54575 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492800Ab0A2SGN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 29 Jan 2010 19:06:13 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o0TI6L89003237;
        Fri, 29 Jan 2010 19:06:22 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o0TI6Km7003233;
        Fri, 29 Jan 2010 19:06:20 +0100
Date:   Fri, 29 Jan 2010 19:06:20 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Guenter Roeck <guenter.roeck@ericsson.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Kernel crash in 2.6.32.6 / bcm1480 with 16k page size
Message-ID: <20100129180619.GA20113@linux-mips.org>
References: <20100128155514.GA31611@ericsson.com>
 <20100129132406.GD5685@linux-mips.org>
 <20100129151220.GA3882@ericsson.com>
 <4B6316D2.1060006@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B6316D2.1060006@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 25741
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19032

On Fri, Jan 29, 2010 at 09:11:46AM -0800, David Daney wrote:

> >So first question would be: Has anyone successfully loaded a 64
> >bit mips kernel with 2.6.32 and a page size of 16k or 64k ? This
> >would at least help me reducing the problem to sb1.
> 
> Yes, I routinely run with both 64K and 16K page sizes on 2.6.32 and
> 2.6.33-rc*.  I have not seen any crashes that can not be easily
> explained.

I can reproduce it with today's 14b7baff3eb4b1b46a592630e6f85ded9264798a.
4K page size works ok, 16K without IPv6 works ok and 16K with IPv6 crashes.
Note, I was testing with a non-16K capable userland so ok means userland is
reached.

Either way, that's good enought to look into things.

  Ralf
