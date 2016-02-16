Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Feb 2016 16:43:27 +0100 (CET)
Received: from mail-ob0-f176.google.com ([209.85.214.176]:33969 "EHLO
        mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012831AbcBPPmvffxYn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Feb 2016 16:42:51 +0100
Received: by mail-ob0-f176.google.com with SMTP id wb13so264705936obb.1
        for <linux-mips@linux-mips.org>; Tue, 16 Feb 2016 07:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ZXxs8YdyzhLkEbvdQM60e5fjJX16TyQnyWOZA+WGp5g=;
        b=SBlBX+lp1ZzbWJpxOulb1+5V00TiyOoq8PVo0x+/a32DuOP/edAULWlpxDljaUsbjT
         +F5bvkqPg0lLUZH3a6xDgG89XFx31yocIHMltsVKb3aK1BsBLDk9r4MMJELTug8WmEQe
         Pi2Svud3v4RDjIonCiZvlVaLKsLQkct1PTIX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ZXxs8YdyzhLkEbvdQM60e5fjJX16TyQnyWOZA+WGp5g=;
        b=mMtfDt5N6Q4kEWeki8K+EqbO9CwlPLFvM5w3cHdEl3O6sm2QuIMIh/oDaN/qDX4+3j
         UhiJGFCuxgXsKuYwVBUWBh7i0UOUbR2RIv3BqiqHNNmRjlOmj0jkMDOKr8LPxrxuUH0l
         2qBgmXyhu3qasseF5meN5o6U7//5e3ILjG3P3jTxfAdKUX1tlpfsY2w8Fv4OnB33DeaZ
         9aJNfCPnEp2p+eLL5PjGQyLbWff1aNKdiwxtY5Dhy/JLidvLx+5URRRFCWWqY2r2ADJ2
         l/OFdcFNURWIQopc+njhvkfTxsElat+HK/nowK4CaEEt/Kx0ep7vzCOfeY9b1Wbf4bdl
         gmTQ==
X-Gm-Message-State: AG10YOQB3ab9Pq7Zm26B37n+ixiCzegAgeFbaqUL+EJLLu+Bk8pSlfR7HF+P7OZQCP8N9Nyk/yTo0Ce36tegAouV
MIME-Version: 1.0
X-Received: by 10.202.232.19 with SMTP id f19mr17060714oih.113.1455637339017;
 Tue, 16 Feb 2016 07:42:19 -0800 (PST)
Received: by 10.182.55.105 with HTTP; Tue, 16 Feb 2016 07:42:18 -0800 (PST)
In-Reply-To: <1455551208-2825510-2-git-send-email-arnd@arndb.de>
References: <20160202194831.10827.63244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
        <1455551208-2825510-1-git-send-email-arnd@arndb.de>
        <1455551208-2825510-2-git-send-email-arnd@arndb.de>
Date:   Tue, 16 Feb 2016 16:42:18 +0100
Message-ID: <CACRpkdaQN9_qoTn4_riZGvi4BKRLEVkRRL4CWzKj8e_di7Q2Xg@mail.gmail.com>
Subject: Re: [PATCH 1/4] gpio: remove broken irq_to_gpio() interface
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alexandre Courbot <gnurou@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Linux MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52089
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

On Mon, Feb 15, 2016 at 4:46 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> gpiolib has removed the irq_to_gpio() API several years ago,
> but the global header still provided a non-working stub.
>
> Apparently one new user has shown up in arch/mips, so this patch
> moves the broken definition to where it is used, ensuring that
> we get new users but not changing the current behavior on jz4740.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied.

I expect the driver maintainer to deal with the resulting
deprecation fallout.

Yours,
Linus Walleij
