Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Mar 2011 02:12:35 +0200 (CEST)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:43053 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491165Ab1C1AMc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Mar 2011 02:12:32 +0200
Received: by iyb39 with SMTP id 39so2846699iyb.36
        for <multiple recipients>; Sun, 27 Mar 2011 17:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=y5d/q84vUAxr39JMF+UunogMkCdFFng+Ew5qB1o06hs=;
        b=gZikCx1E0S1NmPUWcM8QKOSDwNOGQYzzBYpU7oq2MuPGW7Wg9gI5r5FGjfnGIrlrnT
         OqxGupeExoiBccbN+xb4ExB2p/z05J0nMmMFJQlTjC5hSplbKitq8AeecQcBrYJKWGro
         62j7/7M1wpBJfoU70jCWWE4s/Lc1xFKP80tkY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=wAi5FOiEu6LfyBRPzSuV/GAsOcSjpnN46VQYa5djyuDaJqriZ608/epdyXVCgjQutn
         EcYmp1XFU0EhANfVapU7Toil/gW925vxzfImUZqjsBZCLbP/SXoGluU1ukMIKSFUnNdt
         tn9+LYv9LpKxypUoJaO/NE6/fTAPazfSXosKo=
Received: by 10.42.76.73 with SMTP id d9mr5289484ick.354.1301271145364;
        Sun, 27 Mar 2011 17:12:25 -0700 (PDT)
Received: from dd_xps.caveonetworks.com (adsl-67-127-59-9.dsl.pltn13.pacbell.net [67.127.59.9])
        by mx.google.com with ESMTPS id 13sm2538280ibo.25.2011.03.27.17.12.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 Mar 2011 17:12:24 -0700 (PDT)
Message-ID: <4D8FD267.9040304@gmail.com>
Date:   Sun, 27 Mar 2011 17:12:23 -0700
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110307 Fedora/3.1.9-0.38.b3pre.fc13 Thunderbird/3.1.9
MIME-Version: 1.0
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org
Subject: Re: [patch 3/5] MIPS: Octeon: Simplify irq_cpu_on/offline irq chip
 functions
References: <20110327155637.623706071@linutronix.de> <20110327161118.737588559@linutronix.de> <4D8FA840.2080108@gmail.com> <alpine.LFD.2.00.1103272326270.31464@localhost6.localdomain6> <alpine.LFD.2.00.1103272337260.31464@localhost6.localdomain6>
In-Reply-To: <alpine.LFD.2.00.1103272337260.31464@localhost6.localdomain6>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <david.s.daney@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29582
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips

On 03/27/2011 02:41 PM, Thomas Gleixner wrote:
> On Sun, 27 Mar 2011, Thomas Gleixner wrote:
>> On Sun, 27 Mar 2011, David Daney wrote:
>>
>>> On 03/27/2011 09:22 AM, Thomas Gleixner wrote:
>>>> Make use of the IRQCHIP_ONOFFLINE_ENABLED flag and remove the
>>>> wrappers. Use irqd_irq_disabled() instead of desc->status, which will
>>>> go away.
>>>>
>>> I rewrote my patch set and was testing it.  Interesting that I came up with a
>>> function with almost the same name and purpose.
>>>
>>> However my function told us if the irq was masked *or* disabled.  The idea
>>> being a function that returns true if the irq could fire.  We cannot be
>>> enabling the interrupt in the controller if it is masked.
>>>
>>> For example I need to test this when adjusting affinity, and taking CPUs on
>>> and off line.
>>>
>>> I don't think your genirq changes can tell the me information I really need in
>>> their current state.  I think we need to consider how the masked state
>>> interacts with IRQCHIP_ONOFFLINE_ENABLED and irqd_irq_disabled().
> So you want to know whether the core code masked the interrupt or
> not. In your case that's equivivalent to the irqd_irq_disabled check
> simply because you provide a irq_disable() callback which prevents the
> lazy disable mechanism.

      CPU1                                                 CPU2
handle_edge_irq()
    handle_irq_event()
       .
       .
       .
       enable_interrupts
       .
       handle_edge_irq()
           mask

                                                             set_affinity()
                                                                 enable 
the irq on some CPU1.


          interrupt fires again (incorrectly)






In my set affinity code I want to know if it is masked, so I don't 
inadvertently re-enable it.

David Daney
