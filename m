Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Mar 2015 09:42:26 +0100 (CET)
Received: from mail-ob0-f176.google.com ([209.85.214.176]:33589 "EHLO
        mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007921AbbCSImWkx83K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Mar 2015 09:42:22 +0100
Received: by obcxo2 with SMTP id xo2so49464464obc.0
        for <linux-mips@linux-mips.org>; Thu, 19 Mar 2015 01:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=V0Jc6nr315PEaI73KtdD0LfiskW36ZQfOJ1O9AAPUVk=;
        b=dGFsxNva951wV9XByheVByC1VzmUlogaO8Sl4p9h3TJoulklWvqtJCKOhsD89JGmhv
         ZFJbzdy4CmwqER/oaSjivlyVa8PeI+Tvn2y4H/qxGPhSQmq72TN/3/USlZqsdDHgz2hH
         e9MOdbf+zKJJOvNSJmq3bQ5euwtbhGiw4/l8wb8P2Nh9vVUt0nrVkz3C6lrIlB2HgwaE
         WcKfjZL6hiyGXsstoL7V5p6f9ZdrLDihXNV65Ujc0MVCJOMjLk2YE5T383hr3yE2PrFW
         3xtUNnRAuxU9L/ObBcn91eo3NLPhPWzJYDZWfYf7SUbsIE9fKl+SOQtXTC6d1a/NzvzT
         aELg==
X-Gm-Message-State: ALoCoQk8XS/mUDaGOvHyhVdwdhY9NyjfV92mF2OakfqJVJxtTgQJ/gFVIuIAVMyYuDg3D8SRBPIp
MIME-Version: 1.0
X-Received: by 10.202.223.6 with SMTP id w6mr56571358oig.89.1426754536846;
 Thu, 19 Mar 2015 01:42:16 -0700 (PDT)
Received: by 10.182.180.4 with HTTP; Thu, 19 Mar 2015 01:42:16 -0700 (PDT)
In-Reply-To: <CAL1qeaHCKPeQnf8VPWmz_=uN1=_mxWbMGF+HuPZ_AYOqA+15JA@mail.gmail.com>
References: <1424744104-14151-1-git-send-email-abrestic@chromium.org>
        <1424744104-14151-3-git-send-email-abrestic@chromium.org>
        <CACRpkdbqioAreyDwM2JN87=gH20n1OkUXPjdkW885iDWUV1NnA@mail.gmail.com>
        <CAL1qeaHzpi3_PNpxnLOf=b8d2n5DrRrnB_yiZFHpiP8C7b0hSg@mail.gmail.com>
        <CACRpkdbt4MQYY7MqjFN-1Dp0am1PaOZ1YL+bKc8SJrtFDnSW_Q@mail.gmail.com>
        <CAL1qeaHCKPeQnf8VPWmz_=uN1=_mxWbMGF+HuPZ_AYOqA+15JA@mail.gmail.com>
Date:   Thu, 19 Mar 2015 09:42:16 +0100
Message-ID: <CACRpkdbXm_aPQU0-wV8yASts7n4QBd1dAe8-d40g2xy2KBAKEQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: Add Pistachio SoC pin control driver
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Andrew Bresticker <abrestic@chromium.org>
Cc:     Alexandre Courbot <gnurou@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        Govindraj Raja <govindraj.raja@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46455
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

On Tue, Mar 17, 2015 at 5:56 PM, Andrew Bresticker
<abrestic@chromium.org> wrote:
[Me]
>> Sorry if I don't really know how things work now... :(
>> It seems like a logical way to me.
(...)
> 4) The ->set_mux() op must set the proper function for the pin.
> 5) The ->set_mux() op must also disable the GPIO function for the pin.
> To disable the GPIO function, the pinctrl driver must map the pin to a
> GPIO bank/offset and disable the GPIO via the GPIO bank's GPIO_EN
> register.

That sounds like the"GPIO" registers are actually involved in any
muxing usecase, meaning there is not really a clean split between
the pinctrl and GPIO hardware, the case I refer to as "GPIO mode
pitfalls" in Documentation/pinctrl.txt.

In such cases both halves of the driver(s) need to be aware of
the other, and that is what you seem to be wanting to achieve.

So I was wrong in thinking the GPIO device could be a separate
subdevice, the two parts are too dependent on each other.
So keep a single probe() function and let the two driver halves
poke into each others' registers.

Sorry for the fuzz...

Yours,
Linus Walleij
