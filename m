Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2015 15:33:16 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:47890 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011099AbbATOdOqYSMX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jan 2015 15:33:14 +0100
Date:   Tue, 20 Jan 2015 14:33:14 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [PATCH RFC v2 27/70] MIPS: kernel: cevt-r4k: Add MIPS R6 to the
 c0_compare_interrupt handler
In-Reply-To: <20150120091414.GA23188@jhogan-linux.le.imgtec.org>
Message-ID: <alpine.LFD.2.11.1501201427370.28301@eddie.linux-mips.org>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-28-git-send-email-markos.chandras@imgtec.com> <alpine.LFD.2.11.1501200110040.28301@eddie.linux-mips.org> <20150120091414.GA23188@jhogan-linux.le.imgtec.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45370
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

On Tue, 20 Jan 2015, James Hogan wrote:

> >  While a preexisting bug, this is simply not true, there's CP0.Cause.TI to 
> > examine for a timer interrupt pending.  Please fix your change to use 
> > `c0_compare_int_pending' instead and synchronise with stuff posted by 
> > James (cc-ed) at <http://patchwork.linux-mips.org/patch/8900/>.
> 
> I'm not sure I follow what you mean. This change makes it treat r6 like
> it treats r2 (i.e. there is still a Cause.TI bit), which sounds correct
> to me. I'm guessing cpu_has_mips_r6 doesn't imply cpu_has_mips_r2.

 Correct, R6 is not backwards compatible with R2 so it doesn't set the R2 
flag and consequently any compatibility that does exist has to be handled 
explicitly; see 28/70 for the details of the flag setup.

  Maciej
