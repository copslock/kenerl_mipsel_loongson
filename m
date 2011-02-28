Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Feb 2011 09:05:13 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:43354 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491025Ab1B1IFG convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Feb 2011 09:05:06 +0100
Received: by bwz1 with SMTP id 1so3692606bwz.36
        for <linux-mips@linux-mips.org>; Mon, 28 Feb 2011 00:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OSQM2neuX+5Bp8T3m3g4W23VHcEIErrjPSQrBn240YA=;
        b=GYi1YSflbnRrG2WAGXevTaVYOFnsh9OkCH5qPFoyZl/XCDjdRqPMF/3ALmHGqakkY9
         hJmIqaGA7T6KKxbKI7v7Mk7hGhxf/WLqqCLwyRFrDv5Uca+s8Of0L0RH/t8rUh0vB9L5
         mLp7dps2OLh/HaUtSCwkEBTXPxkj3q2KKbc9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=VAPIQRD85yEMwVkh2I+NSPQJJk/C5aC/UeSDh1iuApUWm/khKm6+cmrB+npOjdJW1N
         4n5nDwqlEVAGqAzipKjSB1382kx8uKIAfG+sWET3iU09yVxBU6/XjQQePlwjsEJIy1zK
         bWjreHl/THOIejEfk8S8bEkCNossysTvlI0vA=
MIME-Version: 1.0
Received: by 10.204.35.150 with SMTP id p22mr4322814bkd.83.1298880298930; Mon,
 28 Feb 2011 00:04:58 -0800 (PST)
Received: by 10.204.33.152 with HTTP; Mon, 28 Feb 2011 00:04:58 -0800 (PST)
In-Reply-To: <4D6AF445.6020401@gmail.com>
References: <4D672850.80902@gmail.com>
        <AANLkTik8ynTVq--A-u1nYCt_AX4RPqVGdep6JfZ7m86x@mail.gmail.com>
        <4D6AF445.6020401@gmail.com>
Date:   Mon, 28 Feb 2011 09:04:58 +0100
X-Google-Sender-Auth: h1qkPCRMMYyOnRiSE4UnCALzfJA
Message-ID: <AANLkTimBv2SVBiBVxqXdj1Sp7W9ddghUCS3a_g4CbJQd@mail.gmail.com>
Subject: Re: Memory needed for hibernation too much
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Jacky Lam <lamshuyin@gmail.com>
Cc:     linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 28, 2011 at 02:03, Jacky Lam <lamshuyin@gmail.com> wrote:
>    I create a 300GB swap space (just use up the remaining space in disk, no
> special reason). Is that a problem?

That should be plenty for a box with 128 MiB RAM...

> On 2/25/2011 4:12 PM, Geert Uytterhoeven wrote:
>> On Fri, Feb 25, 2011 at 04:56, Jacky Lam<lamshuyin@gmail.com>  wrote:
>>>
>>>    I try the hibernation feature with my MIPS box which has 128MB RAM.
>>> After
>>> boot up, it remains to have 110MB something. Then I mount ramfs on a
>>> directory, create a file 100MB from /dev/urandom and enter hibernation.
>>> The
>>> process failed because of no memory. Then, I continue to cut the data
>>> file
>>> size and not success until 20MB.
>>>
>>>    I want to make sure if it is an expected behavior or I am doing some
>>> wrong?
>>
>> How large is your swapspace? Hibernation needs space on swap to store
>> the contents
>> of RAM (that cannot be loaded again from somewhere else).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
