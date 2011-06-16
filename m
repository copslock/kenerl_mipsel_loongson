Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Jun 2011 21:21:25 +0200 (CEST)
Received: from imr4.ericy.com ([198.24.6.8]:34398 "EHLO imr4.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491089Ab1FPTVT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Jun 2011 21:21:19 +0200
Received: from eusaamw0706.eamcs.ericsson.se ([147.117.20.31])
        by imr4.ericy.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id p5GJLBVD031947;
        Thu, 16 Jun 2011 14:21:12 -0500
Received: from localhost (147.117.20.214) by eusaamw0706.eamcs.ericsson.se
 (147.117.20.91) with Microsoft SMTP Server id 8.3.137.0; Thu, 16 Jun 2011
 15:21:05 -0400
Date:   Thu, 16 Jun 2011 12:21:05 -0700
From:   Guenter Roeck <guenter.roeck@ericsson.com>
To:     David Daney <ddaney@caviumnetworks.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Octeon Ethernet driver
Message-ID: <20110616192105.GC19833@ericsson.com>
References: <20110616181806.GC19457@ericsson.com>
 <4DFA4B7D.7010905@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4DFA4B7D.7010905@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 30429
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13841

On Thu, Jun 16, 2011 at 02:29:17PM -0400, David Daney wrote:
> On 06/16/2011 11:18 AM, Guenter Roeck wrote:
> > Hi David,
> >
> > looks like we'll need to use the Octeon Ethernet driver from SDK 2.0
> > or later in our system, for performance reasons. We plan to use 2.6.39,
> > so we can not directly use the SDK driver.
> >
> > Do you (or someone else) have plans to port it to the upstream kernel,
> > or do you know if such a port exists ?
> 
> I can't really comment on specific plans other than to say that we are 
> working towards reducing the divergence between our Octeon SDK and 
> upstream kernels.
> 
> The existence of any port is irrelevant, what you want is something you 
> can use, and I am not aware of anything other that what is currently in 
> the drivers/staging.
> 
It is not completely irrelevant. If someone did the work already, I won't have
to do it myself. And I won't end up submitting a patch to the driver in staging
just to learn that someone else did the same two days earlier, or planned to submit
the same set of changes two days later.

Thanks,
Guenter
