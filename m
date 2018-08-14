Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2018 02:07:59 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:38628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993889AbeHNAHzECBhB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Aug 2018 02:07:55 +0200
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF3F320C01;
        Tue, 14 Aug 2018 00:07:46 +0000 (UTC)
Date:   Mon, 13 Aug 2018 20:07:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, oleg@redhat.com,
        mhiramat@kernel.org, liu.song.a23@gmail.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        ananth@linux.vnet.ibm.com, alexis.berlemont@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Subject: Re: [PATCH v8 1/6] Uprobes: Simplify uprobe_register() body
Message-ID: <20180813200745.2d0d5bb3@gandalf.local.home>
In-Reply-To: <20180813085612.GE44470@linux.vnet.ibm.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
        <20180809041856.1547-2-ravi.bangoria@linux.ibm.com>
        <20180813085612.GE44470@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <SRS0=NrGH=K5=goodmis.org=rostedt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65581
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

On Mon, 13 Aug 2018 01:56:12 -0700
Srikar Dronamraju <srikar@linux.vnet.ibm.com> wrote:

> * Ravi Bangoria <ravi.bangoria@linux.ibm.com> [2018-08-09 09:48:51]:
> 
> > Simplify uprobe_register() function body and let __uprobe_register()
> > handle everything. Also move dependency functions around to fix build
> > failures.
> >   
> 
> One nit:
> s/to fix build/failures/to avoid build failures/

I pulled in this patch with the above update to the change log.

> 
> 
> 
> > Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> > ---  
> 
> 
> Acked-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Thanks, I added your ack and Song's Reviewed-by tags.

-- Steve
