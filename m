Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Oct 2010 09:50:04 +0200 (CEST)
Received: from t111.niisi.ras.ru ([193.232.173.111]:47898 "EHLO
        t111.niisi.ras.ru" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491016Ab0JTHuB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Oct 2010 09:50:01 +0200
Received: from aa19.niisi.msk.ru (aa19.niisi.msk.ru [172.16.0.19] (may be forged))
        by t111.niisi.ras.ru (8.13.8/8.13.8) with ESMTP id o9K7o4Cn014837;
        Wed, 20 Oct 2010 11:50:04 +0400
Received: from [192.168.173.2] (aa248 [172.16.0.248])
        by aa19.niisi.msk.ru (8.13.8/8.13.8) with ESMTP id o9K7dnhT027235;
        Wed, 20 Oct 2010 11:39:49 +0400
Message-ID: <4CBEA2D6.6050507@niisi.msk.ru>
Date:   Wed, 20 Oct 2010 12:05:42 +0400
From:   "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Shinya Kuribayashi <skuribay@pobox.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend 5/9] MIPS: sync after cacheflush
References: <17ebecce124618ddf83ec6fe8e526f93@localhost> <17d8d27a2356640a4359f1a7dcbb3b42@localhost> <4CBC4F4E.5010305@pobox.com> <AANLkTinpry=XG-ZDgXJK-VB6QkBL2TO4-vrsV5Tc1eEs@mail.gmail.com> <alpine.LFD.2.00.1010190146360.15889@eddie.linux-mips.org> <20101019123441.GJ27377@linux-mips.org> <alpine.LFD.2.00.1010192039550.15889@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.00.1010192039550.15889@eddie.linux-mips.org>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: Dr.Web (R) for Mail Servers on t111.niisi.ras.ru host
X-Antivirus-Code: 100000
Return-Path: <raiko@niisi.msk.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28173
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raiko@niisi.msk.ru
Precedence: bulk
X-list: linux-mips

On 20.10.2010 0:11, Maciej W. Rozycki wrote:
>   That said, R4k DECstations seem to perform aggressive write buffering in
> the chipset and to make sure a write has propagated to an MMIO register a
> SYNC and an uncached read operation are necessary.

Just uncached read may be enough. R4k shall pull data from its store 
buffer on uncached read.

>   I haven't investigated DMA dependencies and I think we currently only
> have one TURBOchannel device/driver only (that is the DEFTA/defxx FDDI
> thingy) making use of the generic DMA API on DECstations.  It seemed to
> work correctly the last time I tried; presumably either because the API
> Does The Right Thing, or by pure luck and right timings.

dfx_writel issues sync after store. BTW, it seems no uncached read 
issued here (just mb() is used, which seems to do sync only), so either 
those uncached read is not needed (unlikely) or data from dfx_writel 
wait somewhere in the chipset for being pulled by subsequent reads or 
writes.

Gleb.
