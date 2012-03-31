Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Apr 2012 00:19:34 +0200 (CEST)
Received: from pm1.terions.de ([83.137.96.25]:47733 "EHLO pm1.terions.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903631Ab2CaWTb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 1 Apr 2012 00:19:31 +0200
Received: (qmail 23754 invoked by uid 98); 31 Mar 2012 22:19:27 -0000
Received: from unknown (HELO ?192.168.178.33?) (postmaster@lkmail.de@78.43.56.110)
  by 0 with ESMTPA; 31 Mar 2012 22:19:27 -0000
Message-ID: <4F7782ED.7050407@lkmail.de>
Date:   Sun, 01 Apr 2012 00:19:25 +0200
From:   Lorenz Kolb <linuxppcemb@lkmail.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.1.16) Gecko/20101125 Thunderbird/3.0.11
MIME-Version: 1.0
To:     paulmck@linux.vnet.ibm.com
CC:     Eric Dumazet <eric.dumazet@gmail.com>,
        linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
        dhowells@redhat.com, sparclinux@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-am33-list@redhat.com,
        linux@arm.linux.org.uk, linux-hexagon@vger.kernel.org,
        x86@kernel.org, jejb@parisc-linux.org, cmetcalf@tilera.com,
        uclinux-dist-devel@blackfin.uclinux.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-m32r@ml.linux-m32r.org,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux390@de.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH RFC] Simplify the Linux kernel by reducing its state space
References: <20120331163321.GA15809@linux.vnet.ibm.com> <1333227608.2325.4054.camel@edumazet-glaptop> <20120331212149.GI2450@linux.vnet.ibm.com>
In-Reply-To: <20120331212149.GI2450@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32846
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linuxppcemb@lkmail.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

With that patchset in mind, I am working on a really huge patch, which 
will greatly simplify the Linux kernel  for the real problem of having 
that number of CPUs.

That patch will have a lot of changes all over the architectures, so 
what will be the best way to post it? Should I split it architecture 
dependend and into one generic part.

Currently it is a large blob of millions of changes, but will greatly 
simplify the Linux kernel.

Regards,

Lorenz Kolb

Am 31.03.2012 23:21, schrieb Paul E. McKenney:
> On Sat, Mar 31, 2012 at 11:00:08PM +0200, Eric Dumazet wrote:
>    
>> On Sun, 2012-04-01 at 00:33 +0800, Paul E. McKenney wrote:
>>      
>>> Although there have been numerous complaints about the complexity of
>>> parallel programming (especially over the past 5-10 years), the plain
>>> truth is that the incremental complexity of parallel programming over
>>> that of sequential programming is not as large as is commonly believed.
>>> Despite that you might have heard, the mind-numbing complexity of modern
>>> computer systems is not due so much to there being multiple CPUs, but
>>> rather to there being any CPUs at all.  In short, for the ultimate in
>>> computer-system simplicity, the optimal choice is NR_CPUS=0.
>>>
>>> This commit therefore limits kernel builds to zero CPUs.  This change
>>> has the beneficial side effect of rendering all kernel bugs harmless.
>>> Furthermore, this commit enables additional beneficial changes, for
>>> example, the removal of those parts of the kernel that are not needed
>>> when there are zero CPUs.
>>>
>>> Signed-off-by: Paul E. McKenney<paulmck@linux.vnet.ibm.com>
>>> Reviewed-by: Thomas Gleixner<tglx@linutronix.de>
>>> ---
>>>        
>> Hmm... I believe you could go one step forward and allow negative values
>> as well. Antimatter was proven to exist after all.
>>
>> Hint : nr_cpu_ids is an "int", not an "unsigned int"
>>
>> Bonus: Existing bugs become "must have" features.
>>      
> ;-) ;-) ;-)
>
>    
>> Of course there is no hurry and this can wait 365 days.
>>      
> James Bottomley suggested imaginary numbers of CPUs some time back,
> and I suppose there is no reason you cannot have fractional numbers of
> CPUs, and perhaps irrational numbers as well.  Of course, these last two
> would require use of floating-point arithmetic (or something similar)
> in the kernel.  So I guess we have at several years worth.  Over to you
> for the negative numbers.  ;-)
>
> 							Thanx, Paul
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>    
