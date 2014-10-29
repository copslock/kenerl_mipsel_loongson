Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 05:13:25 +0100 (CET)
Received: from mail-qg0-f54.google.com ([209.85.192.54]:54287 "EHLO
        mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011817AbaJ2ENXvNp-G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 05:13:23 +0100
Received: by mail-qg0-f54.google.com with SMTP id q108so1689026qgd.13
        for <linux-mips@linux-mips.org>; Tue, 28 Oct 2014 21:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jgGD1ZLXhnykoBkf6MqFyYNZlxf5g6mu4xrgtZuQGAk=;
        b=pFMBKmkM88ql7KqTGbDSE2vU7rVjP2dAm/MPXYalhC1RnxPEWnvBdhYgzhVQ0BmaGX
         IwPP+ZsNmI2qksLDweW26CNToiZgSuk0hhCsZhqSPAOp3mUjy7wLPKkONctU1ykXLbjN
         hvvMS1/5Uy0Zy5HsvDFiGj9s0NksQcrT4O5f7D5mx3Kwbq0gdjrA79RUFDxY4lL9k/nq
         0rlB41nPJivSgYp6BjyNGJbXrpP0aEPH08htviopQX3tgxChY0qWPuzl1/ZxCIBzOIPj
         RbQDZuM2LDgPKxLniLCAVjsSUFwhJ8AU3ERHS8R8gqFLUXqU95OkMextM1/cMhcLa/fa
         /7Yg==
X-Received: by 10.229.35.197 with SMTP id q5mr11847910qcd.26.1414555997941;
 Tue, 28 Oct 2014 21:13:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.89.113 with HTTP; Tue, 28 Oct 2014 21:12:57 -0700 (PDT)
In-Reply-To: <CAJiQ=7DVSavXNYBd4yntRS-LKJMHQyxJx8Uim8Oz24rNfADcXg@mail.gmail.com>
References: <1413930186-23168-1-git-send-email-cernekee@gmail.com>
 <1413930186-23168-10-git-send-email-cernekee@gmail.com> <CAL_Jsq+AuqTOU7UFdYi28YGjL1QorY=3zOSccN43Vb1a=q6SHw@mail.gmail.com>
 <CAJiQ=7BrfnyOQYptBCTR8GP8hLq4+q1NQ2H988wHK=8PnkqLkg@mail.gmail.com>
 <CAL_JsqJbva6i5BwDMf9f0TcuToxzP2u9_oe1t92zQXJyS077oA@mail.gmail.com> <CAJiQ=7DVSavXNYBd4yntRS-LKJMHQyxJx8Uim8Oz24rNfADcXg@mail.gmail.com>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Tue, 28 Oct 2014 21:12:57 -0700
Message-ID: <CAJiQ=7A8D8SgeRbJMwce=7UD6yLTjhMgQZnPHWysGqFayJrdcg@mail.gmail.com>
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
X-archive-position: 43682
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

On Thu, Oct 23, 2014 at 7:31 AM, Kevin Cernekee <cernekee@gmail.com> wrote:
>> I think we'd just have to add a noearlycon option instead if we made
>> it the default. It's never been the default before, so I don't think
>> we should change now. There's also an implicit requirement that the
>> bootloader has configured the uart already. You could easily hang if
>> the uart has not been setup.
>
> EARLY_PRINTK is enabled by default on MIPS platforms that support it.
> I have been using this for years and found it very helpful in
> debugging failures in the kernel boot process (especially intermittent
> ones).
>
> But for a new platform it is better to use earlycon as earlycon
> provides a clean way of reading the UART information out of DT.  My
> original bcm3384 (MIPS) port used EARLY_PRINTK but I recently
> converted it to earlycon.  The last remaining goal is to get it
> enabled by default again.

Hi Rob,

Do you think we should just drop this patch for now, and use these
options to append "earlycon" to the bootloader-supplied command line:

CONFIG_CMDLINE_BOOL=y
CONFIG_CMDLINE="earlycon"
CONFIG_CMDLINE_OVERRIDE=n

If you have other suggestions on how to enable earlycon by default, I
would be happy to help implement them.

Thanks!
