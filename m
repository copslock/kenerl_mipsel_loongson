Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Feb 2010 14:49:58 +0100 (CET)
Received: from mail-fx0-f227.google.com ([209.85.220.227]:44146 "EHLO
        mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492262Ab0BBNty (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Feb 2010 14:49:54 +0100
Received: by fxm27 with SMTP id 27so61414fxm.27
        for <multiple recipients>; Tue, 02 Feb 2010 05:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=j+YRzQop0cnP/ogiHMfiqcuL7p6Ovef3oy8qyyPkxpk=;
        b=aquum+FF2yoFaKY77TnRUEjLCjl/pOdKTRojnIt33UhuDZum78J+4zZ9B8pE2NHmcY
         h9I3E4GnEPsL3ObQJKgJ7/OhoDEZz+InkqguhNIJ8fwjtPJ78E/479BgIM2FZALpooUn
         z1FpdHVfFaKWKKjhJNfIELVEq6RGUmvgyv9Sw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ADJ0U658exe4rqWwZyhGtfHq+sALqXOoO7jitxYhzwom5mCgp97ogErnNRcRvthn/o
         5BGDmwMDC6iKMFQHWiT53M1VtJMV9DuPjyDjjGAb3sea0QtWvt9Ui0XKSyQ7t+5MZina
         6+52qxQX7Bac+jeSmcbV/RVjuIv1Pearvd9Mo=
MIME-Version: 1.0
Received: by 10.223.4.25 with SMTP id 25mr1229969fap.38.1265118589669; Tue, 02 
        Feb 2010 05:49:49 -0800 (PST)
In-Reply-To: <20100202134613.GD13987@linux-mips.org>
References: <1265107061-18355-1-git-send-email-guenter.roeck@ericsson.com>
         <20100202130153.GB10837@linux-mips.org>
         <90edad821002020505x6ecfd03ejb03f316d9859b9db@mail.gmail.com>
         <20100202131015.GB13987@linux-mips.org>
         <90edad821002020534s54c4120atb7ac183f39d44847@mail.gmail.com>
         <20100202134613.GD13987@linux-mips.org>
Date:   Tue, 2 Feb 2010 15:49:49 +0200
Message-ID: <90edad821002020549q8c75cbck2f2a0a0928871ec0@mail.gmail.com>
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
X-archive-position: 25851
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, Feb 2, 2010 at 3:46 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Feb 02, 2010 at 03:34:31PM +0200, Dmitri Vorobiev wrote:
>
>> >> I haven't been following this closely enough, so maybe my question is
>> >> stupid. However: will this work on SGI R5000? I'm using an Indy, so
>> >> I'm quite concerned about this CPU.
>> >
>> > The point is that your Indy right now is not working with a 64-bit kernel :)
>>
>> I know. :)
>>
>> What I was asking about was whether my Indy is going to work with the
>> new scheme of calculating VMALLOC_END.
>
> Of course it will.

OK, thanks!

Dmitri

>
>  Ralf
>
