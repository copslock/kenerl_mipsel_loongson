Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Feb 2010 14:34:45 +0100 (CET)
Received: from mail-fx0-f227.google.com ([209.85.220.227]:64356 "EHLO
        mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492289Ab0BBNel (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Feb 2010 14:34:41 +0100
Received: by fxm27 with SMTP id 27so44256fxm.27
        for <multiple recipients>; Tue, 02 Feb 2010 05:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=ZhDOqbP4kckl3CPUFt5mVwrLiBx78az/wWrYrXoLdyw=;
        b=dpHNgn9eOQnYMgM0uM8lqoNljCLoEleYAEI15Ypc+mbdF2gvfPzbvfXVLkmOEKaPHA
         IJyAoF4kkc0Nbp689Ai9O5miaNfZBKTIy1yl0wqAY9qAhaDgsXznuVPaQN1gWr5u1UVV
         8ihjCSdMlo4E7/SfguQP120JK+Am5gI/5U+ME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=VogBmfmuEmeR9GkhyZxXYEPwSfUN3EqBe5r7AuPkEiVlfZVj+40Pcra3hOsJ/jRhxq
         qZXV3XgmmlvOxJRcoFKjHboJKt1mliTD/u87lEnuJa37pU2MOrj+wQWpiZ05kRVM3xzQ
         0ApJ1LYmpaIB6RSMt9jpmmVdMwkW/tpQSb92A=
MIME-Version: 1.0
Received: by 10.223.63.193 with SMTP id c1mr6205244fai.80.1265117671595; Tue, 
        02 Feb 2010 05:34:31 -0800 (PST)
In-Reply-To: <20100202131015.GB13987@linux-mips.org>
References: <1265107061-18355-1-git-send-email-guenter.roeck@ericsson.com>
         <20100202130153.GB10837@linux-mips.org>
         <90edad821002020505x6ecfd03ejb03f316d9859b9db@mail.gmail.com>
         <20100202131015.GB13987@linux-mips.org>
Date:   Tue, 2 Feb 2010 15:34:31 +0200
Message-ID: <90edad821002020534s54c4120atb7ac183f39d44847@mail.gmail.com>
Subject: Re: [PATCH v5] Virtual memory size detection for 64 bit MIPS CPUs
From:   Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Guenter Roeck <guenter.roeck@ericsson.com>,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25849
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, Feb 2, 2010 at 3:10 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Feb 02, 2010 at 03:05:49PM +0200, Dmitri Vorobiev wrote:
>
>> On Tue, Feb 2, 2010 at 3:01 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
>> > On Tue, Feb 02, 2010 at 02:37:41AM -0800, Guenter Roeck wrote:
>> >
>> > Pretty good, let the nitpicking start :-)
>>
>> I haven't been following this closely enough, so maybe my question is
>> stupid. However: will this work on SGI R5000? I'm using an Indy, so
>> I'm quite concerned about this CPU.
>
> The point is that your Indy right now is not working with a 64-bit kernel :)

I know. :)

What I was asking about was whether my Indy is going to work with the
new scheme of calculating VMALLOC_END.

Dmitri

>
>  Ralf
>
