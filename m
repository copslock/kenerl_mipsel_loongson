Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Dec 2015 00:39:10 +0100 (CET)
Received: from mail-ig0-f170.google.com ([209.85.213.170]:38654 "EHLO
        mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007195AbbLBXjHGba07 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Dec 2015 00:39:07 +0100
Received: by igbxm8 with SMTP id xm8so35016igb.1
        for <linux-mips@linux-mips.org>; Wed, 02 Dec 2015 15:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hurleysoftware-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=k7eRwhmW9YmKcnd/vcImWXNJtv/kNIVTM17lQh3eZbg=;
        b=SqSh4JefAMr0/YfkQ17jlllGfr3W8ya9cqevyC2S7p55ACmCZ8HcG+6knu5FE5gqVO
         GocSRIF68NZSbwbYKJhwG5Mxq6WKsy4vJ6fh8Inc/y16fSnuVOvJNbIjnYLC3QZ1YcqP
         uv7kd33u0jXCmNf3oMOuga3+wrci8vv/gdxg6SNkHGZBk7q+ARAREjJWYyH87AHXrVmX
         Q3Ex3iEOPB3lvWGeh6FHV1M4wb2/jHHTeoVXRA4ut6tXME8Jo/bA4OYvA4iIO5NnjR5p
         jK+phUCgo87PVawJTCcbfZ7WH6ZiptZLjD5LEUYtx/IWnSnNF5wVn0CUv0AhiqkMvNrh
         lgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=k7eRwhmW9YmKcnd/vcImWXNJtv/kNIVTM17lQh3eZbg=;
        b=H/s52lRZe8jpCWUICG+O0Eda6MwaPeZsHykugOO+RFylzKI0OdwwpuIWVyGh8Zb0/q
         1WiEC1OhkkVz785HRkKyZuj7UmuT6ahkXQ4cPil8+Nbd1/+To7TIkMbDuhNb8TIQYDPN
         1Vw9JCEEUskTMejJJLpov8q9qHRHPd+1NGYw+PTAt7u875ftu5TrCNM+cAJgBDtUydeZ
         NC10sUIvKsykRQ8pXirZ4LLQ2+pNyntw+LtcLYkDxsI+0sOEd3XDFRldPWvIUeX5yytP
         Gws0Ict/18/Mh2vcB7TrBAl34D+FHGMo50lvSzC0q4zfi34jZnRuDownYxAMFhtMxvrv
         o3pw==
X-Gm-Message-State: ALoCoQkjksOxGOtDEeLu9TIZz0q6Tf588yjLn3mvQNnmyQEmz7Fd4uJ5DYXbdGe6bxtLDDGqy1XW
X-Received: by 10.50.43.227 with SMTP id z3mr36011164igl.34.1449099541331;
        Wed, 02 Dec 2015 15:39:01 -0800 (PST)
Received: from [192.168.1.4] (cpe-76-190-194-55.neo.res.rr.com. [76.190.194.55])
        by smtp.gmail.com with ESMTPSA id a5sm12156724iga.7.2015.12.02.15.39.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Dec 2015 15:39:00 -0800 (PST)
Subject: Re: [PATCH 01/28] serial: earlycon: allow MEM32 I/O for DT earlycon
To:     Rob Herring <robh+dt@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>
References: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
 <1448900513-20856-2-git-send-email-paul.burton@imgtec.com>
 <CAL_JsqJ3cZEbWT_Ycrb1euWJ05cN31wOYikbwKhZSEyFu2rkrA@mail.gmail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Grant Likely <grant.likely@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
From:   Peter Hurley <peter@hurleysoftware.com>
Message-ID: <565F8112.8040907@hurleysoftware.com>
Date:   Wed, 2 Dec 2015 18:38:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJ3cZEbWT_Ycrb1euWJ05cN31wOYikbwKhZSEyFu2rkrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <peter@hurleysoftware.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50302
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peter@hurleysoftware.com
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

On 11/30/2015 05:52 PM, Rob Herring wrote:
> On Mon, Nov 30, 2015 at 10:21 AM, Paul Burton <paul.burton@imgtec.com> wrote:
>> Read the reg-io-width property when earlycon is setup via device tree,
>> and set the I/O type to UPIO_MEM32 when 4 is read. This behaviour
>> matches that of the of_serial driver, and is needed for DT configured
>> earlycon on the MIPS Boston board.
>>
>> Note that this is only possible when CONFIG_LIBFDT is enabled, but
>> enabling it everywhere seems like overkill. Thus systems that need this
>> functionality should select CONFIG_LIBFDT for themselves.
> 
> libfdt is enabled if you are booting from DT, so checking this
> property should not add anything.
> 
>>
>> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
>> ---
>>
>>  drivers/of/fdt.c              |  2 +-
>>  drivers/tty/serial/Makefile   |  1 +
>>  drivers/tty/serial/earlycon.c | 15 ++++++++++++++-
>>  include/linux/serial_core.h   |  2 +-
>>  4 files changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>> index d243029..71c7f0d 100644
>> --- a/drivers/of/fdt.c
>> +++ b/drivers/of/fdt.c
>> @@ -833,7 +833,7 @@ static int __init early_init_dt_scan_chosen_serial(void)
>>                 if (addr == OF_BAD_ADDR)
>>                         return -ENXIO;
>>
>> -               of_setup_earlycon(addr, match->data);
>> +               of_setup_earlycon(fdt, offset, addr, match->data);
>>                 return 0;
>>         }
>>         return -ENODEV;
>> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
>> index 5ab4111..1d290d6 100644
>> --- a/drivers/tty/serial/Makefile
>> +++ b/drivers/tty/serial/Makefile
>> @@ -7,6 +7,7 @@ obj-$(CONFIG_SERIAL_21285) += 21285.o
>>
>>  obj-$(CONFIG_SERIAL_EARLYCON) += earlycon.o
>>  obj-$(CONFIG_SERIAL_EARLYCON_ARM_SEMIHOST) += earlycon-arm-semihost.o
>> +CFLAGS_earlycon.o += -I$(srctree)/scripts/dtc/libfdt
> 
> This is no longer necessary.
> 
>>
>>  # These Sparc drivers have to appear before others such as 8250
>>  # which share ttySx minor node space.  Otherwise console device
>> diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
>> index f096360..2b936a7 100644
>> --- a/drivers/tty/serial/earlycon.c
>> +++ b/drivers/tty/serial/earlycon.c
>> @@ -17,6 +17,7 @@
>>  #include <linux/kernel.h>
>>  #include <linux/init.h>
>>  #include <linux/io.h>
>> +#include <linux/libfdt.h>
>>  #include <linux/serial_core.h>
>>  #include <linux/sizes.h>
>>  #include <linux/mod_devicetable.h>
>> @@ -196,17 +197,29 @@ static int __init param_setup_earlycon(char *buf)
>>  }
>>  early_param("earlycon", param_setup_earlycon);
>>
>> -int __init of_setup_earlycon(unsigned long addr,
>> +int __init of_setup_earlycon(const void *fdt, int offset, unsigned long addr,
> 
> I would add iotype as a parameter instead, and then...
> 
>>                              int (*setup)(struct earlycon_device *, const char *))
>>  {
>>         int err;
>>         struct uart_port *port = &early_console_dev.port;
>> +       const __be32 *prop;
>>
>>         port->iotype = UPIO_MEM;
>>         port->mapbase = addr;
>>         port->uartclk = BASE_BAUD * 16;
>>         port->membase = earlycon_map(addr, SZ_4K);
>>
>> +       if (config_enabled(CONFIG_LIBFDT)) {
>> +               prop = fdt_getprop(fdt, offset, "reg-io-width", NULL);
>> +               if (prop) {
>> +                       switch (be32_to_cpup(prop)) {
>> +                       case 4:
>> +                               port->iotype = UPIO_MEM32;
>> +                               break;
>> +                       }
>> +               }
> 
> ...move this parsing into fdt.c where we parse the address.

FWIW, all of of_setup_earlycon() should only be #ifdef CONFIG_OF_EARLY_FLATTREE

Regards,
Peter Hurley
