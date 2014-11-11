Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2014 18:35:53 +0100 (CET)
Received: from mail-la0-f43.google.com ([209.85.215.43]:60362 "EHLO
        mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013253AbaKKRfu6wQl2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Nov 2014 18:35:50 +0100
Received: by mail-la0-f43.google.com with SMTP id ge10so9967502lab.2
        for <linux-mips@linux-mips.org>; Tue, 11 Nov 2014 09:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=urBIpp06uHMYAf4IXliYpP32G9q3SVW0LH442qZxl3k=;
        b=k8VEAuqrgiOJb+IHgue9AEQvgcy1q+AziCKNw1DMB+ZohW5S4/VW20Jha/qzglGd6K
         WVTvB+7S/sLOCAMHw6sbvlJZJl+jcOCLyVOkOFlFL4k+GTxz4bKnp0f3KRMzzPqFCmRb
         hrtGezFMyQtm2nBaKU9LpgyYPWig10TvaZR1uaRmzaSUKOca5DxUBD7RaD1Iu7Tb6dqb
         uh2vC1To0196QIK+HBd+itKN8aiilKTwurEBmR5RGNlbE6E5eQ2eSl3ijCwk7tTNV4uG
         M4SaD51gsY0Osb0AkoHnK7RywDsaGyvW49NjuSHGQd9LxTWkmL0nwS4SFu7mKiRBk2WW
         bEQQ==
X-Received: by 10.152.43.97 with SMTP id v1mr37377357lal.3.1415727344400; Tue,
 11 Nov 2014 09:35:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.112.11.233 with HTTP; Tue, 11 Nov 2014 09:35:23 -0800 (PST)
In-Reply-To: <CAJiQ=7C5ki+9opnH68Kw9a573PmO=ANeiVutmVROUP2Typn2qw@mail.gmail.com>
References: <1415523348-4631-1-git-send-email-cernekee@gmail.com>
 <1415523348-4631-2-git-send-email-cernekee@gmail.com> <CAL_JsqLXznpCo3YjN+XqF6cDG38C6dKzO9DHJmzi6=sNnAU=hQ@mail.gmail.com>
 <CAJiQ=7DUV0isdRooz6112Ncx07+9RE5DS5tMBwxr47hTWA8PAw@mail.gmail.com>
 <CAL_JsqLYoUKr71Q-hfLQhXOVL72Gy7PkO-Zd4rBc0Fn-prOqTw@mail.gmail.com> <CAJiQ=7C5ki+9opnH68Kw9a573PmO=ANeiVutmVROUP2Typn2qw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 11 Nov 2014 11:35:23 -0600
X-Google-Sender-Auth: sZhEF8AeQ_DrYbq1wosx_bq3fdg
Message-ID: <CAL_JsqKE=p_d53A7n4QZpQc_z0tbAp0bhZGerjsUt2BSSvGgtw@mail.gmail.com>
Subject: Re: [PATCH 2/2] tty: serial: bcm63xx: Allow device nodes to be
 renamed to /dev/ttyBCM*
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Grant Likely <grant.likely@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxime Bizon <mbizon@freebox.fr>,
        Jonas Gorski <jogo@openwrt.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44009
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Mon, Nov 10, 2014 at 1:50 PM, Kevin Cernekee <cernekee@gmail.com> wrote:
> On Mon, Nov 10, 2014 at 11:22 AM, Rob Herring <robh@kernel.org> wrote:
>>>> This can be solved with a udev rule to create sym links.
>>>
>>> Is it safe to register two console drivers named "ttyS" with the same
>>> major/minor numbers?  Maybe there is a trick to making them coexist?
>>
>> No, but I think you can do dynamic minor numbers. I seem to recall
>> this coming up with the Samsung UARTs a while back.
>
> The other variations I've seen in the tree are:
>
> nwpserial: ttySQ, major 4 minor 68 (not 64)
>
> sunhv, sunsab, sunsu, sunzilog: set uart_driver->major to 4 but let
> uart_driver->minor default to 0
>
> SERIAL_ATMEL_TTYAT: compile-time selectable between ttySn (4/64) and
> ttyATn (204/154).  txx9 does something similar using
> SERIAL_TXX9_STDSERIAL.
>
> A whole bunch of other SoC serial drivers use major 204 and a custom
> name like "ttyAL".  Some of these show up in
> Documentation/devices.txt; others don't.  ~3 drivers use 204/64 from
> the middle of the Altix assigned range.
>
> What is the current best practice for new drivers?

I think it would be using dynamic numbering, but would be good to have
others weigh in here. It looks like a dynamic major would solve your
problem. See tty_register_driver. Also, there was a patch to make this
the fallback behavior instead of an error[1], but it was never merged
(and it's not clear why). This was the Samsung related change I was
remembering.

Rob

[1] http://lists.linaro.org/pipermail/linaro-kernel/2014-January/010383.html
