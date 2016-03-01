Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Mar 2016 03:18:33 +0100 (CET)
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35819 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007810AbcCACSbFdhvt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Mar 2016 03:18:31 +0100
Received: by mail-wm0-f68.google.com with SMTP id 1so1743637wmg.2;
        Mon, 29 Feb 2016 18:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=nsnQm0Rp6h1jCd8yIvIGUhL4lmEc0/mHB+gUI1tyy74=;
        b=qq57fUPJraTrTib0R8iZvVaPusim85Op7Q24tEx0zyUgo6zNn5p5jrDy0YEw0Yz3e1
         FA98z4i+VnEdBnILqewxGu97ul4NRg/jjawV6XyE5sdLagj3z2btLfxq8Nb0BU22zKGi
         F2kKpwbNjJtm5wdShAztSoB77hF6QUIlmwsXKRIpWIDhOZB7YsHbts/L/WY2wiGxDTrv
         bvpHrAdtupgYS8m4AjR7aHPdUn09N7KFR2X3iy1aPoUGKRz4oZbXYeBRpLeW+8srZ06s
         NyQJtlxbXp8McsYkYjvMrWz5TGbQn8N6g0akAcCnPvto2HRbgA5Ylbe1EuEc/cRZYDiD
         DByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=nsnQm0Rp6h1jCd8yIvIGUhL4lmEc0/mHB+gUI1tyy74=;
        b=dEYGrx+FnE5Ahf9z4VoxWGVyto6sVGPH5lbW5qpQh+8K4B5+j3fDgiY6xlTK1eiV9U
         aDMh/Ze4W1tEoq/zv9R7zxBFyoVvliR5BkQRs8AHnrVcT/WXYwRn26xgKD6Ng0LRU78l
         NnU0qpeLpdzH5Y8mMljhTqPk2wfwnBqhH2zVDfgQkcA1GOy/Hu5bZeb30okedgMFWb59
         RBdC440PkamyKudILZ26/wkTiT7n2On7qHJv6OCLi9qrma531o6s8mDz8YKH/3ffAFu9
         BItkGIrnfDnwMJYI8kJmLtUD8kyJ1dD/GtWvQBtjPVXZG503k2CqQCvp47txbS8b43a4
         WP9Q==
X-Gm-Message-State: AD7BkJIbq8PPS9ntlErXe9bv3Nhg9+kk/wB5V9Bav624KrR5i99j1ElYiRzZhu90RrcI+QFatVF3Rh6Z8bTzzA==
MIME-Version: 1.0
X-Received: by 10.28.30.198 with SMTP id e189mr897934wme.60.1456798704249;
 Mon, 29 Feb 2016 18:18:24 -0800 (PST)
Received: by 10.27.13.13 with HTTP; Mon, 29 Feb 2016 18:18:24 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1603010025240.15885@tp.orcam.me.uk>
References: <1456324384-18118-1-git-send-email-chenhc@lemote.com>
        <1456324384-18118-8-git-send-email-chenhc@lemote.com>
        <alpine.DEB.2.00.1602250046480.15885@tp.orcam.me.uk>
        <CAAhV-H5rGWVooK5RaWxPDYV2dYBes9JetmvCisCsF1ouLWiKDA@mail.gmail.com>
        <alpine.DEB.2.00.1602251221250.15885@tp.orcam.me.uk>
        <CAAhV-H4hZM_xoe85WkB1cLwNv6XS5egpEjmV=t8RA=YANTs7rQ@mail.gmail.com>
        <alpine.DEB.2.00.1603010025240.15885@tp.orcam.me.uk>
Date:   Tue, 1 Mar 2016 10:18:24 +0800
X-Google-Sender-Auth: eKbnC4USpd7oVuMYiin8kqepv8M
Message-ID: <CAAhV-H78xbKf07ORYuyHLAGmoJbZ8xjYkEQpjtgC9j+3ZXveVw@mail.gmail.com>
Subject: Re: [PATCH V3 5/5] MIPS: Loongson-3: Introduce CONFIG_LOONGSON3_ENHANCEMENT
From:   Huacai Chen <chenhc@lemote.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52373
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Yes, you are right, I'll update the commit message.

Huacai

On Tue, Mar 1, 2016 at 9:06 AM, Maciej W. Rozycki <macro@imgtec.com> wrote:
> On Thu, 25 Feb 2016, Huacai Chen wrote:
>
>> Yes, we can probe whether the platform support ei/di or not. But
>> whether use ei/di is not depend on runtime flag, but depend on
>> CONFIG_* in current kernel. So I have no idea how to use ei/di by
>> probing.
>
>  OK, I think I have a full picture now.
>
>  There's no need to probe, but I think the commit description and config
> text option are a bit misleading.  This looks like the next architecture
> revision to me, much like MIPS32r1 vs MIPS32r2 for example, and it is
> quite normal that you don't probe for the new features it provides (even
> though -- sticking to the example -- we could probe for MIPS32r2
> additions), but you just require whoever configures the kernel to choose
> the intended setup.  IOW it's a design decision rather than a technical
> limitation.
>
>  So may I suggest that you rewrite the relevant part of the help text to
> read:
>
> "This option enables those enhancements which are not probed at run time."
>
> or suchlike?  And then similarly in the commit description.
>
>  Thanks,
>
>   Maciej
>
