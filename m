Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 May 2011 17:06:43 +0200 (CEST)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:55053 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491133Ab1EGPGh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 May 2011 17:06:37 +0200
Received: by eyh6 with SMTP id 6so1363261eyh.36
        for <multiple recipients>; Sat, 07 May 2011 08:06:31 -0700 (PDT)
Received: by 10.14.122.81 with SMTP id s57mr2584434eeh.195.1304780791456;
        Sat, 07 May 2011 08:06:31 -0700 (PDT)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru [213.79.90.226])
        by mx.google.com with ESMTPS id s1sm2123276ees.3.2011.05.07.08.06.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 07 May 2011 08:06:29 -0700 (PDT)
Message-ID: <4DC55F80.7010409@mvista.com>
Date:   Sat, 07 May 2011 19:04:32 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Hauke Mehrtens <hauke@hauke-m.de>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 5/5] MIPS: BCM47xx: Fix mac address parsing.
References: <1304771263-10937-1-git-send-email-hauke@hauke-m.de> <1304771263-10937-6-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1304771263-10937-6-git-send-email-hauke@hauke-m.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29863
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Hauke Mehrtens wrote:

> Some devices like the Netgear WGT634u are using minuses between the
> blocks of the mac address and other devices are using colons to
> separate them.

> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  arch/mips/include/asm/mach-bcm47xx/nvram.h |   11 +++++++++--
>  1 files changed, 9 insertions(+), 2 deletions(-)

> diff --git a/arch/mips/include/asm/mach-bcm47xx/nvram.h b/arch/mips/include/asm/mach-bcm47xx/nvram.h
> index 9759588..fcdeca7 100644
> --- a/arch/mips/include/asm/mach-bcm47xx/nvram.h
> +++ b/arch/mips/include/asm/mach-bcm47xx/nvram.h
> @@ -39,8 +39,15 @@ extern int nvram_getenv(char *name, char *val, size_t val_len);
>  
>  static inline void nvram_parse_macaddr(char *buf, u8 *macaddr)
>  {
> -	sscanf(buf, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx", &macaddr[0], &macaddr[1],
> -	       &macaddr[2], &macaddr[3], &macaddr[4], &macaddr[5]);
> +	if (strchr(buf, ':')) {
> +		sscanf(buf, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx", &macaddr[0], &macaddr[1],
> +			&macaddr[2], &macaddr[3], &macaddr[4], &macaddr[5]);
> +	} else if (strchr(buf, '-')) {
> +		sscanf(buf, "%hhx-%hhx-%hhx-%hhx-%hhx-%hhx", &macaddr[0], &macaddr[1],
> +			&macaddr[2], &macaddr[3], &macaddr[4], &macaddr[5]);
> +	} else {
> +		printk(KERN_WARNING "Can not parse mac address: %s\n", buf);
> +	}
>  }
>  
>  #endif

    checkcptach.pl says:

WARNING: line over 80 characters
#21: FILE: arch/mips/include/asm/mach-bcm47xx/nvram.h:43:
+		sscanf(buf, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx", &macaddr[0], &macaddr[1],

WARNING: line over 80 characters
#24: FILE: arch/mips/include/asm/mach-bcm47xx/nvram.h:46:
+		sscanf(buf, "%hhx-%hhx-%hhx-%hhx-%hhx-%hhx", &macaddr[0], &macaddr[1],

total: 0 errors, 2 warnings, 17 lines checked

patches/MIPS-BCM47xx-Fix-mac-address-parsing.patch has style problems, please 
review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.

    Additionally, though the script doesn't warn about this, {} are not 
necessary -- every branch is really a single statement.

WBR, Sergei
