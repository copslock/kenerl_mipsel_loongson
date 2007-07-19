Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jul 2007 10:46:15 +0100 (BST)
Received: from dmz.mips-uk.com ([194.74.144.194]:8458 "EHLO dmz.mips-uk.com")
	by ftp.linux-mips.org with ESMTP id S20022485AbXGSJqN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 19 Jul 2007 10:46:13 +0100
Received: from internal-mx1 ([192.168.192.240] helo=ukservices1.mips.com)
	by dmz.mips-uk.com with esmtp (Exim 3.35 #1 (Debian))
	id 1IBSXH-0000TI-00; Thu, 19 Jul 2007 10:43:03 +0100
Received: from ukcvpn39.mips-uk.com ([192.168.193.39] helo=[127.0.0.1])
	by ukservices1.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1IBSX9-0006M4-00; Thu, 19 Jul 2007 10:42:55 +0100
Message-ID: <469F3227.6090307@mips.com>
Date:	Thu, 19 Jul 2007 10:43:03 +0100
From:	Nigel Stephens <nigel@mips.com>
User-Agent: Thunderbird 2.0.0.4 (Windows/20070604)
MIME-Version: 1.0
To:	Franck <vagabon.xyz@gmail.com>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [RFC] User stack pointer randomisation
References: <469F0E5F.4050005@innova-card.com>
In-Reply-To: <469F0E5F.4050005@innova-card.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MIPS-Technologies-UK-MailScanner: Found to be clean
X-MIPS-Technologies-UK-MailScanner-From: nigel@mips.com
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15802
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips



Franck Bui-Huu wrote:
> +/*
> + * Don't forget that the stack pointer must be aligned on a 8 bytes
> + * boundary at least.
> + */
> +unsigned long arch_align_stack(unsigned long sp)
> +{
> +	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
> +		sp -= get_random_int() & ~PAGE_MASK;
> +
> +	return sp & ~7;
> +}
>   

For the 64-bit ABIs (N32 & N64) the stack must be 16 byte aligned.

Nigel
