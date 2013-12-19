Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Dec 2013 00:08:19 +0100 (CET)
Received: from mail-ig0-f170.google.com ([209.85.213.170]:46442 "EHLO
        mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6867279Ab3LSXIQdwHZw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Dec 2013 00:08:16 +0100
Received: by mail-ig0-f170.google.com with SMTP id k19so13302001igc.1
        for <multiple recipients>; Thu, 19 Dec 2013 15:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=FjFuCrSroMnyLR+Rkzk9L/pg5HnmU99Ve6DE3BRYhzo=;
        b=xSmDbMY9804sLTUwzT3D64Qlkx9PhbNIoaWWjO2AXtNbsIF5Dz8IMfpuuIr1mpb7ZN
         8JldL2Zb5yDaNn5FOwcxqEkDhL9fkySirg0dD1qk9AC+63Qh/xK2owUPisMjhivP4Yoq
         GkZAj1jFQhNIyk1r1nb89xznLaN2mLMu3lbwnjHQEIAt2xDOQ31M9NuwP1f+Jdgy3CR7
         EJdvqSxmya9LiqoRAl6YylzCBpBm02vmUB/SPx9Ps8kmrr6ofM1a5+HFf/LW712Cmz1Q
         CoKX8Qij9tAPdJQRFGEdYnNemGM288H0JMNNfi05dAdBMqFfzS6Y6oyHYzJHIxSLE6AK
         F+1A==
X-Received: by 10.42.84.130 with SMTP id m2mr3166227icl.16.1387494489800;
        Thu, 19 Dec 2013 15:08:09 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id y10sm9373479igl.4.2013.12.19.15.08.07
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 19 Dec 2013 15:08:08 -0800 (PST)
Message-ID: <52B37C56.7090302@gmail.com>
Date:   Thu, 19 Dec 2013 15:08:06 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Christoph Lameter <cl@linux.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
CC:     Tejun Heo <tj@kernel.org>, akpm@linuxfoundation.org,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 29/40] mips: Replace __get_cpu_var uses
References: <20131219155015.443763038@linux.com> <20131219155033.834416420@linux.com> <52B330F3.4090603@gmail.com> <alpine.DEB.2.10.1312191506370.17603@nuc>
In-Reply-To: <alpine.DEB.2.10.1312191506370.17603@nuc>
Content-Type: multipart/mixed;
 boundary="------------070507070702050801040409"
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38766
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

This is a multi-part message in MIME format.
--------------070507070702050801040409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/2013 01:10 PM, Christoph Lameter wrote:
> On Thu, 19 Dec 2013, David Daney wrote:
>
>>> 16:07:58.244398747 -0600
>>> @@ -43,7 +43,7 @@ DECLARE_PER_CPU(struct mips_fpu_emulator
>>>    #define MIPS_FPU_EMU_INC_STATS(M)					\
>>>    do {
>>> \
>>>    	preempt_disable();						\
>>> -	__local_inc(&__get_cpu_var(fpuemustats).M);			\
>>> +	__this_cpu_inc(fpuemustats.M);					\
>>>    	preempt_enable();						\
>>>    } while (0)
>>>
>>
>> Something seems to be incorrect in this bit.
>
> Hrmm.. yes this is a local_t so the this_cpu_inc would not work unless
> fpuemustats is defined differently.
>

See the attached patch.  Feel free to include it as part of your patch set.

I tested it on a 64-bit OCTEON system.  I think it will work on 32-bit 
systems as well.

> Use
>
> __local_inc(this_cpu_ptr(fpuemustats.M);
>

No, I couldn't get various incantations of that to work either.

> instead until then.
>


--------------070507070702050801040409
Content-Type: text/x-patch;
 name="0001-MIPS-Replace-__get_cpu_var-uses-in-FPU-emulator.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-MIPS-Replace-__get_cpu_var-uses-in-FPU-emulator.patch"
