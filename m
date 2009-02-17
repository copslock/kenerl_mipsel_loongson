Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Feb 2009 16:57:25 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:2769 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S21365908AbZBQQ5W (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Feb 2009 16:57:22 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B499aec620000>; Tue, 17 Feb 2009 11:57:06 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 17 Feb 2009 08:57:04 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 17 Feb 2009 08:57:04 -0800
Message-ID: <499AEC5F.2050206@caviumnetworks.com>
Date:	Tue, 17 Feb 2009 08:57:03 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] remove "support for" from Cavium system type
References: <20090214170926.d750aaaf.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20090214170926.d750aaaf.yoichi_yuasa@tripeaks.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Feb 2009 16:57:04.0280 (UTC) FILETIME=[C25FA980:01C99120]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21943
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Yoichi Yuasa wrote:
> Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

Also:
Signed-off-by: David Daney <ddaney@caviumnetworks.com>


> 
> diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/Kconfig linux/arch/mips/Kconfig
> --- linux-orig/arch/mips/Kconfig	2009-02-14 16:56:19.274686578 +0900
> +++ linux/arch/mips/Kconfig	2009-02-14 16:57:14.474681145 +0900
> @@ -596,7 +596,7 @@ config WR_PPMC
>  	  board, which is based on GT64120 bridge chip.
>  
>  config CAVIUM_OCTEON_SIMULATOR
> -	bool "Support for the Cavium Networks Octeon Simulator"
> +	bool "Cavium Networks Octeon Simulator"
>  	select CEVT_R4K
>  	select 64BIT_PHYS_ADDR
>  	select DMA_COHERENT
> @@ -610,7 +610,7 @@ config CAVIUM_OCTEON_SIMULATOR
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
