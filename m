Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2018 02:04:12 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:38306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992960AbeHNAEJlKhMB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Aug 2018 02:04:09 +0200
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71F072174B;
        Tue, 14 Aug 2018 00:04:01 +0000 (UTC)
Date:   Mon, 13 Aug 2018 20:03:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Song Liu <liu.song.a23@gmail.com>, srikar@linux.vnet.ibm.com,
        mhiramat@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, open list <linux-kernel@vger.kernel.org>,
        ananth@linux.vnet.ibm.com,
        Alexis Berlemont <alexis.berlemont@gmail.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Subject: Re: [PATCH v8 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
Message-ID: <20180813200359.31311bbb@gandalf.local.home>
In-Reply-To: <20180813115019.GB28360@redhat.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
        <20180809041856.1547-4-ravi.bangoria@linux.ibm.com>
        <CAPhsuW49+qA7kT7yE4tgbnAuox-iOzssg-jc2abG8XDo6XeX8A@mail.gmail.com>
        <95a1221e-aecc-42be-5239-a2c2429be176@linux.ibm.com>
        <20180813115019.GB28360@redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <SRS0=NrGH=K5=goodmis.org=rostedt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65579
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

On Mon, 13 Aug 2018 13:50:19 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> On 08/13, Ravi Bangoria wrote:
> >
> > On 08/11/2018 01:27 PM, Song Liu wrote:  
> > >> +
> > >> +static void delayed_uprobe_delete(struct delayed_uprobe *du)
> > >> +{
> > >> +       if (!du)
> > >> +               return;  
> > > Do we really need this check?  
> >
> > Not necessary though, but I would still like to keep it for a safety.  
> 
> Heh. I tried to ignore all minor problems in this version, but now that Song
> mentioned this unnecessary check...
> 
> Personally I really dislike the checks like this one.
> 
> 	- It can confuse the reader who will try to understand the purpose
> 
> 	- it can hide a bug if delayed_uprobe_delete(du) is actually called
> 	  with du == NULL.
> 
> IMO, you should either remove it and let the kernel crash (to notice the
> problem), or turn it into
> 
> 	if (WARN_ON(!du))
> 		return;

I'd prefer the more robust WARN_ON(!du) above instead of removing it.

-- Steve
