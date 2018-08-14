Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2018 02:01:55 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:37842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992960AbeHNABwnQGHB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Aug 2018 02:01:52 +0200
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CDED21731;
        Tue, 14 Aug 2018 00:01:43 +0000 (UTC)
Date:   Mon, 13 Aug 2018 20:01:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        srikar@linux.vnet.ibm.com, mhiramat@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        ananth@linux.vnet.ibm.com,
        Alexis Berlemont <alexis.berlemont@gmail.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Subject: Re: [PATCH v8 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
Message-ID: <20180813200141.601a44e0@gandalf.local.home>
In-Reply-To: <CAPhsuW4ymZAxLdDOAz-rKkyb_POA3ibNW7+2G3BE5Mxtntyqsg@mail.gmail.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
        <20180809041856.1547-4-ravi.bangoria@linux.ibm.com>
        <20180809143827.GC22636@redhat.com>
        <20180810155813.49259913@gandalf.local.home>
        <CAPhsuW4ymZAxLdDOAz-rKkyb_POA3ibNW7+2G3BE5Mxtntyqsg@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <SRS0=NrGH=K5=goodmis.org=rostedt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65578
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

On Fri, 10 Aug 2018 23:14:01 -0700
Song Liu <liu.song.a23@gmail.com> wrote:

> On Fri, Aug 10, 2018 at 12:58 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Thu, 9 Aug 2018 16:38:28 +0200
> > Oleg Nesterov <oleg@redhat.com> wrote:
> >  
> >> I need to read this (hopefully final) version carefully. I'll try to do
> >> this before next Monday.
> >>  
> >
> > Monday may be the opening of the merge window (more likely Sunday). Do
> > you think this is good enough for pushing it in this late in the game,
> > or do you think we should wait another cycle?
> >
> > -- Steve  
> 
> We (Facebook) have use cases in production that would benefit from this work, so
> I would rather see this gets in sooner than later. After a brief
> review (I will more
> careful review before Monday), I think this set is not likely to break
> existing uprobes
> (those w/o ref_ctr). Therefore, I think it is safe to put it in this cycle.
> 

It's still going under review, and the merge window is now open. I'd
prefer that this waits till the next merge window.

-- Steve
