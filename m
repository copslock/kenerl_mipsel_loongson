Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jan 2011 15:02:03 +0100 (CET)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:42571 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493451Ab1AQOCA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Jan 2011 15:02:00 +0100
Received: by vws5 with SMTP id 5so1884750vws.36
        for <linux-mips@linux-mips.org>; Mon, 17 Jan 2011 06:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Sz1dLzCRVjl4Lnyrxd/sKmON8qRs2stfr3YPk0+nmI8=;
        b=P5JGvZnWdrDbE08LNQ8As3QI4JPOioyrFHDcFcCCVHmAM85rP49C0gn+ldlsrItctC
         U4g28k7gt05OTZ9ax3pJ2j3a2gvk8zWcW3tHqeEiuvMb/AOWLgFV05sN2sqNtPxf/C+k
         oAxdQif47a/y7T6vkD2sbisRlEHINqeHcT8K0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=JnhlWrBO5fvdXfETuvCcFrdRhxTajOTSq6AqGBpCiBL/QFOZ3jkUI83wAImZUh3G3S
         vwf/ql+e/9VkV9uYKCf+pa4OjMNLuI4BlmAeqve/47FnGnVtFk/pjaRb4OmCv10a5Gt6
         +g14MOipiWjEuIr4PtIWRLQ9GZbkwfYpBNwhI=
Received: by 10.229.188.68 with SMTP id cz4mr3604794qcb.261.1295272912499;
 Mon, 17 Jan 2011 06:01:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.229.39.9 with HTTP; Mon, 17 Jan 2011 06:01:32 -0800 (PST)
In-Reply-To: <AANLkTinwGaqg8ahGWd3+_dfhrCNTQNOfO1E-EUepFJ+C@mail.gmail.com>
References: <AANLkTi=GDcy50zsC6=Dgv1-Ty3cYK2qpx9o=q3JdXuCh@mail.gmail.com>
 <1295261783.24530.3.camel@maggie> <AANLkTikJcug7LUTgX_YDD4Z8ZBrdkAdLq8_Epa6TkA5f@mail.gmail.com>
 <1295265468.24530.23.camel@maggie> <AANLkTims0DPfG+u9qynuuj_-0WjUr1nAGLuFz3k706T-@mail.gmail.com>
 <AANLkTinwGaqg8ahGWd3+_dfhrCNTQNOfO1E-EUepFJ+C@mail.gmail.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Mon, 17 Jan 2011 15:01:32 +0100
Message-ID: <AANLkTi=6p_bzwRtP0dOyGXGJzMg=_dQg-593Zc9BYeu0@mail.gmail.com>
Subject: Re: Merging SSB and HND/AI support
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     =?UTF-8?Q?Michael_B=C3=BCsch?= <mb@bu3sch.de>,
        linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28940
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips

On 17 January 2011 14:54, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> If it's AMBA, can it be integrated with the existing code in drivers/amba/?

Hm, I once had a sentence about it there, I must have accidentally deleted it.

I tried finding similarities between Broadcom's code and ARM's AMBA
specification to better understand the code, but except some tiny ones
I couldn't find anything usable. Unfortunately I couldn't find
anything about Broadcom's AMBA implementation, except that it's "AMBA"
licensed from ARM.

Jonas
