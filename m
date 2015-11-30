Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 13:17:48 +0100 (CET)
Received: from mail-oi0-f51.google.com ([209.85.218.51]:35357 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007949AbbK3MRq1d9XP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2015 13:17:46 +0100
Received: by oige206 with SMTP id e206so93429897oig.2
        for <linux-mips@linux-mips.org>; Mon, 30 Nov 2015 04:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2fuierJUYY2wphERmh30RRy+qZn7A0ueVil6MAS4bXU=;
        b=1zgwoxFGoieUSMMAtapbPYYcOyRWLNa80pPiK1BDPAylNKY1FRyyFiJveyrj8BMjDn
         DEkf0GlWd9E7AExTbqGOe8OwJ2b8FLa2a2hWfLIWsUz7AbOGxMw9nujH5DVKXZJylpNh
         idbE9XsfHbkfR0uQLqGJC6Xk5qMgOLtPKzbm53Kyg27v0PN9rO9kUP9YC/0sF2C90Mdq
         nvRoB4MNOhr2WGPPJfaa5Jd+Y/7UveSqjFj21/ScIiPvN+H58knPHD2WstouRxp7NCsE
         eLMltIPB6Q6dAVPmhPj7bUPDHmV6Z5M11oE8raoxdfHsnxDEBUujp/a2DFuCV8sYvANR
         YAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=2fuierJUYY2wphERmh30RRy+qZn7A0ueVil6MAS4bXU=;
        b=A/doaKhUe5bnOBlwQvORY9n+zqUrHSNP81CpJdg8x/WYmTJue3jIAF3jTUhAfJ4AbK
         KRMPQeWI8sspWHY29PCLGEa71uwYHzlVC5+UnwZFw5Fd6JODRepmrk1tJtDbrGzT3sgf
         2RjnFQNTLyb8yoLx/Be0PwJVpabo8Xkbss6HcC4SSLALcwdRI0Ajtl41BiNgCY7z8YTl
         7mR/NlbKS0CyeE3Jfb0lca0OMstLPbJsReBYTVOdAkaXGrfaSNsEyW+uQpHEMcU7L6M8
         7iCQDg7aZyiO3OJvv1n9OtD4LbPwXw6AlaG48/uyR917eT57UKfrM4BdZRchGXbK1XdZ
         JhbA==
X-Gm-Message-State: ALoCoQluv30fL3BXk7Ztxblw7FxOpdCTXt10LxlbWvhWDPzEx5v+jq04ehied7U6HjowceVKIhR/
MIME-Version: 1.0
X-Received: by 10.202.71.132 with SMTP id u126mr43068740oia.113.1448885860848;
 Mon, 30 Nov 2015 04:17:40 -0800 (PST)
Received: by 10.182.32.70 with HTTP; Mon, 30 Nov 2015 04:17:40 -0800 (PST)
In-Reply-To: <1448532010-30930-4-git-send-email-mschiller@tdt.de>
References: <1448532010-30930-1-git-send-email-mschiller@tdt.de>
        <1448532010-30930-4-git-send-email-mschiller@tdt.de>
Date:   Mon, 30 Nov 2015 13:17:40 +0100
Message-ID: <CACRpkdZsBhZd-NtVHMgo+Z0oQN5d_-8QU6MnZ7vx9du=sBd7oQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] pinctrl/lantiq: Fix GPIO Setup of GPIO Port3
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Martin Schiller <mschiller@tdt.de>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Jonas Gorski <jogo@openwrt.org>, daniel.schwierzeck@gmail.com
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50171
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

On Thu, Nov 26, 2015 at 11:00 AM, Martin Schiller <mschiller@tdt.de> wrote:

> From: John Crispin <blogic@openwrt.org>
>
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Signed-off-by: Martin Schiller <mschiller@tdt.de>
> ---
> Changes in v3:
> - Moved this change into a separate patch

Patch applied, I conjured a commit blurb because this was missing
one.

Yours,
Linus Walleij
