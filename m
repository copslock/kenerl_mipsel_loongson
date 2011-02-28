Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Feb 2011 02:03:14 +0100 (CET)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:47628 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491768Ab1B1BDH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Feb 2011 02:03:07 +0100
Received: by iwn36 with SMTP id 36so2854491iwn.36
        for <linux-mips@linux-mips.org>; Sun, 27 Feb 2011 17:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=wsTnt+df4gAMeqVys70+QXaleOqhfauYA1GKodY5M0w=;
        b=DvYvN7o3RRjpqPXZUvC3uxC5oiXSU4ELge/VTi6VDiRCJ64HQVMWoCG3roPYLe6aCU
         l0hBPYvxIWRdWge+IehN0bewjp3lvEllfQ9t0Ofy6cz5eSMZQ06Xjj4SlGMuDKjlEKiL
         pPZg4FocBgpPoPJlTqktkMGG8//cUDg46MkVE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=dES0DwV//qvsjn9fn9QbGq6+C0m83mklYQxFDiDYr3SIUWpAUC0xuOouMkGB/AxtIQ
         0DXSfZTBTMPXJkcmuMYV4VQZpUfabiMO6spaQckV7miV7+DWwfGljooBks11LKO6X7ny
         lqW/juRmKYRYWWGRhfZmAwJv5Uei1YJvgsQI8=
Received: by 10.42.239.68 with SMTP id kv4mr4174780icb.443.1298854980836;
        Sun, 27 Feb 2011 17:03:00 -0800 (PST)
Received: from [192.168.100.231] ([220.232.195.195])
        by mx.google.com with ESMTPS id uf10sm1038233icb.5.2011.02.27.17.02.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 Feb 2011 17:03:00 -0800 (PST)
Message-ID: <4D6AF445.6020401@gmail.com>
Date:   Mon, 28 Feb 2011 09:03:01 +0800
From:   Jacky Lam <lamshuyin@gmail.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     linux-mips <linux-mips@linux-mips.org>
Subject: Re: Memory needed for hibernation too much
References: <4D672850.80902@gmail.com> <AANLkTik8ynTVq--A-u1nYCt_AX4RPqVGdep6JfZ7m86x@mail.gmail.com>
In-Reply-To: <AANLkTik8ynTVq--A-u1nYCt_AX4RPqVGdep6JfZ7m86x@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <lamshuyin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29293
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lamshuyin@gmail.com
Precedence: bulk
X-list: linux-mips

     I create a 300GB swap space (just use up the remaining space in 
disk, no special reason). Is that a problem?

Jacky

On 2/25/2011 4:12 PM, Geert Uytterhoeven wrote:
> On Fri, Feb 25, 2011 at 04:56, Jacky Lam<lamshuyin@gmail.com>  wrote:
>>     I try the hibernation feature with my MIPS box which has 128MB RAM. After
>> boot up, it remains to have 110MB something. Then I mount ramfs on a
>> directory, create a file 100MB from /dev/urandom and enter hibernation. The
>> process failed because of no memory. Then, I continue to cut the data file
>> size and not success until 20MB.
>>
>>     I want to make sure if it is an expected behavior or I am doing some
>> wrong?
> How large is your swapspace? Hibernation needs space on swap to store
> the contents
> of RAM (that cannot be loaded again from somewhere else).
>
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
>
