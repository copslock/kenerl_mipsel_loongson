Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2009 15:42:28 +0100 (CET)
Received: from mail.netlogicmicro.com ([64.0.7.62]:3550 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1492872AbZKYOmZ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Nov 2009 15:42:25 +0100
X-TM-IMSS-Message-ID: <0ec3f32c00011684@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.1.1.7]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id 0ec3f32c00011684 ; Wed, 25 Nov 2009 06:42:18 -0800
Received: from 71.145.164.137 ([71.145.164.137]) by orion8.netlogicmicro.com ([10.1.1.7]) with Microsoft Exchange Server HTTP-DAV ;
 Wed, 25 Nov 2009 14:43:27 +0000
Received: from kh-d280-64 by webmail2.netlogicmicro.com; 25 Nov 2009 08:42:18 -0600
Subject: Re: [PATCH] MIPS: EARLY_PRINTK: Fixup of dependency
From:   Kevin Hickey <khickey@netlogicmicro.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
In-Reply-To: <20091124163006.GA11277@linux-mips.org>
References: <1259055230-15818-1-git-send-email-wuzhangjin@gmail.com>
         <f861ec6f0911240824u187347d6od5bfebc509a27d8d@mail.gmail.com>
         <20091124163006.GA11277@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Date:   Wed, 25 Nov 2009 08:42:18 -0600
Message-ID: <1259160138.4675.14.camel@kh-d280-64>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Return-Path: <khickey@netlogicmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25126
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@netlogicmicro.com
Precedence: bulk
X-list: linux-mips

On Tue, 2009-11-24 at 16:30 +0000, Ralf Baechle wrote:
> On Tue, Nov 24, 2009 at 05:24:57PM +0100, Manuel Lauss wrote:
> 
> > On Tue, Nov 24, 2009 at 10:33 AM, Wu Zhangjin <wuzhangjin@gmail.com> wrote:
> > [...]
> > > This patch will only enable that option when the DEBUG_KERNEL is
> > > enabled.
> > 
> > How about making it independent from DEBUG_KERNEL altogether?  If find
> > it useful even without full debug info.

I agree with Manuel here.  I often build release kernels that benefit
from EARLY_PRINTK.  Why not make EARLY_PRINTK a selectable option in the
config?  Coupling it to DEBUG_KERNEL seems confusing. 

=Kevin
> 
> DEBUG_INFO controlls the generation of ELF debug information.  DEBUG_KERNEL
> only hides most of the debugging options.
> 
>   Ralf
> 
