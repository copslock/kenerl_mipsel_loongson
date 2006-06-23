Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jun 2006 13:58:41 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:23732 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133571AbWFWM6c (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Jun 2006 13:58:32 +0100
Received: (qmail 5976 invoked from network); 23 Jun 2006 17:10:04 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 23 Jun 2006 17:10:04 -0000
Message-ID: <449BE538.5030203@ru.mvista.com>
Date:	Fri, 23 Jun 2006 16:57:28 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Domen Puncer <domen.puncer@ultra.si>,
	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: [patch 1/8] au1xxx: psc fixes + add au1200 adresses
References: <20060623095703.GA30980@domen.ultra.si> <20060623095831.GA31017@domen.ultra.si>
In-Reply-To: <20060623095831.GA31017@domen.ultra.si>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11828
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Domen Puncer wrote:
> Based on Jordan Crusoe's i2c patch:
> - fix PSC3_BASE_ADDR to match au1550 databook
> - fix PSC_SMBTXRX_RSR
> - add PSC addresses for au1200

    That was my patch, originally. And (surprise!) it just went from the -mm 
tree to Linus. Congrats, now we're going to have a patch conflict. :-)

> Signed-off-by: Domen Puncer <domen.puncer@ultra.si>

> Index: linux-mailed/include/asm-mips/mach-au1x00/au1xxx_psc.h
> ===================================================================
> --- linux-mailed.orig/include/asm-mips/mach-au1x00/au1xxx_psc.h
> +++ linux-mailed/include/asm-mips/mach-au1x00/au1xxx_psc.h
> @@ -40,7 +40,12 @@
>  #define PSC0_BASE_ADDR		0xb1a00000
>  #define PSC1_BASE_ADDR		0xb1b00000
>  #define PSC2_BASE_ADDR		0xb0a00000
> -#define PSC3_BASE_ADDR		0xb0d00000
> +#define PSC3_BASE_ADDR		0xb0b00000
> +#endif
> +
> +#ifdef CONFIG_SOC_AU1200
> +#define PSC0_BASE_ADDR		0xb1a00000
> +#define PSC1_BASE_ADDR		0xb1b00000
>  #endif
>  
>  /* The PSC select and control registers are common to
> @@ -506,7 +511,7 @@ typedef struct	psc_smb {
>  
>  /* Transmit register control.
>  */
> -#define PSC_SMBTXRX_RSR		(1 << 30)
> +#define PSC_SMBTXRX_RSR		(1 << 28)
>  #define PSC_SMBTXRX_STP		(1 << 29)
>  #define PSC_SMBTXRX_DATAMASK	(0xff)

WBR, Sergei
