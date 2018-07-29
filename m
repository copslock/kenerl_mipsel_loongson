Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jul 2018 23:25:57 +0200 (CEST)
Received: from mail-io0-x242.google.com ([IPv6:2607:f8b0:4001:c06::242]:39618
        "EHLO mail-io0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993032AbeG2VZyZS510 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Jul 2018 23:25:54 +0200
Received: by mail-io0-x242.google.com with SMTP id o22-v6so8274193ioh.6
        for <linux-mips@linux-mips.org>; Sun, 29 Jul 2018 14:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+bDfOeIoWn2xiMhXJCWZLdTeeSciR4nbv3LPsboJCd8=;
        b=J0jODnO8pfFWDja9sKRyuEwYb8vjuxqI8QfN1ao2gzqxWDSdgWprRC44IDkg18rUtj
         UY7wxusfTzqQ90K3RO/1EiLeDiNG7++mW7jXeSb2FHSun24Z2KmK21pD0L0tn5GnTK13
         q5a2Ezymp1p2HLvjOAC3OunvrtCjEpEUiZUsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+bDfOeIoWn2xiMhXJCWZLdTeeSciR4nbv3LPsboJCd8=;
        b=T7NH/bzDoBX4BXXjOcAi8YAS73UHE9CFVGyQHtvhZc2cFZW3v3JTbT78bgeZ4WtPiN
         hEk8eyGW80jmvb/I8OICkcfiUrTl3hqtIMPOvdFFyXQJM8DkRDu+xgRQt8JqeZubknRE
         mkLx4jGVb9xdA8SICWGX0uQfMdoXYX5Mu7kcmtud7YsZyvxDpG9RZpYN4T3FAw/VQFtK
         tmaoF4QYbvUgs3wzsqOIuTBx+HQl+Ycztn/7IpUTscZthMPyaLYPvAKyNcxlU7AoX0fw
         DkZoObR9hbnZNn3cRZu3l1cf8MUGvksTsr3eF4e4B6o0eE0pkI3LHaWU8btVRTf0CRcf
         9o8w==
X-Gm-Message-State: AOUpUlHztjpFp5b3G4iWmOBdd2zF2BOX7NHXW83T/++AnJlRAU69IAMS
        UsIVXIMbfOL22+exlmLB+2ya0tuqLi+MeUlpd7vPng==
X-Google-Smtp-Source: AAOMgpf/re6I0W/wdg975Yr5g4QqOazQIKpgGugOf7lqoVTHNMF9/DidzmkCEBOzT0aHn1r2ozweOy17148aFH9B6+o=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr11531904iof.304.1532899548216;
 Sun, 29 Jul 2018 14:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180725122621.31713-1-quentin.schulz@bootlin.com>
In-Reply-To: <20180725122621.31713-1-quentin.schulz@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 29 Jul 2018 23:25:20 +0200
Message-ID: <CACRpkdbNAvoEagYwW0K7rQtnq6tsWnheiLuHQMhcUUBEs4FMrA@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: mscc: ocelot: add interrupt controller
 properties to GPIO controller
To:     quentin.schulz@bootlin.com
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>, paul.burton@mips.com,
        James Hogan <jhogan@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65235
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

On Wed, Jul 25, 2018 at 2:27 PM Quentin Schulz
<quentin.schulz@bootlin.com> wrote:

> The GPIO controller also serves as an interrupt controller for events
> on the GPIO it handles.
>
> An interrupt occurs whenever a GPIO line has changed.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
