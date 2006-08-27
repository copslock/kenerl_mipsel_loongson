Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Aug 2006 13:36:04 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:23156 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20038995AbWH0MgB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 27 Aug 2006 13:36:01 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id B80C13EEA; Sun, 27 Aug 2006 05:35:45 -0700 (PDT)
Message-ID: <44F191E5.30208@ru.mvista.com>
Date:	Sun, 27 Aug 2006 16:36:53 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	thomas@koeller.dyndns.org
Cc:	ralf@linux-mips.org, thomas.koeller@baslerweb.com,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Add configuration variables for RM9xxx processor
References: <200608271351.48462.thomas@koeller.dyndns.org>
In-Reply-To: <200608271351.48462.thomas@koeller.dyndns.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12445
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

thomas@koeller.dyndns.org wrote:
> This patch introduces a number of configuration variables. These allow to
> specify presence/absence of integrated peripherals found on the MIPS
> RM9xxx processor family, based on the particular processor model used.

> Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>
[...]
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 96165d7..8affac6 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
[...]
> @@ -1021,6 +1028,15 @@ config EMMA2RH
>  	depends on MARKEINS
>  	default y
>  
> +config SERIAL_RM9000
> +	bool
> +

    Haven't you just renamed this option to SERIAL_8250_RM9K?

WBR, Sergei
