Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2005 05:35:13 +0100 (BST)
Received: from [IPv6:::ffff:216.208.38.107] ([IPv6:::ffff:216.208.38.107]:2968
	"EHLO OTTLS.pngxnet.com") by linux-mips.org with ESMTP
	id <S8225245AbVGVEew>; Fri, 22 Jul 2005 05:34:52 +0100
Received: from bacchus.net.dhis.org ([10.255.255.134])
	by OTTLS.pngxnet.com (8.12.4/8.12.4) with ESMTP id j6M4alnA013094
	for <linux-mips@linux-mips.org>; Fri, 22 Jul 2005 00:36:47 -0400
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j6LLrsEg005271
	for <linux-mips@linux-mips.org>; Thu, 21 Jul 2005 17:53:54 -0400
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j6LLrs0E005270
	for linux-mips@linux-mips.org; Thu, 21 Jul 2005 17:53:54 -0400
Date:	Thu, 21 Jul 2005 17:53:54 -0400
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
Message-ID: <20050721215354.GB4282@linux-mips.org>
References: <20050721153639Z8225221-3678+3748@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050721153639Z8225221-3678+3748@linux-mips.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8593
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jul 21, 2005 at 04:36:37PM +0100, ths@linux-mips.org wrote:

> Log message:
> 	#ifdef looks better than #if. :-)
> 
> diff -urN linux/include/asm-mips/reg.h linux/include/asm-mips/reg.h
> --- linux/include/asm-mips/reg.h	2005/07/14 12:05:09	1.6
> +++ linux/include/asm-mips/reg.h	2005/07/21 15:36:30	1.7
> @@ -70,7 +70,7 @@
>  
>  #endif
>  
> -#if CONFIG_64BIT
> +#ifdef CONFIG_64BIT

It's can be a bug, depending on the exact use, so generally it's shot
to kill.

 Ralf
