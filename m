Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Apr 2003 23:23:45 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:42852
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225208AbTDXWXk>; Thu, 24 Apr 2003 23:23:40 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 198p7x-000jYk-00
	for linux-mips@linux-mips.org; Fri, 25 Apr 2003 00:23:37 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 198p7x-00074d-00
	for <linux-mips@linux-mips.org>; Fri, 25 Apr 2003 00:23:37 +0200
Date: Fri, 25 Apr 2003 00:23:37 +0200
To: linux-mips@linux-mips.org
Subject: Re: [patch] new wait instruction for vr4181
Message-ID: <20030424222337.GD19131@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030424112711.E28275@mvista.com> <079701c30aa8$7de13300$3501a8c0@wssseeger>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <079701c30aa8$7de13300$3501a8c0@wssseeger>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2184
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Steven Seeger wrote:
> I think I figured this out. Could someone look at this and tell me if I did
> it right?
> 
> Thanks.
> 
> -Steve
> 

> --- /root/vr/new/linux-2.4.21.orig/arch/mips/kernel/cpu-probe.c	2003-04-24 05:32:21.000000000 -0700
> +++ ./cpu-probe.c	2003-04-24 14:16:35.000000000 -0700
> @@ -34,6 +34,16 @@
>  		".set\tmips0");
>  }
>  
> +#ifdef CONFIG_VR4181
> +static void vr4181_wait(void)

The GAS source claims all vr41xx have 'standby', so you may probably
rename the function and enable it for all CONFIG_VR41*.

> +{
> +   __asm__(".set\tnoreorder\n"

A \t at the end like
__asm__(".set\tnoreorder\n\t"
gives better formatting, and the last line doesn't need a \n.

> +	   ".int 0x42000021\n"

.word is probably more usual.


Thiemo
