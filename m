Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Jan 2011 15:38:56 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:39277 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493206Ab1APOix (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Jan 2011 15:38:53 +0100
Received: by iyj21 with SMTP id 21so4080185iyj.36
        for <linux-mips@linux-mips.org>; Sun, 16 Jan 2011 06:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:cc:content-type;
        bh=EO3/elsygplAmlyKXJdryBP07SOIs+VIA9pTk75x0+M=;
        b=UAZ1N4XfI4ZKj/wgfRN/izPw5hfjVBPkrWiln5+6OJyf9j1R3WxV6FMaKs/vH9T02F
         gDUpvuLwhHv0feLbPhHj3VDj//t4H5ssPQnOP/F1w+rnP7nB2bwkT1FVzhFxe1VCiT6k
         juvmbJeZDS6Wl+m6uaFdIFUsOIIAXTLdIK934=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:cc
         :content-type;
        b=LQZnejpKcoRrt8QDHhb4eGFqmJzbUiN9Juh80SWcjaR7gj56SICP/8oOo0CgGLr2UL
         ucPc2qwEGQluSHVdbBZjUn1+wSChfHxs5DOXSv2chiz7BraXDsCmUR3++DjfGpojojrF
         SLPna3CcKN5Oqru19yXO5CumoY0tSwbOxTIJY=
MIME-Version: 1.0
Received: by 10.42.176.70 with SMTP id bd6mr3237741icb.164.1295188727298; Sun,
 16 Jan 2011 06:38:47 -0800 (PST)
Received: by 10.42.195.199 with HTTP; Sun, 16 Jan 2011 06:38:47 -0800 (PST)
In-Reply-To: <AANLkTik8hQfd8cvNj=qeq5U=6zpQHw33a9hfK-q8+x1Z@mail.gmail.com>
References: <AANLkTinvdEPwQ=DmcF8nnTAa0Py_O=+p7x1pobcTNHom@mail.gmail.com>
        <AANLkTik8hQfd8cvNj=qeq5U=6zpQHw33a9hfK-q8+x1Z@mail.gmail.com>
Date:   Sun, 16 Jan 2011 22:38:47 +0800
Message-ID: <AANLkTikpUBtg2zz8tcbcz2rcG-O+fTFwb_pTi88uZe0h@mail.gmail.com>
Subject: Re: about udelay in mips
From:   loody <miloody@gmail.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
To:     unlisted-recipients:; (no To-header on input)
Return-Path: <miloody@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28917
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: miloody@gmail.com
Precedence: bulk
X-list: linux-mips

hi wu, winfred:
Thanks for your reply ;)
2011/1/14 wu zhangjin <wuzhangjin@gmail.com>:
> On Thu, Jan 13, 2011 at 6:02 PM, loody <miloody@gmail.com> wrote:
>> hi all:
>> If i trace source in the correct place, I found udelay(100) is
>> implemented as a loop which decrease 1 per iteration until the count,
>> 100, as 0.
>> What makes me confused is since the speed of cpus are different and
>> that will make udelay not precise on different platform, right?
>
> Yeah, it may be not precise, so, some processors, like Cavium octeon
> have added their own timestamp register based delay functions, please
> refer to:
>
> arch/mips/cavium-octeon/csrc-octeon.c
>
> The delay_tsc() for X86 defined in arch/x86/lib/delay.c is similar.
>
> But both of them are 64bit timestamp registers.
>
> We can also apply similar method to add the precise delays for the
> other CPUs, but we may need to take extra notice:
>
> 1. If the CPU only provides 32bit timestamp registers(e.g R4K MIPS),
> overflow should be considered.
> 2. If the CPU support dynamic CPU frequency and the frequency of the
> timestamp binds to the CPU's frequency, the scaled down timestamp
> should be converted to the real timestamp.
below is the formula about calculating the delay
(us  *   0x000010c7   *   HZ   *   lpj   )) >> 32)
I cannot figure out why we need to multiply 0x10c7, and what lpj mean?
Does lpj mean if jiffies increase 1, how many "subu    %0, 1" may need?
Regards,
miloody
