Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 31 Dec 2005 04:04:25 +0000 (GMT)
Received: from amdext4.amd.com ([163.181.251.6]:28341 "EHLO amdext4.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133373AbVLaEED (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 31 Dec 2005 04:04:03 +0000
Received: from SAUSGW01.amd.com (sausgw01.amd.com [163.181.250.21])
	by amdext4.amd.com (8.12.11/8.12.11/AMD) with ESMTP id jBV45vtJ018947;
	Fri, 30 Dec 2005 22:06:02 -0600
Received: from 163.181.250.1 by SAUSGW02.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Fri, 30 Dec 2005 22:05:51 -0600
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
Received: from ldcmail.amd.com (ldcmail.amd.com [147.5.200.40]) by
 amdint2.amd.com (8.12.8/8.12.8/AMD) with ESMTP id jBV45oh5001854; Fri,
 30 Dec 2005 22:05:50 -0600 (CST)
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id 01F262028; Fri, 30 Dec 2005
 21:05:50 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id jBV4Btwo005529; Fri, 30 Dec 2005 21:11:55
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id jBV4BtJU005528; Fri, 30 Dec 2005 21:11:55
 -0700
Date:	Fri, 30 Dec 2005 21:11:55 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	"Sergei Shtylylov" <sshtylyov@ru.mvista.com>
cc:	"Andrew Morton" <akpm@osdl.org>,
	"Linux MIPS Development" <linux-mips@linux-mips.org>,
	ralf@linux-mips.org
Subject: Re: Au1xx0: replace casual readl() with au_readl() in the
 drivers
Message-ID: <20051231041155.GA5422@cosmic.amd.com>
References: <43452054.2090305@ru.mvista.com>
 <436FB1DE.6010405@ru.mvista.com> <43B5BDCF.7010900@ru.mvista.com>
MIME-Version: 1.0
In-Reply-To: <43B5BDCF.7010900@ru.mvista.com>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6FA8DC150T0670651-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9762
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

Acked-by: Jordan CRouse <jordan.crouse@amd.com>

On 31/12/05 02:07 +0300, Sergei Shtylylov wrote:
> Hello, I wrote:
> 
> >>    We have found some issues with Au1550 AC'97 OSS driver in 2.6
> >>(sound/oss/au1550_ac97.c), though it also should concern 2.4 driver
> >>(drivers/sound/au1550_psc.c).
> >>    First, we don't think that using readl() calls instead of 
> >>au_readl() is
> >>correct -- readl() is subject to byte-swapping etc., so may not work in
> >>BE mode anymore and au_readl() is intended for embedded Au1550 devices
> >>for which the byte swapping issue is resolved automagically,  and BTW the 
> >>same
> >>PSC_AC97STAT register is read "both ways" in the driver.
> 
> [skipped]
> 
>     Additionally, I've found one unjustified call to readl() in the Au1xx0 
>     USB
> code, so adding the fix for it to the patch. Andrew, I'm sending the patch 
> to
> you as was advised by Ralf and Jordan...
> 
> WBR, Sergei
> 

> diff --git a/drivers/usb/host/ohci-au1xxx.c b/drivers/usb/host/ohci-au1xxx.c
> index 486202d..0fc728e 100644
> --- a/drivers/usb/host/ohci-au1xxx.c
> +++ b/drivers/usb/host/ohci-au1xxx.c
> @@ -66,7 +66,7 @@ static void au1xxx_stop_hc(struct platfo
>  	       ": stopping Au1xxx OHCI USB Controller\n");
>  
>  	/* Disable clock */
> -	au_writel(readl((void *)USB_HOST_CONFIG) & ~USBH_ENABLE_CE, USB_HOST_CONFIG);
> +	au_writel(au_readl(USB_HOST_CONFIG) & ~USBH_ENABLE_CE, USB_HOST_CONFIG);
>  }
>  
>  
> diff --git a/sound/oss/au1550_ac97.c b/sound/oss/au1550_ac97.c
> index f70effd..64e2e46 100644
> --- a/sound/oss/au1550_ac97.c
> +++ b/sound/oss/au1550_ac97.c
> @@ -463,7 +463,7 @@ stop_dac(struct au1550_state *s)
>  	/* Wait for Transmit Busy to show disabled.
>  	*/
>  	do {
> -		stat = readl((void *)PSC_AC97STAT);
> +		stat = au_readl(PSC_AC97STAT);
>  		au_sync();
>  	} while ((stat & PSC_AC97STAT_TB) != 0);
>  
> @@ -492,7 +492,7 @@ stop_adc(struct au1550_state *s)
>  	/* Wait for Receive Busy to show disabled.
>  	*/
>  	do {
> -		stat = readl((void *)PSC_AC97STAT);
> +		stat = au_readl(PSC_AC97STAT);
>  		au_sync();
>  	} while ((stat & PSC_AC97STAT_RB) != 0);
>  
> @@ -542,7 +542,7 @@ set_xmit_slots(int num_channels)
>  	/* Wait for Device ready.
>  	*/
>  	do {
> -		stat = readl((void *)PSC_AC97STAT);
> +		stat = au_readl(PSC_AC97STAT);
>  		au_sync();
>  	} while ((stat & PSC_AC97STAT_DR) == 0);
>  }
> @@ -574,7 +574,7 @@ set_recv_slots(int num_channels)
>  	/* Wait for Device ready.
>  	*/
>  	do {
> -		stat = readl((void *)PSC_AC97STAT);
> +		stat = au_readl(PSC_AC97STAT);
>  		au_sync();
>  	} while ((stat & PSC_AC97STAT_DR) == 0);
>  }
> @@ -1996,7 +1996,7 @@ au1550_probe(void)
>  	/* Wait for PSC ready.
>  	*/
>  	do {
> -		val = readl((void *)PSC_AC97STAT);
> +		val = au_readl(PSC_AC97STAT);
>  		au_sync();
>  	} while ((val & PSC_AC97STAT_SR) == 0);
>  
> @@ -2019,7 +2019,7 @@ au1550_probe(void)
>  	/* Wait for Device ready.
>  	*/
>  	do {
> -		val = readl((void *)PSC_AC97STAT);
> +		val = au_readl(PSC_AC97STAT);
>  		au_sync();
>  	} while ((val & PSC_AC97STAT_DR) == 0);
>  


-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>
