Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Aug 2018 21:34:19 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:45910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993070AbeH1TeQN0imR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Aug 2018 21:34:16 +0200
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CE242087E;
        Tue, 28 Aug 2018 19:34:07 +0000 (UTC)
Date:   Tue, 28 Aug 2018 15:34:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>, mhiramat@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        ananth@linux.vnet.ibm.com,
        Alexis Berlemont <alexis.berlemont@gmail.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Subject: Re: [PATCH v9 1/4] Uprobes: Support SDT markers having reference
 count (semaphore)
Message-ID: <20180828153405.7e44d040@gandalf.local.home>
In-Reply-To: <CAPhsuW55gYH2oFg5qEYLW_5hjEOVKvmQvsNPZO4=S=VGdbL6hQ@mail.gmail.com>
References: <20180820044250.11659-1-ravi.bangoria@linux.ibm.com>
        <20180820044250.11659-2-ravi.bangoria@linux.ibm.com>
        <20180822123943.GD2080@linux.vnet.ibm.com>
        <CAPhsuW55gYH2oFg5qEYLW_5hjEOVKvmQvsNPZO4=S=VGdbL6hQ@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <SRS0=SA81=LL=goodmis.org=rostedt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65770
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

On Tue, 28 Aug 2018 12:07:30 -0700
Song Liu <liu.song.a23@gmail.com> wrote:

> Hi all,
> 
> What's our plan with this work? Will this be routed via Steven's tree?
> 
> 

I can start pulling these in and testing them.

Thanks,

-- Steve
