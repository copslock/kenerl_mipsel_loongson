Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jul 2012 18:30:11 +0200 (CEST)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:65290 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903718Ab2GMQaF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Jul 2012 18:30:05 +0200
Received: by eaaf11 with SMTP id f11so1171393eaa.36
        for <multiple recipients>; Fri, 13 Jul 2012 09:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:organization:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding
         :content-type;
        bh=ud6MvCWpfZnqLNmei4I2J1EUEYzFmj12TdTXOwU9jnY=;
        b=eU/180dLXqELSzX/F87ZGTUYH1Q6KItr4I24JTO28psvYA5bY/mSPnRNOsFOj7r135
         aQUfVOLMWCgccDCLU0hclx057gqbjfN70LVjLY0b2O4lyl7t7vGHli1HVDTLGo78lZn+
         wSBoVk74YLY/T6Jbt0t/1lXJchPbK5C/2Fu5p7Lb28Ay2sTgsDOzn52hLgfZid3mFd9Y
         qhkLIMWI8pmLjCRzOgVWMDbVKNqJx2UOMMgACRKyh5u8PIdWLeOhzX+sZ3Nkp/7uOlNs
         4hv4877m1T7TjJoBf+39sUmfH+UVXTwEes6Px8hhhl+BIB5QAtjFWcTaNGUIMf6JLJPm
         EcoA==
Received: by 10.14.101.138 with SMTP id b10mr516908eeg.56.1342196999619;
        Fri, 13 Jul 2012 09:29:59 -0700 (PDT)
Received: from flexo.localnet (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id u56sm26747934eef.7.2012.07.13.09.29.54
        (version=SSLv3 cipher=OTHER);
        Fri, 13 Jul 2012 09:29:55 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Jayachandran C <jayachandranc@netlogicmicro.com>,
        ralf@linux-mips.org
Subject: Re: [PATCH 06/12] MIPS: Netlogic: early console fix
Date:   Fri, 13 Jul 2012 18:27:07 +0200
Message-ID: <2602396.OWAlsVeLic@flexo>
Organization: OpenWrt
User-Agent: KMail/4.8.4 (Linux/3.2.0-24-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <1342196605-4260-7-git-send-email-jayachandranc@netlogicmicro.com>
References: <1342196605-4260-1-git-send-email-jayachandranc@netlogicmicro.com> <1342196605-4260-7-git-send-email-jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-archive-position: 33922
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

On Friday 13 July 2012 21:53:19 Jayachandran C wrote:
> In prom_putchar(), wait for just the TX empty bit to clear in the
> UART LSR.
> 
> Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
> ---
>  arch/mips/netlogic/common/earlycons.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/netlogic/common/earlycons.c 
b/arch/mips/netlogic/common/earlycons.c
> index f193f7b..53b200a5 100644
> --- a/arch/mips/netlogic/common/earlycons.c
> +++ b/arch/mips/netlogic/common/earlycons.c
> @@ -54,7 +54,7 @@ void prom_putchar(char c)
>  #elif defined(CONFIG_CPU_XLR)
>  	uartbase = nlm_mmio_base(NETLOGIC_IO_UART_0_OFFSET);
>  #endif
> -	while (nlm_read_reg(uartbase, UART_LSR) == 0)
> +	while ((nlm_read_reg(uartbase, UART_LSR) & 0x20) == 0)
>  		;

You could use use UART_LSR_THRE here instead of 0x20.
--
Florian
