Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 May 2014 16:21:34 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:64628 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6854398AbaE1OVcEJuMo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 May 2014 16:21:32 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 4134FB775265D;
        Wed, 28 May 2014 15:21:22 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Wed, 28 May
 2014 15:21:25 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 28 May 2014 15:21:25 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 28 May
 2014 15:21:24 +0100
Message-ID: <5385F0E4.1080207@imgtec.com>
Date:   Wed, 28 May 2014 15:21:24 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Paolo Bonzini <pbonzini@redhat.com>,
        David Daney <ddaney.cavm@gmail.com>,
        David Daney <david.daney@cavium.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
CC:     <linux-mips@linux-mips.org>, Gleb Natapov <gleb@kernel.org>,
        <kvm@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        Sanjay Lal <sanjayl@kymasys.com>,
        qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH 14/21] MIPS: KVM: Add nanosecond count bias KVM register
References: <1398439204-26171-1-git-send-email-james.hogan@imgtec.com> <1398439204-26171-15-git-send-email-james.hogan@imgtec.com> <535A9AF5.30105@gmail.com> <2197488.6tnytXFBJm@radagast> <535B7E58.4070304@redhat.com>
In-Reply-To: <535B7E58.4070304@redhat.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40285
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

Hi Paolo, David, Andreas,

On 26/04/14 10:37, Paolo Bonzini wrote:
> Il 26/04/2014 00:34, James Hogan ha scritto:
>> So yes, you could technically manage without (4) by using (2) ((4) was
>> implemented first), but I think it probably still has some value since
>> you can
>> do it with a single ioctl rather than 4 ioctls (freeze timer, read
>> resume_time, read or write count, unfreeze timer).
>>
>> Enough value to be worthwhile? I haven't really made up my mind yet
>> but I'm
>> leaning towards yes.
> 
> It would be interesting to see how the userspace patches use this
> independent of COUNT_RESUME.

The implementation in QEMU that I've settled upon makes do with just
COUNT_CTL and COUNT_RESUME, but with a slight kernel modification so
that COUNT_RESUME is writeable (to any positive monotonic nanosecond
value <= now). It works fairly cleanly and correctly even with stopping
and starting VM clock (gdb, stop/cont, savevm/loadvm, live migration),
to match the behaviour of the existing mips cpu timer emulation, so I
plan to drop this bias patch, and will post a v2 patchset soon with just
a few modifications.

QEMU saves the state of the KVM timer from kvm_arch_get_registers() or
when the VM clock is stopped (via a vmstate notifier) - whichever comes
first. It then restores the KVM timer from kvm_arch_put_registers() or
when the VM clock is started - whichever comes last.
Example sequence:
stop VM - SAVE
get regs - vm clock already stopped, not saved again
start VM - regs dirty, not restored
put regs - vm clock running, RESTORE

Saving involves:
COUNT_CTL.DC = 1 (freeze KVM timer)
get CP0_Cause, CP0_Count and COUNT_RESUME
store a copy of the calculated VM clock @COUNT_RESUME nanoseconds
(i.e. the VM clock corresponding to the saved CP0_Count)

Restoring involves:
put COUNT_RESUME = now - (vm clock @now - saved vm clock)
(resume occurs at the same interval into the past that the VM clock has
increased since saving)
put CP0_Cause, CP0_Count
(the stored CP0_Count applies at that resume time)
COUNT_CTL.DC = 0 (resume KVM timer from CP0_Count at COUNT_RESUME)

I'll post an updated QEMU patchset ASAP after the KVM patchset, but
wanted to explain how this API can actually be used. Does it sound
reasonable?

Thanks
James
