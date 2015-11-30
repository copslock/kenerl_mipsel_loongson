Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 13:15:46 +0100 (CET)
Received: from mail-oi0-f53.google.com ([209.85.218.53]:36614 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006865AbbK3MPoKuByP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2015 13:15:44 +0100
Received: by oiww189 with SMTP id w189so93554784oiw.3
        for <linux-mips@linux-mips.org>; Mon, 30 Nov 2015 04:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FgehPymKrnNxfZ9AysJlgsPFLHIWSg3dT/Pxvc22SrU=;
        b=beqrja8iXpDZOeTiRwuEF/Qlt6iwNDhqaONufeZ5ubM0llVH6KFYlraOWuRQh4iopX
         wioINU04VtarpRVs6p/G2+RvDp1jbHy54GjikcIR5NFc5HGcr2Zu7+Btndv0b+A5xjvG
         hApLIk69UqbNoE8tIYOFVXWbsKq7Y+IEAtlhJmMYVVpQ42PqIQye68K6Ps2zs4uBEs0R
         JqUjgF+rPQ9DatAPPgNr5+q3aLLq0ZbqkvFjTG64e3BQ90zvvc9Jb/YFeyed5YKw/++B
         6PHEv85PMx2ltb8+c6+VuFPJybqM3VTiGqCqysGBHsguD/jHqoqmkWIKXiV/x9GhpX3f
         E33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=FgehPymKrnNxfZ9AysJlgsPFLHIWSg3dT/Pxvc22SrU=;
        b=AGt+OfP5HV1iYE3PnukWjTTqdKr6VtM8/vC7717Trvs91hWJ90enb3ldd6tJki91rY
         V1qPnAUxiEPob6y/OqxoTJ2qcKO8r9+bR6bR0m+gNDVY6C5K4yTvP7TXJKTxnUwUbopk
         jHQxY6QqtANqvVWZmJNPqZK951YYXDXRuboeLZ1wNUFZgvbd0Ta6j6+E1hkv74Mtqkz/
         c0AmRCygAhdY3O+MfqL0T3XAlKTgyAS1X+Y2vx+A1eRQvH5fnXGsDeZcXXug8m4PEowv
         Ezn28RF4/0GSx7PQsE8yyS46Wci2wBzwF8tTuJHyK9Oc2T3M6qZvF1CHZTNmTayPfiW+
         HytA==
X-Gm-Message-State: ALoCoQnF+fTmcwuKDzQF6OadZ7ZViLlVQ2kP4T5/ms0rOotW8ctalbcWP1TV8Z6vN4eytQmln+Ul
MIME-Version: 1.0
X-Received: by 10.202.93.8 with SMTP id r8mr2014303oib.106.1448885738561; Mon,
 30 Nov 2015 04:15:38 -0800 (PST)
Received: by 10.182.32.70 with HTTP; Mon, 30 Nov 2015 04:15:38 -0800 (PST)
In-Reply-To: <1448532010-30930-3-git-send-email-mschiller@tdt.de>
References: <1448532010-30930-1-git-send-email-mschiller@tdt.de>
        <1448532010-30930-3-git-send-email-mschiller@tdt.de>
Date:   Mon, 30 Nov 2015 13:15:38 +0100
Message-ID: <CACRpkdav_vbU1BG+LF+NnCy-w1f8fGobBVoX-QSykbYd+jCWFw@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] pinctrl/lantiq: update devicetree binding in dts file
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
X-archive-position: 50170
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

> This patch updates the compatible string in the easy50712.dts file to the new
> "lantiq,danube-pinctrl".
>
> Signed-off-by: Martin Schiller <mschiller@tdt.de>
> ---
> Changes in v3:
> None

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Please merge this through the MIPS tree.

Yours,
Linus Walleij
