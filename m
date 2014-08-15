Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Aug 2014 14:10:15 +0200 (CEST)
Received: from bastet.se.axis.com ([195.60.68.11]:49649 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6855199AbaHOMJymHUlH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Aug 2014 14:09:54 +0200
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 7CB1A1808C;
        Fri, 15 Aug 2014 14:09:47 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id Mydl9-KQAFTA; Fri, 15 Aug 2014 14:09:38 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
        by bastet.se.axis.com (Postfix) with ESMTP id B830C180CB;
        Fri, 15 Aug 2014 14:09:38 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id 4914D16C6;
        Fri, 15 Aug 2014 14:09:01 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
        by boulder.se.axis.com (Postfix) with ESMTP id 3BC7B16BC;
        Fri, 15 Aug 2014 14:09:01 +0200 (CEST)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
        by seth.se.axis.com (Postfix) with ESMTP id 3925F3E048;
        Fri, 15 Aug 2014 14:09:01 +0200 (CEST)
Received: from [10.88.41.1] (10.88.41.1) by xmail2.se.axis.com (10.0.5.74)
 with Microsoft SMTP Server (TLS) id 8.3.342.0; Fri, 15 Aug 2014 14:09:00
 +0200
Message-ID: <1408104536.19220.7.camel@lnxlarper.se.axis.com>
Subject: Re: [PATCH v2] MIPS: Remove race window in page fault handling
From:   Lars Persson <lars.persson@axis.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Date:   Fri, 15 Aug 2014 14:08:56 +0200
In-Reply-To: <20140815110129.GB5642@linux-mips.org>
References: <1407505668-18547-1-git-send-email-larper@axis.com>
         <53E500E4.5020509@gmail.com> <20140808204705.GH29898@linux-mips.org>
         <1408089827.15236.2.camel@lnxlarper.se.axis.com>
         <20140815110129.GB5642@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.4.4-3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <lars.persson@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42120
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars.persson@axis.com
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

On fre, 2014-08-15 at 13:01 +0200, Ralf Baechle wrote:
> On Fri, Aug 15, 2014 at 10:03:47AM +0200, Lars Persson wrote:
> 
> > 
> > On fre, 2014-08-08 at 22:47 +0200, Ralf Baechle wrote:
> > > On Fri, Aug 08, 2014 at 09:55:00AM -0700, David Daney wrote:
> > > 
> > > > >+static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> > > > >+	pte_t *ptep, pte_t pteval);
> > > > >+
> > > > 
> > > > Is it possible to reorder the code such that this declaration is not
> > > > necessary?
> > > 
> > > That's not as obvious as one might think initially.  set_pte_at needs
> > > to be defined after set_pte but before clear_pte which is calling set_pte_at.
> > > 
> > > Of both set_pte and clear_pte there are two #ifdefd variants.
> > > 
> > > set_pte_at is a fairly small function only but it's invoked quite a few
> > > times so I was a little concerned about the effect on I'm experimenting with
> > > outlining set_pte_at entirely.  ip22_defconfig with the patch applied as
> > > posted; this is the effect on code size.
> > > 
> > >   text    data     bss     dec     hex filename
> > > 3790118  175304   84544 4049966  3dcc2e vmlinux		as posted
> > > 3789062	 175304	  84544	4048910	 3dc80e	vmlinux		set_pte_at outlined
> > > 
> > >   Ralf
> > 
> > Hi Ralf
> > 
> > Should I update the patch with outlined set_pte_at ?
> 
> Not necessary; I've already done that myself.  I was just waiting for
> comments.
> 
> Thanks for your work on tracking this down.  I wonder, how did you discover
> this issue?

This one was tricky to track down. We had sporadic SIGILLs in
multi-threaded apps for a long time. Eventually we got a test case that
triggered more page cache evictions and the frequency of SIGILLs
increased enough to catch it with a JTAG debugger. 

Kernel call stacks showed one thread handling an illegal instruction
exception while another thread was somewhere around the
set_pte_at/update_mmu_cache calls for the same page.

BR,
 Lars
