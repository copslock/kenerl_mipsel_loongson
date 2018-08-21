Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2018 16:29:28 +0200 (CEST)
Received: from mail-lj1-x22c.google.com ([IPv6:2a00:1450:4864:20::22c]:46698
        "EHLO mail-lj1-x22c.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993964AbeHUO3QxlW08 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2018 16:29:16 +0200
Received: by mail-lj1-x22c.google.com with SMTP id 203-v6so14439109ljj.13
        for <linux-mips@linux-mips.org>; Tue, 21 Aug 2018 07:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=73R0KCNXFJRIOXpf/Nyu/iqnfM02jYVw8Q5oXxtGuJo=;
        b=SXBSnh1l4Tj7rd/kiXloT/xi6J/zgyZ7fNHXIV3pcFioIcuGuecJ9iZ3zCKx7kihNa
         d7KalOrdrY5s4x3+KRZIQxr9FJ74pb0nBARSuyrHUMmKDP6m45sZm9g0fOi6+oXe42wl
         n/9S2SLMiCCr1ArYEOhPuHHihAfYf5Sa7Ah+vdr/T+Ue8Kx8RjJwT1zQmmjfFFRhj8MA
         BrDlO+BAbdO6weFI7gphC+MjGcLMwttsCdljWlmBMABGoPasLFjUJKzOhCjg+qn0lWrR
         /c3f6tD2OB2/PHIAnvPklXmLiUMroBDtAw/hdkuSrrl/wBuRyeIHgRTnH7uUqJfx30Hh
         eIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=73R0KCNXFJRIOXpf/Nyu/iqnfM02jYVw8Q5oXxtGuJo=;
        b=mFfVl5kuLF0K3dcw68mLKXArhl1z0hX1AhLj7ZtbknYrtxgzOVDwLmTthFK52PamA0
         x8e7YDfHkHzU7wOy3M4Ptvd/prqW1P0gsPsxKtm3cAOwhXlZFJi8aEBcibYZZCbJCrD5
         gsBVuol1raa1Phpwb5ldk0wq1dBkX6MXqGMRv+XgU6Rb+E/n40daP0YRkypQu8G9F/PF
         20MjgyQ7G+2uVaZaS4VaZvHIsqLRFJDz+DacouDv+JqiTokyxo4mp/G46KzqaoSYskVV
         6rp4p8vOUFqLGbtadUZo//O0+/1N4HVKlmRIxd5r07h32Z75LutaD4Xrs0OVk9WRfhbt
         IO4A==
X-Gm-Message-State: AOUpUlF5s/Q1po1vGNr8bFTh4KcEphQyIKVKZpRyCm3oZPA+vKhOKSyv
        YKyI/DVgfWUUoY494+i0ANw=
X-Google-Smtp-Source: AA+uWPxbGlSrjjwKDz9vmIlhQKu+r6HKNijuGaOZ/2Nqk6DfESrEFls8k9w65D0xoTO8+BCXL1wJWw==
X-Received: by 2002:a2e:8185:: with SMTP id e5-v6mr10475196ljg.93.1534861751306;
        Tue, 21 Aug 2018 07:29:11 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id o184-v6sm1308564lff.95.2018.08.21.07.29.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 07:29:10 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fs7eg-0006pI-Hn; Tue, 21 Aug 2018 16:29:11 +0200
Date:   Tue, 21 Aug 2018 16:29:10 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        linux-usb@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>,
        Xue Liu <liuxuenetmail@gmail.com>,
        Ben Whitten <ben.whitten@lairdtech.com>,
        devicetree@vger.kernel.org,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        Alexander Graf <agraf@suse.de>,
        "LoRa_Community_Support@semtech.com" 
        <LoRa_Community_Support@semtech.com>,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>,
        Stefan Rehm <rehm@miromico.ch>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: serdev: How to attach serdev devices to USB based tty devices?
Message-ID: <20180821142910.GJ14967@localhost>
References: <3639955d-5990-1c82-7158-ac07b33c41f2@suse.de>
 <20180815182150.wsd5oxlucsox2qig@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815182150.wsd5oxlucsox2qig@earth.universe>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <jhovold@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65680
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: johan@kernel.org
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

On Wed, Aug 15, 2018 at 08:21:50PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> +cc Johan Hovold <johan@kernel.org>
> 
> Johan told me, that he is working on this at ELCE 2017. Also he is
> the subsystem maintainer of the USB serial subsystem.

I haven't done much work on this; it's more of a low-priority background
task that keeps popping up. ;)

Rob already linked to Ricardo's series in which this was recently
discussed [1][2].

In one of those threads I also posted to some code I've been using to
test serdev with USB-serial devices [3]. There are some known issues
blocking this from being merged (e.g. serdev not supporting hangups and
agreement on DT bindings), but it would otherwise allow you to use
serdev for fixed topologies (i.e. you know beforehand which port you'll
be plugging your USB-serial device into). So that might still be useful
for development purposes as is.

With DT-overlay support this could be extended also to the dynamic case
(e.g. loading overlays from userspace or passing the equivalent data
from a tty driver).

Johan


[1] https://lkml.kernel.org/r/CAPybu_0RRNMsdzv4CKyw922hX3_EF=-LKD_QWZV0DoQmjG0aRQ@mail.gmail.com
[2] https://lkml.kernel.org/r/20180611115240.32606-1-ricardo.ribalda@gmail.com
[3] https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/log/?h=usb-serial-of
