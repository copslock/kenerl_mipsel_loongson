Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Aug 2018 21:43:54 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:58110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994059AbeH3TntzKJpG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 30 Aug 2018 21:43:49 +0200
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FADB20835;
        Thu, 30 Aug 2018 19:43:41 +0000 (UTC)
Date:   Thu, 30 Aug 2018 15:43:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        srikar@linux.vnet.ibm.com, oleg@redhat.com, mhiramat@kernel.org,
        liu.song.a23@gmail.com, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        ananth@linux.vnet.ibm.com, alexis.berlemont@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Subject: Re: [PATCH v9 4/4] perf probe: Support SDT markers having reference
 counter (semaphore)
Message-ID: <20180830154339.1a14e4bf@gandalf.local.home>
In-Reply-To: <20180830185026.GI6097@kernel.org>
References: <20180820044250.11659-1-ravi.bangoria@linux.ibm.com>
        <20180820044250.11659-5-ravi.bangoria@linux.ibm.com>
        <20180830144531.3011e185@gandalf.local.home>
        <20180830185026.GI6097@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <SRS0=8yld=LN=goodmis.org=rostedt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65806
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

On Thu, 30 Aug 2018 15:50:27 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Thu, Aug 30, 2018 at 02:45:31PM -0400, Steven Rostedt escreveu:
> > 
> > Arnaldo,
> > 
> > I'm going to be playing with some of the probe code which may conflict
> > with these patches, so I would like to pull these in my tree. But this
> > patch requires an Acked-by from you before I can pull it in.
> > 
> > You OK with this?  
> 
> Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>  

Awesome, thanks Arnaldo,

-- Steve
