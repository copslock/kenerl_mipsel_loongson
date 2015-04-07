Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Apr 2015 15:24:30 +0200 (CEST)
Received: from mail-ie0-f169.google.com ([209.85.223.169]:36534 "EHLO
        mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014196AbbDGNY3WNXvF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Apr 2015 15:24:29 +0200
Received: by iebrs15 with SMTP id rs15so46007731ieb.3
        for <linux-mips@linux-mips.org>; Tue, 07 Apr 2015 06:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=o28B98OCFoQzfwkxv7q5Dgh3bqry9cw3ONQwa6ERtf0=;
        b=kTSneX2MaCKgTSJ5IsiDgfbENyAp6VIl7eEVq6qjlMlKzmnrz4aIJmM+IF40PUl4VW
         IAC0IM+Gn/81T1HGH6111twe6jBZpXHJgdFy0m4YjAFoD9D9oOtjS7rMK7KqTjXwFQKe
         Ft/U6lx1HPvZPHl7QZuUNQkpJf4L6iG04IuP0rQzG7D4oXD1j339Qry0SrQYZi/Akspa
         iGDy4641VTbUQw/l79rVnrA5r1kzmdsF/cK21cWn8YBaSRDg9kSPY0qkhqEknrI33+VQ
         zzmK9QrqNECCRfvt34H8xGlGqa69TFyhIqMCyuPcVbCUjxmsj2ggKLOIM4ykteKfpPmW
         15hQ==
X-Gm-Message-State: ALoCoQnPLWN5FwtHr1rU+u0zWv8WOSlCO6gVeE2DiXafLbcRUGNI/odhhhj/9A1eMvUBqPsqGhWc
MIME-Version: 1.0
X-Received: by 10.50.18.49 with SMTP id t17mr3552662igd.3.1428413065039; Tue,
 07 Apr 2015 06:24:25 -0700 (PDT)
Received: by 10.42.103.133 with HTTP; Tue, 7 Apr 2015 06:24:24 -0700 (PDT)
In-Reply-To: <CAL1qeaFd0dz0wirFzCRfetprjs1vJqm6RrmuPj0sBiEg_mc6pg@mail.gmail.com>
References: <1427757416-14491-1-git-send-email-abrestic@chromium.org>
        <20150331140034.GE28951@linux-mips.org>
        <CAL1qeaFd0dz0wirFzCRfetprjs1vJqm6RrmuPj0sBiEg_mc6pg@mail.gmail.com>
Date:   Tue, 7 Apr 2015 15:24:24 +0200
Message-ID: <CACRpkdZTTfrE9D7hWzfyq_4tWCFWiZM+96v=dCnEOHLf_BvWRQ@mail.gmail.com>
Subject: Re: [PATCH V2 0/3] pinctrl: Support for IMG Pistachio
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Andrew Bresticker <abrestic@chromium.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46804
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

On Tue, Mar 31, 2015 at 7:20 PM, Andrew Bresticker
<abrestic@chromium.org> wrote:
> On Tue, Mar 31, 2015 at 7:00 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
>> On Mon, Mar 30, 2015 at 04:16:53PM -0700, Andrew Bresticker wrote:
>>
>>> This series adds support for the system pin and GPIO controller on the IMG
>>> Pistachio SoC.  Pistachio's system pin controller manages 99 pins, 90 of
>>> which are MFIOs which can be muxed between multiple functions or used
>>> as GPIOs.  The GPIO control for the 90 MFIOs is broken up into banks
>>> of 16.  Pistachio also has a second pin controller, the RPU pin controller,
>>> which will be supported by a future patchset through an extension to this
>>> driver.
>>>
>>> Test on an IMG Pistachio BuB.  Based on mips-for-linux-next which inluces my
>>> series adding Pistachio platform support [1].  A branch with this series is
>>> available at [2].
>>
>> Does this mean you want me to funnel this through the MIPS tree?  If so,
>> could I have an Ack from the maintainers?
>
> Linus mentioned in v1 that if the only dependency was a Kconfig symbol
> that he could take it through his tree.  I'm fine either way, though
> it would be slightly more convenient for it to go through the MIPS
> tree.  Linus?

I took 1/3 into pinctrl since it touched my core documentation and
actually even had to be slightly rebased.

I will look at 2/3 and 3/3 and provide ACK if I think they are
all right.

Yours,
Linus Walleij
