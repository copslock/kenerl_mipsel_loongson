Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jan 2016 16:26:17 +0100 (CET)
Received: from mail-oi0-f52.google.com ([209.85.218.52]:34752 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009505AbcAGP0QAzat3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jan 2016 16:26:16 +0100
Received: by mail-oi0-f52.google.com with SMTP id o124so315251800oia.1
        for <linux-mips@linux-mips.org>; Thu, 07 Jan 2016 07:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=syoXOUHtzoQM0I88fw2V6t9dM+0Xh6+SHfwOUEfCqx8=;
        b=UJ78I625SSMVvIBg+3sj+3TL8fqQxLpqpXM+UbnWXWnhGLqPOFTwfqJmTN7DGgFlKU
         qw7h2wdEuhWFz31DC6la40uEkvWugOnA9HbR81fFnxPwszCliovaOtwFbxAF5kWy3dz/
         t+DPRe47IKhlR3tkiN/Tu18yMSyKUS8x/hI8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=syoXOUHtzoQM0I88fw2V6t9dM+0Xh6+SHfwOUEfCqx8=;
        b=kRSTyOMxo9QlreiyxGkB/SWY/SnyROmFoqAVKa0TiIukpZe7Djx9Po2Z1E0o7MA8xQ
         UDgjO8c6zrQVRBPkhxnav7a8jNAaOkJZSqD5ts9PwhZxT4OlxMwp6c+m+Ly3FddJPSIW
         ud8EO7/fdNOUe7dmVNlvWfeMk28iXPaOIGjnlTjFZa3+o/HeFOD2Mi4jcHMZmN8gsEAP
         f1G05YTeRjrDG/y4ANwShTxSUF9tm2cdAJLHBE52mro8qEhUXVXzTsXGw1oVZ88wGzJ4
         EodIFhTgQzshWZm7DnRcnsbE99u7WHGBv8B1hKhTZBX1DX+uLfew4cVqEovmPe4B7f7k
         k3hQ==
X-Gm-Message-State: ALoCoQlC95RRcSqRiMExojF8/+Hsx9dUg5iACaMkm64hpAsYjM66MzyHmIpGWmla3K+A/R7jUcedBvIP6fw3UI/RIIGc4nmOQrtjIPOhK/6Jw5Gd3xRIOfM=
MIME-Version: 1.0
X-Received: by 10.202.196.67 with SMTP id u64mr73481171oif.94.1452180370103;
 Thu, 07 Jan 2016 07:26:10 -0800 (PST)
Received: by 10.182.55.105 with HTTP; Thu, 7 Jan 2016 07:26:10 -0800 (PST)
In-Reply-To: <1452106523-11556-3-git-send-email-f.fainelli@gmail.com>
References: <1452106523-11556-1-git-send-email-f.fainelli@gmail.com>
        <1452106523-11556-3-git-send-email-f.fainelli@gmail.com>
Date:   Thu, 7 Jan 2016 16:26:10 +0100
Message-ID: <CACRpkdavAtSqcdp3_C5WFgSnAwzkCx-5G_BkbC05T0-GxnJxBw@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpio: brcmstb: Set endian flags for big-endian MIPS
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Gregory Fong <gregory.0xf0@gmail.com>, jaedon.shin@gmail.com,
        Alexandre Courbot <gnurou@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50958
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

On Wed, Jan 6, 2016 at 7:55 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:

> Broadcom MIPS-based STB chips endianness is configured by boot strap,
> which also reverses all bus endianness (i.e., big-endian CPU + big
> endian bus ==> native endian I/O).
>
> Other architectures (e.g., ARM) either do not support big endian, or
> else leave I/O in little endian mode.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Patch applied with Gregory's ACK.

Yours,
Linus Walleij
