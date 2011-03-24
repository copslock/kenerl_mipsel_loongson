Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Mar 2011 14:58:08 +0100 (CET)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:53736 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491127Ab1CXN6E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Mar 2011 14:58:04 +0100
Received: by ewy3 with SMTP id 3so2648584ewy.36
        for <multiple recipients>; Thu, 24 Mar 2011 06:57:59 -0700 (PDT)
Received: by 10.213.20.220 with SMTP id g28mr3638066ebb.26.1300975079320;
        Thu, 24 Mar 2011 06:57:59 -0700 (PDT)
Received: from [192.168.2.2] ([91.79.104.70])
        by mx.google.com with ESMTPS id v1sm4527928eeh.20.2011.03.24.06.57.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Mar 2011 06:57:58 -0700 (PDT)
Message-ID: <4D8B4D8E.1010000@mvista.com>
Date:   Thu, 24 Mar 2011 16:56:30 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
MIME-Version: 1.0
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [patch 37/38] mips: vr41xx: Cleanup the direct access to irq_desc[]
References: <20110323210437.398062704@linutronix.de> <20110323210538.070462971@linutronix.de> <4D8B3CBC.3080307@mvista.com> <alpine.LFD.2.00.1103241400250.31464@localhost6.localdomain6>
In-Reply-To: <alpine.LFD.2.00.1103241400250.31464@localhost6.localdomain6>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29486
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

On 24-03-2011 16:00, Thomas Gleixner wrote:

>>> -		if (!(desc->status&   IRQ_DISABLED)&&   desc->chip->unmask)
>>> -			desc->chip->unmask(source_irq);
>>> +		if (!(desc->status&   IRQ_DISABLED)&&   chip->irq_unmask)
>>> +			chip->irq_unmask(idata);

>>     Hm, doesn't this (I mean the old) code break after the previous patch?

> Not as long as the compat functions are active in the core.

    I've looked at compat_*() before replying: it seems that they work vice 
versa, i.e. the new functions are emulated by calling the old, and you're 
moving away from old to new in the previous patch. Maybe I miss something...

WBR, Sergei
