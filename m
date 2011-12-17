Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Dec 2011 22:58:11 +0100 (CET)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:43357 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903725Ab1LQV6H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Dec 2011 22:58:07 +0100
Received: by wgbds11 with SMTP id ds11so7159119wgb.24
        for <linux-mips@linux-mips.org>; Sat, 17 Dec 2011 13:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=61ifzSReSz8CF42YflkNthPHKKa4GlRHg7rbN/aXFm4=;
        b=j5DHX/QURTh1zAnQBR75ASuhkgAI1AnoRYnbuFKA9vUJOs4LO9iuv6NirHktFamIbw
         OmgmhHl2xx7CPyoMJ5WWlDbjOxT6pvrmz0SK0JWuoiGwghUjPH1co6GFEkmyrBsPwGQe
         kgnR04VwkgC+xwVON3h7IGfQ9N2HkYV5yCjvY=
Received: by 10.216.135.154 with SMTP id u26mr4899667wei.20.1324159082333;
 Sat, 17 Dec 2011 13:58:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.89.71 with HTTP; Sat, 17 Dec 2011 13:57:41 -0800 (PST)
In-Reply-To: <1324157643.2240.2.camel@koala>
References: <1324126698-9919-1-git-send-email-jonas.gorski@gmail.com>
 <1324126698-9919-3-git-send-email-jonas.gorski@gmail.com> <1324157643.2240.2.camel@koala>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Sat, 17 Dec 2011 22:57:41 +0100
Message-ID: <CAOiHx=nwZ27ByyLDOXcy21x3_NJZKWU4AEJo3m3SfcposAbucA@mail.gmail.com>
Subject: Re: [PATCH 2/5] MTD: bcm63xxpart: make sure CFE and NVRAM partitions
 are at least 64K
To:     dedekind1@gmail.com
Cc:     linux-mtd@lists.infradead.org, linux-mips@linux-mips.org,
        Artem Bityutskiy <Artem.Bityutskiy@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Florian Fainelli <florian@openwrt.org>
Content-Type: text/plain; charset=UTF-8
X-archive-position: 32127
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14237

On 17 December 2011 22:33, Artem Bityutskiy <dedekind1@gmail.com> wrote:
> Not that I have any knowledge about BCM platform, but still, I think
> it is good idea to explain why these partitions have to be at least
> 64KiB. Could you please do this, just for the sake of having good
> commit messages?

Sure, no problem. Should I sent the whole series again or is a V2 of
this one enough?


Jonas
