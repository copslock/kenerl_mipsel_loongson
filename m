Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Oct 2010 12:30:29 +0200 (CEST)
Received: from t111.niisi.ras.ru ([193.232.173.111]:33206 "EHLO
        t111.niisi.ras.ru" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491205Ab0JRKaZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Oct 2010 12:30:25 +0200
Received: from aa19.niisi.msk.ru (aa19.niisi.msk.ru [172.16.0.19] (may be forged))
        by t111.niisi.ras.ru (8.13.8/8.13.8) with ESMTP id o9IAUSve017274;
        Mon, 18 Oct 2010 14:30:28 +0400
Received: from [192.168.173.2] (aa248 [172.16.0.248])
        by aa19.niisi.msk.ru (8.13.8/8.13.8) with ESMTP id o9IAKQ6c017192;
        Mon, 18 Oct 2010 14:20:26 +0400
Message-ID: <4CBC256A.7020808@niisi.msk.ru>
Date:   Mon, 18 Oct 2010 14:46:02 +0400
From:   "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        "wilbur.chan" <wilbur512@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: Question about Context register in TLB refilling
References: <AANLkTikP=77Tq=QzFVwexr8fMHg5qmX8fbRjfdkoNSGr@mail.gmail.com> <AANLkTikbw1F+jBhsFFyX0vT6CCAqckzLHK3MK2WtTZiA@mail.gmail.com> <alpine.LFD.2.00.1010172025110.15889@eddie.linux-mips.org> <20101018000030.GB31080@linux-mips.org>
In-Reply-To: <20101018000030.GB31080@linux-mips.org>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: Dr.Web (R) for Mail Servers on t111.niisi.ras.ru host
X-Antivirus-Code: 100000
Return-Path: <raiko@niisi.msk.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28135
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raiko@niisi.msk.ru
Precedence: bulk
X-list: linux-mips

On 18.10.2010 4:00, Ralf Baechle wrote:
> The aliasing problem is solvable and it may be worth to revisit that old
> piece of code again now 15 years later.

Before anybody will start to prepare patches, I'd like to note using 
c0_context allows less than 128 processes (their mm contexts in fact but 
who cares) to be directly mapped on 32-bit cpus. So, some kind of 
caching needs to be implemented and it will add overhead on every mm 
switch. Sure, this overhead might be bounded for a real case where there 
is a small number of processes, so they all fit in the cache.
--- Beware, wild assumptions here ---
I'm afraid the cost of such caching still will be higher than loading 
pgd_current even from main memory on tlb refill.
--- End of wild assumptions ---

Gleb.
