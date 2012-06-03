Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jun 2012 13:49:25 +0200 (CEST)
Received: from e28smtp01.in.ibm.com ([122.248.162.1]:57793 "EHLO
        e28smtp01.in.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903618Ab2FCLtR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Jun 2012 13:49:17 +0200
Received: from /spool/local
        by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
        Sun, 3 Jun 2012 17:19:09 +0530
Received: from d28relay03.in.ibm.com (9.184.220.60)
        by e28smtp01.in.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Sun, 3 Jun 2012 17:19:05 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
        by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q53Bn5mH11206926;
        Sun, 3 Jun 2012 17:19:05 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
        by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q53HIpos001301;
        Mon, 4 Jun 2012 03:18:52 +1000
Received: from [9.79.225.40] ([9.79.225.40])
        by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id q53HIlbZ001138;
        Mon, 4 Jun 2012 03:18:48 +1000
Message-ID: <4FCB4F00.8080202@linux.vnet.ibm.com>
Date:   Sun, 03 Jun 2012 17:18:16 +0530
From:   "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120424 Thunderbird/12.0
MIME-Version: 1.0
To:     Yong Zhang <yong.zhang0@gmail.com>
CC:     tglx@linutronix.de, peterz@infradead.org,
        paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au,
        mingo@kernel.org, akpm@linux-foundation.org,
        vatsa@linux.vnet.ibm.com, rjw@sisk.pl, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, nikunj@linux.vnet.ibm.com,
        Ralf Baechle <ralf@linux-mips.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Mike Frysinger <vapier@gentoo.org>,
        David Howells <dhowells@redhat.com>,
        Arun Sharma <asharma@fb.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 10/27] mips, smpboot: Use generic SMP booting infrastructure
References: <20120601090952.31979.24799.stgit@srivatsabhat.in.ibm.com> <20120601091226.31979.62223.stgit@srivatsabhat.in.ibm.com> <20120603082507.GA16829@zhy>
In-Reply-To: <20120603082507.GA16829@zhy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
x-cbid: 12060311-4790-0000-0000-0000030FA1A4
X-archive-position: 33508
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: srivatsa.bhat@linux.vnet.ibm.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 06/03/2012 01:55 PM, Yong Zhang wrote:

> On Fri, Jun 01, 2012 at 02:42:32PM +0530, Srivatsa S. Bhat wrote:
>> Convert mips to use the generic framework to boot secondary CPUs.
>>
>> Notes:
>> 1. The boot processor was setting the secondary cpu in cpu_online_mask!
>> Instead, leave it up to the secondary cpu (... and it will be done by the
>> generic code now).
>>
>> 2. Make the boot cpu wait for the secondary cpu to be set in cpu_online_mask
>> before returning.
> 
> We don't need to wait for both cpu_callin_map (The code above yours)
> any more.


Yes, I noticed that while writing the patch. But then, I thought of cleaning
up the hundreds of callin/callout/commenced maps in various architectures and
bringing them out into core code in a later series, and clean this up at that time..
I didn't want to do too many invasive changes all at one-shot.

But I guess for this particular case of mips, I can get rid of the wait for
cpu_callin_map in this patchset itself. I'll update this patch with that change.

Thanks!

> 
>>
>> 3. Don't enable interrupts in cmp_smp_finish() and vsmp_smp_finish().
>> Do it much later, in generic code.
> 
> Hmmm... the bad thing is that some board enable irq more early than
> ->smp_finish(), I have sent patches for that (by moving irq enable
> to smp_finish() and delaying smp_finish()).
> Please check patch#0001~patch#0004 in
> http://marc.info/?l=linux-mips&m=133758022710973&w=2
> 
>>
>> 4. In synchronise_count_slave(), use local_save_flags() instead of
>> local_irq_save() because irqs are still disabled.
> 
> We can just remove local_irq_save()/local_irq_restore() like:
> http://marc.info/?l=linux-mips&m=133758046211043&w=2
> 


So what is the status of those patches? Has anyone picked them up?

I could rebase this patch on top of yours, or better yet, if your
patches haven't been picked up yet, I could include them in this
patchset itself to avoid too many dependencies on external patches.

What do you say?

Regards,
Srivatsa S. Bhat
