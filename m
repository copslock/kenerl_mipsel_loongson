Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jun 2014 18:29:52 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:53895 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6859971AbaFPQ3uUH1B1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Jun 2014 18:29:50 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0184C71C35315;
        Mon, 16 Jun 2014 17:29:40 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Mon, 16 Jun
 2014 17:29:43 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Mon, 16 Jun 2014 17:29:43 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Mon, 16 Jun
 2014 17:29:42 +0100
Message-ID: <539F1B76.8090601@imgtec.com>
Date:   Mon, 16 Jun 2014 17:29:42 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Gleb Natapov <gleb@kernel.org>, <kvm@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, David Daney <david.daney@cavium.com>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: Re: [PATCH v2 00/23] MIPS: KVM: Fixes and guest timer rewrite
References: <1401355005-20370-1-git-send-email-james.hogan@imgtec.com> <53870DAD.7050900@redhat.com> <53874719.5070604@imgtec.com> <538750F8.7040202@redhat.com> <53875FEE.1020607@imgtec.com> <53876850.20600@redhat.com> <53879C3E.3040102@imgtec.com> <538839DE.3000804@redhat.com>
In-Reply-To: <538839DE.3000804@redhat.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40528
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

On 30/05/14 08:57, Paolo Bonzini wrote:
> Il 29/05/2014 22:44, James Hogan ha scritto:
>> Yes, I agree with your analysis and had considered something like this,
>> although it doesn't particularly appeal to my sense of perfectionism :).
> 
> I can see that.  But I think the simplification of the code is worth it.
> 
> It is hard to explain why the invalid times-goes-backwards case can
> happen if env->count_save_time is overwritten with data from another
> machine.  I think the explanation is that (due to
> timers_state.cpu_ticks_enabled) the value of "cpu_get_clock_at(now) -
> env->count_save_time" does not depend on get_clock(), but the code
> doesn't have any comment for that.

Exactly. I think of it in terms of count_save_time being in the time
frame of the vm clock, which is also migrated.

In fact since the VM clock is stopped during migration, the
saved/restored count_save_time will likely be the same as the saved vm
clock, so the delta calculated above at restore time is the time since
the vm clock was resumed.

> Rather than adding comments, we might as well force it to be always zero
> and just write get_clock() to COUNT_RESUME.
> 
> Finally, having to serialize env->count_save_time makes harder to
> support migration from TCG to KVM and back.

Yes, I'm not keen on that bit of code.

> 
>> It would be race free though, and if you're stopping the VM at all you
>> expect to lose some time anyway.
> 
> Since you mentioned perfectionism, :) your code also loses some time;
> COUNT_RESUME is written based on when the CPU state becomes clean, not
> on when the CPU was restarted.

The offset you suggest removing is what ensures time isn't lost there.
The VM time when the cpu is restarted == the VM time when it is stopped,
so by saving vm time to count_save_time at vm stop, the timer can be
restarted at exactly the right interval into the past
(COUNT_RESUME=now-interval) so that no time is lost.

Now there is one case I believe where time will be gained which is hard
to avoid without getting a notification before VM stop rather than
after. When the VM is stopped and qemu's state is clean, the state is
read very soon after (not immediately), so the saved state will be at
slightly after the recorded vm time. I.e. the timer was allowed to
continue slightly past when the vm clock was actually stopped.

Cheers
James
