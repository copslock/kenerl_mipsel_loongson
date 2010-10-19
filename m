Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Oct 2010 02:51:18 +0200 (CEST)
Received: from mail-qy0-f170.google.com ([209.85.216.170]:38267 "EHLO
        mail-qy0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490978Ab0JSAvP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Oct 2010 02:51:15 +0200
Received: by qyk32 with SMTP id 32so267436qyk.15
        for <multiple recipients>; Mon, 18 Oct 2010 17:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=ER04KrYW9Xn7Xnmodj7ASS3KHx40P1lThc1l+6DqPMA=;
        b=RzhKJtUx9zBIrBBo7gL5pUIxsm0xVlmB1oeU4xrlDwZ75OaBQ3jUWw7fKtvtt7WudC
         PIMS4EBsYESF6GVpklCbR9v3EQT3l0QeQ7+GTrcQt4YPDM4tMDyrRQvTqXBZnDQ3wJBU
         hwT1Kfrv107EsPfY/l8dHxrPOHq1akpIVuaOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=vfl7j9IoDszbkEamNSr161ANtbqRAGOZiJco1AMSCIo/ojemE9XcRLGyzN0kwxcPU+
         nCK5o7Bq8iyR9MkTjOug7l6/MBRIrNzSPWyJRPoOezLE0129sXV7SvEnInA1lded+e/I
         UdXtXc1RTXxF1rdhNBJe4mvTOrMCz+k8MVhz8=
MIME-Version: 1.0
Received: by 10.224.2.85 with SMTP id 21mr370020qai.288.1287449469203; Mon, 18
 Oct 2010 17:51:09 -0700 (PDT)
Received: by 10.224.45.148 with HTTP; Mon, 18 Oct 2010 17:51:09 -0700 (PDT)
In-Reply-To: <4CBCE05E.20408@renesas.com>
References: <17ebecce124618ddf83ec6fe8e526f93@localhost>
        <17d8d27a2356640a4359f1a7dcbb3b42@localhost>
        <4CBC4F4E.5010305@pobox.com>
        <AANLkTinpry=XG-ZDgXJK-VB6QkBL2TO4-vrsV5Tc1eEs@mail.gmail.com>
        <4CBCE05E.20408@renesas.com>
Date:   Mon, 18 Oct 2010 17:51:09 -0700
Message-ID: <AANLkTinTaW87RGUZ+o4TL8gzUPGkoR8=7C1e7aYWC9=b@mail.gmail.com>
Subject: Re: [PATCH resend 5/9] MIPS: sync after cacheflush
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Cc:     Shinya Kuribayashi <skuribay@pobox.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28148
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, Oct 18, 2010 at 5:03 PM, Shinya Kuribayashi
<shinya.kuribayashi.px@renesas.com> wrote:
> IIUC, the problem is that write operation originating from step 5. seems
> to overtake the one originating from step 3., correct?

Correct.  This particular system makes no guarantees that data flushed
out through CACHE operations will not overtake subsequent uncached
stores.

For the case of DMA, it is possible that data that I am attempting to
send to a device (via DRAM) could still be in transit when
dma_cache_wback() returns, and may be incomplete when the DMA
operation starts.  Or that dirty cachelines that I am attempting to
"free up" for a DMA_FROM_DEVICE operation are still in transit when
dma_cache_wback_inv() returns, potentially clobbering whatever data
the peripheral is trying to write to memory.

Adding SYNC at the end of dma_cache_wback* guarantees that the write
buffers have been emptied out to DRAM and I do not have to worry
anymore about any of these cases.

> Then we'd like to know, what is that 'Caller mentioned at step 5.', and
> what kind of operation will be done by the Caller?

It is my recollection that the caller was the USB EHCI driver, and it
was allocating some sort of uncached descriptor block that contained
pointers.  Sometimes those pointers got inexplicably zeroed out, and
this is what we found to be the root cause.
