Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Feb 2015 12:39:22 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:40843 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012544AbbBCLjULSuE4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Feb 2015 12:39:20 +0100
Date:   Tue, 3 Feb 2015 11:39:20 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Oleg Kolosov <bazurbat@gmail.com>
cc:     =?ISO-8859-15?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: Few questions about porting Linux to SMP86xx boards
In-Reply-To: <54D017D4.70200@gmail.com>
Message-ID: <alpine.LFD.2.11.1502030930000.22715@eddie.linux-mips.org>
References: <54CEACC1.1040701@gmail.com>        <CAJiQ=7AQuP1JsiApEs4yAR449w6-pcR_qqhSqKdpqNHL5L1mRQ@mail.gmail.com> <yw1xwq409odv.fsf@unicorn.mansr.com> <54D017D4.70200@gmail.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45623
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Tue, 3 Feb 2015, Oleg Kolosov wrote:

> >>> 1. They (Sigma Designs) have overridden __fast_iob which is identical to
> >>> the default one except for one line:
> >>> ...
> >>
> >> I do not have any direct experience with these SoCs, but you might
> >> want to look at the memory map to try to figure this one out.  i.e. if
> >> __fast_iob() normally performs an uncached dummy read from the first
> >> word of physical memory, does the address need to be adjusted by 64MB
> >> on the Sigma chips because system memory (or the memory allocated to
> >> the Linux application processor) starts at PA 0x0400_0000 instead of
> >> 0x0000_0000?
> >>
> >> That theory would also explain why the exception vectors were adjusted
> >> by the same offset.
> > 
> > The 86xx has two DRAM controllers mapped with 1GB windows at 0x8000_0000
> > and 0xc000_0000, and also with 256MB windows at 0x1000_0000 and 0x2000_0000.
> > To complicate matters, CPU physical addresses starting at 0x04000000 are
> > subjected to a set of remapping registers translating 6 blocks of 64MB
> > to an arbitrary (64MB-aligned) bus address (not that these addresses
> > overlap with the low mappings of the DRAM controllers).  The obvious way
> > to support this would be to simply set these registers to an identity
> > mapping and use highmem for anything that doesn't fit the low windows.
> > Obviously, they didn't do that.
> > 
> 
> Thanks for the explanations! This is really useful.

 For the record -- the exact address `__fast_iob' reads from does not 
really matter, all it has to guarantee is no side effects on read access.  
Using the base of KSEG1 was therefore a natural choice for legacy MIPS 
processors that set the architecture back at the time this code was added, 
as the presence of exception vectors there guaranteed this area of the 
address space behaved like RAM so the same location did for any system.

 With the introduction of revision 2 of the MIPS architecture the CP0 
EBase register was added and consequently there is no longer a guarantee 
that exception vectors reside at the base of KSEG1.  Using the value read 
from CP0.EBase to determine a usable address might therefore be a better 
idea, although the current revision of the MIPS architecture specification 
that includes segmentation control makes it a bit complicated.  Using a 
dummy page mapped uncached instead might work the best.

  Maciej
