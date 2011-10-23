Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Oct 2011 17:25:55 +0200 (CEST)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:59005 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491050Ab1JWPZs convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 23 Oct 2011 17:25:48 +0200
Received: by iagz35 with SMTP id z35so7924043iag.36
        for <multiple recipients>; Sun, 23 Oct 2011 08:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=xuiknyXUMjD0QBbkzhHX0xDKd11B9j2WIa48P+S2xUk=;
        b=Z1mBp81e6Q4VlmOF/4FFT+WxGBQmfuxtdEWW5iTdzVUe8MfXGeCtWHdH9Q9iZ3B/Bo
         swiBzCK5D86quSY0DEA1twLKfyL/eCFUt1tegvbZN2ATYwusxY3PzWgGOw3+0qvS6oJY
         Ra0rn0ehYGJTl0V0+SEqHDjCq025DMip8NBbY=
MIME-Version: 1.0
Received: by 10.231.1.6 with SMTP id 6mr8613961ibd.38.1319383539591; Sun, 23
 Oct 2011 08:25:39 -0700 (PDT)
Received: by 10.231.59.135 with HTTP; Sun, 23 Oct 2011 08:25:39 -0700 (PDT)
In-Reply-To: <20111017180015.1e5fc4fe@dragon.agroecology>
References: <20111012190659.GC15003@mails.so.argh.org>
        <20111013080412.GA17240@linux-mips.org>
        <CAD+V5Y+shM4eqVHomaHvrXKdO8WpKfpCHw=2ExP1GFuuQzSaGw@mail.gmail.com>
        <20111017180015.1e5fc4fe@dragon.agroecology>
Date:   Sun, 23 Oct 2011 23:25:39 +0800
Message-ID: <CAD+V5Y+55V+XvDBOsRNO6HrH51ZZm12emWix3uomEtXfuQJ6vg@mail.gmail.com>
Subject: Re: YeeLoong / hotkey driver
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Paul Roge <proge@riseup.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Andreas Barth <aba@not.so.argh.org>, linux-mips@linux-mips.org,
        debian-mips@lists.debian.org
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-archive-position: 31283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16622

On Tue, Oct 18, 2011 at 7:00 AM, Paul Roge <proge@riseup.net> wrote:
>> The old patch is out-of-date, perhaps we can start a new trip to
>> upstream the latest version maintained at
>> http://dev.lemote.com/code/linux-loongson-community.
>>
>> The latest one threaded the irq interrupt handler and fixed some bugs.
>>
>> Hope somebody else can work on it for I'm a little busy currently ;-)
>
> Since I am new to configuring kernels, I doubt that I can help very much on this.
>
> The 3.0.4-libre-lemote kernel from http://linux-libre.fsfla.org/pub/linux-libre/lemote/gnewsense has everything except hotkey support for wireless. The CONFIG_RTL8187 and CONFIG_RTL8187B options are disabled in the config file. Typing "echo 1 > /sys/class/rfkill/rfkill0/state" does nothing, even when the kernel is reconfigured with those drivers enabled.
>
> The 2.36.8-loongson-2f kernel from http://bjlx.org.cn/loongson2f/squeeze has functional hotkey and wireless networking capability. However, the date resets to 1968 when restarted, thus messing up certificates, and scrolling with the keybad is disabled.
>
> I would really appreciate suggestions for adding wireless/hotkey capability to the 3.0.4-libre-lemote kernel, or fixing the date problem and adding the keybad scrolling capability on 2.36.8-loongson-2f! Should I add the patch, modify options, or both?

I guess something may have been broken from 2.6.39 or 3.0, because I
have no enough time to continue the maintaining, sorry, hope you can
try 2.6.37 or 2.6.38 from http://bjlx.org.cn/loongson2f/squeeze
instead.

Sorry for my late response.

Regards,
Wu Zhangjin

>
> Thanks!
> Paul
>
