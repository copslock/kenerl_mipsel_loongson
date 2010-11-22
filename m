Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Nov 2010 22:34:49 +0100 (CET)
Received: from gateway06.websitewelcome.com ([69.56.148.7]:45150 "HELO
        gateway06.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1492049Ab0KVVeq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Nov 2010 22:34:46 +0100
Received: (qmail 23542 invoked from network); 22 Nov 2010 21:34:48 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway06.websitewelcome.com with SMTP; 22 Nov 2010 21:34:48 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Source:X-Source-Args:X-Source-Dir;
        b=VCrQ0AskfF9/KOCtXqaP3mw0R8P14Z4NBH/QaTSXC4XHtpxtCbiebj3nCvjclpN6KU8dhETG3C8zmDeZpoKd0KyC0OXTRdSvedFV4BUVtM5ng3bJQ4xLmyM1niT6NqjP;
Received: from [216.239.45.4] (port=1473 helo=kkissell.mtv.corp.google.com)
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1PKe22-0007T4-Ri; Mon, 22 Nov 2010 15:34:38 -0600
Message-ID: <4CEAE1EE.9020406@paralogos.com>
Date:   Mon, 22 Nov 2010 13:34:38 -0800
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Maksim Rayskiy <maksim.rayskiy@gmail.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: ASID conflict after CPU hotplug
References: <AANLkTi=yHm72=sM=QwLpm=aDRnxVf7ZM5=W6eNzgVoTN@mail.gmail.com> <20101122034141.GA13138@linux-mips.org>
In-Reply-To: <20101122034141.GA13138@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28455
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

On 11/21/10 19:41, Ralf Baechle wrote:
> ...
> Need to think a little about potencial consequences of your suggested
> patch.  It seems ok.  Kevin, what do you think?
>    
Since you ask, while I would imagine that Maksim's patch works fine for 
him, I'm not sure that it's really the right fix.  I never did succeed 
in getting CPU hotplugging working back in the 2.6.18 days, so I don't 
know as much about it as I'd like, but if per_cpu_trap_init() needs to 
be invoked on a hot plugin event, and if its behavior needs to be 
different , I'd really, really prefer to see that state propagated 
explicitly, rather than inferring it from whatever happens to be in 
cache/memory at cpu_data[cpu].asid_cache.  But beyond that, if the 
problem arises because setting cpu_data[cpu].asid_cache to a known 
initial state on a plugin event can conflict with the residual content 
of EntryHi, rather than creating a special case where we don't 
initialize the ASID cache, since we seem to be (re)initializing a lot of 
other privileged state, why aren't we also setting a known sane initial 
EntryHi value?   Wouldn't that be a cleaner fix?  (And I don't mean that 
as a rhetorical question - there may be very good reasons to let EntryHi 
values persist across hot unplug/plug events.  I just can't imagine them 
offhand over coffee.)

/K.
