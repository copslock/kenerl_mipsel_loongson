Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jan 2010 20:56:37 +0100 (CET)
Received: from imr1.ericy.com ([198.24.6.9]:42355 "EHLO imr1.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492854Ab0A2T4c (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 29 Jan 2010 20:56:32 +0100
Received: from eusaamw0706.eamcs.ericsson.se ([147.117.20.31])
        by imr1.ericy.com (8.13.1/8.13.1) with ESMTP id o0TJvFdm019438;
        Fri, 29 Jan 2010 13:57:17 -0600
Received: from localhost (147.117.20.212) by eusaamw0706.eamcs.ericsson.se
 (147.117.20.91) with Microsoft SMTP Server id 8.1.375.2; Fri, 29 Jan 2010
 14:56:18 -0500
Date:   Fri, 29 Jan 2010 11:58:01 -0800
From:   Guenter Roeck <guenter.roeck@ericsson.com>
To:     David Daney <ddaney@caviumnetworks.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Kernel crash in 2.6.32.6 / bcm1480 with 16k page size
Message-ID: <20100129195801.GC11123@ericsson.com>
References: <20100128155514.GA31611@ericsson.com> <20100129132406.GD5685@linux-mips.org> <20100129151220.GA3882@ericsson.com> <4B6316D2.1060006@caviumnetworks.com> <20100129180619.GA20113@linux-mips.org> <20100129183926.GB9895@ericsson.com> <4B632F60.4000604@caviumnetworks.com> <20100129192532.GA11123@ericsson.com> <4B6336F1.8070208@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4B6336F1.8070208@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 25748
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                
X-UID: 19081

On Fri, Jan 29, 2010 at 02:28:49PM -0500, David Daney wrote:
...
> 
> I suspect you are hitting a maximum valid address bits limit and getting 
> the Address Exception.  Limiting VMALLOC_END so that you don't hit the 
> limit seems to be the solution.  I don't have the manual for the sibyte, 
> so I don't know what the limit is.  The architecture specification 
> doesn't state a fixed limit, although it tells what should happen when 
> the limit is reached.
> 
You mean there might be a CPU-specific limit ? I hope not - that would be quite messy.

I'll see if I can dig up a sibyte manual.

Guenter
