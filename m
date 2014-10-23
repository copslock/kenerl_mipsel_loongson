Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2014 05:26:10 +0200 (CEST)
Received: from mail-qa0-f46.google.com ([209.85.216.46]:56358 "EHLO
        mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011355AbaJWD0Ios0YQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Oct 2014 05:26:08 +0200
Received: by mail-qa0-f46.google.com with SMTP id s7so139218qap.5
        for <linux-mips@linux-mips.org>; Wed, 22 Oct 2014 20:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+Cz8goUcxuBko5swo1/tsPArNW301Q8tNhG+ia/OEAY=;
        b=U2XleHw+Ks2FVpGe9Yqt0+FX8vhowj8l+hw937IA9dHicNxmDewIfRwl+F0+0nx/ZY
         +1OznWakptkoeoiC7LXoHhk+9+NQFOg4OYVDDLtJJxnz8s4+UsIqZ88yQvaqSPcH852n
         XQfY2ZfJd/Da5eaH2d+HG4QUHXJK8xfiMtUV0COV/J6FHpNYYvmr2dJKZgvTU1c2xWRm
         gtfVJ9qdWelJivJXrS8icV51W/8UxQ0+2tl9RkBd55qm30gpVf5rs5fhXrpO/Erkb3Eg
         aHf05ZEnA4kMFamWcVSQkoP5/PgOGXBemYARYTyGdEryNANMNfZRLuDdqpDeBaXwUpqq
         fe1Q==
X-Received: by 10.140.91.72 with SMTP id y66mr3286391qgd.52.1414034762808;
 Wed, 22 Oct 2014 20:26:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.93.8 with HTTP; Wed, 22 Oct 2014 20:25:42 -0700 (PDT)
In-Reply-To: <CAL_Jsq+AuqTOU7UFdYi28YGjL1QorY=3zOSccN43Vb1a=q6SHw@mail.gmail.com>
References: <1413930186-23168-1-git-send-email-cernekee@gmail.com>
 <1413930186-23168-10-git-send-email-cernekee@gmail.com> <CAL_Jsq+AuqTOU7UFdYi28YGjL1QorY=3zOSccN43Vb1a=q6SHw@mail.gmail.com>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Wed, 22 Oct 2014 20:25:42 -0700
Message-ID: <CAJiQ=7BrfnyOQYptBCTR8GP8hLq4+q1NQ2H988wHK=8PnkqLkg@mail.gmail.com>
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
X-archive-position: 43517
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

On Wed, Oct 22, 2014 at 2:27 AM, Rob Herring <robh@kernel.org> wrote:
> On Wed, Oct 22, 2014 at 6:23 AM, Kevin Cernekee <cernekee@gmail.com> wrote:
>> On many development systems it is very common to see failures during the
>> early stages of the boot process, e.g. SMP boot or PCIe initialization.
>> This is one likely reason why some existing earlyprintk implementations,
>> such as arch/mips/kernel/early_printk.c, are enabled unconditionally
>> at compile time.
>>
>> Now that earlycon's operating parameters can be passed into the kernel
>> via DT, it is helpful to be able to configure the kernel to turn it on
>> automatically.  Introduce a new CONFIG_SERIAL_EARLYCON_FORCE option for
>> this purpose.
>
> You can already force this using the CMDLINE_EXTEND option. I'm not
> sure we need more options.

Hi Rob,

Now that earlycon can get all of its parameters from DT, do you think
it might make sense to drop the command line option entirely from
fdt.c and enable it all of the time if stdout-path is set correctly?

From the user's standpoint, how important is it to be able to run
without earlycon?

>>  void __init early_init_dt_scan_nodes(void)
>>  {
>> +#ifdef CONFIG_SERIAL_EARLYCON_FORCE
>> +       if (early_init_dt_scan_chosen_serial() < 0)
>> +               pr_warn("Unable to set up earlycon from stdout-path\n");
>> +#endif
>
> Doesn't this make the earlycon get scanned and setup twice? Hopefully
> that is safe...

Patch 08/10 makes it safe.  Without Patch 08/10, specifying "earlycon
earlycon" also generates a backtrace.

> This also introduces the scanning at another point in time during boot
> which may not work depending on the arch.

Currently the sequence looks like:

 - arch code calls early_init_dt_scan() to populate boot_command_line
and memory ranges

 - arch code might do some other stuff, possibly setting up page
tables, register mappings, etc.

 - arch code calls parse_early_param() to look at the final command line

 - parse_early_param() might call early_init_dt_scan_chosen_serial()

So we're assuming that the arch code knows not to call
parse_early_param() until the mappings are configured.  But this is an
implicit requirement, and might not be totally obvious.  Since
SERIAL_EARLYCON is enabled by the UART driver, not the arch code, it
is possible that some platforms have ordering issues here that won't
be discovered until somebody tries to use earlycon.

Would it be more straightforward to have the arch code explicitly call
early_init_dt_scan_chosen_serial() to indicate that it is ready for
the early UART driver to run?
