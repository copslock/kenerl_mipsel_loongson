Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Oct 2010 21:41:31 +0200 (CEST)
Received: from mail-qy0-f170.google.com ([209.85.216.170]:45736 "EHLO
        mail-qy0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491865Ab0JRTl2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Oct 2010 21:41:28 +0200
Received: by qyk35 with SMTP id 35so4798040qyk.15
        for <multiple recipients>; Mon, 18 Oct 2010 12:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=0mIN1987yeYFAlhCuzojHkpWfpfTBKyDsYdAdtsj9pY=;
        b=ZBwNyUI2xLYOP144teReZEVHoTjSyvT7ejnCPdFOvCY5cCqYioKjBii3LZH2hSG4Np
         sgPyDJ5LjeKsPtCE4JuEWP7aWf6OD1UMmBKtZKTG92Q9UQgUi3Tz8y7TfJXhQly8TFR4
         U4zr4WIz+xHHI7f2vksOT37f8Xn/9lqj/pkGg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Q9OcaT/DwPbc3Rb5oMhPpW0m6vaCQgaeacBDb11ZJEb3mQ2GYGQRidFWHX8DikHSDz
         40FNF3TUm4HuIvHcMV9pr7lTsUpjt6Q/P1GkCnodqnRJSLVLnYEYHdOCL5VyEYGB2k2A
         t8HOs/rk2Y9eOXzo61VutKCarQI6FoKUh6mS4=
MIME-Version: 1.0
Received: by 10.224.2.85 with SMTP id 21mr78740qai.288.1287430880234; Mon, 18
 Oct 2010 12:41:20 -0700 (PDT)
Received: by 10.224.45.148 with HTTP; Mon, 18 Oct 2010 12:41:20 -0700 (PDT)
In-Reply-To: <20101018191936.GH27377@linux-mips.org>
References: <17ebecce124618ddf83ec6fe8e526f93@localhost>
        <17d8d27a2356640a4359f1a7dcbb3b42@localhost>
        <4CBC4F4E.5010305@pobox.com>
        <20101018191936.GH27377@linux-mips.org>
Date:   Mon, 18 Oct 2010 12:41:20 -0700
Message-ID: <AANLkTimmatKpOFATCPDxthN-9pZzzXRAOnLGR1_348=r@mail.gmail.com>
Subject: Re: [PATCH resend 5/9] MIPS: sync after cacheflush
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Shinya Kuribayashi <skuribay@pobox.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28142
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, Oct 18, 2010 at 12:19 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> I'm trying to get a statement from the MIPS architecture guys if the
> necessity to do anything beyond a cache flush is an architecture violation.

IMO such a requirement would be unnecessarily strict.  Larger flushes
(e.g. page at a time) tend to benefit from some form of pipelining or
write gathering.  Forcing the processor to flush exactly 32 bytes at a
time, synchronously, could really slow things down and thrash the
memory controller.

I have not been able to find any official statement from MIPS that
says that CACHE + SYNC should be used, but that seems like the most
intuitive way to implement things on the hardware side.
