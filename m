Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2012 17:50:54 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:49320 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903688Ab2BQQus (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Feb 2012 17:50:48 +0100
Message-ID: <4F3E8560.7020309@openwrt.org>
Date:   Fri, 17 Feb 2012 17:50:40 +0100
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.20) Gecko/20110820 Icedove/3.1.12
MIME-Version: 1.0
To:     Sergei Shtylyov <sshtylyov@mvista.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/3] MIPS: lantiq: add vr9 support
References: <1329474832-21095-1-git-send-email-blogic@openwrt.org> <1329474832-21095-2-git-send-email-blogic@openwrt.org> <4F3E91B5.5080603@mvista.com>
In-Reply-To: <4F3E91B5.5080603@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 32463
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>


>> +#define SOC_ID_VRX288           0x1C0
>
>    Use tabs to indent the value as above.
>

i would have expected checkpatch.pl to complain about this one ?!

>> +    } else if (ltq_is_vr9()) {
>
>    Where is this defined?
>

was added around 3.1 with the rest of the soc detection code.

you can find it in arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h

thx,
John
