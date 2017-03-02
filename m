Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2017 18:44:55 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:34784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993875AbdCBRoskJekB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Mar 2017 18:44:48 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 0A0B520383;
        Thu,  2 Mar 2017 17:44:46 +0000 (UTC)
Received: from gandalf.local.home (cpe-67-246-153-56.stny.res.rr.com [67.246.153.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BDD82037F;
        Thu,  2 Mar 2017 17:44:43 +0000 (UTC)
Date:   Thu, 2 Mar 2017 12:44:41 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     David Daney <david.daney@cavium.com>,
        Jason Baron <jbaron@akamai.com>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Russell King <linux@armlinux.org.uk>,
        Rabin Vincent <rabin@rab.in>,
        Paul Mackerras <paulus@samba.org>,
        Anton Blanchard <anton@samba.org>,
        Ingo Molnar <mingo@kernel.org>, Zhigang Lu <zlu@ezchip.com>
Subject: Re: [PATCH] module: set __jump_table alignment to 8
Message-ID: <20170302124441.0e2634e0@gandalf.local.home>
In-Reply-To: <8737ewexkp.fsf@concordia.ellerman.id.au>
References: <20170301220453.4756-1-david.daney@cavium.com>
        <87varsj6qc.fsf@concordia.ellerman.id.au>
        <8737ewexkp.fsf@concordia.ellerman.id.au>
X-Mailer: Claws Mail 3.14.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <SRS0=XfmF=2L=goodmis.org=rostedt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
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

On Thu, 02 Mar 2017 22:18:30 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Michael Ellerman <mpe@ellerman.id.au> writes:
> > David Daney <david.daney@cavium.com> writes:  
> >> Strict alignment became necessary with commit 3821fd35b58d
> >> ("jump_label: Reduce the size of struct static_key"), currently in
> >> linux-next, which uses the two least significant bits of pointers to
> >> __jump_table elements.  
> >
> > It would obviously be nice if this could go in before the commit that
> > exposes the breakage, but I guess that's problematic because Steve
> > doesn't want to rebase the tracing tree.
> >
> > Steve I think you've already sent your pull request for this cycle? So I
> > guess if this can go in your first batch of fixes?  
> 
> Ugh. Was looking at the wrong tree - Linus has already merged the commit
> in question, so the above is all moot.

No problem. I've got some other "fixes" to push to Linus. That's what
the -rc releases are for. To fix up breakage from the merge window ;-)

I'll pull this into my tree.

Thanks!

-- Steve
