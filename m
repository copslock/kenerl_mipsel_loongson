Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Dec 2010 21:34:44 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:59442 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491948Ab0LIUek convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Dec 2010 21:34:40 +0100
Received: by iyj21 with SMTP id 21so69353iyj.36
        for <multiple recipients>; Thu, 09 Dec 2010 12:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nGrAPdr9zO5+lpeXfFXukK8zXPM99ZRbVxk3flXSxss=;
        b=rD1szn7ksItnZKIrYcZOJGCoL+UMpHxXtKxFsshPZ87aoCIJDqn8+p28E6yloSaobo
         JDw7fSJ4h5TUlCplHGbmqIKyCYMMeeQR4m4J4nP7uGkJgrQi9KEixHVG5CzsUQmxZUp4
         pXhZJa8EbuvR6h3b2MjFh/WN6VX1nZBIVSnHo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NzurbfGhJlCWBwmvjbcowXw8tSJ4V2Dm/uSR76pDA02/vpGNZeX79y0SeSoA1uswrj
         ltqMl8ima0HGA97Tv8WgDmm3cNZkWX3yvo3APYDSAP+luJJTT8GqRx17IqZL8iIO4R4+
         j+K7NT6oadcWcwXTyUwGTfFhNaJU+9v9tFDQA=
MIME-Version: 1.0
Received: by 10.231.35.8 with SMTP id n8mr720793ibd.123.1291926872614; Thu, 09
 Dec 2010 12:34:32 -0800 (PST)
Received: by 10.231.184.220 with HTTP; Thu, 9 Dec 2010 12:34:32 -0800 (PST)
In-Reply-To: <20101209184638.GD30923@linux-mips.org>
References: <1290511948-10347-1-git-send-email-dmitri.vorobiev@movial.com>
        <20101209184638.GD30923@linux-mips.org>
Date:   Thu, 9 Dec 2010 22:34:32 +0200
Message-ID: <AANLkTimv8reXGvL7_nUyiZ5nOVy9im5jhu9oP2avFzDQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Fix build failure for IP22
From:   Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Dmitri Vorobiev <dmitri.vorobiev@movial.com>,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28631
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, Dec 9, 2010 at 8:46 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Nov 23, 2010 at 01:32:28PM +0200, Dmitri Vorobiev wrote:
>
>> Commit 48e1fd5a81416a037f5a48120bf281102f2584e2 changed the name
>> of the MIPS-specific dma_cache_sync() routine by prefixing it with
>> `mips_', and removed the export for its symbol. Two drivers, which
>> did use dma_cache_sync(), namely, sgiseeq and sgiwd93, were not
>> converted to use the new function, which led to build failure for
>> the IP22 platform.
>>
>> This patch fixes the build failure by fixing the call sites of
>> mips_dma_cache_sync() and exporting the symbol for this routine as
>> a GPL symbol. While at it, some minor changes to improve Kconfig
>> help entries were done.
>
> dma_cache_sync isn't MIPS specific - mips_dma_cache_sync is but the
> function wasn't renamed everywhere.  Looking into what went wrong now
> but your patch surely is not correct.

OK, the main thing would be that the build failure be fixed. Thanks
for looking into that.

Dmitri

>
>  Ralf
>
>
