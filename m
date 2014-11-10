Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Nov 2014 20:51:24 +0100 (CET)
Received: from mail-qg0-f41.google.com ([209.85.192.41]:60462 "EHLO
        mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013230AbaKJTvXRfFhT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Nov 2014 20:51:23 +0100
Received: by mail-qg0-f41.google.com with SMTP id q107so6108037qgd.28
        for <linux-mips@linux-mips.org>; Mon, 10 Nov 2014 11:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=RK6XmvqVuWI72XZg1LmY0LAoPmdZaM2jPP7eqcqTf7s=;
        b=XymqcOe4geVAB05PNL+Bs+73Ax9RMcUX7Xhya9rHqpf6JIYSb8O3UNVOk5oY8Q9NNW
         iZJtjhWNNw0dDkg9sk17ZoCzioCCtJuEFAlO8qNUSnQ4JXjR5kCiGmAPL5FlVcTcWktA
         svF1Uol678jLjVewkyga1HtZLqhIyY+oiByvVWMluNIu3TSUs/HU/0idpGh1aP892gSt
         7Jfg3wCzA9U3ScDzqdqlOnwRG4tTHWho2sXtd19HlY26O+g7K4BgPj5koz4BdJxzK9gb
         rZiQ+JQSLUqJzIJegwG8uFPybKewVdxBCcfF6W5W601znJgYBENxmkV0M6U6ZiD9cxGa
         D7MQ==
X-Received: by 10.224.148.18 with SMTP id n18mr14320000qav.100.1415649076720;
 Mon, 10 Nov 2014 11:51:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.89.113 with HTTP; Mon, 10 Nov 2014 11:50:56 -0800 (PST)
In-Reply-To: <CAL_JsqLYoUKr71Q-hfLQhXOVL72Gy7PkO-Zd4rBc0Fn-prOqTw@mail.gmail.com>
References: <1415523348-4631-1-git-send-email-cernekee@gmail.com>
 <1415523348-4631-2-git-send-email-cernekee@gmail.com> <CAL_JsqLXznpCo3YjN+XqF6cDG38C6dKzO9DHJmzi6=sNnAU=hQ@mail.gmail.com>
 <CAJiQ=7DUV0isdRooz6112Ncx07+9RE5DS5tMBwxr47hTWA8PAw@mail.gmail.com> <CAL_JsqLYoUKr71Q-hfLQhXOVL72Gy7PkO-Zd4rBc0Fn-prOqTw@mail.gmail.com>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Mon, 10 Nov 2014 11:50:56 -0800
Message-ID: <CAJiQ=7C5ki+9opnH68Kw9a573PmO=ANeiVutmVROUP2Typn2qw@mail.gmail.com>
Subject: Re: [PATCH 2/2] tty: serial: bcm63xx: Allow device nodes to be
 renamed to /dev/ttyBCM*
To:     Rob Herring <robh@kernel.org>
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
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43969
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Mon, Nov 10, 2014 at 11:22 AM, Rob Herring <robh@kernel.org> wrote:
>>> This can be solved with a udev rule to create sym links.
>>
>> Is it safe to register two console drivers named "ttyS" with the same
>> major/minor numbers?  Maybe there is a trick to making them coexist?
>
> No, but I think you can do dynamic minor numbers. I seem to recall
> this coming up with the Samsung UARTs a while back.

The other variations I've seen in the tree are:

nwpserial: ttySQ, major 4 minor 68 (not 64)

sunhv, sunsab, sunsu, sunzilog: set uart_driver->major to 4 but let
uart_driver->minor default to 0

SERIAL_ATMEL_TTYAT: compile-time selectable between ttySn (4/64) and
ttyATn (204/154).  txx9 does something similar using
SERIAL_TXX9_STDSERIAL.

A whole bunch of other SoC serial drivers use major 204 and a custom
name like "ttyAL".  Some of these show up in
Documentation/devices.txt; others don't.  ~3 drivers use 204/64 from
the middle of the Altix assigned range.

What is the current best practice for new drivers?
