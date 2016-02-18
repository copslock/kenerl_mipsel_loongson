Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Feb 2016 00:22:01 +0100 (CET)
Received: from mail-ob0-f178.google.com ([209.85.214.178]:33849 "EHLO
        mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012971AbcBRXV5BLHLy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Feb 2016 00:21:57 +0100
Received: by mail-ob0-f178.google.com with SMTP id kf7so8664964obb.1
        for <linux-mips@linux-mips.org>; Thu, 18 Feb 2016 15:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oHxTMo3erVINf3PyRdaeMhpMS6vw4EFlZEbT43EPVVY=;
        b=eBO9Cdx1O3inYWXcWCNRqqCRDMN0FG5KzL3j4zbP+JlV3Ttdba6ps2l+nPd3/iRBDu
         8VtSmgLm/J1tWWL+RKTunYGP+l/oBa4Z1OFshNnbMacRW/cIFzMAvmnboOjbSIjWQ4eD
         lZ5hHMDR4k7SzOO11l/9d/FHYG1s6lilGqTmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=oHxTMo3erVINf3PyRdaeMhpMS6vw4EFlZEbT43EPVVY=;
        b=BQBZNmfnqFlsEeFPq4wrWSiTNKt0xccd0iNVXuOM7ASlwOEKV2MeaW+/MwiVHt0xQu
         BYwRhrowinbcbUaiDZS+dlRLxYJvHA0m6gsxn3ysbe3shPTOTitfUqYsAAlv1jODlLvO
         s3gI2n0CSvjgOWVriNImmEjj1MoRzDRVWm/RAyyeJzUjpQQf20vGxJakmGM4qBk2SlAn
         uW44vApBGbsjEJEwybdQCaNsmaaJkiy/zR5ffIWxbWscd5hgGTsFZFq8CzyOVjDOFy2k
         zE1CYQZEq87pz2HAYrUkWx90sNcCdoC+8xP7mH544l1Y4AGfomSi0FfSngMPOCXSPxzP
         443A==
X-Gm-Message-State: AG10YOQcyVIjAi7+7npF1tABWIdKANxTG3MFHR2zhpTyF9n7LQ7CncGvj8UUKrsC/CRPEQTDlvZlDb4TR61/EgwA
MIME-Version: 1.0
X-Received: by 10.60.147.137 with SMTP id tk9mr9037450oeb.45.1455837711289;
 Thu, 18 Feb 2016 15:21:51 -0800 (PST)
Received: by 10.182.55.105 with HTTP; Thu, 18 Feb 2016 15:21:51 -0800 (PST)
In-Reply-To: <1455637261-2920972-4-git-send-email-arnd@arndb.de>
References: <455637086-2794174-1-git-send-email-arnd@arndb.de>
        <1455637261-2920972-1-git-send-email-arnd@arndb.de>
        <1455637261-2920972-4-git-send-email-arnd@arndb.de>
Date:   Fri, 19 Feb 2016 00:21:51 +0100
Message-ID: <CACRpkdYrUxkOGvxi85zAn8O32otLNGtBGrvQPSqvnm1htp=+-w@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] gpio: ep93xx: remove private irq_to_gpio function
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52126
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

On Tue, Feb 16, 2016 at 4:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The ep93xx goes through its own back-and-forth dance every time
> it wants to know the gpio number for an irq line, when it really
> just hardcodes a fixed offset in ep93xx_gpio_to_irq().
>
> This removes the pointless macro and replaces the conversion inside
> of the driver with simple add/subtract operations, using an
> explicit macro.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Holding this back waiting for the dependent cleanup to come in.

Yours,
Linus Walleij
