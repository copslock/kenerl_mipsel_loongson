Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2009 16:47:18 +0100 (WEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:58268 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022112AbZFBPrM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 Jun 2009 16:47:12 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a25496b0000>; Tue, 02 Jun 2009 11:46:56 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 2 Jun 2009 08:46:49 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 2 Jun 2009 08:46:48 -0700
Message-ID: <4A254968.8090601@caviumnetworks.com>
Date:	Tue, 02 Jun 2009 08:46:48 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] remove "Support for" from Cavium system type
References: <20090602231510.339c24a3.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20090602231510.339c24a3.yoichi_yuasa@tripeaks.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jun 2009 15:46:49.0008 (UTC) FILETIME=[573FF300:01C9E399]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23182
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Yoichi Yuasa wrote:
> Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

Acked-by: David Daney <ddaney@caviumnetworks.com>

> 
> diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/Kconfig linux/arch/mips/Kconfig
> --- linux-orig/arch/mips/Kconfig	2009-04-16 21:22:33.885188833 +0900
> +++ linux/arch/mips/Kconfig	2009-04-16 21:13:04.881168129 +0900
> @@ -593,7 +593,7 @@ config WR_PPMC
>  	  board, which is based on GT64120 bridge chip.
>  
>  config CAVIUM_OCTEON_SIMULATOR
> -	bool "Support for the Cavium Networks Octeon Simulator"
> +	bool "Cavium Networks Octeon Simulator"
>  	select CEVT_R4K
>  	select 64BIT_PHYS_ADDR
>  	select DMA_COHERENT
> @@ -607,7 +607,7 @@ config CAVIUM_OCTEON_SIMULATOR
>  	  hardware.
>  
>  config CAVIUM_OCTEON_REFERENCE_BOARD
> -	bool "Support for the Cavium Networks Octeon reference board"
> +	bool "Cavium Networks Octeon reference board"
>  	select CEVT_R4K
>  	select 64BIT_PHYS_ADDR
>  	select DMA_COHERENT
> 
> 
