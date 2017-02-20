Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2017 14:56:56 +0100 (CET)
Received: from mail-io0-x230.google.com ([IPv6:2607:f8b0:4001:c06::230]:35099
        "EHLO mail-io0-x230.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993897AbdBTN4t7JT0o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Feb 2017 14:56:49 +0100
Received: by mail-io0-x230.google.com with SMTP id j18so26630724ioe.2
        for <linux-mips@linux-mips.org>; Mon, 20 Feb 2017 05:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=p0eKw/S3pdG2X7F8jyLGrbE3ru3iQ25iOY1/ZjTniZ8=;
        b=Qw+q002DlkTvZtrmj0vwj+zkEsJmSBNFX9I5hdoTqOnsi8TfIpZ3S8Nz8xeCluPGdY
         RdEeSRY6huXofaQ1a6AQge+05bjontH72VWUH7zbqW6LQ8ydjaF2tk6FVSyVf3veMP+l
         LZ38BYWpyWxH3nmnjAwYwZYxK22NXVbgsFauc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=p0eKw/S3pdG2X7F8jyLGrbE3ru3iQ25iOY1/ZjTniZ8=;
        b=cqHbLdNz1wTjp2c5H08wB52R1J6w6FncKU4UjghO34vemRB4cTLokTMbC8sOhAm9fb
         PnnyYp9ZKSF9wjXITrBuHE/rDuRZ8aqVO1PzSf88/7L4ZMpqnKxRqLUvFyQdOea3dxhE
         vykJXziAcwMXV1AJgUgT+MASUPYMkKOTODpPh0aQ90MeS8kb/3p3XOrWFUnu9zQlKgA8
         BtgxXRDvVVQ5AulLoXXBx6LhWDtCevsyzjF1LlBz60XG6BiuXuRqtPzqrUVpWYfilAaf
         01TC0mx1r2pQx54xLtp887tl/2V8i2k96rkMLKQQV2t4UODgMHj7PyuuPh8ZP/wXGevi
         zYlw==
X-Gm-Message-State: AMke39ko8vjl1PGkxPAuSVpuCwCZdBSGwJA1fwHim4Dks1UK7EHQLFgAHL6wycaYlWHzR+DfTtpLdsl7S/3k/0n4
X-Received: by 10.107.146.138 with SMTP id u132mr18023699iod.173.1487599002588;
 Mon, 20 Feb 2017 05:56:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.169.75 with HTTP; Mon, 20 Feb 2017 05:56:41 -0800 (PST)
In-Reply-To: <fd3c507484a9ee34a08c9f92e60624db@mail.crapouillou.net>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170125185207.23902-1-paul@crapouillou.net> <20170125185207.23902-2-paul@crapouillou.net>
 <20170130203617.hpljtcmzava3rq2n@rob-hp-laptop> <12dc62a7255bd453ff4e5e89f93ebc58@mail.crapouillou.net>
 <CACRpkdbAgy4sh6NT5DdQD6EQtOZEwevohEA6OGRcVz98yqS52Q@mail.gmail.com> <fd3c507484a9ee34a08c9f92e60624db@mail.crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 20 Feb 2017 14:56:41 +0100
Message-ID: <CACRpkdbAA33FFrMgx-eZPmpBBfQ_hF+=dSu0hANVthdbadicDg@mail.gmail.com>
Subject: Re: [PATCH v3 01/14] Documentation: dt/bindings: Document pinctrl-ingenic
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56880
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

On Thu, Feb 9, 2017 at 6:28 PM, Paul Cercueil <paul@crapouillou.net> wrote:

> I was thinking that instead of having one pinctrl-ingenic instance covering
> 0x600 of register space, and 6 instances of gpio-ingenic having 0x100 each,
> I could just have 6 instances of pinctrl-ingenic, each one with an instance
> of gpio-ingenic declared as a sub-node, each handling just 0x100 of memory
> space.

My head is spinning,  but I think I get it. What is wrong with the solution
I proposed with one pin control instance covering the whole 0x600 and with 6
subnodes of GPIO?

The GPIO nodes do not even have to have an address range associated with
them you know, that can be distributed out with regmap code accessing
the parent regmap.

Yours,
Linus Walleij
