Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jun 2011 20:10:05 +0200 (CEST)
Received: from imr4.ericy.com ([198.24.6.8]:58288 "EHLO imr4.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491000Ab1FNSKA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Jun 2011 20:10:00 +0200
Received: from eusaamw0711.eamcs.ericsson.se ([147.117.20.178])
        by imr4.ericy.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id p5EI92pE011574;
        Tue, 14 Jun 2011 13:09:53 -0500
Received: from [155.53.96.104] (147.117.20.214) by
 eusaamw0711.eamcs.ericsson.se (147.117.20.179) with Microsoft SMTP Server id
 8.3.137.0; Tue, 14 Jun 2011 14:09:47 -0400
Subject: Re: Linux 2.6.39 on Cavium CN38xx
From:   Guenter Roeck <guenter.roeck@ericsson.com>
Reply-To: guenter.roeck@ericsson.com
To:     David Daney <ddaney@caviumnetworks.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <4DF7928C.7010004@caviumnetworks.com>
References: <1307653714.8271.130.camel@groeck-laptop>
         <4DF13E25.2060502@caviumnetworks.com> <20110609220614.GA13583@ericsson.com>
         <4DF15068.30906@caviumnetworks.com>
         <1307751642.8271.315.camel@groeck-laptop>
         <20110612164155.GA30615@ericsson.com> <4DF67CAE.1040804@caviumnetworks.com>
         <20110613215111.GA3484@ericsson.com> <20110614033403.GA4582@ericsson.com>
         <4DF7928C.7010004@caviumnetworks.com>
Content-Type: text/plain; charset="UTF-8"
Organization: Ericsson
Date:   Tue, 14 Jun 2011 11:09:46 -0700
Message-ID: <1308074986.8271.361.camel@groeck-laptop>
MIME-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
X-archive-position: 30378
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11777

On Tue, 2011-06-14 at 12:55 -0400, David Daney wrote:
> On 06/13/2011 08:34 PM, Guenter Roeck wrote:
> > On Mon, Jun 13, 2011 at 05:51:11PM -0400, Guenter Roeck wrote:
> > [ ... ]
> >>>>
> >>>> The actual interrupt causing trouble and spurious interrupts in my case is,
> >>>> oddly enough, STATUSF_IP0. So far I have been unable to track down how that
> >>>> is triggered; I don't see the bit being set set in C0_CAUSE anywhere.
> >>>>
> >>>> Are there any means to trigger an IP0 interrupt other than by writing STATUSF_IP0
> >>>> into the C0_CAUSE register ?
> >>>>
> >>>
> >>> No.  Nothing that I know of ever uses IP0 and IP1, so they should always
> >>> be cleared.
> >>>
> >> Exactly what I figured, yet I still get those spurious interrupts if IP0 is enabled.
> >> Something odd is definitely going on in my system.
> >>
> >> Besides the above, my hopefully final problem is that timer interrupts are only
> >> received by CPU 0. Any idea what to look for to fix this problem ?
> >>
> > Found the problem. Apparently the BIOS resets CvmCtl[IPTI] to 0.
> 
> That is clearly erroneous behavior.  Although you can set any value, the 
> HRM clearly states that 2..7 are the only legal values.
> 
.. and one that I didn't expect at all. Yet here it is:

        /* Force the default state (all 0), including BE mode. */
        dmtc0   zero, CVMC0_CVM_CTL

Guess someone didn't know or care what the "default state" is. Cost me
10 days - by far the most expensive single line of assembler I ever
wrote :(.

> The Cavuim/Octeon u-boot just leave it at the default value of 7, and 
> the kernel basically expects it to be 7, and never explicitly sets it.
> 
> We do set the IPPCI to 6 in the kernel, and for performance reasons, 
> expect it to have a different value than IPTI.  IP{2,3,4} are basically 
> reserved for use by the system interrupt controller, so really these 
> things must be on one of IP{5,6,7}.
> 
Yes, I noticed. I fixed my problem by setting IPTI to 7 at the same
location.

Thanks,
Guenter
