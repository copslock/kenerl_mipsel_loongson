Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 May 2014 16:20:27 +0200 (CEST)
Received: from mail-ig0-f172.google.com ([209.85.213.172]:50379 "EHLO
        mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6839073AbaEPOUZLdP-k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 May 2014 16:20:25 +0200
Received: by mail-ig0-f172.google.com with SMTP id uy17so829273igb.5
        for <linux-mips@linux-mips.org>; Fri, 16 May 2014 07:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=QXMcrD4Q6Ls8ejFCWkU4p6gCzFNQVD+vg8qVHXtVXb0=;
        b=P19y9eATZmN0b7b6EyVGmhKPR57NFK/x5GeUXkAv+fYMIJ+YStJkjFNz45hp013Uq+
         v7z1EBS6ZSiywnx0/ZN6OUUg5Y6Jg7uR6YeH8N8Wtb/c6E/N3+d3vRZnUFMVYsdHSS2K
         5BMoyV4UQcEBr2a+moVIW6DbHE886n9OCuMHhNokSVebQlPlxnPggvBWK9gzu+0T1RLq
         RDv8pDML9GSVaFRlyzWxgFM4KMexVxw1wzgjV9Zw+AtDBPLwb6lFBSC+qiIcwbO6l0pm
         aWJA3DlI7bmmzlXPSp5XoutY6Eujg0ZAAKhAYabbRxB66Kq76QOqChqdCsIoETjIul6M
         TCfA==
MIME-Version: 1.0
X-Received: by 10.50.66.3 with SMTP id b3mr20942970igt.22.1400250018786; Fri,
 16 May 2014 07:20:18 -0700 (PDT)
Received: by 10.64.17.199 with HTTP; Fri, 16 May 2014 07:20:18 -0700 (PDT)
In-Reply-To: <20140516134904.GW618@waldemar-brodkorb.de>
References: <20140516134904.GW618@waldemar-brodkorb.de>
Date:   Fri, 16 May 2014 16:20:18 +0200
X-Google-Sender-Auth: oadzfgtYzCIG03pt5q7MpCftjtE
Message-ID: <CAMuHMdVPSzYkUumqMY78zxVcoQ6=W9Vfm_tyM_T3W8DFzCztVw@mail.gmail.com>
Subject: Re: serial console on rb532 disabled on boot (linux 3.15rc5)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Waldemar Brodkorb <wbx@openadk.org>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40123
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

Hi Waldemar,

On Fri, May 16, 2014 at 3:49 PM, Waldemar Brodkorb <wbx@openadk.org> wrote:
> I am trying to bootup my Mikrotik RB532 board with the latest
> kernel, but my serial console is disabled after boot:
> ..
> Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> serial8250: ttyS0 at MMIO 0x0 (irq = 104, base_baud = 12499875) is a
> 16550A
> console [ttyS0] enabled
> console [ttyS0] disabled
>
> I used git bisect to find the problematic commit:
> commit 5f5c9ae56c38942623f69c3e6dc6ec78e4da2076
> Author: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> Date:   Fri Feb 28 14:21:32 2014 +0100
>
>     serial_core: Unregister console in uart_remove_one_port()
>
>     If the serial port being removed is used as a console, it must
> also be
>     unregistered from the console subsystem using
> unregister_console().
>
>     uart_ops.release_port() will release resources (e.g. iounmap()
> the serial
>     port registers), causing a crash on subsequent kernel output if
> the console
>     is still registered.
>
>     Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> After reverting the change, everything is fine.

Does this patch help? https://lkml.org/lkml/2014/5/10/9

I guess you're not using of_serial?
Your serial driver may need to set port.type too, if it doesn't already do so
and the type is PORT_UNKNOWN on re-registration.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
