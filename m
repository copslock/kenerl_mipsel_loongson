Return-Path: <SRS0=Dbp0=OW=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288ADC67839
	for <linux-mips@archiver.kernel.org>; Thu, 13 Dec 2018 08:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A1120672
	for <linux-mips@archiver.kernel.org>; Thu, 13 Dec 2018 08:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cvAbLtVv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A1120672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbeLMIxe (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 13 Dec 2018 03:53:34 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35844 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbeLMIxe (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 13 Dec 2018 03:53:34 -0500
Received: by mail-io1-f67.google.com with SMTP id m19so999916ioh.3
        for <linux-mips@vger.kernel.org>; Thu, 13 Dec 2018 00:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NY4SdspIVeBMtVOy/sBm91MDgxjtRGG8eTigdfoxIPs=;
        b=cvAbLtVvf5i1nPhBT7AwL4/XH0FiTxb+ILZ5MdgANCtUWcyLxmQcAPvYpLxLOBsBm1
         ChroAkW0oYygHCzE6umEJoDe6cAZzknK2dExwMPaQq6IQWy7YNEoZm32vs+bT6NRIAp8
         i+kGpotGM0SG1FLY3RLAzmG0LwmQjba+XonRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NY4SdspIVeBMtVOy/sBm91MDgxjtRGG8eTigdfoxIPs=;
        b=arhN26qPxG9LTQ//kuxxij3/0574f4ol6FKimGyUAQw+YwFZ9KkC6J2yfdYZfzpARO
         jjoQ9qyNuePMe+aCEurjqjCW295ZB2l/DneKJxjA/A9JBS1mgWr6MsKYUTRr5IrNIzWu
         5r+HN05gIYuR8Gw7Xmr80RMGsNF1qhqpdmifAUsW6Rzdv7bHCmeDcpbvo2pF1tvtJO73
         66pzjLRID7xoMQKc+sOhF5SHln9w8+/BN2UO7xjgcluai02ZaGgIt+pszqMkKAfm3B4h
         C7jq0w7PH1ra9KblUuZbBvFl96LkicWdEsYDSMr5xg8oXJb6dAbiU0EE6UZOlrYPDht3
         Ypqw==
X-Gm-Message-State: AA+aEWbw2hN6Hsza+iQzFqYhr88hvAdiqEaYY2B8Wz6rj57Oa6WPAaA0
        Lxrb1G+5dY9grHwM5AgIRpwepxx/QxGn7rHwunOZog==
X-Google-Smtp-Source: AFSGD/XpsbXbm0GZkoNd4YP1r6hHY6S/YfSixuDiEn0r2ZyIhUmTvp5Ou9Dt9KV3WWp9hMPbPN0Q9Fu062XsQJdVrgs=
X-Received: by 2002:a6b:8f8d:: with SMTP id r135mr19471984iod.5.1544691213151;
 Thu, 13 Dec 2018 00:53:33 -0800 (PST)
MIME-Version: 1.0
References: <1544073508-13720-1-git-send-email-firoz.khan@linaro.org>
 <1544073508-13720-4-git-send-email-firoz.khan@linaro.org> <20181210195144.dvprpyxyddusyb5c@pburton-laptop>
 <CALxhOng7EzAd2zHKAOj3ipEd6y=DpS2JGo34s4V_cWVgmLjPwg@mail.gmail.com>
 <20181211185947.gnaachztyh3ils7o@pburton-laptop> <CALxhOngErLD7+CEhgSPwQUnGg7YEFTcH-v6dhR0j55SvEg1FoA@mail.gmail.com>
 <20181212222834.2zf3rb67fxfcmwuw@pburton-laptop>
In-Reply-To: <20181212222834.2zf3rb67fxfcmwuw@pburton-laptop>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Thu, 13 Dec 2018 14:23:21 +0530
Message-ID: <CALxhOnht8H6r38bwm7xqbHuJs6dvLB03GCKyws2cif1mEE+sKA@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] mips: rename macros and files from '64' to 'n64'
To:     Paul Burton <paul.burton@mips.com>
Cc:     linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Paul,

On Thu, 13 Dec 2018 at 03:58, Paul Burton <paul.burton@mips.com> wrote:
>
> Hi Firoz,
>
> On Wed, Dec 12, 2018 at 10:04:47AM +0530, Firoz Khan wrote:
> >
> > Sure, I think '64' to 'n64' conversion must be remove it from this patch
> > series.I can send v5 without '64' to 'n64' conversion.
> >
> > If we rename '64' to 'n64' in half of the place and this _MIPS_SIM_ABI64
> > if we half to keep it in same looks not good (according to me).
> >
> > (FYI, This macro name - _MIPS_SIM_ABIN64 must be _MIPS_SIM_NABI64
> > and defintion will be:
> > +#define _MIPS_SIM_NABI64           _MIPS_SIM_ABI64)
> >
> > So If you confirm I can send v5 without '64' to 'n64' conversion (not just above
> > one, completely from this patch series). Or uou can take a call just
> > keep this macro -
> > _MIPS_SIM_ABI64 as it is and change it rest of the place.
>
> Let's just go ahead & leave everything as 64, and I'll do the 64 -> n64
> rename later. I hoped whilst you were adding n64-specific code this
> would be an easy change, but at this point let's just prioritize getting
> the series applied without the naming change so it can sit in -next for
> a while before the merge window.

I'll keep the macro - _MIPS_SIM_ABI64 same and will not change the rest
of the patch series. Unfortunately, reverting back to 64 from n64 has lots of
work.

Thanks
Firoz
