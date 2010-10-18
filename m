Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Oct 2010 15:48:17 +0200 (CEST)
Received: from t111.niisi.ras.ru ([193.232.173.111]:47178 "EHLO
        t111.niisi.ras.ru" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491753Ab0JRNsN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Oct 2010 15:48:13 +0200
Received: from aa19.niisi.msk.ru (aa19.niisi.msk.ru [172.16.0.19] (may be forged))
        by t111.niisi.ras.ru (8.13.8/8.13.8) with ESMTP id o9IDmHMw010742;
        Mon, 18 Oct 2010 17:48:17 +0400
Received: from [192.168.173.2] (aa248 [172.16.0.248])
        by aa19.niisi.msk.ru (8.13.8/8.13.8) with ESMTP id o9IDcELx030092;
        Mon, 18 Oct 2010 17:38:14 +0400
Message-ID: <4CBC53C7.3020204@niisi.msk.ru>
Date:   Mon, 18 Oct 2010 18:03:51 +0400
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
References: <AANLkTikP=77Tq=QzFVwexr8fMHg5qmX8fbRjfdkoNSGr@mail.gmail.com> <AANLkTikbw1F+jBhsFFyX0vT6CCAqckzLHK3MK2WtTZiA@mail.gmail.com> <alpine.LFD.2.00.1010172025110.15889@eddie.linux-mips.org> <20101018000030.GB31080@linux-mips.org> <4CBC256A.7020808@niisi.msk.ru> <20101018124838.GF27377@linux-mips.org>
In-Reply-To: <20101018124838.GF27377@linux-mips.org>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: Dr.Web (R) for Mail Servers on t111.niisi.ras.ru host
X-Antivirus-Code: 100000
Return-Path: <raiko@niisi.msk.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28139
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raiko@niisi.msk.ru
Precedence: bulk
X-list: linux-mips

On 18.10.2010 16:48, Ralf Baechle wrote:
> On Mon, Oct 18, 2010 at 02:46:02PM +0400, Gleb O. Raiko wrote:
> 64 context on R2000/R3000, 256 on everything else but R6000 and RM9000
> series, 4096 contexts on RM9000 and that context caching is already
> there.  It's fairly lightweight except in the rare case where the
> PID / ASID number overflows and a full TLB flush becomes necessary.  A
> mm context switch only needs to reload the one wired TLB entry that maps
> the pagetables so that's not too bad.

Ralf,

I counted from the opposite side. Size of KSEG2+KSEG3 is 1 GB, flat page 
table shall be 8 MB aligned to be stored in cp0 context, so we end up 
with 128 page tables in the theory (we have to reserve some space for 
other business too in practice).

If we are going to use a "standard" approach when only current page 
table is mapped, we know the address at compile time and don't need cp0 
context at all. We can even has as many page tables as number of ASIDs 
for cpus with multiple page sizes but cp0 context is still out of play 
anyway.

Gleb.
