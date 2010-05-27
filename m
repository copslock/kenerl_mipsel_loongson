Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 May 2010 23:12:35 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:38190 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491810Ab0E0VMb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 May 2010 23:12:31 +0200
Received: by fxm15 with SMTP id 15so447160fxm.36
        for <linux-mips@linux-mips.org>; Thu, 27 May 2010 14:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=RgwUQoVCBYtsPr+J3nuL/hjO+GcemCHlRgSwl6lo9xk=;
        b=ckXNR17HdHW+oaVQxY5BFbr2oXIBMkj6rKH7o3eV9/R1FzqFmDrPeEfKGfYGksANjU
         0ToHUe0qvBHmxVxDMQmFqs62YLljfE7llhq4nJY/2tSpr082/5/fH6s2ta4EbwY9wL36
         jl0CmdSNk74xzv9rEfKeNpYJjmZrPAOHA0LU4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=An4F69VHt9JR6e8a8h7l/isQYbs17tLOcaH1ZfSFsKwS7t13BGWw8AlAS91KNGmKTx
         WnqQE4qsdw+NIbOZCMSLMWNrzB3+/SWqykER1l8IJFiSRaHnV4Pt1jbKhQyjXxivu5wf
         ACYQbjeCMqzfzXD0wzbXTmj1QbrEz27b5MNjo=
MIME-Version: 1.0
Received: by 10.223.100.141 with SMTP id y13mr10085453fan.15.1274994745663; 
        Thu, 27 May 2010 14:12:25 -0700 (PDT)
Received: by 10.223.104.209 with HTTP; Thu, 27 May 2010 14:12:25 -0700 (PDT)
In-Reply-To: <1274977788.4bfe9dfc7680f@www.inmano.com>
References: <1274711094.4bfa8c3675983@www.inmano.com>
        <AANLkTinOaPkOXm128trTQ39jNGWMcvPhVUGWSQz6hLjR@mail.gmail.com>
        <20100525131341.GA26500@linux-mips.org>
        <1274795905.4bfbd781a17fa@www.inmano.com>
        <20100525144400.GA30900@linux-mips.org>
        <1274879482.4bfd1dfa91e70@www.inmano.com>
        <AANLkTikbZmTWh8X4KOKLAUaJxKS5-PO39hmiTVICB5Zm@mail.gmail.com>
        <1274977788.4bfe9dfc7680f@www.inmano.com>
Date:   Fri, 28 May 2010 00:12:25 +0300
Message-ID: <AANLkTinnlHVRM9kw4BJTicHTEhiSB--rIOaKARrLQsYi@mail.gmail.com>
Subject: Re: Cross compiling MIPS kernel under x86
From:   Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:     octane indice <octane@alinto.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26887
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, May 27, 2010 at 7:29 PM, octane indice <octane@alinto.com> wrote:
> Response to Dmitri Vorobiev <dmitri.vorobiev@gmail.com> :
>
> I tried a lot of different numbers like 2000000 or greater, depending of
> what I find in mailing lists, but I don't find the right value. Is there a
> way to compute it, or it's kernel I made that is not right?

Well, I can't say offhand, and I don't have hardware to check that.
One thing that attracts attention is that the size of 0x24 is
apparently too small.

Hard to say what's going on without knowing the hardware and seeing
the docs for it.

Dmitri
