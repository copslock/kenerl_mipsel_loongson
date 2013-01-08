Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jan 2013 07:57:54 +0100 (CET)
Received: from e23smtp04.au.ibm.com ([202.81.31.146]:46042 "EHLO
        e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823003Ab3AHG5xL9XhY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Jan 2013 07:57:53 +0100
Received: from /spool/local
        by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
        Tue, 8 Jan 2013 16:50:22 +1000
Received: from d23dlp01.au.ibm.com (202.81.31.203)
        by e23smtp04.au.ibm.com (202.81.31.210) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Tue, 8 Jan 2013 16:50:21 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
        by d23dlp01.au.ibm.com (Postfix) with ESMTP id 867A62CE804A;
        Tue,  8 Jan 2013 17:57:37 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
        by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r086jxBJ58851496;
        Tue, 8 Jan 2013 17:45:59 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
        by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r086vYQe022837;
        Tue, 8 Jan 2013 17:57:36 +1100
Received: from srivatsabhat.in.ibm.com (srivatsabhat.in.ibm.com [9.124.35.111] (may be forged))
        by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id r086vTw4022727;
        Tue, 8 Jan 2013 17:57:30 +1100
Message-ID: <50EBC2F9.70303@linux.vnet.ibm.com>
Date:   Tue, 08 Jan 2013 12:25:53 +0530
From:   "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120828 Thunderbird/15.0
MIME-Version: 1.0
To:     Russell King - ARM Linux <linux@arm.linux.org.uk>
CC:     Srivatsa Vaddagiri <vatsa@codeaurora.org>,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        mhocko@suse.cz, "H. Peter Anvin" <hpa@zytor.com>,
        sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
        x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Mike Frysinger <vapier@gentoo.org>,
        linux-arm-msm@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        uclinux-dist-devel@blackfin.uclinux.org,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>,
        Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "rusty@rustcorp.com.au" <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/2] cpuhotplug/nohz: Remove offline cpus from nohz-idle
 state
References: <1357268318-7993-1-git-send-email-vatsa@codeaurora.org> <20130105103627.GU2631@n2100.arm.linux.org.uk>
In-Reply-To: <20130105103627.GU2631@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 13010806-9264-0000-0000-000002F4F48B
X-archive-position: 35391
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

On 01/05/2013 04:06 PM, Russell King - ARM Linux wrote:
> On Thu, Jan 03, 2013 at 06:58:38PM -0800, Srivatsa Vaddagiri wrote:
>> I also think that the
>> wait_for_completion() based wait in ARM's __cpu_die() can be replaced with a
>> busy-loop based one, as the wait there in general should be terminated within
>> few cycles.
> 
> Why open-code this stuff when we have infrastructure already in the kernel
> for waiting for stuff to happen?  I chose to use the standard infrastructure
> because its better tested, and avoids having to think about whether we need
> CPU barriers and such like to ensure that updates are seen in a timely
> manner.
> 
> My stance on a lot of this idle/cpu dying code is that much of it can
> probably be cleaned up and merged into a single common implementation -
> in which case the use of standard infrastructure for things like waiting
> for other CPUs do stuff is even more justified.

On similar lines, Nikunj (in CC) and I had posted a patchset sometime ago to
consolidate some of the CPU hotplug related code in the various architectures
into a common standard implementation [1].

However, we ended up hitting a problem with Xen, because its existing code
was unlike the other arch/ pieces [2]. At that time, we decided that we will
first make the CPU online and offline paths symmetric in the generic code and
then provide a common implementation of the duplicated bits in arch/, for the
new CPU hotplug model [3].

I guess we should probably revisit it sometime, consolidating the code in
incremental steps if not all at a time...

--
[1]. http://lwn.net/Articles/500185/
[2]. http://thread.gmane.org/gmane.linux.kernel.cross-arch/14342/focus=14430
[3]. http://thread.gmane.org/gmane.linux.kernel.cross-arch/14342/focus=15567

Regards,
Srivatsa S. Bhat
