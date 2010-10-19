Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Oct 2010 10:39:00 +0200 (CEST)
Received: from t111.niisi.ras.ru ([193.232.173.111]:44326 "EHLO
        t111.niisi.ras.ru" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491056Ab0JSIi5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Oct 2010 10:38:57 +0200
Received: from aa19.niisi.msk.ru (aa19.niisi.msk.ru [172.16.0.19] (may be forged))
        by t111.niisi.ras.ru (8.13.8/8.13.8) with ESMTP id o9J8cvpZ002639;
        Tue, 19 Oct 2010 12:38:57 +0400
Received: from [192.168.173.2] (aa248 [172.16.0.248])
        by aa19.niisi.msk.ru (8.13.8/8.13.8) with ESMTP id o9J8SnFN020791;
        Tue, 19 Oct 2010 12:28:49 +0400
Message-ID: <4CBD5CC9.8070706@niisi.msk.ru>
Date:   Tue, 19 Oct 2010 12:54:33 +0400
From:   "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Shinya Kuribayashi <skuribay@pobox.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend 5/9] MIPS: sync after cacheflush
References: <17ebecce124618ddf83ec6fe8e526f93@localhost>        <17d8d27a2356640a4359f1a7dcbb3b42@localhost>        <4CBC4F4E.5010305@pobox.com>        <20101018191936.GH27377@linux-mips.org> <AANLkTimmatKpOFATCPDxthN-9pZzzXRAOnLGR1_348=r@mail.gmail.com>
In-Reply-To: <AANLkTimmatKpOFATCPDxthN-9pZzzXRAOnLGR1_348=r@mail.gmail.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: Dr.Web (R) for Mail Servers on t111.niisi.ras.ru host
X-Antivirus-Code: 100000
Return-Path: <raiko@niisi.msk.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28152
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raiko@niisi.msk.ru
Precedence: bulk
X-list: linux-mips

On 18.10.2010 23:41, Kevin Cernekee wrote:
> I have not been able to find any official statement from MIPS that
> says that CACHE + SYNC should be used, but that seems like the most
> intuitive way to implement things on the hardware side.

Indeed, both Architecture for Programmers in Vol. 2 describing 
instruction sets not so clearly say that sync is needed after cache.
For example, documents with rev. 2.62, p. 92 (for MIPS32 ISA) or p. 96 
(for MIPS64).

Considering whether just sync enough I'd like to note some boxes may 
implement dma master and slave blocks to be unsynchronized. Also,there 
may be write buffers somewhere in the path between cpu, memory, and even 
a dma master.

BTW, we have plat_extra_sync_for_device which has appropriate name but 
invented to do things before cache flush. :-) It seems we need another 
one which will do something after.

Gleb.
