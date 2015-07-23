Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jul 2015 14:35:51 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:37757 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010617AbbGWMftTBLg8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Jul 2015 14:35:49 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.1/8.14.8) with ESMTP id t6NCZlSn012467;
        Thu, 23 Jul 2015 14:35:47 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.1/8.15.1/Submit) id t6NCZiXu012462;
        Thu, 23 Jul 2015 14:35:44 +0200
Date:   Thu, 23 Jul 2015 14:35:44 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>,
        Markos Chandras <Markos.Chandras@imgtec.com>
Subject: Re: [PATCH 1/2] MIPS: Handle page faults of executable but
 unreadable pages correctly.
Message-ID: <20150723123544.GH8099@linux-mips.org>
References: <cover.1437644062.git.ralf@linux-mips.org>
 <b02d2b2d33026271c663207dc68bfa0531b16251.1437644062.git.ralf@linux-mips.org>
 <55B0BEB3.7010502@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55B0BEB3.7010502@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48401
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Thu, Jul 23, 2015 at 11:15:15AM +0100, James Hogan wrote:

> On 23/07/15 10:10, Ralf Baechle wrote:
> > Without this we end taking execeptions in an endless loop hanging the
> > thread.
> 
> A little more explanation would be nice. Under what situations does this
> occur? Does this mean any VM_EXEC and !VM_READ page can't actually be
> faulted in without it being treated as an RI violation, or does it only
> affect when read from kernel emulation code?

> > -			if (!(vma->vm_flags & VM_READ)) {
> > +			if (!(vma->vm_flags & VM_READ) &&
> > +			    exception_epc(regs) != address) {
> >  #if 0
> >  				pr_notice("Cpu%d[%s:%d:%0*lx:%ld:%0*lx] RI violation\n",
> >  					  raw_smp_processor_id(),
> > 
> 

The general idea is the change the code to treat loads of an instruction
just like an instruction fetch.  Which is achieved by adding the second
condition "exception_epc(regs) != address" to the if above.
exception_epc(regs) == address means

It would all be easier if Linux was enabling the separate exception codes
for read and execution failure but short of that, a test like above must
provide if a fault was an attempted instruction fetch or happend fetching
data.

  Ralf
