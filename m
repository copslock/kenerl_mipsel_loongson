Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2012 14:28:33 +0200 (CEST)
Received: from sam.nabble.com ([216.139.236.26]:51684 "EHLO sam.nabble.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903559Ab2EKM21 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 May 2012 14:28:27 +0200
Received: from telerig.nabble.com ([192.168.236.162])
        by sam.nabble.com with esmtp (Exim 4.72)
        (envelope-from <lists@nabble.com>)
        id 1SSoxN-0005EI-JP
        for linux-mips@linux-mips.org; Fri, 11 May 2012 05:28:25 -0700
Message-ID: <33777466.post@talk.nabble.com>
Date:   Fri, 11 May 2012 05:28:25 -0700 (PDT)
From:   JoeJ <tttechmail@gmail.com>
To:     linux-mips@linux-mips.org
Subject: Re: SMP MIPS and Linux 3.2
In-Reply-To: <4F42FD60.4090201@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Nabble-From: tttechmail@gmail.com
References: <4BEA3FF3CAA35E408EA55C7BE2E61D055C769FECBC@xmail3.se.axis.com> <4F42FD60.4090201@windriver.com>
X-archive-position: 33257
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tttechmail@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>


Mikael,

 Just wanted to know if you could bring-up 3.2 on mips34k core with SMVP
support enabled? Do you see any boot-up issues or memory related issues
here? I am trying to bring-up SMVP on 34k using 2.6.35 kernel and current
hit on issues during system boot-up (application load). Could you provide me
the following details w.r.t kernel configuration if possible. 
1. Is CONFIG_PREEMPT enabled ?
2. What is page size configured?
3. Do you have timer interrupts to both vpe0 & vpe1?
4. Is the kernel downloaded from kernel.org or mips repository. 
5. If you can share the kernel configuration file you are using, it will be
helpful. 

Also, any other bugs that you encountered during SMVP bring-up using 3.2
kernel?

Regards,
Joe. 




Tiejun Chen-2 wrote:
> 
> Mikael Starvik wrote:
>> I'm running Linux 3.2 on a MIPS 34K with two VPEs (in MT_SMP
>> configuration). It works fine in UP but with SMP it deadlocks during
>> bootup (both CPUs gets idle). Typically like this:
>> 
>> [��� 0.090000] CPU revision is: 01019550 (MIPS 34Kc)
>> [��� 0.090000] Primary instruction cache 32kB, VIPT, 4-way, linesize 32
>> bytes.
>> [��� 0.090000] Primary data cache 32kB, 4-way, PIPT, no aliases, linesize
>> 32 bytes
>> [��� 0.170000] Brought up 2 CPUs
>> <No more output>
>> 
>> I have tried to enable __ARCH_WANT_INTERRUPTS_ON_CTXSW but that didn't
>> improve anything. Anyone else got this running or have any thoughts about
>> what the problem may be?
>> 
> 
> I think using git-bisect is the simplest way to figure out this if you
> already
> know one kernel version is fine for mips 34kc.
> 
> Or did you try to pass 'nosmp' into the kernel command line? If good maybe
> you're hitting some locking issues. You can enable those Kconfig options
> to
> probe-to-debug these locking problem.
> 
> Tiejun
> 
> 
> 
> 

-- 
View this message in context: http://old.nabble.com/SMP-MIPS-and-Linux-3.2-tp33355620p33777466.html
Sent from the linux-mips main mailing list archive at Nabble.com.
