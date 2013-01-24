Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jan 2013 15:00:03 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:57815 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6833437Ab3AXOACbAWul (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Jan 2013 15:00:02 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 5DCF825BAD6;
        Thu, 24 Jan 2013 14:59:57 +0100 (CET)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VJOjq1BRc-FH; Thu, 24 Jan 2013 14:59:57 +0100 (CET)
Received: from [127.0.0.1] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPSA id 2673525BAD7;
        Thu, 24 Jan 2013 14:59:53 +0100 (CET)
Message-ID: <51013E58.9080309@openwrt.org>
Date:   Thu, 24 Jan 2013 14:59:52 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [RFC 11/11] MIPS: ralink: adds Kbuild files
References: <1358942755-25371-1-git-send-email-blogic@openwrt.org> <1358942755-25371-12-git-send-email-blogic@openwrt.org>
In-Reply-To: <1358942755-25371-12-git-send-email-blogic@openwrt.org>
X-Enigmail-Version: 1.5
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Antivirus: avast! (VPS 130124-0, 2013.01.24), Outbound message
X-Antivirus-Status: Clean
X-archive-position: 35541
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

2013.01.23. 13:05 keltezéssel, John Crispin írta:
> Add the Kbuild symbols and Makefiles needed to actually build the ralink code
> from this series
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>

<...>

> @@ -1160,7 +1177,7 @@ config BOOT_ELF32
>  
>  config MIPS_L1_CACHE_SHIFT
>  	int
> -	default "4" if MACH_DECSTATION || MIKROTIK_RB532 || PMC_MSP4200_EVAL
> +	default "4" if MACH_DECSTATION || MIKROTIK_RB532 || PMC_MSP4200_EVAL || RALINK_RT288X
>  	default "6" if MIPS_CPU_SCACHE
>  	default "7" if SGI_IP22 || SGI_IP27 || SGI_IP28 || SNI_RM || CPU_CAVIUM_OCTEON
>  	default "5"

This hunk is specific to the RT288X SoC, so it should be dropped from the patch.

-Gabor
