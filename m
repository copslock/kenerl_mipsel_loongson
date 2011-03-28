Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Mar 2011 02:24:49 +0200 (CEST)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:64085 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491160Ab1C1AYq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Mar 2011 02:24:46 +0200
Received: by iyb39 with SMTP id 39so2854765iyb.36
        for <multiple recipients>; Sun, 27 Mar 2011 17:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=3Bl7UJUQ6Pdbk4VSp/WYDKjpF6xOlI2q88pD2g1+PjE=;
        b=bacKZdUliM92EJ57eVZXuv2lFD0/M+j0cb1+ghDBMbukYB79WZBU7S7MbdtdST9pMK
         w6OXwSycyy5eS6vwYNsqYUb21KGwTje5Kplqe2uMqJjN24sNtcmyTSK0lvqAOO6HGMJU
         PL9/K6ZBpnysm3uzMXxHLupwCQJvi972u8Qxw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=qy+IErkDGv7znQu6mVltOhj3AJW8scKeZwtPREnvIa5Cv9Wq/VpKtNrNoBk8SkvyBG
         g3v21wqx9DO+h7hGn01gw4xFjJ72xCJsT3/ILivW5YrnHeDYBJuEw8oTwSll4Y9uL2WD
         zlFVgkrsIlYc4B6lSjjDhlstnn3/r4JSObS00=
Received: by 10.43.65.136 with SMTP id xm8mr529706icb.34.1301271880169;
        Sun, 27 Mar 2011 17:24:40 -0700 (PDT)
Received: from dd_xps.caveonetworks.com (adsl-67-127-59-9.dsl.pltn13.pacbell.net [67.127.59.9])
        by mx.google.com with ESMTPS id vr5sm2420518icb.12.2011.03.27.17.24.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 Mar 2011 17:24:39 -0700 (PDT)
Message-ID: <4D8FD546.7090806@gmail.com>
Date:   Sun, 27 Mar 2011 17:24:38 -0700
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110307 Fedora/3.1.9-0.38.b3pre.fc13 Thunderbird/3.1.9
MIME-Version: 1.0
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org
Subject: Re: [patch 3/5] MIPS: Octeon: Simplify irq_cpu_on/offline irq chip
 functions
References: <20110327155637.623706071@linutronix.de> <20110327161118.737588559@linutronix.de> <4D8FA840.2080108@gmail.com> <alpine.LFD.2.00.1103272326270.31464@localhost6.localdomain6>
In-Reply-To: <alpine.LFD.2.00.1103272326270.31464@localhost6.localdomain6>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <david.s.daney@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29583
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips

On 03/27/2011 02:29 PM, Thomas Gleixner wrote:
> On Sun, 27 Mar 2011, David Daney wrote:
>
>> On 03/27/2011 09:22 AM, Thomas Gleixner wrote:
>>> Make use of the IRQCHIP_ONOFFLINE_ENABLED flag and remove the
>>> wrappers. Use irqd_irq_disabled() instead of desc->status, which will
>>> go away.
>>>
>> I rewrote my patch set and was testing it.  Interesting that I came up with a
>> function with almost the same name and purpose.
>>
>> However my function told us if the irq was masked *or* disabled.  The idea
>> being a function that returns true if the irq could fire.  We cannot be
>> enabling the interrupt in the controller if it is masked.
>>
>> For example I need to test this when adjusting affinity, and taking CPUs on
>> and off line.
>>
>> I don't think your genirq changes can tell the me information I really need in
>> their current state.  I think we need to consider how the masked state
>> interacts with IRQCHIP_ONOFFLINE_ENABLED and irqd_irq_disabled().
>>
>> Since I have totally rewritten my interrupt code, I am a bit ambivalent about
>> applying these patches.  It might make more sense that I adjust my patch for
>> your genirq changes and test it before committing it.
> The modifications I made are 100% equivalent to the code you provided
> in the first place.

Acknowledged.

However subsequently, I made mostly equivalent changes.  The main 
difference is that I added IRQS_MASKED into the mix testing it in 
addition to IRQS_DISABLED

> The IRQCHIP_ONOFFLINE_ENABLED flag is only used for the on/offline
> callbacks. The disabled checked based on irq_data is in the affinity
> setting code.
>
> Unless I'm missing something we should be all set.
>

As I mentioned in the other e-mail, I am concerned that some of the chip 
functions may get called when the desc is in a IRQS_MASKED istate.

If we can prevent calling .irq_cpu_online when IRQS_MASKED is set that 
might be good.

Perhaps adding a flag similar to IRQCHIP_ONOFFLINE_ENABLED, to disable 
calling .irq_set_affinity when the irq shouldn't be enabled.

With something like that, I think we can get rid of all the checks in 
the irq_chip functions.

Thanks,
David Daney
