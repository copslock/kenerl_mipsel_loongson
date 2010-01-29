Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jan 2010 23:17:40 +0100 (CET)
Received: from imr1.ericy.com ([198.24.6.9]:59887 "EHLO imr1.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492854Ab0A2WRg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 29 Jan 2010 23:17:36 +0100
Received: from eusaamw0712.eamcs.ericsson.se ([147.117.20.181])
        by imr1.ericy.com (8.13.1/8.13.1) with ESMTP id o0TMINiS005217;
        Fri, 29 Jan 2010 16:18:26 -0600
Received: from localhost (147.117.20.212) by eusaamw0712.eamcs.ericsson.se
 (147.117.20.182) with Microsoft SMTP Server id 8.1.375.2; Fri, 29 Jan 2010
 17:17:25 -0500
Date:   Fri, 29 Jan 2010 14:19:08 -0800
From:   Guenter Roeck <guenter.roeck@ericsson.com>
To:     David Daney <ddaney@caviumnetworks.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Kernel crash in 2.6.32.6 / bcm1480 with 16k page size
Message-ID: <20100129221908.GA16558@ericsson.com>
References: <20100129132406.GD5685@linux-mips.org> <20100129151220.GA3882@ericsson.com> <4B6316D2.1060006@caviumnetworks.com> <20100129180619.GA20113@linux-mips.org> <20100129183926.GB9895@ericsson.com> <4B632F60.4000604@caviumnetworks.com> <20100129192532.GA11123@ericsson.com> <4B6336F1.8070208@caviumnetworks.com> <20100129200013.GD11123@ericsson.com> <4B6343B9.2010105@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4B6343B9.2010105@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 25751
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19193

On Fri, Jan 29, 2010 at 03:23:21PM -0500, David Daney wrote:
...
> > To follow up on this - does Octeon have a fixed VM size limit ?
> 
> Yes.  But it is larger than SB1's 44 bits.  For Octeon it is 49 bits.
> 
> 
> > And when you run your tests with larger page sizes, do you have IPV6 enabled ?
> 
> Yes.
> 
> But at 16K pages the VM size is 47 bits, so it is under the limit.
> 
> At 64K pages I am using 2-level page tables for 42 bits of VM space 
> which is again under the limit.
> 
> On SB1 and 3-level tables, you will always exceed the limit for both 16K 
> (47 bits) and 64K (55 bits) page sizes.
> 
Ok, based on this info I'll send out a proposed patch shortly.

Guenter
