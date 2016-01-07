Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jan 2016 16:27:38 +0100 (CET)
Received: from mail-ob0-f169.google.com ([209.85.214.169]:36187 "EHLO
        mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009505AbcAGP1ggcpNh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jan 2016 16:27:36 +0100
Received: by mail-ob0-f169.google.com with SMTP id ba1so329211632obb.3
        for <linux-mips@linux-mips.org>; Thu, 07 Jan 2016 07:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mMYz8E26lbVEAErpGXMZtR1LvFCUv5a/MjtACyi/jeE=;
        b=QWK4Q/uoUYVOZpy51cU1VlFfRMUrpSdoIYr8ncPiF1aoke72VhqC5A4QS0Q6DBol4O
         RhO48o5+MWPqCokAPbjhzWzKe3YD7GPNS5MntlKkrY/2EBq0E5kVTzWZ1PuJNeUk6rXk
         xlfx2Bb1E2DfiK0pEtq6C+/u/LrD7zHz8SJfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=mMYz8E26lbVEAErpGXMZtR1LvFCUv5a/MjtACyi/jeE=;
        b=hS40HrKSRi4IxMduaSHFl4CuVj2DijOJH2BjBxDe78MstB+FNLfE7s4Efu4DM3gU3r
         IgG9H3hEE8hvATkp5uMZVDKK3seg1SOC2YZCnJ6qiWgByQnpCjew9wrbv1u2/l4l/fRI
         zVeU0X1KpHsLvUyjODYoESIwgGdHLf8hiJg7hNXihhE4C+mzbrQn1u7GdHkJEbtYF+C4
         I2oSWUesznyY8MoTXjUZ31s3zVp6OXUBxwMiCfEw4NlEFWPxSNIOR7LIwc/88zoLk4OI
         X6jG0rKzTaY77EGOLKMIVJylhJ+1e68w+PiWWoO03YaICZvkV9BHeaz7WZbJgvJ/gm1q
         KrxQ==
X-Gm-Message-State: ALoCoQmen4gHuC3b/yx2YMwyvk9X4branu8VrGVs5ZbkrKGGl23EuwEwsiOZdCtmaj2aBLlYPbV3/XlDpYOG2hlBjBP1y1eel9lSluHvv0iAsxH5hnqTLpA=
MIME-Version: 1.0
X-Received: by 10.182.247.105 with SMTP id yd9mr75024360obc.21.1452180450395;
 Thu, 07 Jan 2016 07:27:30 -0800 (PST)
Received: by 10.182.55.105 with HTTP; Thu, 7 Jan 2016 07:27:30 -0800 (PST)
In-Reply-To: <1452106523-11556-4-git-send-email-f.fainelli@gmail.com>
References: <1452106523-11556-1-git-send-email-f.fainelli@gmail.com>
        <1452106523-11556-4-git-send-email-f.fainelli@gmail.com>
Date:   Thu, 7 Jan 2016 16:27:30 +0100
Message-ID: <CACRpkdbxUCq=aHkBSJ14LaKRYte=cupf=34g9APuafNpBXkobA@mail.gmail.com>
Subject: Re: [PATCH 3/3] gpio: brcmstb: Allow building driver for BMIPS_GENERIC
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
X-archive-position: 50959
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

> BMIPS_GENERIC (arch/mips/bmips) is the Kconfig symbol associated with
> Broadcom MIPS-based STB chips. Since this driver is perfectly usable on
> these platforms as well, allow using it.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Patch applied with Gregory's ACK.

Yours,
Linus Walleij
