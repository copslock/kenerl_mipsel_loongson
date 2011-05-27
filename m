Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 May 2011 22:09:36 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:62382 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491779Ab1E0UJa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 May 2011 22:09:30 +0200
Received: by ywf9 with SMTP id 9so1056674ywf.36
        for <multiple recipients>; Fri, 27 May 2011 13:09:24 -0700 (PDT)
Received: by 10.91.20.13 with SMTP id x13mr2495910agi.16.1306526964066;
        Fri, 27 May 2011 13:09:24 -0700 (PDT)
Received: from [192.168.2.102] (cpe-24-27-26-60.austin.res.rr.com [24.27.26.60])
        by mx.google.com with ESMTPS id c21sm1595897ana.50.2011.05.27.13.09.21
        (version=SSLv3 cipher=OTHER);
        Fri, 27 May 2011 13:09:22 -0700 (PDT)
Message-ID: <4DE004EF.10507@landley.net>
Date:   Fri, 27 May 2011 15:09:19 -0500
From:   Rob Landley <rob@landley.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110424 Thunderbird/3.1.10
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: MIPS panic in 2.6.39 (bisected to 7eaceaccab5f)
References: <4DDB5673.5060206@landley.net> <20110524143937.GB30117@linux-mips.org> <4DDCB1EB.4020707@landley.net> <20110527075512.GE30117@linux-mips.org> <20110527140011.GF30117@linux-mips.org>
In-Reply-To: <20110527140011.GF30117@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <rob@landley.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30163
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rob@landley.net
Precedence: bulk
X-list: linux-mips

On 05/27/2011 09:00 AM, Ralf Baechle wrote:
> On Fri, May 27, 2011 at 08:55:13AM +0100, Ralf Baechle wrote:
> 
>>> Have you guys been able to reproduce the problem?
>>
>> Staring at the disassembly was good enough, I think.  The commit you
>> bisected is restructuring some of the hardware probing code for Malta and
>> seems to result in gcmp_present being set without _gcmp_base having been
>> assigned, thus the null pointer dereference.
> 
> Can you test below patch?  Thanks,

arch/mips/mti-malta/malta-init.c: In function 'prom_init':
arch/mips/mti-malta/malta-init.c:363: error: implicit declaration of
function 'register_cmp_smp_ops'
arch/mips/mti-malta/malta-init.c:366: error: implicit declaration of
function 'register_vsmp_smp_ops'
make[2]: *** [arch/mips/mti-malta/malta-init.o] Error 1

Rob
