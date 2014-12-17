Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Dec 2014 22:30:30 +0100 (CET)
Received: from mail-qg0-f45.google.com ([209.85.192.45]:37801 "EHLO
        mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009036AbaLQVa2TMHcl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Dec 2014 22:30:28 +0100
Received: by mail-qg0-f45.google.com with SMTP id f51so12538525qge.18
        for <multiple recipients>; Wed, 17 Dec 2014 13:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3jZB8FtaNNBRVq7CS60/c9kQm354CcLX5zw1MTE3Yy0=;
        b=BPSwqznyUTbwunBKcTMG8oEWWw5DaevMlu1F0LovfOrKKdtQJUgeE2z+OCSChQbvrf
         DyiO7XU1/8xTBdT7tAvKK8Z8aEnipEurhDHliSzp9RnE827K3RdwyVup9+A4oApVxSV2
         N7ubVJ8iFwexQLMrZw4D3vtirlY/AkCWhpiY4u3jJTzCAfdEN5/3utukxOLBwBdbEKhW
         lhHrB6+WNJ7Ej687ATY1wC3u0AINiOg1LOmKU7GmwYTUjI8MTNLxkzPqF0hEnKPcl838
         2j3tLBj+9I4CbId7yTvK1J5jipzTYaAF4K8Od1EnzYySpAj4ap7oop/D577YCEEMSvwY
         HQow==
X-Received: by 10.140.105.55 with SMTP id b52mr36602659qgf.1.1418851822431;
 Wed, 17 Dec 2014 13:30:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.82.48 with HTTP; Wed, 17 Dec 2014 13:30:02 -0800 (PST)
In-Reply-To: <1418849927.28384.1.camel@perches.com>
References: <1418849927.28384.1.camel@perches.com>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Wed, 17 Dec 2014 13:30:02 -0800
Message-ID: <CAJiQ=7DE1ojVRW6LqZg2LiqTQ0cgDY_a0nMGn=_Rs1mkuEgwoA@mail.gmail.com>
Subject: Re: rfc: remove early_printk from a few arches? (blackfin, m68k, mips)
To:     Joe Perches <joe@perches.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Steven Miao <realmz6@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44715
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

On Wed, Dec 17, 2014 at 12:58 PM, Joe Perches <joe@perches.com> wrote:
> It seems like early_printk can be configured into
> a few architectures but also appear not to be used.
>
> $ git grep -w "early_printk"
[snip]
> arch/mips/kernel/Makefile:obj-$(CONFIG_EARLY_PRINTK)    += early_printk.o

Nowadays I try to use OF_EARLYCON whenever possible, but when that has
been unavailable, I have used arch/mips/kernel/early_printk.c to get
console output before the serial driver is initialized.  It runs very
early in the boot sequence and has very few dependencies, which makes
it useful for board bringup.

At least on MIPS, the EARLY_PRINTK implementation registers itself as
a console and works with standard printk() calls.  It doesn't rely on
arch/driver code explicitly calling early_printk().

Side note: looking through kernel/printk/printk.c it looks like
there's a space missing in the description string:

MODULE_PARM_DESC(ignore_loglevel, "ignore loglevel setting, to"
        "print all kernel messages to the console.");

But since CONFIG_PRINTK is a bool option, I don't know if the
description string actually shows up anywhere.  Should it be converted
into a comment?
