Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Mar 2015 19:10:26 +0100 (CET)
Received: from mail-qg0-f45.google.com ([209.85.192.45]:37681 "EHLO
        mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008276AbbCFSKYA1Eia (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Mar 2015 19:10:24 +0100
Received: by qgdz107 with SMTP id z107so14539885qgd.4
        for <linux-mips@linux-mips.org>; Fri, 06 Mar 2015 10:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=lcWSz0GXnUX+fG6ev9TeK2b2JGunYUytb2HItvKri6E=;
        b=QzYVRxU7q8vpLp92ktaCi2lH3m98L0V6IA6j1n7+krplbhPHzdRutiefRqTh7/Uroi
         1WQ4b3adP6E6aTVAce5KRoKd1CNtGjQ+QYHKNz14cL07gsj1zip7su6wzynMRFvxXmOm
         Du249eaQ93yJtiASI2yFjZL1wfEgm6UJ13Z9clUmICXdSz0Xveu6Tw2/gqu4F6gpwQni
         IyWLjxqK0FTn5tNrXDQJRWI3Da6AVgGT5qunulCEJZexSJCrRePt5i/KxKIUBe5Q9Ovq
         FB9ENNJFidxbeNzPWSiPKbQbHxLUCTdd8KPP0IbX5ekKl0irfXMufWi9SYIDQVoAAWEt
         T5aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=lcWSz0GXnUX+fG6ev9TeK2b2JGunYUytb2HItvKri6E=;
        b=SLjORg4XO6B/X8VdJz3vcI6MgCokGggRT7YleakqOKFiaxM5S7PeuZFAjpNphgfsuM
         kkxlcEhJ/HdpyY2Zy93JBp1H8feJ1sp/jP1vsZM6U5xsl7+mBo223ANsPIsvSMuUF0HA
         CUAdIIJCc5/r9bf2DNxWZ/GOaAkgZHu6FTNlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=lcWSz0GXnUX+fG6ev9TeK2b2JGunYUytb2HItvKri6E=;
        b=i+XvGkb/EXAVjwS2svkVingMQzjjeun2P02XWaGwA2D3CoRqzZku53Kbf0JiPqisJ6
         9AuSwe55Ly0NJAk/zhlRf1vFPTbFiJkRUCCY/pjETVylYCNlFvLpYCILEaSwMnCqLiF6
         +FHHnG6kmby3zDoBDCkWo9HUM9DS+EoZz9KLbKtG0Az+OS9O3MGNNYUbmvAjjFZRAuRM
         svRjyALtGkclu/Saow/kfj0qVL4FstYs5+kVmkgqkWWb3t9iLr4WJsF/bMfkpzdsN4Si
         oCQdGL6Ur86ey3xJk9MNU5AQX106of/ufc7keFjDnwTPzbn9xFffLNo8mpZ3QAalDSPJ
         +i5w==
X-Gm-Message-State: ALoCoQka/rvilqtbzNtFygsSyVbTu7LnwJELpvlSfxG1MbBVf7/6ZOLPEFxl7UZKwpkjctRmdxnA
MIME-Version: 1.0
X-Received: by 10.55.55.4 with SMTP id e4mr20394517qka.97.1425665419011; Fri,
 06 Mar 2015 10:10:19 -0800 (PST)
Received: by 10.140.19.72 with HTTP; Fri, 6 Mar 2015 10:10:18 -0800 (PST)
In-Reply-To: <CACRpkdbCavYLk-Uo8hjTrGcGLJe6NEB9dVPVNm_fyd3eGccnEw@mail.gmail.com>
References: <1424744104-14151-1-git-send-email-abrestic@chromium.org>
        <1424744104-14151-2-git-send-email-abrestic@chromium.org>
        <CACRpkdbCavYLk-Uo8hjTrGcGLJe6NEB9dVPVNm_fyd3eGccnEw@mail.gmail.com>
Date:   Fri, 6 Mar 2015 10:10:18 -0800
X-Google-Sender-Auth: iHYbfMJumLA9CGmXHjxQ1YqQrxk
Message-ID: <CAL1qeaFcQFBydV7Gnkyp_w9d7M4yivEmX-1tB0OhbtocYeO=AQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: Add Pistachio SoC pin control binding document
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Linus Walleij <linus.walleij@linaro.org>
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
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46239
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

On Fri, Mar 6, 2015 at 3:37 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Feb 24, 2015 at 3:15 AM, Andrew Bresticker
> <abrestic@chromium.org> wrote:
>
>> Add a device-tree binding document for the pin controller present
>> on the IMG Pistachio SoC.
>>
>> Signed-off-by: Damien Horsley <Damien.Horsley@imgtec.com>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> (...)
>> +Note that the GPIO bank sub-nodes *must* be listed in order.
>
> Usually we use aliases to mark the order of things. e.g.:
>
>         aliases {
>                 gpio0 = &gpio0;
>                 gpio1 = &gpio1;
>                 gpio2 = &gpio2;
>                 ethernet0 = &eth0;
>                 ethernet1 = &eth1;
>         };
>
> (arch/arm/boot/dts/armada-375.dtsi)

Ok.

>> +Required properties for pin configuration sub-nodes:
>> +----------------------------------------------------
>> + - pins: List of pins to which the configuration applies. See below for a
>> +   list of possible pins.
>> +
>> +Optional properties for pin configuration sub-nodes:
>> +----------------------------------------------------
>> + - function: Mux function for the specified pins. This is not applicable for
>> +   non-MFIO pins. See below for a list of valid functions for each pin.
>> + - bias-high-impedance: Enable high-impedance mode.
>> + - bias-pull-up: Enable weak pull-up.
>> + - bias-pull-down: Enable weak pull-down.
>> + - bias-bus-hold: Enable bus-keeper mode.
>> + - drive-strength: Drive strength in mA. Supported values: 2, 4, 8, 12.
>> + - input-schmitt-enable: Enable Schmitt trigger.
>> + - input-schmitt-disable: Disable Schmitt trigger.
>> + - slew-rate: Slew rate control. 0 for slow, 1 for fast.
>
> We actually haven't specified that function+pins is a valid pattern,
> a lot of drivers just started doing that :(
>
> function+groups is documented for muxing.
>
> group + config opts is documented for config.
>
> Please consider patching the generic bindings to reflect this
> mux use of pins... We need to discuss it.

Sure, I can update that documentation.

Thanks,
Andrew
