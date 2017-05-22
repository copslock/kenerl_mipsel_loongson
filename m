Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 May 2017 14:19:25 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25711 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992213AbdEVMTRDSL2Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 May 2017 14:19:17 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id E1BF12C1E0F4E;
        Mon, 22 May 2017 13:19:07 +0100 (IST)
Received: from [10.80.2.5] (10.80.2.5) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 22 May
 2017 13:19:10 +0100
Subject: Re: [PATCH 00/21] MIPS memblock: Remove bootmem code and switch to
 NO_BOOTMEM
To:     Serge Semin <fancer.lancer@gmail.com>
References: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
 <be0b6614-708d-a32a-029d-7e606a673e5b@imgtec.com>
 <20170522102643.GA17763@mobilestation>
CC:     <ralf@linux-mips.org>, <paul.burton@imgtec.com>, <rabinv@axis.com>,
        <matt.redfearn@imgtec.com>, <james.hogan@imgtec.com>,
        <alexander.sverdlin@nokia.com>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <Sergey.Semin@t-platforms.ru>,
        <linux-mips@linux-mips.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Message-ID: <eeb52dd6-3fdd-01b9-6774-236ab50e3f4d@imgtec.com>
Date:   Mon, 22 May 2017 14:19:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170522102643.GA17763@mobilestation>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57932
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

On 22.05.2017 12:26, Serge Semin wrote:

> Regarding the patchset. I'm still pretty much eager to make it being
> part of kernel MIPS arch. But there was a problem I outlined
> in the patchset header message, which I can't fix by myself.
> Particulary It's connected with Loonson3 or SGI IP27 code alteration,
> so to make it free of ancient boot_mem_map dependencies (see the
> patchset header message). Without a help from someone, who has
> Loonson64 and SGI IP27 hardware and strong desire to make it free of
> old bootmem allocator, it is useless to make any progress from my
> side. That's why Ralf moved this email-thread into RFC actually.
> Anyway If either you or someone else has got such hardware and is
> interested in the cooperation, I'll be more than happy to push
> my efforts forward with this patchset contribution. But only after
> I got a bit less busy with my work. As I said it will happen within
> next 1-2 months. So do you have the hardware and desire to be part
> of this?

I should be able to update/test the changes on a Loongson64 platform.


Marcin
