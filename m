Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2014 16:31:54 +0200 (CEST)
Received: from mail-qg0-f54.google.com ([209.85.192.54]:57600 "EHLO
        mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012257AbaJWObwoy8oE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Oct 2014 16:31:52 +0200
Received: by mail-qg0-f54.google.com with SMTP id z107so780400qgd.13
        for <linux-mips@linux-mips.org>; Thu, 23 Oct 2014 07:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VTuC6OKj6tbQE8GAsPzT3t5WKdkSbHquwdpNc72ChCc=;
        b=xaCn+8SlWYvnbRJEOiXgU3CUvRKsmqaEPxhr1vTR4IQtUzSiBcCNlCaQ4gQPxlwMfI
         cyuSHRExiN8xhE7+5gQzMIQhi7KVvtdRUSFUH5e6XbKj703sjKJVr5lPXk/z6wubiDjc
         rHw9uI3Md0esv4nQvr/puxJDzHmInFPxB7jN2xyq3CdCCWkAHCZAksY7fAm7wYeKQZJK
         RWVX2ImcPAeeMYb/H1wqFveXkAt43yV/K4DE939yGxLJ4agb9guUFUq3ZnnhBJ1dPo1g
         j2N6XhVSk6+5Ye0dHwnBkS26zAV8GkfB1webpWHSWRm2Fq6MHUBXTXqW7oUnZqdHBaYC
         xJOA==
X-Received: by 10.140.84.106 with SMTP id k97mr5968099qgd.76.1414074706790;
 Thu, 23 Oct 2014 07:31:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.93.8 with HTTP; Thu, 23 Oct 2014 07:31:26 -0700 (PDT)
In-Reply-To: <CAL_JsqJbva6i5BwDMf9f0TcuToxzP2u9_oe1t92zQXJyS077oA@mail.gmail.com>
References: <1413930186-23168-1-git-send-email-cernekee@gmail.com>
 <1413930186-23168-10-git-send-email-cernekee@gmail.com> <CAL_Jsq+AuqTOU7UFdYi28YGjL1QorY=3zOSccN43Vb1a=q6SHw@mail.gmail.com>
 <CAJiQ=7BrfnyOQYptBCTR8GP8hLq4+q1NQ2H988wHK=8PnkqLkg@mail.gmail.com> <CAL_JsqJbva6i5BwDMf9f0TcuToxzP2u9_oe1t92zQXJyS077oA@mail.gmail.com>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Thu, 23 Oct 2014 07:31:26 -0700
Message-ID: <CAJiQ=7DVSavXNYBd4yntRS-LKJMHQyxJx8Uim8Oz24rNfADcXg@mail.gmail.com>
Subject: Re: [PATCH V3 09/10] tty: serial: of-serial: Allow OF earlycon to
 default to "on"
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Grant Likely <grant.likely@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxime Bizon <mbizon@freebox.fr>,
        Jonas Gorski <jogo@openwrt.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43536
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

On Wed, Oct 22, 2014 at 9:47 PM, Rob Herring <robh@kernel.org> wrote:
>> Now that earlycon can get all of its parameters from DT, do you think
>> it might make sense to drop the command line option entirely from
>> fdt.c and enable it all of the time if stdout-path is set correctly?
>>
>> From the user's standpoint, how important is it to be able to run
>> without earlycon?
>
> It may affect boot time for one although if you care you probably
> disable console altogether.
>
> I think we'd just have to add a noearlycon option instead if we made
> it the default. It's never been the default before, so I don't think
> we should change now. There's also an implicit requirement that the
> bootloader has configured the uart already. You could easily hang if
> the uart has not been setup.

EARLY_PRINTK is enabled by default on MIPS platforms that support it.
I have been using this for years and found it very helpful in
debugging failures in the kernel boot process (especially intermittent
ones).

But for a new platform it is better to use earlycon as earlycon
provides a clean way of reading the UART information out of DT.  My
original bcm3384 (MIPS) port used EARLY_PRINTK but I recently
converted it to earlycon.  The last remaining goal is to get it
enabled by default again.

>> Would it be more straightforward to have the arch code explicitly call
>> early_init_dt_scan_chosen_serial() to indicate that it is ready for
>> the early UART driver to run?
>
> Yes, but then when do you handle earlycon command line option for
> non-DT case? Having these at different points in time is asking for
> problems.

Is it important for the non-DT "earlycon" option to be handled from
parse_early_param() just because parse_early_param() runs at the right
point in the boot sequence (not because we actually wanted it to be a
command line option)?

One other option might be to invoke early_init_dt_scan_chosen_serial()
from parse_early_param().  But it is somewhat clunky to put a special
case in there...
