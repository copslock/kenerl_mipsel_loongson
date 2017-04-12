Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Apr 2017 22:33:15 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:59020 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993929AbdDLUdIGuDrF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 12 Apr 2017 22:33:08 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v3CKX4Zm004023;
        Wed, 12 Apr 2017 22:33:04 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v3CKX4iX004022;
        Wed, 12 Apr 2017 22:33:04 +0200
Date:   Wed, 12 Apr 2017 22:33:04 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-mips@linux-mips.org, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: KGDB: Use kernel context for sleeping threads
Message-ID: <20170412203304.GA3990@linux-mips.org>
References: <c34c16db9efabb09ca200d5b2b14ad0e870a0b1c.1490876180.git-series.james.hogan@imgtec.com>
 <b8d4921a-2a88-c69d-1272-5589a0bfbbe9@cogentembedded.com>
 <20170330155526.GA21492@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170330155526.GA21492@jhogan-linux.le.imgtec.org>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57681
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

On Thu, Mar 30, 2017 at 04:55:26PM +0100, James Hogan wrote:

> Hi Sergei,
> 
> On Thu, Mar 30, 2017 at 06:42:08PM +0300, Sergei Shtylyov wrote:
> > On 03/30/2017 06:06 PM, James Hogan wrote:
> > > @@ -254,25 +251,46 @@ void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *p)
> > >  #endif
> > >
> > >  	for (reg = 0; reg < 16; reg++)
> > > -		*(ptr++) = regs->regs[reg];
> > > +		*(ptr++) = 0;
> > 
> >     Parens are not really necessary, you can get rid of them, while at it.
> 
> While not technically required, I disagree that we should get rid of
> them, simply because after coding in C for almost 20 years I still had
> to look at an operator precedence table to check which of post++ and
> dereference operators take precedence.

I strongly side with James on this one so I applied the patch as-is.

  Ralf
