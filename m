Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Mar 2010 20:59:07 +0100 (CET)
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:42692 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492324Ab0CAT7A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Mar 2010 20:59:00 +0100
Received: id: bigeasy by Chamillionaire.breakpoint.cc with local
        (easymta 1.00 BETA 1)
        id 1NmBla-0007Ks-2h; Mon, 01 Mar 2010 20:58:58 +0100
Date:   Mon, 1 Mar 2010 20:58:58 +0100
From:   Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To:     David Miller <davem@davemloft.net>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH 3/3] ide: move dcache flushing to generic ide code
Message-ID: <20100301195858.GA27906@Chamillionaire.breakpoint.cc>
References: <1267371341-16684-1-git-send-email-sebastian@breakpoint.cc>
 <1267371341-16684-4-git-send-email-sebastian@breakpoint.cc>
 <20100228.183417.52179576.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20100228.183417.52179576.davem@davemloft.net>
X-Key-Id: FE3F4706
X-Key-Fingerprint: FFDA BBBB 3563 1B27 75C9  925B 98D5 5C1C FE3F 4706
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <sebastian@breakpoint.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26077
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sebastian@breakpoint.cc
Precedence: bulk
X-list: linux-mips

* David Miller | 2010-02-28 18:34:17 [-0800]:

>From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
>Date: Sun, 28 Feb 2010 16:35:41 +0100
>
>> the pio callbacks are called with different kind of buffers. It could be
>> a straight kernel addr, kernel stack or a kmaped highmem page.
>> Some of this break the virt_to_page() assumptions.
>> This patch moves the dcache flush from architecture code into generic
>> ide code. ide_pio_bytes() is the only place where user pages might be
>> written as far as I can see.
>> The dcache flush is avoided in two cases:
>> - data which is written to the device (i.e. they are comming from the
>>   userland)
>
>This needs a flush on sparc, otherwise an alias now exists in the
>kernel side copy of the buffer.  The D-cache flush is intentionally
>unconditional for PIO mode.  I definitely don't want to take the same
>risks you guys seem to be willing to take for this optimization which
>is of questionable value.
It is not us guys it is just me. And if it is a stupid thing to do then
I get probably punched by Ralf as well once he gets back.
The part I don't get is why you have to flush dcache after the copy
process. I would understand a flush before reading. The dcache alias in
kernel shouldn't hurt since it is not used anymore. Unless we read twice
from the same page. Is this the trick?

>I also, intrinsically, really don't like these changes.
>
>For one thing, you're optimizing PIO mode.
>
>Secondly, IDE is in deep maintainence mode, if you want to optimize
>cache flushing do it in the ATA layer.
This patch patch was mostly driven by the fact that the buffer can be a
normal kernel mapping or a virtual address. The latter doesn't work with
virt_to_page().
Anyway I should probably spent more time getting ATA layer wokring than
on the IDE layer since it is somehow working since patch#1.

>
>Thanks.

Sebastian
