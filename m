Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Nov 2017 14:43:29 +0100 (CET)
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:52089 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992273AbdKJNnVoHoYY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Nov 2017 14:43:21 +0100
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id CF08B20BE0;
        Fri, 10 Nov 2017 08:43:19 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Fri, 10 Nov 2017 08:43:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=K8XVo9WmaIOtG19CkmwuliZJGEB3k
        99ZuhcF7d945GU=; b=FVp2w+OkMyqVw3aaoxG/GGYSqqpDgY4+g/CLW5e1a0S43
        M9qstj7GEX5R6LVS743Ne87fb9rGijx+RK4D18yUwr0Ea9UEm+81d7t5hr9Q0ccQ
        Lzvns18dTZkJwxmNYJU8RuQ4fu+nJs4F53p+w6BZIgIknic4XGn/R6/bJidvh3Es
        TJ4S+dhM9dgcKLuyNkkmpSAMAR2/IoPjp5eTVppEpfxiXhy6BBL/dtfrl25/qGAc
        aFfGGA1QsK3h4seEVi5YiS0KxlqXA1rqSKMYz0pNtuYhKfbjfJezEDoK4y0B/fVV
        +WDXDMtKVijMNwYtAa/VVD8GkvENbRKTtg9LaxAdQ==
X-ME-Sender: <xms:96wFWn4hGUtTZkUUNdr5F4UGOOh8-8LS_wA6wHuMTySenm-VxIViAQ>
Received: from localhost (lfbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.messagingengine.com (Postfix) with ESMTPA id 72E0B7E804;
        Fri, 10 Nov 2017 08:43:19 -0500 (EST)
Date:   Fri, 10 Nov 2017 14:43:31 +0100
From:   Greg KH <greg@kroah.com>
To:     James Hogan <james.hogan@mips.com>
Cc:     stable@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        James Hogan <jhogan@kernel.org>
Subject: Re: [PATCH BACKPORT 4.1..4.9] MIPS: SMP: Fix deadlock & online race
Message-ID: <20171110134331.GF30012@kroah.com>
References: <20171106211514.29104-1-james.hogan@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171106211514.29104-1-james.hogan@mips.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <greg@kroah.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60829
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg@kroah.com
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

On Mon, Nov 06, 2017 at 09:15:14PM +0000, James Hogan wrote:
> From: Matt Redfearn <matt.redfearn@imgtec.com>
> 
> commit 9e8c399a88f0b87e41a894911475ed2a8f8dff9e upstream.
> 
> Commit 6f542ebeaee0 ("MIPS: Fix race on setting and getting
> cpu_online_mask") effectively reverted commit 8f46cca1e6c06 ("MIPS: SMP:
> Fix possibility of deadlock when bringing CPUs online") and thus has
> reinstated the possibility of deadlock.
> 
> The commit was based on testing of kernel v4.4, where the CPU hotplug
> core code issued a BUG() if the starting CPU is not marked online when
> the boot CPU returns from __cpu_up. The commit fixes this race (in
> v4.4), but re-introduces the deadlock situation.
> 
> As noted in the commit message, upstream differs in this area. Commit
> 8df3e07e7f21f ("cpu/hotplug: Let upcoming cpu bring itself fully up")
> adds a completion event in the CPU hotplug core code, making this race
> impossible. However, people were unhappy with relying on the core code
> to do the right thing.
> 
> To address the issues both commits were trying to fix, add a second
> completion event in the MIPS smp hotplug path. It removes the
> possibility of a race, since the MIPS smp hotplug code now synchronises
> both the boot and secondary CPUs before they return to the hotplug core
> code. It also addresses the deadlock by ensuring that the secondary CPU
> is not marked online before it's counters are synchronised.
> 
> This fix should also be backported to fix the race condition introduced
> by the backport of commit 8f46cca1e6c06 ("MIPS: SMP: Fix possibility of
> deadlock when bringing CPUs online"), through really that race only
> existed before commit 8df3e07e7f21f ("cpu/hotplug: Let upcoming cpu
> bring itself fully up").
> 
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
> Fixes: 6f542ebeaee0 ("MIPS: Fix race on setting and getting cpu_online_mask")
> CC: Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>
> Cc: <stable@vger.kernel.org> # v4.1+: 8f46cca1e6c0: "MIPS: SMP: Fix possibility of deadlock when bringing CPUs online"
> Cc: <stable@vger.kernel.org> # v4.1+: a00eeede507c: "MIPS: SMP: Use a completion event to signal CPU up"
> Cc: <stable@vger.kernel.org> # v4.1+: 6f542ebeaee0: "MIPS: Fix race on setting and getting cpu_online_mask"

These did not apply to 3.18, so this patch overall did not apply there
either.

I don't know if you care about 3.18, but if so, can you provide
backports of these for that tree, and then resend this patch so I can
queue it up?

thanks,

greg k-h
