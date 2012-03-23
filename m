Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2012 07:24:59 +0100 (CET)
Received: from e28smtp09.in.ibm.com ([122.248.162.9]:33587 "EHLO
        e28smtp09.in.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903747Ab2CWGYx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Mar 2012 07:24:53 +0100
Received: from /spool/local
        by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <raghavendra.kt@linux.vnet.ibm.com>;
        Fri, 23 Mar 2012 11:54:42 +0530
Received: from d28relay04.in.ibm.com (9.184.220.61)
        by e28smtp09.in.ibm.com (192.168.1.139) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Fri, 23 Mar 2012 11:54:38 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
        by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q2N6OZsJ4505622;
        Fri, 23 Mar 2012 11:54:36 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
        by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q2NBt3IL023394;
        Fri, 23 Mar 2012 22:55:04 +1100
Received: from [9.77.196.243] ([9.77.196.243])
        by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id q2NBsxcP023171;
        Fri, 23 Mar 2012 22:55:00 +1100
Message-ID: <4F6C170A.4070305@linux.vnet.ibm.com>
Date:   Fri, 23 Mar 2012 11:54:10 +0530
From:   Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Organization: IBM
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Chris Zankel <chris@zankel.net>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] config: simplify INLINE_SPIN_UNLOCK
References: <20120322095502.30866.75756.sendpatchset@codeblue>
In-Reply-To: <20120322095502.30866.75756.sendpatchset@codeblue>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
x-cbid: 12032306-2674-0000-0000-000003CF0D5D
X-archive-position: 32737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raghavendra.kt@linux.vnet.ibm.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 03/22/2012 03:25 PM, Raghavendra K T wrote:
> From: Raghavendra K T<raghavendra.kt@linux.vnet.ibm.com>
>
> Patch simplifies current INLINE_SPIN_UNLOCK. compile tested on x86_64
>
> Change log:
> get rid of INLINE_SPIN_UNLOCK entirely replacing it with UNINLINE_SPIN_UNLOCK
> instead with the reverse meaning.
>
> whover wants to uninline the spinlocks (like spinlock debugging, paravirt etc
> all just do select UNINLINE_SPIN_UNLOCK
typo:
Whoever wants to uninline the spinlocks (like spinlock debugging, 
paravirt etc) just do select UNINLINE_SPIN_UNLOCK.

>
> Suggested-by: Linus Torvalds<torvalds@linux-foundation.org>
> Signed-off-by: Raghavendra K T<raghavendra.kt@linux.vnet.ibm.com>
> ---
>   Please refer : https://lkml.org/lkml/2012/3/21/357

Linus, Please let me know if this is what you were looking for or Did I 
really mess it up :(
