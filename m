Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Jul 2017 11:07:22 +0200 (CEST)
Received: from mail-io0-x236.google.com ([IPv6:2607:f8b0:4001:c06::236]:34352
        "EHLO mail-io0-x236.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992110AbdGCJHQBclgg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Jul 2017 11:07:16 +0200
Received: by mail-io0-x236.google.com with SMTP id r36so53426992ioi.1
        for <linux-mips@linux-mips.org>; Mon, 03 Jul 2017 02:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lIczDFyCRABloW28H5OMv2naHN1EJmeRw6ojqKer0TY=;
        b=MdXEdziqMrXacRkxIAdxbvcCUViIkaZvGpMTcObyT5+SL5e7c/BrK7NSpyQG3SJe5k
         fhqVsRe8OgZZ4xe5TYxlScaWAUmh2KRNmxHEh0BsdmNPAvmiNnJBybNNMpLhS6vM1tZt
         e9lVyaHugDtF9eUxwtAysbKHww61VbSLoY2NY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lIczDFyCRABloW28H5OMv2naHN1EJmeRw6ojqKer0TY=;
        b=DqtzlJuo9NxauRIxGOq3fGh0H4bWeRuLBFOBGcVmbnKWmh9AUSg+HXdv9niKYW9CiH
         DOTF/GHJiB+7053E8Qo4497dUpe8L7xRLOuen1JRab8G0u6ShTYpjooxdm5mY7qot75v
         CJ9zVXCiHVvorR0vEEqZxDnWD1TU+o+ehcunrttzZMDUU+0Fq5urQYCuY16XkAjW3Hze
         mBvPu9vP7bLCCiz2MZ/3NUEpg+eiLcbRS4aD8vB2/3rBDCZleK2jzBnjT+/g3PjoVQdz
         LO6jGqouJdiliuXVo1Ult2iihuepedvuKxU6/ZZq+o12B2rC5FQvLgGlPzx3pA8coYbI
         n7NA==
X-Gm-Message-State: AKS2vOyzj5wsSsPJxqro7LyZg6a4q3xRvZ5zYB3ePke1oo20waq88eEm
        84fNfkqcZEHHPHA/rfEsTTpaHAo6JLP6
X-Received: by 10.107.6.23 with SMTP id 23mr37172984iog.122.1499072830243;
 Mon, 03 Jul 2017 02:07:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.142.212 with HTTP; Mon, 3 Jul 2017 02:07:09 -0700 (PDT)
In-Reply-To: <1499013301.1477.0@smtp.crapouillou.net>
References: <20170402204244.14216-2-paul@crapouillou.net> <20170428200824.10906-1-paul@crapouillou.net>
 <20170428200824.10906-6-paul@crapouillou.net> <CACRpkdauf5c2i4o5i8QY8YHPNjizkvTu6kAbnquWiP_=v2=KdQ@mail.gmail.com>
 <1499013301.1477.0@smtp.crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 3 Jul 2017 11:07:09 +0200
Message-ID: <CACRpkdb=Zti+C+2me_WP0=m6z12G5Kz+W_cPcZsw=CVzBO_wAg@mail.gmail.com>
Subject: Re: [PATCH v5 05/14] MIPS: ingenic: Enable pinctrl for all ingenic SoCs
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58982
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

On Sun, Jul 2, 2017 at 6:35 PM, Paul Cercueil <paul@crapouillou.net> wrote:
> Hi Linus,
>
>> I applied all the patches to a branch in pinctrl and merged into my
>> devel branch for testing:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/
>> Branch: ingenic
>>
>> Ralf: are you OK with this? It would be nice to have your ACK on
>> all patches. If you want you can pull this branch into the MIPS
>> tree, or we can hope for it all to settle nicely because of low platform
>> activity in MIPS on this platform, so it only needs to come in
>> from my trees.
>
>
> There has been no word from Ralf, is this going into 4.13?

Yes.

Yours,
Linus Walleij
