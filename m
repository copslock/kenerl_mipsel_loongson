Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Mar 2006 18:25:06 +0000 (GMT)
Received: from amdext3.amd.com ([139.95.251.6]:31974 "EHLO amdext3.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133548AbWCMSYx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 13 Mar 2006 18:24:53 +0000
Received: from SSVLGW01.amd.com (ssvlgw01.amd.com [139.95.250.169])
	by amdext3.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k2DIXnrO025717;
	Mon, 13 Mar 2006 10:33:50 -0800
Received: from 139.95.53.182 by SSVLGW01.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Mon, 13 Mar 2006 10:33:31 -0800
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
Received: from ldcmail.amd.com ([147.5.200.40]) by SSVLEXBH1.amd.com
 with Microsoft SMTPSVC(6.0.3790.0); Mon, 13 Mar 2006 10:33:30 -0800
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id 4B4B2202D; Mon, 13 Mar 2006
 11:33:30 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id k2DIcnPv027541; Mon, 13 Mar 2006 11:38:49
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id k2DIcn93027540; Mon, 13 Mar 2006 11:38:49
 -0700
Date:	Mon, 13 Mar 2006 11:38:49 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	"Sergei Shtylylov" <sshtylyov@ru.mvista.com>
cc:	"Linux MIPS" <linux-mips@linux-mips.org>,
	"Manish Lachwani" <mlachwani@mvista.com>
Subject: Re: Au1550/1200: add missing PSC #define's and make OSS drivers
 use the proper ones
Message-ID: <20060313183849.GL29879@cosmic.amd.com>
References: <4415B3EB.3010102@ru.mvista.com>
MIME-Version: 1.0
In-Reply-To: <4415B3EB.3010102@ru.mvista.com>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 13 Mar 2006 18:33:31.0114 (UTC)
 FILETIME=[A0C474A0:01C646CC]
X-WSS-ID: 680B65712W48258773-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10787
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

Looks good to me as a quick glance.  I'll trust that Sergei got the addresses
right, so..

Acked-by: Jordan Crouse <jordan.crouse@amd.com>

On 13/03/06 21:03 +0300, Sergei Shtylylov wrote:
> Hello.
> 
>     Add missing PSC #define's required for the drivers using PSC on DBAu1550
> board and all Au1200-based boards as well. Make OSS drivers use the correct
> PSC definitions fo each board.
> 
> WBR, Sergei
> 
> 

> diff --git a/include/asm-mips/mach-au1x00/au1xxx_psc.h b/include/asm-mips/mach-au1x00/au1xxx_psc.h
> index 8e5fb3c..8d1f3d1 100644
> --- a/include/asm-mips/mach-au1x00/au1xxx_psc.h
> +++ b/include/asm-mips/mach-au1x00/au1xxx_psc.h
> @@ -36,11 +36,14 @@
>  #include <linux/config.h>
>  
>  /* The PSC base addresses.  */
> -#ifdef CONFIG_SOC_AU1550
> +#if defined(CONFIG_SOC_AU1550)
>  #define PSC0_BASE_ADDR		0xb1a00000
>  #define PSC1_BASE_ADDR		0xb1b00000
>  #define PSC2_BASE_ADDR		0xb0a00000
>  #define PSC3_BASE_ADDR		0xb0d00000
> +#elif defined(CONFIG_SOC_AU1200)
> +#define PSC0_BASE_ADDR		0xb1a00000
> +#define PSC1_BASE_ADDR		0xb1b00000
>  #endif
>  
>  /* The PSC select and control registers are common to
> diff --git a/include/asm-mips/mach-db1x00/db1x00.h b/include/asm-mips/mach-db1x00/db1x00.h
> index 7b28b23..4bbfcaf 100644
> --- a/include/asm-mips/mach-db1x00/db1x00.h
> +++ b/include/asm-mips/mach-db1x00/db1x00.h
> @@ -31,8 +31,20 @@
>  #include <linux/config.h>
>  
>  #ifdef CONFIG_MIPS_DB1550
> +
> +#define DBDMA_AC97_TX_CHAN DSCR_CMD0_PSC1_TX
> +#define DBDMA_AC97_RX_CHAN DSCR_CMD0_PSC1_RX
> +#define DBDMA_I2S_TX_CHAN  DSCR_CMD0_PSC3_TX
> +#define DBDMA_I2S_RX_CHAN  DSCR_CMD0_PSC3_RX
> +
> +#define SPI_PSC_BASE       PSC0_BASE_ADDR
> +#define AC97_PSC_BASE      PSC1_BASE_ADDR
> +#define SMBUS_PSC_BASE     PSC2_BASE_ADDR
> +#define I2S_PSC_BASE       PSC3_BASE_ADDR
> +
>  #define BCSR_KSEG1_ADDR 0xAF000000
>  #define NAND_PHYS_ADDR  0x20000000
> +
>  #else
>  #define BCSR_KSEG1_ADDR 0xAE000000
>  #endif
> diff --git a/sound/oss/au1550_ac97.c b/sound/oss/au1550_ac97.c
> index 64e2e46..fd40962 100644
> --- a/sound/oss/au1550_ac97.c
> +++ b/sound/oss/au1550_ac97.c
> @@ -55,10 +55,9 @@
>  #include <asm/io.h>
>  #include <asm/uaccess.h>
>  #include <asm/hardirq.h>
> -#include <asm/mach-au1x00/au1000.h>
>  #include <asm/mach-au1x00/au1xxx_psc.h>
>  #include <asm/mach-au1x00/au1xxx_dbdma.h>
> -#include <asm/mach-pb1x00/pb1550.h>
> +#include <asm/mach-au1x00/au1xxx.h>
>  
>  #undef OSS_DOCUMENTED_MIXER_SEMANTICS
>  
> diff --git a/sound/oss/au1550_i2s.c b/sound/oss/au1550_i2s.c
> index 529b625..8addad2 100644
> --- a/sound/oss/au1550_i2s.c
> +++ b/sound/oss/au1550_i2s.c
> @@ -63,10 +63,9 @@
>  #include <asm/uaccess.h>
>  #include <asm/hardirq.h>
>  
> -#include <asm/mach-au1x00/au1000.h>
>  #include <asm/mach-au1x00/au1xxx_psc.h>
>  #include <asm/mach-au1x00/au1xxx_dbdma.h>
> -#include <asm/mach-pb1x00/pb1550.h>
> +#include <asm/mach-au1x00/au1xxx.h>
>  
>  #undef OSS_DOCUMENTED_MIXER_SEMANTICS
>  
> 
> 
> 


-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>
