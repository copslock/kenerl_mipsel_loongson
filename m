Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jan 2013 20:25:43 +0100 (CET)
Received: from mail-bk0-f44.google.com ([209.85.214.44]:37794 "EHLO
        mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6833412Ab3AWTZm1kHZE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jan 2013 20:25:42 +0100
Received: by mail-bk0-f44.google.com with SMTP id j4so985172bkw.3
        for <multiple recipients>; Wed, 23 Jan 2013 11:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=4L6apWVDO7Eh2oumITPJBjByTMFWnjR7JGjZk6cVZC8=;
        b=Tg0okz0gJLvzngZ1lOvL/CLWQVct20OanXaFa/X1FNpC1MXhq1V5Xu4vvImR01xSdc
         z2VdUP5Rv6DwugXJmiWd2mJoHZO5XsOzqY7jBc3BLwDQhm4Mc7aB1GSLrh29Eg2n6iC7
         rU1mKuxu8cHMv5cQp3oWDAfUaanylx3CgajayoBoNwdGsv3sAjEJS06kJbu2oWpiuvnA
         u7DO/xn/8z+l6Kcl51Ji+7jgWne4DnyyyxNXU1hCROwakLTumgUdLv28ECYUAUwX7z44
         TwtBaSALKS/3qXavQQjYBOrmQuw7yRsTOB3xBgTmhlQc+muWWLzDhOoXeQ/I4rcpiox+
         J4rA==
X-Received: by 10.204.150.199 with SMTP id z7mr803393bkv.139.1358969137022;
        Wed, 23 Jan 2013 11:25:37 -0800 (PST)
Received: from ?IPv6:2a01:e35:2f70:4010:b1d4:3529:4271:81d8? ([2a01:e35:2f70:4010:b1d4:3529:4271:81d8])
        by mx.google.com with ESMTPS id v8sm15227410bku.6.2013.01.23.11.25.35
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Jan 2013 11:25:36 -0800 (PST)
Message-ID: <5100393D.9010700@openwrt.org>
Date:   Wed, 23 Jan 2013 20:25:49 +0100
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [RFC 00/11] MIPS: ralink: adds support for ralink platform
References: <1358942755-25371-1-git-send-email-blogic@openwrt.org>
In-Reply-To: <1358942755-25371-1-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-archive-position: 35521
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hey John,

Le 23/01/2013 13:05, John Crispin a écrit :
> This series adds support for the ralink SoC family. Currently RT305X type
> SoC is supported. RT2880/3883 are in my local queue already but require
> further testing.

This looks very good, and the diffstat is looking good too. Besides the 
lack of Device Tree bindings documentation for the bindings you add, I 
don't have particular comments. Maybe Gabor should be CC'd on these 
patches so he gets a chance to speak loud if he objects?

Thanks!

>
> John Crispin (11):
>    MIPS: allow platforms to override cp0_compare_irq
>    MIPS: ralink: adds include files
>    MIPS: ralink: adds irq code
>    MIPS: ralink: adds reset code
>    MIPS: ralink: adds prom and cmdline code
>    MIPS: ralink: adds clkdev code
>    MIPS: ralink: adds OF code
>    MIPS: ralink: adds early_printk support
>    MIPS: ralink: adds support for RT305x SoC family
>    MIPS: ralink: adds rt305x devicetree
>    MIPS: ralink: adds Kbuild files
>
>   arch/mips/Kbuild.platforms                      |    1 +
>   arch/mips/Kconfig                               |   19 +-
>   arch/mips/include/asm/mach-ralink/ralink_regs.h |   39 ++++
>   arch/mips/include/asm/mach-ralink/rt305x.h      |  139 ++++++++++++++
>   arch/mips/include/asm/mach-ralink/war.h         |   25 +++
>   arch/mips/include/asm/time.h                    |    1 +
>   arch/mips/kernel/traps.c                        |    7 +-
>   arch/mips/ralink/Kconfig                        |   27 +++
>   arch/mips/ralink/Makefile                       |   15 ++
>   arch/mips/ralink/Platform                       |   11 ++
>   arch/mips/ralink/clk.c                          |   72 +++++++
>   arch/mips/ralink/common.h                       |   43 +++++
>   arch/mips/ralink/dts/Makefile                   |    1 +
>   arch/mips/ralink/dts/rt305x.dts                 |  156 +++++++++++++++
>   arch/mips/ralink/early_printk.c                 |   43 +++++
>   arch/mips/ralink/irq.c                          |  182 ++++++++++++++++++
>   arch/mips/ralink/of.c                           |  105 +++++++++++
>   arch/mips/ralink/prom.c                         |   69 +++++++
>   arch/mips/ralink/reset.c                        |   44 +++++
>   arch/mips/ralink/rt305x.c                       |  231 +++++++++++++++++++++++
>   20 files changed, 1228 insertions(+), 2 deletions(-)
>   create mode 100644 arch/mips/include/asm/mach-ralink/ralink_regs.h
>   create mode 100644 arch/mips/include/asm/mach-ralink/rt305x.h
>   create mode 100644 arch/mips/include/asm/mach-ralink/war.h
>   create mode 100644 arch/mips/ralink/Kconfig
>   create mode 100644 arch/mips/ralink/Makefile
>   create mode 100644 arch/mips/ralink/Platform
>   create mode 100644 arch/mips/ralink/clk.c
>   create mode 100644 arch/mips/ralink/common.h
>   create mode 100644 arch/mips/ralink/dts/Makefile
>   create mode 100644 arch/mips/ralink/dts/rt305x.dts
>   create mode 100644 arch/mips/ralink/early_printk.c
>   create mode 100644 arch/mips/ralink/irq.c
>   create mode 100644 arch/mips/ralink/of.c
>   create mode 100644 arch/mips/ralink/prom.c
>   create mode 100644 arch/mips/ralink/reset.c
>   create mode 100644 arch/mips/ralink/rt305x.c
>
