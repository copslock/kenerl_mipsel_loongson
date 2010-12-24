Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Dec 2010 10:35:02 +0100 (CET)
Received: from mail-qw0-f49.google.com ([209.85.216.49]:43896 "EHLO
        mail-qw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491041Ab0LXJe7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Dec 2010 10:34:59 +0100
Received: by qwj9 with SMTP id 9so7080397qwj.36
        for <multiple recipients>; Fri, 24 Dec 2010 01:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=xWw6LGds5mUpP45zOWbymOGYzRgNCxjj5w0uIKha4uo=;
        b=wXmkBF6vkh0onu/4VueiQoObHDPYZRptfUNfEYMntrV8ljFVKwoZjhQ/gEGz9AUk+P
         wYvkmV66nEvy19G52hG++FmBXpL7VH+K4zvHNuGxqfUkBHpIXLJbDGsI63D3bMEzwPdU
         R2XIjVsocNCvk4NwITLeu5pZPoF4iPCX+QcfE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=rXzkFC5dku7Iv9+9LFxSsH4PPsSVlbOer4a+tACIB5vUY5Q1SeBErxDSO2XuIkBAVf
         UCwwkjFeLTMpmyYOlq8jub0wPa4Ib1YWFRpaY/mqje7m2+NhbJwTS86Y+6iCibUKEg7o
         RxXtJwx+4g93R6C9cceJS1jr+HJ+wSX6Gn/uE=
MIME-Version: 1.0
Received: by 10.229.74.147 with SMTP id u19mr8175494qcj.72.1293183292822; Fri,
 24 Dec 2010 01:34:52 -0800 (PST)
Received: by 10.229.107.10 with HTTP; Fri, 24 Dec 2010 01:34:52 -0800 (PST)
In-Reply-To: <1290067948.9091.14.camel@paanoop1-desktop>
References: <1290067948.9091.14.camel@paanoop1-desktop>
Date:   Fri, 24 Dec 2010 03:34:52 -0600
Message-ID: <AANLkTimNZraGZNOhMSYH7uko7B2h1KmTg1q2Fsg8NHKt@mail.gmail.com>
Subject: Re: [PATCH] Select R4K timer lib for all MSP platforms
From:   Shane McDonald <mcdonald.shane@gmail.com>
To:     Anoop P A <anoop.pa@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28707
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Anoop:

On Thu, Nov 18, 2010 at 2:12 AM, Anoop P A <anoop.pa@gmail.com> wrote:
> >From c872cbbe5f475d3bb3cb7f821270cb466eead1f7 Mon Sep 17 00:00:00 2001
> From: Anoop P A <anoop.pa@gmail.com>
> Signed-off-by: Anoop P A <anoop.pa@gmail.com>
> Date: Thu, 18 Nov 2010 01:33:36 +0530
> Subject: [PATCH] Select R4K timer lib for all MSP platforms

I have successfully booted a 2.6.37-rc6 kernel with this patch applied
on an MSP7120 Garibaldi evaluation board.  It's good to see
PMC-Sierra pushing things back upstream!

Tested-by: Shane McDonald <mcdonald.shane@gmail.com>
