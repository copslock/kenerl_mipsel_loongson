Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Nov 2014 17:24:05 +0100 (CET)
Received: from mail-qg0-f47.google.com ([209.85.192.47]:60945 "EHLO
        mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014026AbaKSQYDyGtMX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Nov 2014 17:24:03 +0100
Received: by mail-qg0-f47.google.com with SMTP id z60so653336qgd.20
        for <linux-mips@linux-mips.org>; Wed, 19 Nov 2014 08:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6IWJOkj7aAsMVKZiLqEKnetQA3c48MU5RHIl+2IhUDQ=;
        b=oa1UMMLLnLLX55l9Gsfitppxfok3iXkBoUDc4op5yMyDXv04kjBmfEHYN9li8B1EHL
         wR8i3UPvGF8LKgPjQzbgajoAChXOg/9/9cV0JkBofn2kA4ZJpqLUr4hGMOiX5lS3BEnm
         ta0jNAC6Vm5MJU0PWUoGMQ0Q1Aqil3Ex4yO9DTk65oBKMzQbBw3unon0OU6EpDIMV4U5
         iuCzT8BUccI9nq1CEG7SUUi0AzClc0LW+h8d2VAH0v6Wq+DcWd3mL+e7Gzwoi1ZmBfrU
         uBXPyhnhoCl+S6/2lAeWQ/7uOXy+ePDA6CkBPXAFt79l0d+l717UxJyss9ksoJ2hV/Ah
         Z7qw==
X-Received: by 10.140.48.11 with SMTP id n11mr52371130qga.1.1416414235977;
 Wed, 19 Nov 2014 08:23:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.89.113 with HTTP; Wed, 19 Nov 2014 08:23:35 -0800 (PST)
In-Reply-To: <20141119144911.9CA5FC40D73@trevor.secretlab.ca>
References: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
 <1415825647-6024-7-git-send-email-cernekee@gmail.com> <20141119144911.9CA5FC40D73@trevor.secretlab.ca>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Wed, 19 Nov 2014 08:23:35 -0800
Message-ID: <CAJiQ=7BpOzAFTCmhER=ZVJgtQwoDKf3xPYKR8u+g-d1RQzhUKw@mail.gmail.com>
Subject: Re: [PATCH V2 06/10] serial: pxa: Add fifo-size and
 {big,native}-endian properties
To:     Grant Likely <grant.likely@linaro.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        daniel@zonque.org, Haojian Zhuang <haojian.zhuang@gmail.com>,
        robert.jarzmik@free.fr, Florian Fainelli <f.fainelli@gmail.com>,
        Maxime Bizon <mbizon@freebox.fr>,
        Jonas Gorski <jogo@openwrt.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44297
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

On Wed, Nov 19, 2014 at 6:49 AM, Grant Likely <grant.likely@linaro.org> wrote:
> On Wed, 12 Nov 2014 12:54:03 -0800
> , Kevin Cernekee <cernekee@gmail.com>
>  wrote:
>> With a few tweaks, the PXA serial driver can handle other 16550A clones.
>> Add a fifo-size DT property to override the FIFO depth (BCM7xxx uses 32),
>> and {native,big}-endian properties similar to regmap to support SoCs that
>> have BE or "automagic endian" registers.
>
> Hold the phone, if these are 16550A clone ports, then why is the pxa
> driver being adapted to drive them? I would expect the of_serial.c
> driver to be used. It's already got support for multiple variants of the
> 16550.

Merely building serial8250 into a multiplatform kernel breaks every
other serial driver that uses "ttyS" and major/minor 4/64.  Even if an
8250/16550A device is never probed.

More discussion in this thread:

http://www.spinics.net/lists/linux-serial/msg14811.html
