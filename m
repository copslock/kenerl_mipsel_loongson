Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Mar 2018 02:15:22 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:53676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990434AbeCXBPOLaJyr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Mar 2018 02:15:14 +0100
Received: from vmware.local.home (cpe-172-100-180-131.stny.res.rr.com [172.100.180.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB9062183F;
        Sat, 24 Mar 2018 01:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB9062183F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date:   Fri, 23 Mar 2018 21:15:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Matthias Schiffer <mschiffer@universe-factory.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ftrace on MIPS/ath79
Message-ID: <20180323211504.18866e83@vmware.local.home>
In-Reply-To: <d0f29d7e-2c4f-c8e4-4179-406c55eaca1c@universe-factory.net>
References: <d0f29d7e-2c4f-c8e4-4179-406c55eaca1c@universe-factory.net>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-Path: <SRS0=0hgc=GO=goodmis.org=rostedt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63210
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

On Fri, 23 Mar 2018 23:20:10 +0100
Matthias Schiffer <mschiffer@universe-factory.net> wrote:

> Hi,
> I'm currently trying to debug a performance bottleneck on low-end ath79
> hardware running OpenWrt/LEDE, but it seems that ftrace is not working
> correctly on these systems. I have tried this with recent 4.4.y and 4.9.y
> with similar results; unfortunately, switching to a newer kernel is not
> easily possible on this hardware at the moment. Please let me know if there
> are any known issues or patches that I should backport.

I don't know of any for mips (nothing in the git logs). The last
updates to the mips code looks to be from 3.17. Also, I have no idea
why try_to_get_module() would be crashing.

> 
> There seem to be two separate issues:
> 
> 1) Building with CONFIG_DYNAMIC_FTRACE leads to a kernel panic as soon as
> kernel modules are loaded (logs attached).
> 
> 2) function_graph tracer does not show anything useful: the trace output
> looks like what was reported in [1]. Building with
> CONFIG_FUNCTION_GRAPH_TRACER leads to a completely empty
> trace_stat/function0 (except for the header); profiling is working as
> expected when CONFIG_FUNCTION_GRAPH_TRACER is disabled.
> 
> I would be thankful for any pointers that might help me to make this work.
> 
> Kind regards,
> Matthias
> 
> 
> [1] https://www.linux-mips.org/archives/linux-mips/2014-11/msg00295.html
> 

From the last email in that thread:

"But yeah, don't go too much by that document. It is out of date, and
when I get time, I'll have to update it. I'll probably do that when I
bring powerpc up to speed with x86 (except for the fentry part).

I want dynamic trampolines for powerpc and such, and when I do that, it
will make all the changes fresh in my mind to go back and tackle the
design documentation."

The sad part is, I've said the same thing recently about updating that
document. But in the mean time, my powerpc box died and I never got to
do what I wanted with that box. My mips board is pretty useless today,
so I don't touch other archs much anymore (don't have the time
either, maybe I will when I retire. That's why I still keep all my
boards around).

I wish I could be of help, but MIPS has been cached out of my brain for
some time. If you want to investigate, I would be willing to give you
help in generic ftrace support, but anything MIPS specific would
require someone from the MIPS team.

-- Steve
