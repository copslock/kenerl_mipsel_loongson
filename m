Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jan 2013 11:34:00 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:50187 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6832208Ab3AXKd7R91Xy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Jan 2013 11:33:59 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id D31EE25BA30;
        Thu, 24 Jan 2013 11:33:53 +0100 (CET)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LOp1GofBP-js; Thu, 24 Jan 2013 11:33:53 +0100 (CET)
Received: from [127.0.0.1] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPSA id 08A8025B7D3;
        Thu, 24 Jan 2013 11:33:52 +0100 (CET)
Message-ID: <51010E1C.5050205@openwrt.org>
Date:   Thu, 24 Jan 2013 11:34:04 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [RFC 02/11] MIPS: ralink: adds include files
References: <1358942755-25371-1-git-send-email-blogic@openwrt.org> <1358942755-25371-3-git-send-email-blogic@openwrt.org>
In-Reply-To: <1358942755-25371-3-git-send-email-blogic@openwrt.org>
X-Enigmail-Version: 1.5
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
X-Antivirus: avast! (VPS 130124-0, 2013.01.24), Outbound message
X-Antivirus-Status: Clean
X-archive-position: 35530
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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

Hi John,

> Before we start adding the platform code we add the common include files.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>  arch/mips/include/asm/mach-ralink/ralink_regs.h |   39 ++++++++++++++++++++
>  arch/mips/include/asm/mach-ralink/war.h         |   25 +++++++++++++
>  arch/mips/ralink/common.h                       |   43 +++++++++++++++++++++++
>  3 files changed, 107 insertions(+)
>  create mode 100644 arch/mips/include/asm/mach-ralink/ralink_regs.h
>  create mode 100644 arch/mips/include/asm/mach-ralink/war.h
>  create mode 100644 arch/mips/ralink/common.h

I prefer to introduce header files along with the code which uses that actually.
Several things are defined in 'common.h' and everyone have to look into the
subseqent patches for the actual code.

<...>

> diff --git a/arch/mips/ralink/common.h b/arch/mips/ralink/common.h
> new file mode 100644
> index 0000000..8c751f5
> --- /dev/null
> +++ b/arch/mips/ralink/common.h
> @@ -0,0 +1,43 @@
> +/*
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License version 2 as published
> + *  by the Free Software Foundation.
> + *
> + * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
> + */
> +
> +#ifndef _RALINK_COMMON_H__
> +#define _RALINK_COMMON_H__
> +
> +#define RAMIPS_SYS_TYPE_LEN	0x100

256 bytes are too much for this IMHO. In OpenWrt we are using 64, but even 32
should be enough for every SoC.

-Gabor
