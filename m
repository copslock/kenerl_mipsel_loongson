Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jan 2010 19:23:16 +0100 (CET)
Received: from imr2.ericy.com ([198.24.6.3]:37482 "EHLO imr2.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S2097172Ab0A2SXJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 29 Jan 2010 19:23:09 +0100
Received: from eusaamw0711.eamcs.ericsson.se ([147.117.20.178])
        by imr2.ericy.com (8.13.1/8.13.1) with ESMTP id o0TINnTZ018590;
        Fri, 29 Jan 2010 12:23:53 -0600
Received: from localhost (147.117.20.212) by eusaamw0711.eamcs.ericsson.se
 (147.117.20.179) with Microsoft SMTP Server id 8.1.375.2; Fri, 29 Jan 2010
 13:22:52 -0500
Date:   Fri, 29 Jan 2010 10:24:35 -0800
From:   Guenter Roeck <guenter.roeck@ericsson.com>
To:     David Daney <ddaney@caviumnetworks.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Kernel crash in 2.6.32.6 / bcm1480 with 16k page size
Message-ID: <20100129182434.GA9895@ericsson.com>
References: <20100128155514.GA31611@ericsson.com> <20100129132406.GD5685@linux-mips.org> <20100129151220.GA3882@ericsson.com> <4B6316D2.1060006@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4B6316D2.1060006@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 25743
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19046

On Fri, Jan 29, 2010 at 12:11:46PM -0500, David Daney wrote:
> Guenter Roeck wrote:
> > On Fri, Jan 29, 2010 at 08:24:07AM -0500, Ralf Baechle wrote:
> >> On Thu, Jan 28, 2010 at 07:55:14AM -0800, Guenter Roeck wrote:
> >>> I get the following kernel crash when running a 2.6.32.6 kernel on a bcm1480 cpu.
> >>> It only happens if I configure a page size of 16k or 64k; 4k page size is fine.
> >>>
...
> 
> Yes, I routinely run with both 64K and 16K page sizes on 2.6.32 and 
> 2.6.33-rc*.  I have not seen any crashes that can not be easily explained.
> 
Do you have IPV6 enabled ? If not, you won't see the crash. I forgot to mention that earlier.

Guenter
