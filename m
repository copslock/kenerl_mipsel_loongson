Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Dec 2015 18:00:26 +0100 (CET)
Received: from mail-wm0-f53.google.com ([74.125.82.53]:33247 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007617AbbLRRAYhOBMm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Dec 2015 18:00:24 +0100
Received: by mail-wm0-f53.google.com with SMTP id p187so72926273wmp.0
        for <linux-mips@linux-mips.org>; Fri, 18 Dec 2015 09:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=zxaCfFPEzWgpcPzraRJgJuh1kMpj6f0/JAODxTnm2YM=;
        b=ACe3Su539dDdjNgJP1sjfHTj3jEy0ok40D/sM5nmM4eCuXNef8nm22UOBNoy37dzQA
         34T2NHKgDU9UnyGhPRE6wbLhEPc0Kpof/PRK+MLHwJusmGLQuH+UHt3SGu6IU2h6sOAl
         eP32k0px8twPUyBrzaKnH/+X/X2IgQxlqo42Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=zxaCfFPEzWgpcPzraRJgJuh1kMpj6f0/JAODxTnm2YM=;
        b=APIYnAZw10AYWVq3yzHxF5dSiPGkzKQsPZuONY6ZnY53fSx0XpXmVoDwRuYzPnr0ZU
         qMotp9WSs9uZKmnys+/Eu6xIpz2PNQ5GAFE6VLR97NbNlT9hYsBnS/GrdfKUPx0rltpk
         2U490Eyi9qKLBuH517nK6rMoaIZ/oHkkXZevhcO5gYHOQxXOpQMPIoxoEPa7nZtrGnGN
         92L75MJUwUVMJ+W/NZm0p7pytSf7fS9FFS9j7Ah/f6MXMoMEJvi4uxTUQ4KfCtmanKnX
         n1oRagDE0YdpC5xjsEtIsjZBIO+hycd94wU1Xwwc4gb3KxBonLXr9Ns7lVJzCF5TcIrP
         tsog==
X-Gm-Message-State: ALoCoQm/lGxjpZAzNe8vbX4PkxhWGCE63AomYAlYfZYl5/OE8kCLGrbNsPze1GzBo/dBXZ9U2c7OX4z2QlP1RJPy/y6ihdRyZQ==
X-Received: by 10.28.13.138 with SMTP id 132mr4640603wmn.62.1450458018941;
        Fri, 18 Dec 2015 09:00:18 -0800 (PST)
Received: from [192.168.1.125] (cpc4-aztw19-0-0-cust71.18-1.cable.virginm.net. [82.33.25.72])
        by smtp.googlemail.com with ESMTPSA id l7sm15582615wjx.14.2015.12.18.09.00.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Dec 2015 09:00:17 -0800 (PST)
Subject: Re: [PATCH v3 4/4] printk/nmi: Increase the size of NMI buffer and
 make it configurable
To:     Petr Mladek <pmladek@suse.com>
References: <1449667265-17525-1-git-send-email-pmladek@suse.com>
 <1449667265-17525-5-git-send-email-pmladek@suse.com>
 <CAMuHMdXVgr58YjoePGrRbMyMncQ27f85prL7G5SpeHeNxoYrXQ@mail.gmail.com>
 <20151211124159.GB3729@pathway.suse.cz>
 <20151211145725.b0e81bb4bb18fcd72ef5f557@linux-foundation.org>
 <20151211232113.GZ8644@n2100.arm.linux.org.uk>
 <alpine.LNX.2.00.1512120024370.9922@cbobk.fhfr.pm>
 <5673DD60.7080302@linaro.org> <20151218145207.GK3729@pathway.suse.cz>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "adi-buildroot-devel@lists.sourceforge.net" 
        <adi-buildroot-devel@lists.sourceforge.net>,
        Cris <linux-cris-kernel@axis.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>
From:   Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <56743BA0.1030409@linaro.org>
Date:   Fri, 18 Dec 2015 17:00:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
In-Reply-To: <20151218145207.GK3729@pathway.suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <daniel.thompson@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50693
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.thompson@linaro.org
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

On 18/12/15 14:52, Petr Mladek wrote:
> On Fri 2015-12-18 10:18:08, Daniel Thompson wrote:
>> On 11/12/15 23:26, Jiri Kosina wrote:
>>> On Fri, 11 Dec 2015, Russell King - ARM Linux wrote:
>>>
>>>> I'm personally happy with the existing code, and I've been wondering why
>>>> there's this effort to apply further cleanups - to me, the changelogs
>>>> don't seem to make that much sense, unless we want to start using
>>>> printk() extensively in NMI functions - using the generic nmi backtrace
>>>> code surely gets us something that works across all architectures...
>>>
>>> It is already being used extensively, and not only for all-CPU backtraces.
>>> For starters, please consider
>>>
>>> - WARN_ON(in_nmi())
>>> - BUG_ON(in_nmi())
>>
>> Sorry to join in so late but...
>>
>> Today we risk deadlock when we try to issue these diagnostic errors
>> directly from NMI context.
>>
>> After this change we will still risk deadlock, because that's what
>> the diagnostic code is trying to tell us, *and* we delay actually
>> reporting the error until, and only if, the NMI handler completes.
>
> I think that NMI messages about a possible deadlock are the ones
> from
>
>      kernel/locking/rtmutex.c
>      kernel/irq_work.c
>      include/linux/hardirq.h
>
> You are right that if the deadlock happens, this patch set lowers the
> chance to see the message.
>
> On the other hand, all the other printk's in NMI seems to be non-fatal
> warnings. In this case, this patch set increases the chance to see
> them.

Maybe for a WARN_ON() the trade off is worth it but I don't think a 
BUG_ON() trace would ever make it out.


> A compromise might be to explicitly call printk_nmi_flush() in the few
> fatal cases. Alternatively we could force the messages on the
> early_console when available.
>
>
>>> - anything being printed out from MCE handlers
>>
>> The MCE handlers should only call printk() when they decide to panic
>> and *after* busting the spinlocks. At this point deferring printk()
>> until it is safe is not very helpful.
>>
>> When we bust the spinlocks we should probably restore the normal
>> printk() function to give best chance of the failure messages making
>> it out.
>
> The problem is that we do not know what locks need to be busted. There
> are too many consoles and too many locks involved. Also busting locks
> open another can of worms.

Yes, I agree that busting the spinlocks doesn't avoid all risk of deadlock.

Probably I've been placing too much weight on the importance of getting 
messages out when dying. You're right that surviving far enough through 
a panic to trigger kdump or reset is equally (or more) important in many 
scenarios than getting a failure message out.

However on a system with nothing but "while(1) {}" hooked up to panic() 
then its worth risking a lock up. In this case restoring normal printk() 
behavior and dumping the NMI buffers would be worthwhile.


Daniel.
