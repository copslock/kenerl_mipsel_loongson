Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Mar 2003 22:37:36 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:3314 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8224827AbTC1Whg>;
	Fri, 28 Mar 2003 22:37:36 +0000
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id OAA03352
	for <linux-mips@linux-mips.org>; Fri, 28 Mar 2003 14:37:33 -0800
Subject: Re: Au1000 ethernet patch
From: Pete Popov <ppopov@mvista.com>
To: Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <3E849F22.7BC4EDE@ekner.info>
References: <3E849F22.7BC4EDE@ekner.info>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1048891068.17369.50.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 28 Mar 2003 14:37:48 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1853
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips


On Fri, 2003-03-28 at 11:14, Hartvig Ekner wrote:
> The following patch fixes an error where ethernet minimum packets are 4 bytes too long. This caused certain
> devices not to respond to ARP requests (which is a bug on their side as well, but.....).


Thanks, I'll apply it later tonight.

Pete

> /Hartvig
> 
> 
> 
> ______________________________________________________________________
> 
> Index: au1000_eth.h
> ===================================================================
> RCS file: /home/cvs/linux/drivers/net/au1000_eth.h,v
> retrieving revision 1.2.2.8
> diff -u -r1.2.2.8 au1000_eth.h
> --- au1000_eth.h	3 Mar 2003 06:40:30 -0000	1.2.2.8
> +++ au1000_eth.h	28 Mar 2003 19:05:48 -0000
> @@ -36,7 +36,7 @@
>  #define MAX_BUF_SIZE 2048
>  
>  #define ETH_TX_TIMEOUT HZ/4
> -#define MAC_MIN_PKT_SIZE 64
> +#define MAC_MIN_PKT_SIZE 60
>  
>  #if defined(CONFIG_MIPS_PB1000) || defined(CONFIG_MIPS_PB1500) || defined(CONFIG_MIPS_PB1100) || defined(CONFIG_MIPS_DB1000) || defined(CONFIG_MIPS_DB1100) || defined(CONFIG_MIPS_DB1500)
>  #define PHY_ADDRESS              0
