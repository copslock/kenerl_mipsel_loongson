Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Jul 2013 12:03:01 +0200 (CEST)
Received: from mail-pb0-f41.google.com ([209.85.160.41]:42743 "EHLO
        mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825317Ab3G3KCmBmSct (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Jul 2013 12:02:42 +0200
Received: by mail-pb0-f41.google.com with SMTP id rp16so5830496pbb.14
        for <linux-mips@linux-mips.org>; Tue, 30 Jul 2013 03:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=nVbAovf8VnpIUxhSGv0BbovmTlxk4YqzzAdpu5nzeJA=;
        b=bMSaXIQB6iAW3KbjFIiAv5bq2bsz3MbcUZ1oaseuuFhOlu+enNAgqkGQOzfDMXrUZK
         EHGyUuLHKxJ3poxC0U04cG49Vu+0Sb2Wgp2R6CkB9xbs9C1I2sEpJJdiQBjRtur4rvBX
         EzYJPGXuNAtnWdgrJ+bFulbtY3eBMMTArcL9pKcsztFanEW11u5xvey7SWPfqMuqpRFe
         FbicPGvs8/yq2QeHRDyng6mBQYslW2BGPooqvQmm8Pd75MD1QZnSUNAwb/g2+lnER4es
         JO2VLgylbsCdZ+AG8kwXKDV/g6AXoHdaUJV1wXDGnwN6MIwhWRBfr9gx/Qy0jf2LmLxX
         l1pQ==
X-Received: by 10.66.221.2 with SMTP id qa2mr73514857pac.188.1375178555038;
 Tue, 30 Jul 2013 03:02:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.68.10.101 with HTTP; Tue, 30 Jul 2013 03:01:53 -0700 (PDT)
In-Reply-To: <51F64E9B.8070306@phrozen.org>
References: <1375091743-20608-1-git-send-email-blogic@openwrt.org>
 <CAGVrzcYXyWB1bwoKyEFrSO7YEJx9Q_v2vOnnPnqVrFVKiigFrA@mail.gmail.com>
 <51F6495D.9000008@phrozen.org> <CAGVrzcYcP8kUueLkDtL+fT9g+HFUKGgdw_hTRXkhA8P+4LbL8A@mail.gmail.com>
 <51F64E9B.8070306@phrozen.org>
From:   Florian Fainelli <florian@openwrt.org>
Date:   Tue, 30 Jul 2013 11:01:53 +0100
X-Google-Sender-Auth: 4Ovs68OUsPSiWWw8UCVxclwwRC0
Message-ID: <CAGVrzcbXTih=yvvRDd0T=PLKiz0tB3+XgOwaPDWxuo6kZAEeKA@mail.gmail.com>
Subject: Re: [PATCH] MIPS: add proper set_mode() to cevt-r4k
To:     John Crispin <john@phrozen.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37400
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

2013/7/29 John Crispin <john@phrozen.org>:
>
>>> the actual problem is not the irq sharing but that the cevt-r4k registers
>>> the irq when the cevt is registered and not when it is activated. i
>>> believe
>>> that the patch fixes this problem
>>
>>
>> Your patch certainly does what you say it does, but that is kind of an
>> abuse of the set_mode() callback.
>
>
> well there are 2 modes "run as oneshot timer and dont run. i dont see how
> this is an abuse?

What you are doing here should be done in some sort of open() call to
the device, not in some sort of ioctl() like interface in my opinion,
I agree that this is your only choice here though.

How about my former proposal to hook your specific use case in
plat_time_init(), does not that work for you?
-- 
Florian
