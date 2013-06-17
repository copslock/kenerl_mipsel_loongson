Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jun 2013 20:33:43 +0200 (CEST)
Received: from merlin.infradead.org ([205.233.59.134]:54616 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6835843Ab3FQSdlLMFev (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Jun 2013 20:33:41 +0200
Received: from dhcp-089-099-019-018.chello.nl ([89.99.19.18] helo=twins)
        by merlin.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
        id 1UoeFF-0001J0-4x; Mon, 17 Jun 2013 18:33:37 +0000
Received: by twins (Postfix, from userid 1000)
        id DDA2C8278340; Mon, 17 Jun 2013 20:33:34 +0200 (CEST)
Date:   Mon, 17 Jun 2013 20:33:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, sibyte-users@bitmover.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 3/7] MIPS: sibyte: Add missing sched.h header
Message-ID: <20130617183334.GC3204@twins.programming.kicks-ass.net>
References: <1371477641-7989-1-git-send-email-markos.chandras@imgtec.com>
 <1371477641-7989-4-git-send-email-markos.chandras@imgtec.com>
 <20130617164427.GE10408@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130617164427.GE10408@linux-mips.org>
User-Agent: Mutt/1.5.21 (2012-12-30)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36956
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peterz@infradead.org
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

On Mon, Jun 17, 2013 at 06:44:27PM +0200, Ralf Baechle wrote:
> On Mon, Jun 17, 2013 at 03:00:37PM +0100, Markos Chandras wrote:
> 
> > It's needed for the TASK_INTERRUPTIBLE definition.
> > 
> > Fixes the following build problem:
> > arch/mips/sibyte/common/sb_tbprof.c:235:4: error: 'TASK_INTERRUPTIBLE'
> > undeclared (first use in this function)
> 
> Ideally sched.h should be included into the actual user of
> TASK_INTERRUPTIBLE, the wake_up_interruptible macro in <linux/wait.h> but
> that seems way too risky that close to a release.

Oh man, there's include recursion hell waiting for you ;-)
