Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Dec 2014 08:28:41 +0100 (CET)
Received: from mail-ie0-f182.google.com ([209.85.223.182]:53824 "EHLO
        mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006968AbaLDH2jT26-x convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 4 Dec 2014 08:28:39 +0100
Received: by mail-ie0-f182.google.com with SMTP id x19so15228431ier.41
        for <multiple recipients>; Wed, 03 Dec 2014 23:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=SyPYrs9Ku8i6Fma/v6kMx3cUsp0mpgfWqAzro9GssLw=;
        b=MdjJN2sfBPCacHipcm+//fwXx0HI4+upeuX+e1CzPXKV3NJD4cJnCBdVog4z3b08WC
         jZYK4eJ5/s0Ahb/bnC7lghNftNBWUc1Qh9kK1LPZFN/HVCXKZqHBtY8B2eH5up0xLpLW
         0wv70Win+65cWbxLeI24cx3yCqs/KxT8jDidox//lX1VTk7w9V8XVAHHqhCncO1wp+3E
         rGv15pay11ffuRc959g0rt2foJXNYT/4fNrUCeSHnrVVuPLNYLa7owWZuuGiwX0p2FBc
         FtV6DE7Bnmui/b0I8HxI9lIx1lYRrglHmSlDL6b+AiRfjF7u+XXOrlmmqQ76GRBj/XAE
         azNA==
MIME-Version: 1.0
X-Received: by 10.107.38.202 with SMTP id m193mr8471333iom.19.1417678113355;
 Wed, 03 Dec 2014 23:28:33 -0800 (PST)
Received: by 10.107.14.9 with HTTP; Wed, 3 Dec 2014 23:28:33 -0800 (PST)
In-Reply-To: <alpine.DEB.2.02.1412040603450.8865@utopia.booyaka.com>
References: <1416736241-12723-1-git-send-email-zajec5@gmail.com>
        <1416778509-31502-1-git-send-email-zajec5@gmail.com>
        <alpine.DEB.2.02.1411240910100.16047@utopia.booyaka.com>
        <CACna6rxwwn5_e86278TAiOFZ3sVu_Exfm2x94vN2KiTJfsFujQ@mail.gmail.com>
        <alpine.DEB.2.02.1411251407290.16047@utopia.booyaka.com>
        <CACna6rxj8=V8me1_L8SxhV3=kgYRyKeBHkxShSMZa4kbcHimLg@mail.gmail.com>
        <alpine.DEB.2.02.1411271926560.1406@utopia.booyaka.com>
        <CACna6rwMjOfmnA-926udNx7jQHQ2JMnmiutQZkTxtJ85qmUw8A@mail.gmail.com>
        <alpine.DEB.2.02.1411281659190.1406@utopia.booyaka.com>
        <alpine.DEB.2.02.1412040603450.8865@utopia.booyaka.com>
Date:   Thu, 4 Dec 2014 08:28:33 +0100
Message-ID: <CACna6rx_oBxx8OhcX2J_SSZz6ABif-eOSKksSJOoQuQv_6d7WQ@mail.gmail.com>
Subject: Re: [PATCH V3] MIPS: BCM47XX: Move NVRAM driver to the drivers/soc/
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Paul Walmsley <paul@pwsan.com>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kumar Gala <galak@codeaurora.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Sandeep Nair <sandeep_n@ti.com>, linux-soc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44572
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

On 4 December 2014 at 07:43, Paul Walmsley <paul@pwsan.com> wrote:
> Hello Rafał,
>
> On Fri, 28 Nov 2014, Paul Walmsley wrote:
>
>> On Thu, 27 Nov 2014, Rafał Miłecki wrote:
>>
>> > I'm pretty sure you look at some old version of arch/bcm47xx/nvram.c.
>> > I wouldn't dare to move such a MIPS-focused driver to some common
>> > place ;)
>> >
>> > Please check for the version of nvram.c in Ralf's upstream-sfr tree. I
>> > think you'll like it much more. Hopefully you will even consider it
>> > ready for moving to the drivers/firmware/ or whatever :)
>>
>> OK I will take a look at this, and will either send comments, or will
>> send a Reviewed-By:.
>
> I had the chance to take a brief look at this file, and you are right: I
> like your newer version better than the older one :-)
>
> It is too bad that it seems this flash area has to be accessed very early
> in boot.  That certainly makes it more difficult to write something
> particularly elegant.  It is also a pity that it is unknown how to verify
> that the flash MMIO window has been configured before reading from these
> areas of the address space.  But under the circumstances, calling
> bcm47xx_nvram_init_from_mem() with the appropriate addresses from the bus
> code during early init, as you did, seems rather reasonable.  I also like
> the code that you added to read the flash data from MTD later in boot.
>
> Here are a few very minor comments that you are welcome to take or leave
> as you wish.

Thanks for your comments! I'll address them before (trying) moving
driver to the drivers/firmware/. Appreciate your review.
