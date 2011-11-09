Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2011 14:43:10 +0100 (CET)
Received: from cantor2.suse.de ([195.135.220.15]:51713 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903563Ab1KINm7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Nov 2011 14:42:59 +0100
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx2.suse.de (Postfix) with ESMTP id 6508489471;
        Wed,  9 Nov 2011 14:42:59 +0100 (CET)
Message-ID: <4EBA8383.3020100@suse.cz>
Date:   Wed, 09 Nov 2011 14:43:31 +0100
From:   Michal Marek <mmarek@suse.cz>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110812 Thunderbird/6.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        Arnaud Lacombe <lacombar@gmail.com>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "Daney, David" <David.Daney@caviumnetworks.com>
Subject: Re: [PATCH] Kbuild: append missing-syscalls to the default target
 list
References: <1314234210-11090-1-git-send-email-lacombar@gmail.com> <4E69FEC9.2080204@suse.cz> <CACqU3MUFyn_jh2pN4GLENqcGVUzAwcMJUR_WLY2EtqOhMheceQ@mail.gmail.com> <20111101232233.GA32441@sepie.suse.cz> <20111107204448.GA9949@linux-mips.org> <20111107211900.GB6264@sepie.suse.cz> <20111107233330.GA26705@linux-mips.org> <4EB8E75D.1010706@suse.cz> <4EB97333.1050403@gmail.com> <4EB9AD98.3010404@suse.cz> <20111109095414.GA15438@linux-mips.org>
In-Reply-To: <20111109095414.GA15438@linux-mips.org>
X-Enigmail-Version: 1.3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 31455
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mmarek@suse.cz
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7732

Dne 9.11.2011 10:54, Ralf Baechle napsal(a):
> On Tue, Nov 08, 2011 at 11:30:48PM +0100, Michal Marek wrote:
> 
>> On 8.11.2011 19:21, David Daney wrote:
>>> The problem is that compiler options meant to be used only for the 
>>> compiling done by scripts/checksyscalls.sh are now leaking into the 
>>> compilation of other parts of the kernel (asm-offsets.c), where they 
>>> wreak havoc.
>>>
>>> Something like the attached is what I think needs to be done.
>>
>> Ah, right. That makes a lot of sense now. Ralf, does the patch at
>> https://lkml.org/lkml/2011/11/8/312 work for you?
> 
> Yes, it does - and unlike David's first version this one also looks
> reasonably elegant.
> 
> Acked-by: Ralf Baechle <ralf@linux-mips.org>

Thanks to both of you, applied to kbuild.git#rc-fixes.

Michal
