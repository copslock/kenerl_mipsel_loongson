Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Nov 2012 23:32:46 +0100 (CET)
Received: from kymasys.com ([64.62.140.43]:38091 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6825740Ab2KNWcot1Q6e convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Nov 2012 23:32:44 +0100
Received: from ::ffff:173.33.185.184 ([173.33.185.184]) by kymasys.com for <linux-mips@linux-mips.org>; Wed, 14 Nov 2012 14:32:35 -0800
Subject: Re: [PATCH 04/20] KVM/MIPS32: MIPS arch specific APIs for KVM
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type:   text/plain; charset=US-ASCII
From:   Sanjay Lal <sanjayl@kymasys.com>
In-Reply-To: <509292CD.5030700@redhat.com>
Date:   Wed, 14 Nov 2012 17:32:38 -0500
Cc:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Content-Transfer-Encoding: 7BIT
Message-Id: <71ED4D6E-2241-4DB5-9321-4DEE075E10F0@kymasys.com>
References: <74E3548E-9F3A-4849-BD5A-D1AAE19A0982@kymasys.com> <509292CD.5030700@redhat.com>
To:     Avi Kivity <avi@redhat.com>
X-Mailer: Apple Mail (2.1283)
X-archive-position: 35005
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sanjayl@kymasys.com
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


On Nov 1, 2012, at 11:18 AM, Avi Kivity wrote:

>> +
>> +    /* Set the appropriate status bits based on host CPU features, before we hit the scheduler */
>> +    kvm_mips_set_c0_status();
>> +
>> +    local_irq_enable();
> 
> Ah, so you handle exits with interrupts enabled.  But that's not how we
> usually do it; the standard pattern is
> 
> 
> while (can continue)
>     disable interrupts
>     enter guest
>     enable interrupts
>     process exit

A bit more detail here. KVM/MIPS has its own set of exception handlers which are separate from the host kernel's handlers.  We switch between the 2 sets of handlers by setting the Exception Base Register (EBASE).  We enable host interrupts just before we switch to guest context so that we trap when the host gets a timer or I/O interrupt.  

When an exception does occur in guest context, the KVM/MIPS handlers will save the guest context, and switch back to the default host kernel exception handlers. We enter the "C" handler (kvm_mips_handle_exit()) with interrupts disabled, and explicitly enable them there.  This allows the host kernel to handle any pending interrupts.

The sequence is as follows
while (can continue)
	disable interrupts
	trampoline code to save host kernel context, load guest context
	enable host interrupts
	enter guest context
	KVM/MIPS trap handler (called with interrupts disabled, per MIPS architecture)
	Restore host Linux context, setup stack to handle exception
	Jump to "C" handler
	Enable interrupts before handling VM exit.
	

Regards
Sanjay
