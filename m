Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Oct 2016 16:52:43 +0200 (CEST)
Received: from foss.arm.com ([217.140.101.70]:53254 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992212AbcJYOwgRcg3h (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 25 Oct 2016 16:52:36 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85E4F28;
        Tue, 25 Oct 2016 07:52:29 -0700 (PDT)
Received: from [10.1.207.16] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 495473F220;
        Tue, 25 Oct 2016 07:52:27 -0700 (PDT)
Subject: Re: [Patch v5 04/12] irqchip: xilinx: Add support for parent intc
To:     =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1476723176-39891-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1476723176-39891-5-git-send-email-Zubair.Kakakhel@imgtec.com>
 <32f5f17d-7864-c782-7a6f-03660b7ab055@arm.com>
 <581adf44-388c-f8e5-8437-59d7ace2fa8f@imgtec.com>
 <alpine.DEB.2.20.1610251246020.4990@nanos>
 <20161025144459.GF14444@xsjsorenbubuntu>
Cc:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        monstr@monstr.eu, ralf@linux-mips.org, jason@lakedaemon.net,
        alistair@popple.id.au, mporter@kernel.crashing.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        michal.simek@xilinx.com, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, paulus@samba.org, benh@kernel.crashing.org
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <a5c90777-06fb-6f92-0258-463b6eb1ab8d@arm.com>
Date:   Tue, 25 Oct 2016 15:52:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <20161025144459.GF14444@xsjsorenbubuntu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55573
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marc.zyngier@arm.com
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

On 25/10/16 15:44, Sören Brinkmann wrote:
> On Tue, 2016-10-25 at 12:49:33 +0200, Thomas Gleixner wrote:
>> On Tue, 25 Oct 2016, Zubair Lutfullah Kakakhel wrote:
>>> On 10/21/2016 10:48 AM, Marc Zyngier wrote:
>>>> Shouldn't you return an error if irq is zero?
>>>>
>>>
>>> I'll add the following for the error case
>>>
>>> 	pr_err("%s: Parent exists but interrupts property not defined\n" ,
>>> __func__);
>>
>> Please do not use this silly __func__ stuff. It's not giving any value to
>> the printout.
>>
>> Set a proper prefix for your pr_* stuff, so the string is prefixed with
>> 'irq-xilinx:' or whatever you think is appropriate. Then the string itself
>> is good enough to find from which place this printk comes.
> 
> Haven't looked at the real code, but is there probably a way to get a
> struct device pointer and use dev_err?

You wish. Interrupt controllers (and timers) are brought up way before
the device model is available, hence no struct device.

I've started untangling that mess a couple of times, and always ran out
of available time (you start pulling the VFS, then the scheduler, the
creation of the first thread, and then things lock up because you need
to context switch and no timer is ready yet).

I may try to spend some time on it again while travelling to LPC...

	M.
-- 
Jazz is not dead. It just smells funny...
