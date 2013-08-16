Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Aug 2013 15:16:34 +0200 (CEST)
Received: from mail-oa0-f51.google.com ([209.85.219.51]:39203 "EHLO
        mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831597Ab3HPNQ3DLyse (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Aug 2013 15:16:29 +0200
Received: by mail-oa0-f51.google.com with SMTP id h1so2212608oag.38
        for <linux-mips@linux-mips.org>; Fri, 16 Aug 2013 06:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Eup4L+azEA8Wpg71D/hUZTgpQS97uHIVdvdVXNe2vR8=;
        b=X2rVb/3Lw8gF68kzWDp7Cgz9JpX+JgBtSIKRRvdrtARGysBradt1U3TXCbdJv54VJA
         U/1ZSFMJjJuLnN7NivDl8dqQRNSe29Wn2wUitAbp7b3rxt3MtHWF4PBWWXJtOkuXXcCO
         2ROSGmty99yCh+loMS/tCMmzmgA3TyDx4qBDByhIBrdEiXh1skkvnobY97mx9D8tyuiT
         l3d/uV7XCI3TnWx7B2uVx+Dh3BaEuK7d9tumcEdwxco7JmYFGPOFi7mS1krgsXR9B9e3
         SZunHKKVi5dvJlLDSuoNtUC6gdXo06CIleObS+e2AW4JQ9Ee0248g+9IQkYBS6PEvtps
         oGLw==
X-Gm-Message-State: ALoCoQmD7iaeCwdaQqOKP8krslT25zjFUf96MQ0B0onGkF38oJUdOiVQ1g2rlAGDKCYw/I8sEbeo
MIME-Version: 1.0
X-Received: by 10.182.176.34 with SMTP id cf2mr1278989obc.45.1376658980492;
 Fri, 16 Aug 2013 06:16:20 -0700 (PDT)
Received: by 10.182.120.7 with HTTP; Fri, 16 Aug 2013 06:16:20 -0700 (PDT)
In-Reply-To: <1375133350-18828-3-git-send-email-ddaney.cavm@gmail.com>
References: <1375133350-18828-1-git-send-email-ddaney.cavm@gmail.com>
        <1375133350-18828-3-git-send-email-ddaney.cavm@gmail.com>
Date:   Fri, 16 Aug 2013 15:16:20 +0200
Message-ID: <CACRpkdaM=hqwHhNxCLCEZudRNYsyW-bZMXzZyvuW4qs2fGaREw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpio MIPS/OCTEON: Add a driver for OCTEON's
 on-chip GPIO pins.
From:   Linus Walleij <linus.walleij@linaro.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37573
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

On Mon, Jul 29, 2013 at 11:29 PM, David Daney <ddaney.cavm@gmail.com> wrote:

> From: David Daney <david.daney@cavium.com>
>
> The SOCs in the OCTEON family have 16 (or in some cases 20) on-chip
> GPIO pins, this driver handles them all.  Configuring the pins as
> interrupt sources is handled elsewhere (OCTEON's irq handling code).
>
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>
> Device tree binding defintions already exist for this device in
> Documentation/devicetree/bindings/gpio/cavium-octeon-gpio.txt

I like this.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I guess you will merge both patches through the MIPS arch
tree?

Yours,
Linus Walleij
