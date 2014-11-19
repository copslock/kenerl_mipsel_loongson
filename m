Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Nov 2014 09:22:24 +0100 (CET)
Received: from mail-ig0-f179.google.com ([209.85.213.179]:50695 "EHLO
        mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013985AbaKSIWWFokOv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Nov 2014 09:22:22 +0100
Received: by mail-ig0-f179.google.com with SMTP id r2so540203igi.12
        for <multiple recipients>; Wed, 19 Nov 2014 00:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6Qb2AjJCgG7ZbytWahyZ5vcS33SiuCp+dtGN0OH8R8c=;
        b=xltJn8MJFEgX3mM/jKYmPL+vcORNvTXGxT5EsgQvXBD7GpZKY841rbCystqF9PXHzy
         fvrlcdHGj4PMs2zDkwn1+YIvX5nWRAsYzCcKGYFvTsZsDFcx1kZQTWAZ+MaDar553oW1
         VGH9sefGDT503RswkxKVr97TKJSHRoP3DsC+fRRZGrOET0+PACGc2i/8fyUNdP1dKAfI
         VP/JWsr5TwGiaDgHOGqLJNWI7es569KW4eYjUNSA/aEhKPCmRBduif1N3u+74rtWv+08
         KlYxA6VuQlfu9pKwtgooOveJtEV7fSjcUmbG3et4FslXmseFmSRh4laxW7HD3Y3ggOW7
         +T5A==
X-Received: by 10.42.126.82 with SMTP id d18mr69380ics.54.1416385336424; Wed,
 19 Nov 2014 00:22:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.246.168 with HTTP; Wed, 19 Nov 2014 00:21:56 -0800 (PST)
In-Reply-To: <CAAVeFuKYgXhV_372FBQnArEFT4xEVB73P+yurJ9mF0CkKCx7eQ@mail.gmail.com>
References: <1415891560-8915-1-git-send-email-chenhc@lemote.com> <CAAVeFuKYgXhV_372FBQnArEFT4xEVB73P+yurJ9mF0CkKCx7eQ@mail.gmail.com>
From:   Alexandre Courbot <gnurou@gmail.com>
Date:   Wed, 19 Nov 2014 17:21:56 +0900
Message-ID: <CAAVeFuJoo3X9aNYdrn5TJ-PjTzvFuEm5QTPmKYMy9NyWFy1_WA@mail.gmail.com>
Subject: Re: [PATCH V4 2/6] MIPS: Move Loongson GPIO driver to drivers/gpio
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <gnurou@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gnurou@gmail.com
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

On Wed, Nov 19, 2014 at 5:11 PM, Alexandre Courbot <gnurou@gmail.com> wrote:
> On Fri, Nov 14, 2014 at 12:12 AM, Huacai Chen <chenhc@lemote.com> wrote:
>> Move Loongson-2's GPIO driver to drivers/gpio and add Kconfig options.
>
> Acked-by: Alexandre Courbot <acourbot@nvidia.com>
>
> Guess this should go through the GPIO tree once the platform
> maintainers have acked this?

Ouch. After looking at this driver's implementation I think I have to
take my Ack back. This driver comes with custom definitions of
gpio_get_value() and other functions, which we will want to get rid of
before moving this into drivers/gpio. Can you port this to a proper
gpiolib driver before doing the move?
