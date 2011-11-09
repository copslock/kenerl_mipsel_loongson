Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2011 12:17:38 +0100 (CET)
Received: from t111.niisi.ras.ru ([193.232.173.111]:38830 "EHLO
        t111.niisi.ras.ru" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903557Ab1KILRd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Nov 2011 12:17:33 +0100
Received: from aa19.niisi.msk.ru (aa19.niisi.msk.ru [172.16.0.19] (may be forged))
        by t111.niisi.ras.ru (8.13.8/8.13.8) with ESMTP id pA9BHKhd000829
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 9 Nov 2011 15:17:21 +0400
Received: from [192.168.173.2] (aa248 [172.16.0.248])
        by aa19.niisi.msk.ru (8.13.8/8.13.8) with ESMTP id pA9BHKSV004574;
        Wed, 9 Nov 2011 15:17:20 +0400
Message-ID: <4EBA6368.6030503@niisi.msk.ru>
Date:   Wed, 09 Nov 2011 15:26:32 +0400
From:   "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Al Cooper <alcooperx@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Kernel hangs occasionally during boot.
References: <y> <1320764341-4275-1-git-send-email-alcooperx@gmail.com> <20111108175532.GA15493@linux-mips.org> <4EBA2E65.3010009@niisi.msk.ru> <20111109103432.GA27378@linux-mips.org>
In-Reply-To: <20111109103432.GA27378@linux-mips.org>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: Dr.Web (R) for Mail Servers on t111.niisi.ras.ru host
X-Antivirus-Code: 100000
X-archive-position: 31451
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raiko@niisi.msk.ru
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7644

On 09.11.2011 14:34, Ralf Baechle wrote:
> Hmm...  Looking at the R4000 manual which generall has the longest
> pipeline hazards, mtc0 gets executed at stage 7, interrupts get sampled
> at stage 3 meaning there is a (7 - 3 - 1) = 3 cycles hazard.  Does
> that one statisfy your constraints?  Or are additional cycles needed
> for a hazard that's generated outside of the CPU's pipeline?
In fact, current back_to_back_hazard is more than enough for cpus I deal 
with. I guess, required time to wait equals number of stages between EX 
(or RD) and WB stages for modern cpus, because CP0 CAUSE is updated 
during WB nowadays.

I suspect, the time required to update internal counter logic for 
original r4k might be bigger though. At least old code waited 12 cycles 
(4*irq_disable_hazard which is 3 for r4k). Perhaps, we should keep this 
code and insert the same amount of nops for old cpus at least.

Regards,
Gleb.
