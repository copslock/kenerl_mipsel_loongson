Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jun 2013 02:27:36 +0200 (CEST)
Received: from mail.windriver.com ([147.11.1.11]:42962 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6835001Ab3FTA1ecmEVv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Jun 2013 02:27:34 +0200
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r5K0RPad012199
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 19 Jun 2013 17:27:26 -0700 (PDT)
Received: from yow-pgortmak-d1 (128.224.146.65) by ALA-HCB.corp.ad.wrs.com
 (147.11.189.41) with Microsoft SMTP Server id 14.2.342.3; Wed, 19 Jun 2013
 17:27:25 -0700
Received: by yow-pgortmak-d1 (Postfix, from userid 1000)        id 2F2C7E1D342; Wed,
 19 Jun 2013 20:28:07 -0400 (EDT)
Date:   Wed, 19 Jun 2013 20:28:07 -0400
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     David Daney <ddaney.cavm@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] mips: delete __cpuinit/__CPUINIT usage from MIPS code
Message-ID: <20130620002806.GA15693@windriver.com>
References: <1371566339-18336-1-git-send-email-paul.gortmaker@windriver.com>
 <51C22E75.3020001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <51C22E75.3020001@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37033
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
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

[Re: [PATCH v2] mips: delete __cpuinit/__CPUINIT usage from MIPS code] On 19/06/2013 (Wed 15:19) David Daney wrote:

> On 06/18/2013 07:38 AM, Paul Gortmaker wrote:
> >The __cpuinit type of throwaway sections might have made sense
> >some time ago when RAM was more constrained, but now the savings
> >do not offset the cost and complications.  For example, the fix in
> >commit 5e427ec2d0 ("x86: Fix bit corruption at CPU resume time")
> >is a good example of the nasty type of bugs that can be created
> >with improper use of the various __init prefixes.
> >
> >After a discussion on LKML[1] it was decided that cpuinit should go
> >the way of devinit and be phased out.  Once all the users are gone,
> >we can then finally remove the macros themselves from linux/init.h.
> >
> >Note that some harmless section mismatch warnings may result, since
> >notify_cpu_starting() and cpu_up() are arch independent (kernel/cpu.c)
> >and are flagged as __cpuinit  -- so if we remove the __cpuinit from
> >the arch specific callers, we will also get section mismatch warnings.
> >As an intermediate step, we intend to turn the linux/init.h cpuinit
> >related content into no-ops as early as possible, since that will get
> >rid of these warnings.  In any case, they are temporary and harmless.
> >
> >Here, we remove all the MIPS __cpuinit from C code and __CPUINIT
> >from asm files.  MIPS is interesting in this respect, because there
> >are also uasm users hiding behind their own renamed versions of the
> >__cpuinit macros.
> >
> >[1] https://lkml.org/lkml/2013/5/20/589
> >
> >Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> I get:
> 
> 
> WARNING: vmlinux.o(.text+0x18640): Section mismatch in reference
> from the function register_cavium_notifier() to the variable
> .cpuinit.data:octeon_cpu_callback_nb.37045
> The function register_cavium_notifier() references
> the variable __cpuinitdata octeon_cpu_callback_nb.37045.
> This is often because register_cavium_notifier lacks a __cpuinitdata
> annotation or the annotation of octeon_cpu_callback_nb.37045 is wrong.
> 
> WARNING: vmlinux.o(.text+0x18650): Section mismatch in reference
> from the function register_cavium_notifier() to the variable
> .cpuinit.data:octeon_cpu_callback_nb.37045
> The function register_cavium_notifier() references
> the variable __cpuinitdata octeon_cpu_callback_nb.37045.
> This is often because register_cavium_notifier lacks a __cpuinitdata
> annotation or the annotation of octeon_cpu_callback_nb.37045 is wrong.
> 
> WARNING: vmlinux.o(.text+0x24778): Section mismatch in reference
> from the function start_secondary() to the function
> .cpuinit.text:calibrate_delay()
> The function start_secondary() references
> the function __cpuinit calibrate_delay().
> This is often because start_secondary lacks a __cpuinit
> annotation or the annotation of calibrate_delay is wrong.
> 
> WARNING: vmlinux.o(.text+0x247b4): Section mismatch in reference
> from the function start_secondary() to the function
> .cpuinit.text:notify_cpu_starting()
> The function start_secondary() references
> the function __cpuinit notify_cpu_starting().
> This is often because start_secondary lacks a __cpuinit
> annotation or the annotation of notify_cpu_starting is wrong.

Yes, see above commit log reference....

> 
> 
> 
> So I think an alternate approach is required.
> 
> Really I think we need to leave all existing __cpuinitdata and
> __cpuinit annotations in place.
> 
> Instead we would first change the definitions of these two to be empyt:
> 
> #define __cpuinit
> #define __cpuinitdata

Again, see above commit log; specifically:

   As an intermediate step, we intend to turn the linux/init.h cpuinit
   related content into no-ops as early as possible, since that will get
   rid of these warnings.  

I am literally in the middle of typing up a mail to linux-arch that
explains this, and that the no-op step comes in at the beginning of the
merge window, and that the big purge comes at the end.

However, I do not want that process to be set in stone ; as Ralf indicated,
he expected some changes to the mips tree and wanted to deal with the
conflicts himself (which is fine by me!) and so we can do that at the
expense of some temporary section warnings.  This is why I explicitly
called them out in the above commit log.

> Once that is working, we would make a second pass and remove the
> symbols themselves.

Yep, thanks for looking at things; it sounds like we are in alignment
with how to proceed here -- only that I wasn't quick enough in getting
the steps published and the no-op phase into linux-next.

Paul.
--

> 
> David Daney
