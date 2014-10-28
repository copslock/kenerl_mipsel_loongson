Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2014 14:46:40 +0100 (CET)
Received: from mail-ie0-f172.google.com ([209.85.223.172]:59017 "EHLO
        mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011577AbaJ1NqiXTJg- convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Oct 2014 14:46:38 +0100
Received: by mail-ie0-f172.google.com with SMTP id rl12so679181iec.3
        for <multiple recipients>; Tue, 28 Oct 2014 06:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=mhevwic4z2ZQffx3/wV+UjChtuYxOF6q91uJjQUcGiA=;
        b=DRzdZs2TUNxzEZy18uzAsGOvCmuzTJebEAupuxgyfPpcQRSRpMFS7m4saQSYKcEOKm
         +A5qwJftHMiNGpgRLRWpY4eueoPJM63zFrPDesw8VQYo1PSfAWhdL4W46PNteqv9HZFP
         4MlcHypaozvL31TgbBDCRDATgmbS5lQUqtXIsCpSY3aPauIE+fFg2eYy6KXyWGrQwbjb
         s4SAJw/NGti8oHBwzD+kDUMqXV12nUs+CsvA/u0m7KSicNFvKI0fN83qlkcKP27zD+4S
         LOinjBAqb5qd2qnebkpYH3tR3HBhn9Uus7d155bywnAZ5CqG+CNFMoprgcWdIb660dTC
         Py9g==
MIME-Version: 1.0
X-Received: by 10.51.17.104 with SMTP id gd8mr4699381igd.21.1414503990964;
 Tue, 28 Oct 2014 06:46:30 -0700 (PDT)
Received: by 10.107.154.15 with HTTP; Tue, 28 Oct 2014 06:46:30 -0700 (PDT)
In-Reply-To: <20141028132602.GE16320@linux-mips.org>
References: <1414499423-16662-1-git-send-email-zajec5@gmail.com>
        <20141028124804.GC16320@linux-mips.org>
        <CACna6rxSCZJ=oUNXVYEbkSZuiyUyy96amkMKbg7pdEXkVmtkZw@mail.gmail.com>
        <20141028131315.GD16320@linux-mips.org>
        <CACna6rz78HtA6AVxQP0PWiuRSbGZvtNudHz46jLOx860kis2UA@mail.gmail.com>
        <20141028132602.GE16320@linux-mips.org>
Date:   Tue, 28 Oct 2014 14:46:30 +0100
Message-ID: <CACna6rzJfJGwHP62ru=c3M0CcfrJZa7aUhMn0JQym7RgxwgPAA@mail.gmail.com>
Subject: Re: [PATCH] MIPS: BCM47XX: Make bcma init NVRAM instead of bcm47xx
 polling it
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43634
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

On 28 October 2014 14:26, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Oct 28, 2014 at 02:18:33PM +0100, Rafał Miłecki wrote:
>
>> 7605 is V1 with mistakes pointed by Hauke
>> 7611 is V2 which fixes things pointed by Hauke
>>
>> Please use
>> http://patchwork.linux-mips.org/patch/7611/
>
> Ah, 7611 has a different subject that's why I didn't notice there was a
> v2.
>
> All three of
>
>   https://patchwork.linux-mips.org/patch/7611/
>   https://patchwork.linux-mips.org/patch/7612/
>   https://patchwork.linux-mips.org/patch/8233/
>
> applied.  Thanks!

Thank you! To avoid similar confusion in the future, I've created
patchwork account that will allow me to mark old (superseded) patches.

In case you find time to push two more pending BCM47XX patches, it
would be great to see them in your tree.

1) [V2] MIPS: BCM47XX: Move SPROM fallback code into sprom.c
http://patchwork.linux-mips.org/patch/8232/
It's a rebased version of patch sent ~2 months ago (7617) that was
Acked-by Hauke

2) MIPS: BCM47XX: Initialize bcma bus later (with mm available)
http://patchwork.linux-mips.org/patch/8234/
It's resend-ing of RFC patch (7606) that also was Acked-by Hauke.
