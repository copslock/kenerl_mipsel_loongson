Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Dec 2015 11:18:18 +0100 (CET)
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38248 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006811AbbLRKSQd4fgG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Dec 2015 11:18:16 +0100
Received: by mail-wm0-f46.google.com with SMTP id l126so58474630wml.1
        for <linux-mips@linux-mips.org>; Fri, 18 Dec 2015 02:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=wepTfVH0PMVDtb5enoiBtQGY1mhryiamlTKb1tv486E=;
        b=WNIFmsZvvMUAq+vAJ0HYeAkpdrjcDA5l9nb9dRS1NTbidS4ufEANRTD+TOJvCjJXlF
         JuX4orGS++Ijq3DhXBErNanP87jybjxMwPKWM0yfmXgm+8cEcuDV3j1lcb/le1y2tkDv
         TYNWKthEfayBLbqzBJYXm/22dJ1CjsoX8gOp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=wepTfVH0PMVDtb5enoiBtQGY1mhryiamlTKb1tv486E=;
        b=f0N/+ozAQDudvrLjkmNaQ2baaDCSFYN882p/fiBueOzH719vVeheoIZ5xNaZlpnql6
         zVfUIhlT0S9igwbwO38Z2x8hKkH5gy209vV1GYhLJsGNNGmcjXGO2kAQ3OI7usqvcSfq
         Eu8AoPoMJxrQVLY7JSUHkHAeq9y4vvqITw1RyRlBEpRyCbJz/x35sdH5+zJNWcTzaW+F
         RKzeRR9CBZbzXfuIbKactt6mL01mX1/LK67zKfYwQ53HcSDUho4v1gLRMKw0rogY7Hkp
         bxcygTi9Tb9zlDYxinlKBTu6hermTgAqwyAIUU4udBn76OAjZIbgym+c981tQb2xRfEY
         yApA==
X-Gm-Message-State: ALoCoQl4ljUJxawh4Mzsp2sVjdDVMUVuNt6JmsT5rWZj8s4EVn24+IBs86Qr21WVsKCnSnUfDL2vh86/oIVN1y9XYxwZvFEjzg==
X-Received: by 10.28.214.20 with SMTP id n20mr2314686wmg.36.1450433890907;
        Fri, 18 Dec 2015 02:18:10 -0800 (PST)
Received: from [192.168.1.125] (cpc4-aztw19-0-0-cust71.18-1.cable.virginm.net. [82.33.25.72])
        by smtp.googlemail.com with ESMTPSA id f11sm6064431wmd.7.2015.12.18.02.18.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Dec 2015 02:18:09 -0800 (PST)
Subject: Re: [PATCH v3 4/4] printk/nmi: Increase the size of NMI buffer and
 make it configurable
To:     Jiri Kosina <jikos@kernel.org>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>
References: <1449667265-17525-1-git-send-email-pmladek@suse.com>
 <1449667265-17525-5-git-send-email-pmladek@suse.com>
 <CAMuHMdXVgr58YjoePGrRbMyMncQ27f85prL7G5SpeHeNxoYrXQ@mail.gmail.com>
 <20151211124159.GB3729@pathway.suse.cz>
 <20151211145725.b0e81bb4bb18fcd72ef5f557@linux-foundation.org>
 <20151211232113.GZ8644@n2100.arm.linux.org.uk>
 <alpine.LNX.2.00.1512120024370.9922@cbobk.fhfr.pm>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
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
Message-ID: <5673DD60.7080302@linaro.org>
Date:   Fri, 18 Dec 2015 10:18:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.00.1512120024370.9922@cbobk.fhfr.pm>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <daniel.thompson@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50682
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

On 11/12/15 23:26, Jiri Kosina wrote:
> On Fri, 11 Dec 2015, Russell King - ARM Linux wrote:
>
>> I'm personally happy with the existing code, and I've been wondering why
>> there's this effort to apply further cleanups - to me, the changelogs
>> don't seem to make that much sense, unless we want to start using
>> printk() extensively in NMI functions - using the generic nmi backtrace
>> code surely gets us something that works across all architectures...
>
> It is already being used extensively, and not only for all-CPU backtraces.
> For starters, please consider
>
> - WARN_ON(in_nmi())
> - BUG_ON(in_nmi())

Sorry to join in so late but...

Today we risk deadlock when we try to issue these diagnostic errors 
directly from NMI context.

After this change we will still risk deadlock, because that's what the 
diagnostic code is trying to tell us, *and* we delay actually reporting 
the error until, and only if, the NMI handler completes.

I'm not entirely sure that this is an improvement.


> - anything being printed out from MCE handlers

The MCE handlers should only call printk() when they decide to panic and 
*after* busting the spinlocks. At this point deferring printk() until it 
is safe is not very helpful.

When we bust the spinlocks we should probably restore the normal 
printk() function to give best chance of the failure messages making it out.


Daniel.
