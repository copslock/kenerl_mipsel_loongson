Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 May 2017 11:48:51 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:22332 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992517AbdEVJsns3U-X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 May 2017 11:48:43 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id F2E30166382FA;
        Mon, 22 May 2017 10:48:34 +0100 (IST)
Received: from [10.80.2.5] (10.80.2.5) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 22 May
 2017 10:48:37 +0100
Subject: Re: [PATCH 00/21] MIPS memblock: Remove bootmem code and switch to
 NO_BOOTMEM
To:     Serge Semin <fancer.lancer@gmail.com>, <ralf@linux-mips.org>,
        <paul.burton@imgtec.com>, <rabinv@axis.com>,
        <matt.redfearn@imgtec.com>, <james.hogan@imgtec.com>,
        <alexander.sverdlin@nokia.com>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>
References: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
CC:     <Sergey.Semin@t-platforms.ru>, <linux-mips@linux-mips.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Message-ID: <be0b6614-708d-a32a-029d-7e606a673e5b@imgtec.com>
Date:   Mon, 22 May 2017 11:48:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57929
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi Serge,

On 19.12.2016 03:07, Serge Semin wrote:
> Most of the modern platforms supported by linux kernel have already
> been cleaned up of old bootmem allocator by moving to nobootmem
> interface wrapping up the memblock. This patchset is the first
> attempt to do the similar improvement for MIPS for UMA systems
> only.
>
> Even though the porting was performed as much careful as possible
> there still might be problem with support of some platforms,
> especially Loonson3 or SGI IP27, which perform early memory manager
> initialization by their self.
>
> The patchset is split so individual patch being consistent in
> functional and buildable ways. But the MIPS early memory manager
> will work correctly only either with or without the whole set being
> applied. For the same reason a reviewer should not pay much attention
> to methods bootmem_init(), arch_mem_init(), paging_init() and
> mem_init() until they are fully refactored.
>
> The patchset is applied on top of kernel v4.9.

Have you progressed any further with these patches?
They would definitely be useful to include for MIPS arch, so can you let 
us know if you are planning to send any updated version?

thanks,
Marcin
